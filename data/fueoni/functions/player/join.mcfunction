#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

playsound minecraft:entity.player.levelup voice @s[type=player,tag=!foGamePlayer] ~ ~ ~ 1.0 2.0
tellraw @s[type=player,tag=!foGamePlayer] [{"text":""},{"text":"増え鬼","color":"yellow","bold":"true"},{"text":" » ","color":"gray"},{"text":"あなたは次の増え鬼ゲームの参加者になりました。","color":"green"}]
team join foGameJoinQueue @s[type=player,tag=!foGamePlayer]
tag @s[type=player,tag=!foGamePlayer] add foGamePlayer