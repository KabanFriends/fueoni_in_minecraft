#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

summon marker ~ ~ ~ {Tags:["foTPSearch","foGameEntity"]}
scoreboard players operation tp_y foGameData = max_y foGameData
execute store result entity @e[tag=foTPSearch,limit=1] Pos[1] double 1 run scoreboard players get max_y foGameData
execute as @e[tag=foTPSearch] at @s run tp @s ~ ~1 ~
execute as @e[tag=foTPSearch] at @s run function fueoni:entity/iterate_random_tp

execute if entity @e[tag=foTPTarget] run tp @s @e[tag=foTPTarget,limit=1,sort=random]
execute unless entity @e[tag=foTPTarget] run kill @s[type=!player]
tag @s[tag=foNeedTeleport] remove foNeedTeleport
kill @e[tag=foTPTarget]
kill @e[tag=foTPSearch]
