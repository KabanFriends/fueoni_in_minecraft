#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

playsound minecraft:entity.player.levelup voice @s[type=player,tag=!foGamePlayer] ~ ~ ~ 1.0 2.0
tellraw @s[type=player,tag=!foGamePlayer] [{"text":""},{"text":"増え鬼","color":"yellow","bold":"true"},{"text":" » ","color":"gray"},{"text":"あなたは次の増え鬼ゲームの参加者になりました。","color":"green"}]
team join foGameJoinQueue @s[type=player,tag=!foGamePlayer]

#turn into spectator and tp to random player if game already started
execute if score game_mode foGameData matches 4.. run gamemode spectator @s[type=player,tag=!foGamePlayer]
execute if score game_mode foGameData matches 4.. run tp @s[type=player,tag=!foGamePlayer] @a[tag=foGamePlayer,sort=random,limit=1]

#add gameplayer tag
tag @s[type=player,tag=!foGamePlayer] add foGamePlayer