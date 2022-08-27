#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

scoreboard players remove min_y foGameData 1
execute store result entity @s Pos[1] double 1 run scoreboard players get min_y foGameData
execute at @s unless block ~ ~ ~ chest{foImpossible:1b} run function fueoni:world/iterate_down
