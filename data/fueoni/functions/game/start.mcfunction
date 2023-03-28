#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

kill @e[tag=foGameEntity]
summon marker ~ ~ ~ {Tags:["foStartLocation","foGameEntity"]}
scoreboard players set game_timer foGameData 0
scoreboard players set game_mode foGameData 1
