#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

playsound minecraft:entity.player.levelup voice @s[type=player,tag=!foGamePlayer] ~ ~ ~ 1.0 2.0
tellraw @s[type=player,tag=!foGamePlayer] [{"text":""},{"translate":"増え鬼%1$s","color":"yellow","bold":true,"with":[{"text":" » ","color":"gray","bold":false}]},{"translate":"あなたは次の増え鬼ゲームの参加者になりました。","color":"green"}]
team join foGameJoinQueue @s[type=player,tag=!foGamePlayer]

#before oni selection -> teleport to game start location
execute as @s[type=player,tag=!foGamePlayer] if score game_mode foGameData matches 1..2 run function fueoni:player/remove_tags
execute as @s[type=player,tag=!foGamePlayer] if score game_mode foGameData matches 1..2 run team join foGameJoinQueue @s
execute as @s[type=player,tag=!foGamePlayer] if score game_mode foGameData matches 1..2 run clear @s
execute as @s[type=player,tag=!foGamePlayer] if score game_mode foGameData matches 1..2 run gamemode adventure @s
execute as @s[type=player,tag=!foGamePlayer] if score game_mode foGameData matches 1..2 run tp @s @e[tag=foStartLocation,limit=1]
#after oni selection -> spectator
execute as @s[type=player,tag=!foGamePlayer] if score game_mode foGameData matches 3..5 run function fueoni:player/remove_tags
execute as @s[type=player,tag=!foGamePlayer] if score game_mode foGameData matches 3..5 run team join foGameJoinQueue @s
execute as @s[type=player,tag=!foGamePlayer] if score game_mode foGameData matches 3..5 run clear @s
execute as @s[type=player,tag=!foGamePlayer] if score game_mode foGameData matches 3..5 run gamemode spectator @s
execute as @s[type=player,tag=!foGamePlayer] if score game_mode foGameData matches 3..4 run tp @s @a[tag=foGamePlayer,sort=random,limit=1]

#add gameplayer tag
tag @s[type=player,tag=!foGamePlayer] add foGamePlayer
