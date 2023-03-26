#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

scoreboard players add game_timer foGameData 1
effect give @a[tag=foGamePlayer] resistance infinite 127 true
effect give @a[tag=foGamePlayer] instant_health infinite 127 true
effect give @a[tag=foGamePlayer] saturation infinite 127 true
execute if score game_timer foGameData matches 1 run scoreboard players set num_20 foGameData 20
execute if score game_timer foGameData matches 1 run scoreboard players operation game_timeleft foGameData = oni_release_seconds foGameOption 
execute if score game_timer foGameData matches 1 run scoreboard objectives setdisplay sidebar foIngameSidebar
execute if score game_timer foGameData matches 1 run scoreboard players set @a[tag=foGamePlayer] foAliveTime 3
execute if score game_timer foGameData matches 1 run effect give @a[tag=foGamePlayer,team=foOni] blindness infinite 0 true
execute if score game_timer foGameData matches 1 run effect give @a[tag=foGamePlayer,team=foOni] levitation infinite 255 true
execute if score game_timer foGameData matches 1 run effect give @a[tag=foGamePlayer,team=foOni] invisibility infinite 0 true
#give oni speed effect
execute if score game_timer foGameData matches 1 if score oni_speed_seconds foGameOption matches 1.. at @e[tag=foVoidLocation] run summon area_effect_cloud ~ ~ ~ {Tags:["foOniSpeedEffect","foGameEntity"],DurationOnUse:0,WaitTime:0,Duration:2147483647,ReapplicationDelay:0,RadiusOnUse:0,RadiusPerTick:0,Radius:1f,Particle:"block air",Effects:[{Id:1b,Amplifier:0b,Ambient:true}]}
execute if score game_timer foGameData matches 1 if score oni_speed_seconds foGameOption matches 1.. store result entity @e[tag=foOniSpeedEffect,limit=1] Effects[0].Duration int 20 run scoreboard players get oni_speed_seconds foGameOption
#start countdown timer
scoreboard players operation game_ticksec foGameData = game_timer foGameData
scoreboard players operation game_ticksec foGameData %= num_20 foGameData
execute if score game_ticksec foGameData matches 0 run scoreboard players remove game_timeleft foGameData 1
team join foReleaseTime §r§r§r§r
scoreboard players operation §r§r§r§r foIngameSidebar = game_timeleft foGameData
execute if score game_timeleft foGameData matches 1..3 if score game_ticksec foGameData matches 0 run execute as @a[tag=foGamePlayer] at @s run playsound minecraft:ui.button.click voice @s ~ ~ ~ 1.0 1.0
execute if score game_timeleft foGameData matches 1..3 if score game_ticksec foGameData matches 0 run tellraw @a[tag=foGamePlayer] [{"text":""},{"translate":"fueoni.message.prefix","fallback":"増え鬼","color":"yellow","bold":true},{"text":" » ","color":"gray","bold":false},{"translate":"fueoni.message.oni_waiting.release_countdown","fallback":"鬼が%1$sに解放されます！","color":"gold","with":[{"translate":"fueoni.unit.seconds_later","fallback":"%1$s秒後","color":"red","bold":true,"with":[{"score":{"name":"game_timeleft","objective":"foGameData"},"color":"red","bold":true}]}]}]
execute if score game_timeleft foGameData matches 1.. run title @a[tag=foGamePlayer,team=foOni] times 0 40 0
execute if score game_timeleft foGameData matches 1.. run title @a[tag=foGamePlayer,team=foOni] title {"translate":"fueoni.title.oni_waiting.waiting","fallback":"解放待機中","color":"yellow","bold":true}
execute if score game_timeleft foGameData matches 1.. run title @a[tag=foGamePlayer,team=foOni] subtitle [{"translate":"fueoni.title.oni_waiting.remaining","fallback":"あと%1$s…","with":[{"translate":"fueoni.unit.seconds_later","fallback":"%1$s秒","color":"aqua","bold":true,"with":[{"score":{"name":"game_timeleft","objective":"foGameData"},"color":"aqua","bold":true}]}]}]
execute if score game_timeleft foGameData matches 1.. at @e[tag=foVoidLocation] run teleport @a[tag=foGamePlayer,team=foOni] ~ ~ ~ ~ 90.0
#count 0
execute if score game_timeleft foGameData matches 0 if score game_ticksec foGameData matches 0 run effect clear @a[tag=foGamePlayer,team=foOni] blindness
execute if score game_timeleft foGameData matches 0 if score game_ticksec foGameData matches 0 run effect clear @a[tag=foGamePlayer,team=foOni] levitation
execute if score game_timeleft foGameData matches 0 if score game_ticksec foGameData matches 0 run effect clear @a[tag=foGamePlayer] resistance
execute if score game_timeleft foGameData matches 0 if score game_ticksec foGameData matches 0 run effect clear @a[tag=foGamePlayer] instant_health
execute if score game_timeleft foGameData matches 0 if score game_ticksec foGameData matches 0 run kill @e[tag=foOniSpeedEffect]
execute if score game_timeleft foGameData matches 0 if score game_ticksec foGameData matches 0 run tp @a[tag=foGamePlayer,team=foOni] @e[tag=foStartLocation,limit=1]
execute if score game_timeleft foGameData matches 0 if score game_ticksec foGameData matches 0 if score oni_speed_seconds foGameOption matches 1.. run tellraw @a[tag=foGamePlayer] [{"text":""},{"translate":"fueoni.message.prefix","fallback":"増え鬼","color":"yellow","bold":true},{"text":" » ","color":"gray","bold":false},{"translate":"最初の鬼は%1$s、移動速度が速くなります！","color":"aqua","with":[{"translate":"fueoni.unit.seconds_duration","fallback":"%1$s秒間","color":"red","with":[{"score":{"name":"oni_speed_seconds","objective":"foGameOption"},"color":"red"}]}]}]
execute if score game_timeleft foGameData matches 0 if score game_ticksec foGameData matches 0 run title @a[tag=foGamePlayer] times 5 60 20
execute if score game_timeleft foGameData matches 0 if score game_ticksec foGameData matches 0 run title @a[tag=foGamePlayer] title {"translate":"fueoni.title.game.game_start","fallback":"ゲームスタート","color":"gold","bold":true}
execute if score game_timeleft foGameData matches 0 if score game_ticksec foGameData matches 0 run title @a[tag=foGamePlayer,team=foRunner] subtitle {"translate":"fueoni.title.game.runner_tip","fallback":"鬼につかまるな！"}
execute if score game_timeleft foGameData matches 0 if score game_ticksec foGameData matches 0 run title @a[tag=foGamePlayer,team=foOni] subtitle {"translate":"fueoni.title.game.oni_tip","fallback":"逃走者をつかまえろ！"}
execute if score game_timeleft foGameData matches 0 if score game_ticksec foGameData matches 0 run execute as @a[tag=foGamePlayer] at @s run playsound minecraft:entity.ender_dragon.growl voice @s ~ ~ ~ 50.0 1.0
execute if score game_timeleft foGameData matches 0 if score game_ticksec foGameData matches 0 run scoreboard players reset §r foIngameSidebar
execute if score game_timeleft foGameData matches 0 if score game_ticksec foGameData matches 0 run scoreboard players set game_timer foGameData 0
execute if score game_timeleft foGameData matches 0 if score game_ticksec foGameData matches 0 run scoreboard players set game_mode foGameData 4
#respawn
tp @a[tag=foGamePlayer,scores={foAliveTime=2}] @e[tag=foStartLocation,limit=1]
scoreboard players set @a[tag=foGamePlayer,scores={foAliveTime=3..}] foAliveTime 3
