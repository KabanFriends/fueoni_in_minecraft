#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

scoreboard players set game_checks foGameData 0
scoreboard players set game_noplayer foGameData 0
#check 1 - lobby x
execute if score lobby_xpos foGameOption matches 1.. run scoreboard players add game_checks foGameData 1
execute if score lobby_xpos foGameOption matches ..0 run scoreboard players add game_checks foGameData 1
#check 2 - lobby y
execute if score lobby_ypos foGameOption matches 1.. run scoreboard players add game_checks foGameData 1
execute if score lobby_ypos foGameOption matches ..0 run scoreboard players add game_checks foGameData 1
#check 3 - lobby z
execute if score lobby_zpos foGameOption matches 1.. run scoreboard players add game_checks foGameData 1
execute if score lobby_zpos foGameOption matches ..0 run scoreboard players add game_checks foGameData 1
#check 4 - players
execute if score all_players foGameData matches 2.. run scoreboard players add game_checks foGameData 1
execute unless score all_players foGameData matches 2.. run scoreboard players set game_noplayer foGameData 1
#check pass
execute if score game_checks foGameData matches 4.. as @e[tag=foStartLocation] run tp @a[tag=foGamePlayer] @s
execute if score game_checks foGameData matches 4.. as @a[tag=foGamePlayer] run function fueoni:player/remove_tags
execute if score game_checks foGameData matches 4.. run tag @a[tag=foGamePlayer] add foOniSelection
execute if score game_checks foGameData matches 4.. run gamemode adventure @a[tag=foGamePlayer]
execute if score game_checks foGameData matches 4.. run clear @a[tag=foGamePlayer]
execute if score game_checks foGameData matches 4.. run scoreboard players add sessionID foGameOption 1
execute if score game_checks foGameData matches 4.. run scoreboard players operation @a[tag=foGamePlayer] foPlayerSID = sessionID foGameOption
execute if score game_checks foGameData matches 4.. run scoreboard objectives setdisplay sidebar foListSidebar
execute if score game_checks foGameData matches 4.. run tellraw @a[tag=foGamePlayer] [{"text":""},{"text":"増え鬼","color":"yellow","bold":true},{"text":" » ","color":"gray"},{"text":"このあとゲームが参加者","color":"green"},{"score":{"name":"all_players","objective":"foGameData"},"color":"gold","bold":true},{"text":"人","color":"gold","bold":true},{"text":"で始まります！","color":"green"}]
execute if score game_checks foGameData matches 4.. run tellraw @a[tag=foGamePlayer] [{"text":""},{"text":"増え鬼","color":"yellow","bold":true},{"text":" » ","color":"gray"},{"text":"1人目の鬼になりたい人は、","color":"gold"},{"text":"赤い輪の中","color":"red","bold":true},{"text":"に入ってください！","color":"gold"}]
execute if score game_checks foGameData matches 4.. run execute as @a[tag=foGamePlayer] at @s run playsound minecraft:entity.player.levelup voice @s ~ ~ ~ 1.0 1.0
execute if score game_checks foGameData matches 4.. at @e[tag=foStartLocation] run particle minecraft:flame ~ ~ ~ 0 3 0 0 100 force @a
execute if score game_checks foGameData matches 4.. run scoreboard players set game_mode foGameData 2
#check fail
execute unless score game_checks foGameData matches 4.. as @e[tag=foStartLocation] at @s run execute as @a[distance=..5] at @s run playsound minecraft:block.note_block.bass voice @s ~ ~ ~ 1.0 1.0
execute unless score game_checks foGameData matches 4.. unless score game_noplayer foGameData matches 1 as @e[tag=foStartLocation] at @s run tellraw @a[distance=..5] [{"text":""},{"text":"増え鬼","color":"yellow","bold":true},{"text":" » ","color":"gray"},{"text":"ロビー地点が設定されていません。","color":"red"}]
execute unless score game_checks foGameData matches 4.. if score game_noplayer foGameData matches 1 as @e[tag=foStartLocation] at @s run tellraw @a[distance=..5] [{"text":""},{"text":"増え鬼","color":"yellow","bold":true},{"text":" » ","color":"gray"},{"text":"ゲームを始めるには","color":"red"},{"text":"2人以上","color":"gold"},{"text":"のプレイヤーが必要です。","color":"red"}]
execute unless score game_checks foGameData matches 4.. run kill @e[tag=foStartLocation]
execute unless score game_checks foGameData matches 4.. run scoreboard players set game_timer foGameData 0
execute unless score game_checks foGameData matches 4.. run scoreboard players set game_mode foGameData 0
