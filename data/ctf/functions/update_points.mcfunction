# find out who is near what
tag @e remove capture_point_near_team_a
tag @e remove capture_point_near_team_b
execute as @a[team=team_a] run tag @e[tag=capture_point, distance=0..5] add capture_point_near_team_a
execute as @a[team=team_b] run tag @e[tag=capture_point, distance=0..5] add capture_point_near_team_b

# find out which points are being attacked
tag @e remove capture_point_threatened
tag @e[tag=captured_team_a, tag=capture_point_near_team_b, tag=!capture_point_near_team_a] add capture_point_threatened
tag @e[tag=captured_team_b, tag=capture_point_near_team_a, tag=!capture_point_near_team_b] add capture_point_threatened

# find out which points are being secured/restored
tag @e remove capture_point_being_secured
tag @e[tag=!captured_a, tag=capture_point_near_team_b, tag=!capture_point_near_team_a] add capture_point_being_secured
tag @e[tag=!captured_b, tag=capture_point_near_team_a, tag=!capture_point_near_team_b] add capture_point_being_secured

# adjust progress
scoreboard players add @e[tag=capture_point_being_secured, scores={capture_progress=..100}] capture_progress 4
scoreboard players remove @e[tag=capture_point_threatened, scores={capture_progress=0..}] capture_progress 4
scoreboard players add @e[tag=!capture_point_being_secured, tag=!capture_point_threatened, tag=capture_point_is_secure, scores={capture_progress=..100}] 1
scoreboard players remove @e[tag=!capture_point_being_secured, tag=!capture_point_threatened, tag=!capture_point_is_secure, scores={capture_progress=..100}] 1

# update securedness
execute as @e[tag=capture_point_is_secure, scores={capture_progress=..0}] run function ctf:on_point_loss
tag @e[tag=capture_point_is_secure, scores={capture_progress=..0}] remove capture_point_is_secure
execute as @e[tag=capture_point, tag=!capture_point_is_secure, scores={capture_progress=100..}] run function ctf:on_point_gain
tag @e[tag=capture_point, scores={capture_progress=100..}] add capture_point_is_secure

