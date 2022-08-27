#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

#CHECK ENABLED ITEMS
scoreboard players set item_count foGameData 0

scoreboard players set item_eye_added foGameData 0
scoreboard players set item_speed_added foGameData 0
scoreboard players set item_invis_added foGameData 0
scoreboard players set item_arrow_added foGameData 0

scoreboard players set item_1 foGameData 0
scoreboard players set item_2 foGameData 0
scoreboard players set item_3 foGameData 0
scoreboard players set item_4 foGameData 0

execute if score item_eye foGameOption matches 1 if score item_eye_added foGameData matches 0 run function fueoni:game/add_item/eye
execute if score item_speed foGameOption matches 1 if score item_speed_added foGameData matches 0 run function fueoni:game/add_item/speed
execute if score item_invis foGameOption matches 1 if score item_invis_added foGameData matches 0 run function fueoni:game/add_item/invis
execute if score item_arrow foGameOption matches 1 if score item_arrow_added foGameData matches 0 run function fueoni:game/add_item/arrow

execute as @e[tag=foStartLocation] at @s run function fueoni:world/get_world_height

scoreboard players operation void_y foGameData = min_y foGameData
scoreboard players remove void_y foGameData 16
