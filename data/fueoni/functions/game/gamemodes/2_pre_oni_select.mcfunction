#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

scoreboard players add game_timer foGameData 1
effect give @a[tag=foGamePlayer] resistance infinite 127 true
effect give @a[tag=foGamePlayer] instant_health infinite 127 true
effect give @a[tag=foGamePlayer] saturation infinite 127 true
execute if score game_timer foGameData matches 1 run scoreboard players set num_5 foGameData 5
execute if score game_timer foGameData matches 1 run scoreboard players set num_20 foGameData 20
execute if score game_timer foGameData matches 1 run scoreboard players set game_timeleft foGameData 15
execute if score game_timer foGameData matches 1 run scoreboard objectives setdisplay sidebar foListSidebar
execute if score game_timer foGameData matches 1 run scoreboard players set @a[tag=foGamePlayer] foAliveTime 3
#spawn particle origins
execute if score game_timer foGameData matches 1 at @e[tag=foStartLocation] run summon marker ~ ~ ~ {Tags:["foParticleOrigin","foGameEntity"]}
execute if score game_timer foGameData matches 1 at @e[tag=foStartLocation] run summon marker ~ ~0.75 ~ {Tags:["foParticleOrigin","foGameEntity"]}
execute if score game_timer foGameData matches 1 at @e[tag=foStartLocation] run summon marker ~ ~1.5 ~ {Tags:["foParticleOrigin","foGameEntity"]}
execute if score game_timer foGameData matches 1 at @e[tag=foStartLocation] run summon marker ~ ~2.25 ~ {Tags:["foParticleOrigin","foGameEntity"]}
execute if score game_timer foGameData matches 1 at @e[tag=foStartLocation] run summon marker ~ ~3 ~ {Tags:["foParticleOrigin","foGameEntity"]}
scoreboard players operation game_ticksec foGameData = game_timer foGameData
scoreboard players operation game_ticksec foGameData %= num_20 foGameData
execute if score game_timeleft foGameData matches 2.. if score game_ticksec foGameData matches 0 run execute as @a[tag=foGamePlayer] at @s run playsound minecraft:block.note_block.hat voice @s ~ ~ ~ 1.0 1.0
execute if score game_ticksec foGameData matches 0 run scoreboard players remove game_timeleft foGameData 1
team join foCountdownTime §r§r§r§r§r
scoreboard players operation §r§r§r§r§r foListSidebar = game_timeleft foGameData
execute if score game_timer foGameData matches 1 run tellraw @a[tag=foGamePlayer] [{"text":""},{"translate":"fueoni.message.prefix","fallback":"増え鬼","color":"yellow","bold":true},{"text":" » ","color":"gray","bold":false},{"translate":"fueoni.message.starting.oni_select_countdown","fallback":"鬼が%1$sに抽選されます！","color":"aqua","with":[{"translate":"fueoni.unit.seconds_later","fallback":"%1$s秒後","color":"red","bold":true,"with":[{"score":{"name":"game_timeleft","objective":"foGameData"},"color":"red","bold":true}]}]}]
execute if score game_timeleft foGameData matches 10 if score game_ticksec foGameData matches 0 run tellraw @a[tag=foGamePlayer] [{"text":""},{"translate":"fueoni.message.prefix","fallback":"増え鬼","color":"yellow","bold":true},{"text":" » ","color":"gray","bold":false},{"translate":"fueoni.message.starting.oni_select_countdown","fallback":"鬼が%1$sに抽選されます！","color":"aqua","with":[{"translate":"fueoni.unit.seconds_later","fallback":"%1$s秒後","color":"red","bold":true,"with":[{"score":{"name":"game_timeleft","objective":"foGameData"},"color":"red","bold":true}]}]}]
execute if score game_timeleft foGameData matches 1..5 if score game_ticksec foGameData matches 0 run tellraw @a[tag=foGamePlayer] [{"text":""},{"translate":"fueoni.message.prefix","fallback":"増え鬼","color":"yellow","bold":true},{"text":" » ","color":"gray","bold":false},{"translate":"fueoni.message.starting.oni_select_countdown","fallback":"鬼が%1$sに抽選されます！","color":"aqua","with":[{"translate":"fueoni.unit.seconds_later","fallback":"%1$s秒後","color":"red","bold":true,"with":[{"score":{"name":"game_timeleft","objective":"foGameData"},"color":"red","bold":true}]}]}]
#oni player check
scoreboard players operation particle_timer foGameData = game_timer foGameData
scoreboard players operation particle_timer foGameData %= num_5 foGameData
execute as @e[tag=foParticleOrigin] at @s if score particle_timer foGameData matches 0 run function fueoni:particle/circle_reddust_big
execute at @e[tag=foStartLocation] run execute as @a[tag=foGamePlayer,distance=5..] run execute as @s[tag=foOniSelection] at @s run playsound minecraft:ui.button.click voice @s ~ ~ ~ 1.0 1.0
execute at @e[tag=foStartLocation] run tag @a[tag=foGamePlayer,distance=5..] remove foOniSelection
execute at @e[tag=foStartLocation] run execute as @a[tag=foGamePlayer,distance=..5] run execute as @s[tag=!foOniSelection] at @s run playsound minecraft:ui.button.click voice @s ~ ~ ~ 1.0 1.0
execute at @e[tag=foStartLocation] run tag @a[tag=foGamePlayer,distance=..5] add foOniSelection
execute as @a[tag=foGamePlayer] run title @s[tag=foOniSelection] actionbar {"translate":"fueoni.actionbar.starting.oni_queued","fallback":"鬼の抽選候補です","color":"red","bold":true}
execute as @a[tag=foGamePlayer] run title @s[tag=!foOniSelection] actionbar {"translate":"fueoni.actionbar.starting.oni_unqueued","fallback":"鬼の抽選候補ではありません","color":"green","bold":true}
#clear particle origins
execute if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 run kill @e[tag=foParticleOrigin]
#no oni selection
execute if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 if score all_onisels foGameData matches 0 run tellraw @a[tag=foGamePlayer] [{"text":""},{"translate":"fueoni.message.prefix","fallback":"増え鬼","color":"yellow","bold":true},{"text":" » ","color":"gray","bold":false},{"translate":"fueoni.message.starting.oni_select_random.no_players","fallback":"鬼の希望者がいないので、最初の鬼がランダムに選ばれます！","color":"yellow"}]
execute if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 if score all_onisels foGameData matches 1.. if score all_onisels foGameData < oni_count foGameOption run tellraw @a[tag=foGamePlayer] [{"text":""},{"translate":"fueoni.message.prefix","fallback":"増え鬼","color":"yellow","bold":true},{"text":" » ","color":"gray","bold":false},{"translate":"fueoni.message.starting.oni_select_random.not_enough","fallback":"鬼の希望者が足りないので、残りの鬼がランダムに選ばれます！","color":"yellow"}]
execute if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 if score all_onisels foGameData < oni_count foGameOption run tag @a[tag=foGamePlayer] add foOniSelection
#select random oni
execute if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 run team join foRunner @a[tag=foGamePlayer]
execute if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 run scoreboard players operation onis_to_sel foGameData = oni_count foGameOption
execute if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 run function fueoni:game/iterate_select_oni
execute if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 run item replace entity @a[tag=foGamePlayer,team=foRunner] hotbar.0 with minecraft:wooden_shovel{display:{Name:'{"translate":"fueoni.item.shovel.name","fallback":"逃走者の鈍器","color":"yellow","bold":true,"italic":false}',Lore:['{"translate":"fueoni.item.shovel.lore.1","fallback":"鬼が来たらこれで引き離せ！","color":"gray","italic":false}','{"translate":"fueoni.item.shovel.lore.2","fallback":"使いづらいけど頑張れ！！","color":"gray","italic":false}']},Unbreakable:1b, HideFlags:63,Enchantments:[{id:"minecraft:knockback",lvl:2s},{id:"minecraft:vanishing_curse",lvl:1s}]}
execute if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 run item replace entity @a[tag=foGamePlayer,team=foRunner] armor.chest with minecraft:leather_chestplate{display:{Name:'{"translate":"fueoni.item.runner_shirt.name","fallback":"逃走者の服","color":"green","bold":true,"italic":false}',Lore:['{"translate":"fueoni.item.runner_shirt.lore.1","fallback":"普通の服だよ","color":"gray","italic":false}','{"translate":"fueoni.item.runner_shirt.lore.2","fallback":"脱げないけどね","color":"gray","italic":false}'],color:65280},HideFlags:63,Unbreakable:1b,Enchantments:[{id:"minecraft:binding_curse",lvl:1s},{id:"minecraft:vanishing_curse",lvl:1s}]}
execute if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 at @e[tag=foStartLocation] run summon marker ~ ~ ~ {Tags:["foVoidLocation","foGameEntity"]}
execute if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 store result entity @e[tag=foVoidLocation,limit=1] Pos[1] double 1 run scoreboard players get void_y foGameData
execute if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 at @e[tag=foVoidLocation] run teleport @a[tag=foGamePlayer,team=foOni] ~ ~ ~ ~ 90.0
execute if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 run tellraw @a[tag=foGamePlayer] [{"text":""},{"translate":"fueoni.message.prefix","fallback":"増え鬼","color":"yellow","bold":true},{"text":" » ","color":"gray","bold":false},{"translate":"fueoni.message.oni_waiting.oni_players","fallback":"最初の鬼は %1$s です！","color":"yellow","with":[{"selector":"@a[team=foOni]"}]}]
execute if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 run tellraw @a[tag=foGamePlayer,team=foRunner] [{"text":""},{"translate":"fueoni.message.prefix","fallback":"増え鬼","color":"yellow","bold":true},{"text":" » ","color":"gray","bold":false},{"translate":"fueoni.message.oni_waiting.tip","fallback":"鬼が解放される前にできるだけ逃げろ！","color":"gold"}]
#count 0
execute if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 run execute as @a[tag=foGamePlayer] at @s run playsound block.note_block.pling voice @s ~ ~ ~ 1.0 1.0
#change gamemode
execute if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 run scoreboard players set game_timer foGameData 0
execute if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 run scoreboard players set game_mode foGameData 3
#respawn
tp @a[tag=foGamePlayer,scores={foAliveTime=2}] @e[tag=foStartLocation,limit=1]
scoreboard players set @a[tag=foGamePlayer,scores={foAliveTime=3..}] foAliveTime 3
