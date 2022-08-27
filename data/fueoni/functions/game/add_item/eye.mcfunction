#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

scoreboard players add item_count foGameData 1
scoreboard players set item_eye_added foGameData 1

execute if score item_count foGameData matches 1 run scoreboard players set item_1 foGameData 1
execute if score item_count foGameData matches 2 run scoreboard players set item_2 foGameData 1
execute if score item_count foGameData matches 3 run scoreboard players set item_3 foGameData 1
execute if score item_count foGameData matches 4 run scoreboard players set item_4 foGameData 1
