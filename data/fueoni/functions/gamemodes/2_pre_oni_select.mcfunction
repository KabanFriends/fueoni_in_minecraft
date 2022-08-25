#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

scoreboard players add game_timer foGameData 1
effect give @a[tag=foGamePlayer] resistance 1000000 127 true
effect give @a[tag=foGamePlayer] instant_health 1000000 127 true
effect give @a[tag=foGamePlayer] saturation 1000000 127 true
execute if score game_timer foGameData matches 1 run scoreboard players set num_20 foGameData 20
execute if score game_timer foGameData matches 1 run scoreboard players set game_timeleft foGameData 15
execute if score game_timer foGameData matches 1 run scoreboard objectives setdisplay sidebar foListSidebar
execute if score game_timer foGameData matches 1 run scoreboard players set @a[tag=foGamePlayer] foAliveTime 3
scoreboard players operation game_ticksec foGameData = game_timer foGameData
scoreboard players operation game_ticksec foGameData %= num_20 foGameData
execute if score game_timeleft foGameData matches 2.. if score game_ticksec foGameData matches 0 run execute as @a[tag=foGamePlayer] at @s run playsound minecraft:block.note_block.hat voice @s ~ ~ ~ 1.0 1.0
execute if score game_ticksec foGameData matches 0 run scoreboard players remove game_timeleft foGameData 1
scoreboard players operation 鬼抽選まで(秒) foListSidebar = game_timeleft foGameData
execute if score game_timer foGameData matches 1 run tellraw @a[tag=foGamePlayer] [{"text":""},{"text":"増え鬼","color":"yellow","bold":true},{"text":" » ","color":"gray"},{"text":"鬼が","color":"aqua"},{"score":{"name":"game_timeleft","objective":"foGameData"},"color":"red","bold":true},{"text":"秒後","color":"red","bold":true},{"text":"に抽選されます！","color":"aqua"}]
execute if score game_timeleft foGameData matches 10 if score game_ticksec foGameData matches 0 run tellraw @a[tag=foGamePlayer] [{"text":""},{"text":"増え鬼","color":"yellow","bold":true},{"text":" » ","color":"gray"},{"text":"鬼が","color":"aqua"},{"score":{"name":"game_timeleft","objective":"foGameData"},"color":"red","bold":true},{"text":"秒後","color":"red","bold":true},{"text":"に抽選されます！","color":"aqua"}]
execute if score game_timeleft foGameData matches 1..5 if score game_ticksec foGameData matches 0 run tellraw @a[tag=foGamePlayer] [{"text":""},{"text":"増え鬼","color":"yellow","bold":true},{"text":" » ","color":"gray"},{"text":"鬼が","color":"aqua"},{"score":{"name":"game_timeleft","objective":"foGameData"},"color":"red","bold":true},{"text":"秒後","color":"red","bold":true},{"text":"に抽選されます！","color":"aqua"}]
#oni player check
execute as @e[tag=foStartLocation] at @s run function fueoni:particle/circle_reddust_big
execute at @e[tag=foStartLocation] run execute as @a[tag=foGamePlayer,distance=5..] run execute as @s[tag=foOniSelection] at @s run playsound minecraft:ui.button.click voice @s ~ ~ ~ 1.0 1.0
execute at @e[tag=foStartLocation] run tag @a[tag=foGamePlayer,distance=5..] remove foOniSelection
execute at @e[tag=foStartLocation] run execute as @a[tag=foGamePlayer,distance=..5] run execute as @s[tag=!foOniSelection] at @s run playsound minecraft:ui.button.click voice @s ~ ~ ~ 1.0 1.0
execute at @e[tag=foStartLocation] run tag @a[tag=foGamePlayer,distance=..5] add foOniSelection
execute as @a[tag=foGamePlayer] run title @s[tag=foOniSelection] actionbar {"text":"鬼の抽選候補です","color":"red","bold":true}
execute as @a[tag=foGamePlayer] run title @s[tag=!foOniSelection] actionbar {"text":"鬼の抽選候補ではありません","color":"green","bold":true}
#no oni selection
execute if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 if score all_onisels foGameData matches 0 run tellraw @a[tag=foGamePlayer] [{"text":""},{"text":"増え鬼","color":"yellow","bold":true},{"text":" » ","color":"gray"},{"text":"鬼の希望者がいないので、最初の鬼がランダムに選ばれます！","color":"yellow"}]
execute if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 if score all_onisels foGameData matches 0 run tag @a[tag=foGamePlayer] add foOniSelection
#select one random oni
execute if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 run team join foRunner @a[tag=foGamePlayer]
execute if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 run tag @r[tag=foOniSelection] add foTempOni
execute if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 run team join foOni @a[tag=foTempOni]
execute if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 run item replace entity @a[tag=foGamePlayer,team=foRunner] hotbar.0 with minecraft:wooden_shovel{display: {Name: '{"text":"逃走者の鈍器","color":"yellow","bold":true,"italic":false}', Lore: ['{"text":"鬼が来たらこれで引き離せ！","color":"gray","italic":false}', '{"text":"使いづらいけど頑張れ！！","color":"gray","italic":false}']}, Unbreakable: 1b, HideFlags: 63, Enchantments: [{id: "minecraft:knockback", lvl: 2s}, {id: "minecraft:vanishing_curse", lvl: 1s}]}
execute if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 run item replace entity @a[tag=foGamePlayer,team=foRunner] armor.chest with minecraft:leather_chestplate{display: {Name: '{"text":"逃走者の服","color":"green","bold":true,"italic":false}', Lore: ['{"text":"普通の服だよ","color":"gray","italic":false}', '{"text":"脱げないけどね","color":"gray","italic":false}'], color: 65280}, HideFlags: 63, Unbreakable: 1b, Enchantments: [{id: "minecraft:binding_curse", lvl: 1s}, {id: "minecraft:vanishing_curse", lvl: 1s}]}
execute if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 at @e[tag=foStartLocation] run teleport @a[tag=foGamePlayer,team=foOni] ~ -80 ~ ~ 90.0
execute if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 run tellraw @a[tag=foGamePlayer] [{"text":""},{"text":"増え鬼","color":"yellow","bold":true},{"text":" » ","color":"gray"},{"text":"最初の鬼は","color":"yellow"},{"selector":"@a[tag=foTempOni]"},{"text":"さんになりました！","color":"yellow"}]
execute if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 run tellraw @a[tag=foGamePlayer,team=foRunner] [{"text":""},{"text":"増え鬼","color":"yellow","bold":true},{"text":" » ","color":"gray"},{"text":"鬼が解放される前にできるだけ逃げろ！","color":"gold"}]
#count 0
execute if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 run execute as @a[tag=foGamePlayer] at @s run playsound block.note_block.pling voice @s ~ ~ ~ 1.0 1.0
#change gamemode
execute if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 run scoreboard players set game_timer foGameData 0
execute if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 run scoreboard players set game_mode foGameData 3
#respawn
tp @a[tag=foGamePlayer,scores={foAliveTime=2}] @e[tag=foStartLocation,limit=1]
scoreboard players set @a[tag=foGamePlayer,scores={foAliveTime=3..}] foAliveTime 3
