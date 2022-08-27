#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

#detect timer and spawn
execute at @e[tag=foStartLocation] run summon marker ~ ~ ~ {Tags:["foPlayerVoidLocation","foGameEntity"]}
execute store result entity @e[tag=foPlayerVoidLocation,limit=1] Pos[1] double 1 run scoreboard players get void_y foGameData
execute if score @s foItemSpawnId matches 1 run scoreboard players operation @s foItemSpawnType = item_1 foGameData
execute if score @s foItemSpawnId matches 2 run scoreboard players operation @s foItemSpawnType = item_2 foGameData
execute if score @s foItemSpawnId matches 3 run scoreboard players operation @s foItemSpawnType = item_3 foGameData
execute if score @s foItemSpawnId matches 4 run scoreboard players operation @s foItemSpawnType = item_4 foGameData
execute at @e[tag=foPlayerVoidLocation] if score @s foItemSpawnTimer >= @s foSpawnTimerEnd if score @s foItemSpawnType matches 1 run summon armor_stand ~ ~ ~ {CustomNameVisible:1b,NoGravity:1b,Invulnerable:1b,Marker:0b,Invisible:1b,Tags:["foNeedItem","foNeedTeleport","foEye","foGameEntity","foItemEntity"],DisabledSlots:4144959}
execute at @e[tag=foPlayerVoidLocation] if score @s foItemSpawnTimer >= @s foSpawnTimerEnd if score @s foItemSpawnType matches 2 run summon armor_stand ~ ~ ~ {CustomNameVisible:1b,NoGravity:1b,Invulnerable:1b,Marker:0b,Invisible:1b,Tags:["foNeedItem","foNeedTeleport","foSpeed","foGameEntity","foItemEntity"],DisabledSlots:4144959}
execute at @e[tag=foPlayerVoidLocation] if score @s foItemSpawnTimer >= @s foSpawnTimerEnd if score @s foItemSpawnType matches 3 run summon armor_stand ~ ~ ~ {CustomNameVisible:1b,NoGravity:1b,Invulnerable:1b,Marker:0b,Invisible:1b,Tags:["foNeedItem","foNeedTeleport","foInvisible","foGameEntity","foItemEntity"],DisabledSlots:4144959}
execute at @e[tag=foPlayerVoidLocation] if score @s foItemSpawnTimer >= @s foSpawnTimerEnd if score @s foItemSpawnType matches 4 run summon armor_stand ~ ~ ~ {CustomNameVisible:1b,NoGravity:1b,Invulnerable:1b,Marker:0b,Invisible:1b,Tags:["foNeedItem","foNeedTeleport","foKillOni","foGameEntity","foItemEntity"],DisabledSlots:4144959}

#spread spawned item
execute at @e[tag=foPlayerVoidLocation] if score @s foItemSpawnTimer >= @s foSpawnTimerEnd run spreadplayers ~ ~ 0 64 false @e[tag=foItemEntity,limit=1,sort=nearest]

#clear player void entity
kill @e[tag=foPlayerVoidLocation]
