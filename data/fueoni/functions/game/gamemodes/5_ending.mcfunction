#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

scoreboard players add game_timer foGameData 1
effect give @a[tag=foGamePlayer] saturation infinite 127 true
effect give @a[tag=foGamePlayer] resistance infinite 127 true
effect give @a[tag=foGamePlayer] instant_health infinite 127 true
execute if score game_timer foGameData matches 1 run execute as @a[tag=foGamePlayer] at @s run playsound minecraft:entity.player.levelup voice @s ~ ~ ~ 50.0 1.0
execute if score game_timer foGameData matches 1 run title @a[tag=foGamePlayer] times 5 60 20
execute if score game_timer foGameData matches 1 if score game_winner foGameData matches 1 run title @a[tag=foGamePlayer] title {"translate":"fueoni.title.ending.runner_win","fallback":"逃走者の勝利","color":"green","bold":true}
execute if score game_timer foGameData matches 1 if score game_winner foGameData matches 1 run title @a[tag=foGamePlayer] subtitle {"translate":"fueoni.title.ending.no_oni","fallback":"全ての鬼がいなくなった！"}
execute if score game_timer foGameData matches 1 if score game_winner foGameData matches 2 run title @a[tag=foGamePlayer] title {"translate":"fueoni.title.ending.oni_win","fallback":"鬼の勝利","color":"red","bold":true}
execute if score game_timer foGameData matches 1 if score game_winner foGameData matches 2 run title @a[tag=foGamePlayer] subtitle {"translate":"fueoni.title.ending.no_runner","fallback":"逃走者が全員つかまった！"}
execute if score game_timer foGameData matches 1 if score game_winner foGameData matches 3 run title @a[tag=foGamePlayer] title {"translate":"fueoni.title.ending.runner_win","fallback":"逃走者の勝利","color":"green","bold":true}
execute if score game_timer foGameData matches 1 if score game_winner foGameData matches 3 run title @a[tag=foGamePlayer] subtitle {"translate":"fueoni.title.ending.out_of_time","fallback":"制限時間切れになった！"}
execute if score game_timer foGameData matches 100.. run function fueoni:game/reset
