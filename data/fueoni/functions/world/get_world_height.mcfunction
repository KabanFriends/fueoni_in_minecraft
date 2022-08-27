#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

scoreboard players set min_y foGameData -64
scoreboard players set max_y foGameData 319
scoreboard players set in_world foGameData 0

execute store result score detect_start_y foGameData run data get entity @s Pos[1] 1
summon marker ~ ~ ~ {"Tags":["foWorldHeightDetect","foGameEntity"]}

# check if outside world
execute at @e[tag=foWorldHeightDetect,limit=1] unless block ~ ~ ~ chest{foImpossible:1b} run scoreboard players set in_world foGameData 1
execute if score in_world foGameData matches 0 run tellraw @a[advancements={fueoni:spawn_egg/start_game=true}] [{"text":""},{"translate":"増え鬼%1$s","color":"yellow","bold":true,"with":[{"text":" » ","color":"gray","bold":false}]},{"translate":"ワールドの高さを検出できないため、既定値を使用します。","color":"red"}]

# detect min y
execute store result entity @e[tag=foWorldHeightDetect,limit=1] Pos[1] double 1 run scoreboard players get detect_start_y foGameData
execute if score in_world foGameData matches 1 run scoreboard players operation min_y foGameData = detect_start_y foGameData
execute if score in_world foGameData matches 1 as @e[tag=foWorldHeightDetect] run function fueoni:world/iterate_down
execute if score in_world foGameData matches 1 run scoreboard players add min_y foGameData 1

# detect max y
execute store result entity @e[tag=foWorldHeightDetect,limit=1] Pos[1] double 1 run scoreboard players get detect_start_y foGameData
execute if score in_world foGameData matches 1 run scoreboard players operation max_y foGameData = detect_start_y foGameData
execute if score in_world foGameData matches 1 as @e[tag=foWorldHeightDetect] run function fueoni:world/iterate_up
execute if score in_world foGameData matches 1 run scoreboard players remove max_y foGameData 1

kill @e[tag=foWorldHeightDetect]
