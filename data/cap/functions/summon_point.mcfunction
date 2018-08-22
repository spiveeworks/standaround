summon minecraft:armor_stand ~ ~ ~ {"Tags": ["new_capture_point", "capture_point"]}
scoreboard players set @e[tag=new_capture_point] capture_progress 0
tag @e remove new_capture_point
