#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

summon marker ~ ~ ~ {Tags:["foTPSearch","foGameEntity"]}
execute store result entity @e[tag=foTPSearch,limit=1] Pos[1] double 1 run scoreboard players get max_y foGameData
execute as @e[tag=foTPSearch] at @s run function fueoni:entity/iterate_random_tp

execute if entity @e[tag=foTPTarget] run teleport @s @e[tag=foTPTarget,limit=1,sort=random]
execute unless entity @e[tag=foTPTarget] run kill @s[type=!player]
tag @s[tag=foNeedTeleport] remove foNeedTeleport
kill @e[tag=foTPTarget]
kill @e[tag=foTPSearch]
