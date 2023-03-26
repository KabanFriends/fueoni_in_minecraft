#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

data modify storage fueoni:check_arrow_projectile PlayerUUID set from entity @s UUID
execute as @e[type=arrow,distance=..10,tag=!foGameEntity] run function fueoni:player/check/arrow_projectile/run_check