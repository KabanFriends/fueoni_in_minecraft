#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

scoreboard players remove tp_y foGameData 1
execute store result entity @s Pos[1] double 1 run scoreboard players get tp_y foGameData
execute if score tp_y foGameData > min_y foGameData at @s if block ~ ~1 ~ #fueoni:fo_nonsolid if block ~ ~ ~ #fueoni:fo_nonsolid unless block ~ ~-1 ~ #fueoni:fo_nonsolid_liquid run summon marker ~ ~ ~ {Tags:["foTPTarget","foGameEntity"]}
execute if score tp_y foGameData > min_y foGameData at @s run function fueoni:entity/iterate_random_tp
