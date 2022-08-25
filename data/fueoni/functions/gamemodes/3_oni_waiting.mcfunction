#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

scoreboard players add game_timer foGameData 1
effect give @a[tag=foGamePlayer] resistance 1000000 127 true
effect give @a[tag=foGamePlayer] instant_health 1000000 127 true
effect give @a[tag=foGamePlayer] saturation 1000000 127 true
execute if score game_timer foGameData matches 1 run scoreboard players set num_20 foGameData 20
execute if score game_timer foGameData matches 1 run scoreboard players set game_timeleft foGameData 15
execute if score game_timer foGameData matches 1 run scoreboard objectives setdisplay sidebar foIngameSidebar
execute if score game_timer foGameData matches 1 run scoreboard players set @a[tag=foGamePlayer] foAliveTime 3
execute if score game_timer foGameData matches 1 run effect give @a[tag=foGamePlayer,team=foOni] blindness 1000000 0 true
execute if score game_timer foGameData matches 1 run effect give @a[tag=foGamePlayer,team=foOni] levitation 1000000 255 true
execute if score game_timer foGameData matches 1 run item replace entity @a[tag=foGamePlayer,team=foOni] armor.chest with minecraft:leather_chestplate{display: {Name: '{"text":"鬼の服","color":"red","bold":true,"italic":false}', Lore: ['{"text":"トマトジュースで染まった","color":"gray","italic":false}', '{"text":"きれいな赤色！","color":"gray","italic":false}'], color: 16711680}, HideFlags: 63, Unbreakable: 1b, Enchantments: [{id: "minecraft:protection", lvl: 127s}, {id: "minecraft:binding_curse", lvl: 1s}, {id: "minecraft:vanishing_curse", lvl: 1s}]}
scoreboard players operation game_ticksec foGameData = game_timer foGameData
scoreboard players operation game_ticksec foGameData %= num_20 foGameData
execute if score game_ticksec foGameData matches 0 run scoreboard players remove game_timeleft foGameData 1
scoreboard players operation 鬼解放まで(秒) foIngameSidebar = game_timeleft foGameData
execute if score game_timeleft foGameData matches 1..3 if score game_ticksec foGameData matches 0 run execute as @a[tag=foGamePlayer] at @s run playsound minecraft:ui.button.click voice @s ~ ~ ~ 1.0 1.0
execute if score game_timeleft foGameData matches 1..3 if score game_ticksec foGameData matches 0 run tellraw @a[tag=foGamePlayer] [{"text":""},{"text":"増え鬼","color":"yellow","bold":true},{"text":" » ","color":"gray"},{"text":"鬼が","color":"gold"},{"score":{"name":"game_timeleft","objective":"foGameData"},"color":"red","bold":true},{"text":"秒後","color":"red","bold":true},{"text":"に解放されます！","color":"gold"}]
execute if score game_timeleft foGameData matches 1.. run title @a[tag=foGamePlayer,team=foOni] times 0 40 0
execute if score game_timeleft foGameData matches 1.. run title @a[tag=foGamePlayer,team=foOni] title {"text":"解放待機中","color":"yellow","bold":true}
execute if score game_timeleft foGameData matches 1.. run title @a[tag=foGamePlayer,team=foOni] subtitle [{"text":"あと"},{"score":{"name":"game_timeleft","objective":"foGameData"},"color":"aqua","bold":true},{"text":"秒","color":"aqua","bold":true},{"text":"…"}]
execute if score game_timeleft foGameData matches 1.. at @e[tag=foStartLocation] run teleport @a[tag=foGamePlayer,team=foOni] ~ -80 ~ ~ 90.0
#count 0
execute if score game_timeleft foGameData matches 0 if score game_ticksec foGameData matches 0 run effect clear @a[tag=foGamePlayer,team=foOni] blindness
execute if score game_timeleft foGameData matches 0 if score game_ticksec foGameData matches 0 run effect clear @a[tag=foGamePlayer,team=foOni] levitation
execute if score game_timeleft foGameData matches 0 if score game_ticksec foGameData matches 0 run effect clear @a[tag=foGamePlayer] resistance
execute if score game_timeleft foGameData matches 0 if score game_ticksec foGameData matches 0 run effect clear @a[tag=foGamePlayer] instant_health
execute if score game_timeleft foGameData matches 0 if score game_ticksec foGameData matches 0 run tp @a[tag=foGamePlayer,team=foOni] @e[tag=foStartLocation,limit=1]
execute if score game_timeleft foGameData matches 0 if score game_ticksec foGameData matches 0 run title @a[tag=foGamePlayer] times 20 60 20
execute if score game_timeleft foGameData matches 0 if score game_ticksec foGameData matches 0 run title @a[tag=foGamePlayer] title {"text":"ゲームスタート","color":"gold","bold":true}
execute if score game_timeleft foGameData matches 0 if score game_ticksec foGameData matches 0 run title @a[tag=foGamePlayer,team=foRunner] subtitle {"text":"鬼につかまるな！"}
execute if score game_timeleft foGameData matches 0 if score game_ticksec foGameData matches 0 run title @a[tag=foGamePlayer,team=foOni] subtitle {"text":"逃走者をつかまえろ！"}
execute if score game_timeleft foGameData matches 0 if score game_ticksec foGameData matches 0 run execute as @a[tag=foGamePlayer] at @s run playsound minecraft:entity.ender_dragon.growl voice @s ~ ~ ~ 50.0 1.0
execute if score game_timeleft foGameData matches 0 if score game_ticksec foGameData matches 0 run scoreboard players reset 鬼解放まで(秒) foIngameSidebar
execute if score game_timeleft foGameData matches 0 if score game_ticksec foGameData matches 0 run scoreboard players set game_timer foGameData 0
execute if score game_timeleft foGameData matches 0 if score game_ticksec foGameData matches 0 run scoreboard players set game_mode foGameData 4
#respawn
tp @a[tag=foGamePlayer,scores={foAliveTime=2}] @e[tag=foStartLocation,limit=1]
scoreboard players set @a[tag=foGamePlayer,scores={foAliveTime=3..}] foAliveTime 3
