#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

data modify storage fueoni:check_dropped_item PlayerUUID set from entity @s UUID
execute as @e[type=item,distance=..2,tag=!foGameEntity] run function fueoni:player/check/dropped_item/run_check