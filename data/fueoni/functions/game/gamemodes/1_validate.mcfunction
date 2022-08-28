#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

scoreboard players set game_checks foGameData 0
scoreboard players set game_noplayer foGameData 0
#check 1 - lobby x
execute if score lobby_xpos foGameOption matches 1.. run scoreboard players add game_checks foGameData 1
execute if score lobby_xpos foGameOption matches ..0 run scoreboard players add game_checks foGameData 1
execute if score tp_lobby foGameOption matches 0 if score game_checks foGameData matches ..0 run scoreboard players add game_checks foGameData 1
#check 2 - lobby y
execute if score lobby_ypos foGameOption matches 1.. run scoreboard players add game_checks foGameData 1
execute if score lobby_ypos foGameOption matches ..0 run scoreboard players add game_checks foGameData 1
execute if score tp_lobby foGameOption matches 0 if score game_checks foGameData matches ..1 run scoreboard players add game_checks foGameData 1
#check 3 - lobby z
execute if score lobby_zpos foGameOption matches 1.. run scoreboard players add game_checks foGameData 1
execute if score lobby_zpos foGameOption matches ..0 run scoreboard players add game_checks foGameData 1
execute if score tp_lobby foGameOption matches 0 if score game_checks foGameData matches ..2 run scoreboard players add game_checks foGameData 1
#check 4 - players
scoreboard players operation req_players foGameData = oni_count foGameOption
scoreboard players add req_players foGameData 1
execute if score all_players foGameData >= req_players foGameData run scoreboard players add game_checks foGameData 1
execute unless score all_players foGameData >= req_players foGameData run scoreboard players set game_noplayer foGameData 1
#check pass
execute if score game_checks foGameData matches 4.. run tp @a[tag=foGamePlayer] @e[tag=foStartLocation,limit=1]
execute if score game_checks foGameData matches 4.. at @e[tag=foStartLocation] run spawnpoint @a[tag=foGamePlayer] ~ ~ ~
execute if score game_checks foGameData matches 4.. as @a[tag=foGamePlayer] run function fueoni:player/remove_tags
execute if score game_checks foGameData matches 4.. run function fueoni:game/prepare
execute if score game_checks foGameData matches 4.. run tag @a[tag=foGamePlayer] add foOniSelection
execute if score game_checks foGameData matches 4.. run gamemode adventure @a[tag=foGamePlayer]
execute if score game_checks foGameData matches 4.. run clear @a[tag=foGamePlayer]
execute if score game_checks foGameData matches 4.. run scoreboard players add sessionID foGameOption 1
execute if score game_checks foGameData matches 4.. run scoreboard players operation @a[tag=foGamePlayer] foPlayerSID = sessionID foGameOption
execute if score game_checks foGameData matches 4.. run scoreboard objectives setdisplay sidebar foListSidebar
execute if score game_checks foGameData matches 4.. run tellraw @a[tag=foGamePlayer] [{"text":""},{"translate":"増え鬼%1$s","color":"yellow","bold":true,"with":[{"text":" » ","color":"gray","bold":false}]},{"translate":"このあとゲームが参加者%1$sで始まります！","color":"green","with":[{"translate":"%1$s人","color":"gold","bold":true,"with":[{"score":{"name":"all_players","objective":"foGameData"},"color":"gold","bold":true}]}]}]
execute if score game_checks foGameData matches 4.. run tellraw @a[tag=foGamePlayer] [{"text":""},{"translate":"増え鬼%1$s","color":"yellow","bold":true,"with":[{"text":" » ","color":"gray","bold":false}]},{"translate":"最初の鬼が%1$s抽選されます。","color":"gold","with":[{"translate":"%1$s人","color":"yellow","bold":true,"with":[{"score":{"name":"oni_count","objective":"foGameOption"}}]}]}]
execute if score game_checks foGameData matches 4.. run tellraw @a[tag=foGamePlayer] [{"text":""},{"translate":"増え鬼%1$s","color":"yellow","bold":true,"with":[{"text":" » ","color":"gray","bold":false}]},{"translate":"鬼になりたい人は、%1$sに入ってください！","color":"gold","with":[{"translate":"赤い輪の中","color":"red","bold":true}]}]
execute if score game_checks foGameData matches 4.. run execute as @a[tag=foGamePlayer] at @s run playsound minecraft:entity.player.levelup voice @s ~ ~ ~ 1.0 1.0
execute if score game_checks foGameData matches 4.. at @e[tag=foStartLocation] run particle minecraft:flame ~ ~ ~ 0 3 0 0 100 force @a
execute if score game_checks foGameData matches 4.. run scoreboard players set game_mode foGameData 2
#check fail
execute unless score game_checks foGameData matches 4.. as @a[advancements={fueoni:spawn_egg/start_game=true}] at @s run playsound minecraft:block.note_block.bass voice @s ~ ~ ~ 1.0 1.0
execute unless score game_checks foGameData matches 4.. unless score game_noplayer foGameData matches 1 run tellraw @a[advancements={fueoni:spawn_egg/start_game=true}] [{"text":""},{"translate":"増え鬼%1$s","color":"yellow","bold":true,"with":[{"text":" » ","color":"gray","bold":false}]},{"translate":"ロビー地点が設定されていません。","color":"red"}]
execute unless score game_checks foGameData matches 4.. if score game_noplayer foGameData matches 1 run tellraw @a[advancements={fueoni:spawn_egg/start_game=true}] [{"text":""},{"translate":"増え鬼%1$s","color":"yellow","bold":true,"with":[{"text":" » ","color":"gray","bold":false}]},{"translate":"ゲームを始めるには%1$sのプレイヤーが必要です。","color":"red","with":[{"translate":"%1$s人以上","color":"gold","with":[{"score":{"name":"req_players","objective":"foGameData"}}]}]}]
execute unless score game_checks foGameData matches 4.. run kill @e[tag=foStartLocation]
execute unless score game_checks foGameData matches 4.. run scoreboard players set game_timer foGameData 0
execute unless score game_checks foGameData matches 4.. run scoreboard players set game_mode foGameData 0
