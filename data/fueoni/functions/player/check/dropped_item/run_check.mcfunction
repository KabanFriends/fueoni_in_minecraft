#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

scoreboard players set compare_check foGameData -1
data remove storage fueoni:check_dropped_item ItemThrower
execute store result score item_entity_age foGameData run data get entity @s Age
execute if score item_entity_age foGameData matches ..5 run data modify storage fueoni:check_dropped_item ItemThrower set from entity @s Thrower
execute if score item_entity_age foGameData matches ..5 store success score compare_check foGameData run data modify storage fueoni:check_dropped_item ItemThrower set from storage fueoni:check_dropped_item PlayerUUID

execute if score item_entity_age foGameData matches ..5 if score compare_check foGameData matches 0 run tag @s add foGameEntity
