#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

kill @e[tag=foStartLocation]
summon armor_stand ~ ~ ~ {Tags:["foStartLocation","foGameEntity"],Invisible:true,Invulnerable:true,Marker:true,NoGravity:true}
scoreboard players set game_timer foGameData 0
scoreboard players set game_mode foGameData 1