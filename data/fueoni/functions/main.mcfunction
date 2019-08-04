#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

#GIVE ADMIN ITEM
execute as @e[nbt={Inventory:[{id:"minecraft:command_block",tag:{display:{Name:"{\"text\":\"fueoni\"}"}}}]}] run function fueoni:player/admin

#ADMIN ENTITY: SET LOBBY
execute if entity @e[tag=foSetLobby] as @e[tag=foSetLobby] store result score lobby_x foGameOption run data get entity @s Pos[0] 1
execute if entity @e[tag=foSetLobby] as @e[tag=foSetLobby] store result score lobby_y foGameOption run data get entity @s Pos[1] 1
execute if entity @e[tag=foSetLobby] as @e[tag=foSetLobby] store result score lobby_z foGameOption run data get entity @s Pos[2] 1
execute if entity @e[tag=foSetLobby] as @e[tag=foSetLobby] at @s run particle minecraft:end_rod ~ ~ ~ 0 3 0 0 100 force @a

#ADMIN ENTITY: ADD PLAYERS
execute as @e[tag=foAddPlayers] at @s run execute as @a[tag=!foGamePlayer,distance=..3] run function fueoni:player/join
execute as @e[tag=foAddPlayers] at @s run summon armor_stand ~ ~ ~ {Tags:["foAddParticleOrigin"],Invisible:true,Invulnerable:true,Marker:true,NoGravity:true,Small:true}
execute as @e[tag=foAddParticleOrigin] at @s run particle minecraft:crit ~ ~ ~ 0 3 0 0 100 force @a
execute as @e[tag=foAddParticleOrigin] at @s run function fueoni:particle/circle_happy_villager
kill @e[tag=foAddParticleOrigin]

#ADMIN ENTITY: SHOW JOINED PLAYERS
execute as @e[tag=foShowJoinedPlayers] at @s run scoreboard objectives setdisplay sidebar foListSidebar

#ADMIN ENTITY: REMOVE PLAYERS
execute as @e[tag=foRemovePlayers] at @s run execute as @a[tag=foGamePlayer,distance=..3,team=foGameJoinQueue] run function fueoni:player/quit
execute as @e[tag=foRemovePlayers] at @s run summon armor_stand ~ ~ ~ {Tags:["foRemoveParticleOrigin"],Invisible:true,Invulnerable:true,Marker:true,NoGravity:true,Small:true}
execute as @e[tag=foRemoveParticleOrigin] at @s run particle minecraft:crit ~ ~ ~ 0 3 0 0 100 force @a
execute as @e[tag=foRemoveParticleOrigin] at @s run function fueoni:particle/circle_reddust
kill @e[tag=foRemoveParticleOrigin]

#ADMIN ENTITY: REMOVE ALL PLAYERS
execute as @e[tag=foRemoveAllPlayers] run execute as @a[tag=foGamePlayer] at @s run playsound minecraft:block.note_block.bass voice @s ~ ~ ~ 1.0 1.0
execute as @e[tag=foRemoveAllPlayers] run execute as @a[tag=foGamePlayer,team=foGameJoinQueue] run function fueoni:player/quit

#ADMIN ENTITY: START
execute as @e[tag=foStart] at @s run function fueoni:start

#ADMIN ENTITY: START ALL PLAYERS
execute as @e[tag=foStartAllPlayers] run team join foGameJoinQueue @a[tag=!foGamePlayer]
execute as @e[tag=foStartAllPlayers] at @s run tag @a[tag=!foGamePlayer] add foGamePlayer
execute as @e[tag=foStartAllPlayers] at @s run function fueoni:start

#ADMIN ENTITY: END GAME
execute as @e[tag=foEndGame] run execute as @a[tag=foGamePlayer] at @s run playsound minecraft:block.note_block.bass voice @s ~ ~ ~ 1.0 1.0
execute as @e[tag=foEndGame] run function fueoni:reset
execute as @e[tag=foEndGame] run kill @e[tag=foGameEntity]
execute as @e[tag=foEndGame] run team join foGameJoinQueue @a[tag=foGamePlayer]

#ADMIN ENTITY: CHANGE TIME
execute as @e[tag=foChangeTime] at @s run execute as @a[distance=..5,scores={foSneakTime=1..}] run tag @e[tag=foChangeTime] add foHasSneaker
execute as @e[tag=foChangeTime,tag=!foHasSneaker] at @s run execute as @a[distance=..5] at @s run playsound minecraft:block.wooden_button.click_on voice @s ~ ~ ~ 1.0 1.8
execute as @e[tag=foChangeTime,tag=!foHasSneaker] run scoreboard players add game_minutes foGameOption 1 
execute as @e[tag=foChangeTime,tag=foHasSneaker] at @s if score game_minutes foGameOption matches 1 run execute as @a[distance=..5] at @s run playsound minecraft:block.note_block.bass voice @s ~ ~ ~ 1.0 1.0
execute as @e[tag=foChangeTime,tag=foHasSneaker] at @s if score game_minutes foGameOption matches 1 run tellraw @a[distance=..5] [{"text":""},{"text":"増え鬼","color":"yellow","bold":"true"},{"text":" » ","color":"gray"},{"text":"ゲームの長さは","color":"red"},{"text":"1分以上","color":"gold"},{"text":"である必要があります。","color":"red"}]
execute as @e[tag=foChangeTime,tag=foHasSneaker] at @s if score game_minutes foGameOption matches 2.. run execute as @a[distance=..5] at @s run playsound minecraft:block.wooden_button.click_on voice @s ~ ~ ~ 1.0 1.0
execute as @e[tag=foChangeTime,tag=foHasSneaker] if score game_minutes foGameOption matches 2.. run scoreboard players remove game_minutes foGameOption 1
execute as @e[tag=foChangeTime] at @s run title @a[distance=..5] actionbar [{"text":""},{"text":">","color":"gray","bold":"true"},{"text":" ゲームの長さ: ","color":"green"},{"score":{"name":"game_minutes","objective":"foGameOption"},"color":"aqua","bold":"true"},{"text":"分間","color":"aqua","bold":"true"}]

#VARIOUS DATA COLLECTION
scoreboard players add game_minutes foGameOption 0

scoreboard players add game_mode foGameData 0
scoreboard players add game_timer foGameData 0
scoreboard players set all_players foGameData 0
scoreboard players set all_queues foGameData 0
scoreboard players set all_runners foGameData 0
scoreboard players set all_onis foGameData 0
scoreboard players set all_onisels foGameData 0
execute as @a[tag=foGamePlayer] run scoreboard players add all_players foGameData 1
execute as @a[tag=foGamePlayer,team=foGameJoinQueue] run scoreboard players add all_queues foGameData 1
execute as @a[tag=foGamePlayer,team=foRunner] run scoreboard players add all_runners foGameData 1
execute as @a[tag=foGamePlayer,team=foOni] run scoreboard players add all_onis foGameData 1
execute as @a[tag=foGamePlayer] run execute as @s[tag=foOniSelection] run scoreboard players add all_onisels foGameData 1

#REJOINED PLAYERS
execute as @a[tag=foGamePlayer,scores={foQuitGame=1..}] run function fueoni:player/remove_tags
team join foGameJoinQueue @a[tag=foGamePlayer,scores={foQuitGame=1..}]
clear @a[tag=foGamePlayer,scores={foQuitGame=1..}]
scoreboard players reset @a[tag=foGamePlayer,scores={foQuitGame=1..}] foQuitGame

#CREATE LIST SIDEBAR
scoreboard players operation 参加人数 foListSidebar = all_players foGameData 
scoreboard players set @a[tag=foGamePlayer] foListSidebar 0
scoreboard players reset @a[tag=!foGamePlayer] foListSidebar

#SNEAK DETECTION
scoreboard players set @a[scores={foSneakTime=1..}] foSneakTime 1
scoreboard players reset @a[scores={foSneakTime=1..}] foSneakTime

#GAMEMODE 1: VALIDATE
execute if score game_mode foGameData matches 1 run scoreboard players set game_checks foGameData 0
execute if score game_mode foGameData matches 1 run scoreboard players set game_noplayer foGameData 0
#check 1 - lobby x
execute if score game_mode foGameData matches 1 if score lobby_x foGameOption matches 1.. run scoreboard players add game_checks foGameData 1
execute if score game_mode foGameData matches 1 if score lobby_x foGameOption matches ..0 run scoreboard players add game_checks foGameData 1
#check 2 - lobby y
execute if score game_mode foGameData matches 1 if score lobby_y foGameOption matches 1.. run scoreboard players add game_checks foGameData 1
execute if score game_mode foGameData matches 1 if score lobby_y foGameOption matches ..0 run scoreboard players add game_checks foGameData 1
#check 3 - lobby z
execute if score game_mode foGameData matches 1 if score lobby_z foGameOption matches 1.. run scoreboard players add game_checks foGameData 1
execute if score game_mode foGameData matches 1 if score lobby_z foGameOption matches ..0 run scoreboard players add game_checks foGameData 1
#check 4 - players
execute if score game_mode foGameData matches 1 if score all_players foGameData matches 1.. run scoreboard players add game_checks foGameData 1
execute if score game_mode foGameData matches 1 unless score all_players foGameData matches 1.. run scoreboard players set game_noplayer foGameData 1
#check pass
execute if score game_mode foGameData matches 1 if score game_checks foGameData matches 4.. run scoreboard players add game_checks foGameData 1
execute if score game_mode foGameData matches 1 if score game_checks foGameData matches 4.. run tp @a[tag=foGamePlayer] @e[tag=foStartLocation,limit=1]
execute if score game_mode foGameData matches 1 if score game_checks foGameData matches 4.. run tag @a[tag=foGamePlayer] add foOniSelection
execute if score game_mode foGameData matches 1 if score game_checks foGameData matches 4.. as @a[tag=foGamePlayer] run function fueoni:player/remove_tags
execute if score game_mode foGameData matches 1 if score game_checks foGameData matches 4.. run gamemode adventure @a[tag=foGamePlayer]
execute if score game_mode foGameData matches 1 if score game_checks foGameData matches 4.. run clear @a[tag=foGamePlayer]
execute if score game_mode foGameData matches 1 if score game_checks foGameData matches 4.. run scoreboard objectives setdisplay sidebar foListSidebar
execute if score game_mode foGameData matches 1 if score game_checks foGameData matches 4.. run tellraw @a[tag=foGamePlayer] [{"text":""},{"text":"増え鬼","color":"yellow","bold":"true"},{"text":" » ","color":"gray"},{"text":"このあとゲームが参加者","color":"green"},{"score":{"name":"all_players","objective":"foGameData"},"color":"gold","bold":"true"},{"text":"人","color":"gold","bold":"true"},{"text":"で始まります！","color":"green"}]
execute if score game_mode foGameData matches 1 if score game_checks foGameData matches 4.. run tellraw @a[tag=foGamePlayer] [{"text":""},{"text":"増え鬼","color":"yellow","bold":"true"},{"text":" » ","color":"gray"},{"text":"1人目の鬼になりたい人は、","color":"gold"},{"text":"赤い輪の中","color":"red","bold":"true"},{"text":"に入ってください！","color":"gold"}]
execute if score game_mode foGameData matches 1 if score game_checks foGameData matches 4.. run execute as @a[tag=foGamePlayer] at @s run playsound minecraft:entity.player.levelup voice @s ~ ~ ~ 1.0 1.0
execute if score game_mode foGameData matches 1 if score game_checks foGameData matches 4.. at @e[tag=foStartLocation] run particle minecraft:flame ~ ~ ~ 0 3 0 0 100 force @a
execute if score game_mode foGameData matches 1 if score game_checks foGameData matches 4.. run scoreboard players set game_mode foGameData 2
execute if score game_mode foGameData matches 1 if score game_checks foGameData matches 4.. run scoreboard players set game_timer foGameData 1
#check fail
execute if score game_mode foGameData matches 1 unless score game_checks foGameData matches 4.. as @e[tag=foStartLocation] at @s run execute as @a[distance=..5] at @s run playsound minecraft:block.note_block.bass voice @s ~ ~ ~ 1.0 1.0
execute if score game_mode foGameData matches 1 unless score game_checks foGameData matches 4.. unless score game_noplayer foGameData matches 1 as @e[tag=foStartLocation] at @s run tellraw @a[distance=..5] [{"text":""},{"text":"増え鬼","color":"yellow","bold":"true"},{"text":" » ","color":"gray"},{"text":"ロビー地点が設定されていません。","color":"red"}]
execute if score game_mode foGameData matches 1 unless score game_checks foGameData matches 4.. if score game_noplayer foGameData matches 1 as @e[tag=foStartLocation] at @s run tellraw @a[distance=..5] [{"text":""},{"text":"増え鬼","color":"yellow","bold":"true"},{"text":" » ","color":"gray"},{"text":"ゲームを始めるには","color":"red"},{"text":"2人以上","color":"gold"},{"text":"のプレイヤーが必要です。","color":"red"}]
execute if score game_mode foGameData matches 1 unless score game_checks foGameData matches 4.. run kill @e[tag=foStartLocation]
execute if score game_mode foGameData matches 1 unless score game_checks foGameData matches 4.. run scoreboard players set game_timer foGameData 0
execute if score game_mode foGameData matches 1 unless score game_checks foGameData matches 4.. run scoreboard players set game_mode foGameData 0

#GAMEMODE 2: BEFORE ONI SELECTION
execute if score game_mode foGameData matches 2 run scoreboard players add game_timer foGameData 1
execute if score game_mode foGameData matches 2 run effect give @a[tag=foGamePlayer] resistance 1000000 255 true
execute if score game_mode foGameData matches 2 run effect give @a[tag=foGamePlayer] instant_health 1000000 250 true
execute if score game_mode foGameData matches 2 run effect give @a[tag=foGamePlayer] saturation 1000000 250 true
execute if score game_mode foGameData matches 2 if score game_timer foGameData matches 1 run scoreboard players set num_20 foGameData 20
execute if score game_mode foGameData matches 2 if score game_timer foGameData matches 1 run scoreboard players set game_timeleft foGameData 20
execute if score game_mode foGameData matches 2 if score game_timer foGameData matches 1 run scoreboard objectives setdisplay sidebar foListSidebar
execute if score game_mode foGameData matches 2 run scoreboard players operation game_ticksec foGameData = game_timer foGameData
execute if score game_mode foGameData matches 2 run scoreboard players operation game_ticksec foGameData %= num_20 foGameData
execute if score game_mode foGameData matches 2 if score game_timeleft foGameData matches 2.. if score game_ticksec foGameData matches 0 run execute as @a[tag=foGamePlayer] at @s run playsound minecraft:block.note_block.hat voice @s ~ ~ ~ 1.0 1.0
execute if score game_mode foGameData matches 2 if score game_ticksec foGameData matches 0 run scoreboard players remove game_timeleft foGameData 1
execute if score game_mode foGameData matches 2 run scoreboard players operation 鬼抽選まで(秒) foListSidebar = game_timeleft foGameData
execute if score game_mode foGameData matches 2 if score game_timer foGameData matches 1 run tellraw @a[tag=foGamePlayer] [{"text":""},{"text":"増え鬼","color":"yellow","bold":"true"},{"text":" » ","color":"gray"},{"text":"鬼が","color":"aqua"},{"score":{"name":"game_timeleft","objective":"foGameData"},"color":"red","bold":"true"},{"text":"秒後","color":"red","bold":"true"},{"text":"に抽選されます！","color":"aqua"}]
execute if score game_mode foGameData matches 2 if score game_timeleft foGameData matches 10 if score game_ticksec foGameData matches 0 run tellraw @a[tag=foGamePlayer] [{"text":""},{"text":"増え鬼","color":"yellow","bold":"true"},{"text":" » ","color":"gray"},{"text":"鬼が","color":"aqua"},{"score":{"name":"game_timeleft","objective":"foGameData"},"color":"red","bold":"true"},{"text":"秒後","color":"red","bold":"true"},{"text":"に抽選されます！","color":"aqua"}]
execute if score game_mode foGameData matches 2 if score game_timeleft foGameData matches 1..5 if score game_ticksec foGameData matches 0 run tellraw @a[tag=foGamePlayer] [{"text":""},{"text":"増え鬼","color":"yellow","bold":"true"},{"text":" » ","color":"gray"},{"text":"鬼が","color":"aqua"},{"score":{"name":"game_timeleft","objective":"foGameData"},"color":"red","bold":"true"},{"text":"秒後","color":"red","bold":"true"},{"text":"に抽選されます！","color":"aqua"}]
#oni player check
execute if score game_mode foGameData matches 2 run execute as @e[tag=foStartLocation] at @s run function fueoni:particle/circle_reddust_big
execute if score game_mode foGameData matches 2 at @e[tag=foStartLocation] run execute as @a[tag=foGamePlayer,distance=5..] run execute as @s[tag=foOniSelection] at @s run playsound minecraft:ui.button.click voice @s ~ ~ ~ 1.0 1.0
execute if score game_mode foGameData matches 2 at @e[tag=foStartLocation] run tag @a[tag=foGamePlayer,distance=5..] remove foOniSelection
execute if score game_mode foGameData matches 2 at @e[tag=foStartLocation] run execute as @a[tag=foGamePlayer,distance=..5] run execute as @s[tag=!foOniSelection] at @s run playsound minecraft:ui.button.click voice @s ~ ~ ~ 1.0 1.0
execute if score game_mode foGameData matches 2 at @e[tag=foStartLocation] run tag @a[tag=foGamePlayer,distance=..5] add foOniSelection
execute if score game_mode foGameData matches 2 run execute as @a[tag=foGamePlayer] run title @s[tag=foOniSelection] actionbar {"text":"鬼の抽選候補です","color":"red","bold":"true"}
execute if score game_mode foGameData matches 2 run execute as @a[tag=foGamePlayer] run title @s[tag=!foOniSelection] actionbar {"text":"鬼の抽選候補ではありません","color":"green","bold":"true"}
#no oni selection
execute if score game_mode foGameData matches 2 if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 if score all_onisels foGameData matches 0 run tellraw @a[tag=foGamePlayer] [{"text":""},{"text":"増え鬼","color":"yellow","bold":"true"},{"text":" » ","color":"gray"},{"text":"鬼の希望者がいないので、最初の鬼がランダムに選ばれます！","color":"yellow"}]
execute if score game_mode foGameData matches 2 if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 if score all_onisels foGameData matches 0 run tag @a[tag=foGamePlayer] add foOniSelection
#select one random oni
execute if score game_mode foGameData matches 2 if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 run team join foRunner @a[tag=foGamePlayer]
execute if score game_mode foGameData matches 2 if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 run replaceitem entity @a[tag=foGamePlayer] armor.chest minecraft:leather_chestplate{display:{Name:"{\"text\":\"逃走者の服\",\"color\":\"green\",\"bold\":true,\"italic\":false}",Lore:["{\"text\":\"普通の服だよ\",\"color\":\"gray\",\"italic\":\"false\"}","{\"text\":\"脱げないけどね\",\"color\":\"gray\",\"italic\":\"false\"}"],color:65280},HideFlags:63,Unbreakable:1b,Enchantments:[{id:"minecraft:binding_curse",lvl:1s},{id:"minecraft:vanishing_curse",lvl:1s}]}
execute if score game_mode foGameData matches 2 if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 run tag @r[tag=foOniSelection] add foTempOni
execute if score game_mode foGameData matches 2 if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 run team join foOni @a[tag=foTempOni]
execute if score game_mode foGameData matches 2 if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 at @e[tag=foStartLocation] run teleport @a[tag=foGamePlayer,team=foOni] ~ -10 ~ ~ 90.0
execute if score game_mode foGameData matches 2 if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 run tellraw @a[tag=foGamePlayer] [{"text":""},{"text":"増え鬼","color":"yellow","bold":"true"},{"text":" » ","color":"gray"},{"text":"最初の鬼は","color":"yellow"},{"selector":"@a[tag=foTempOni]"},{"text":"さんになりました！","color":"yellow"}]
execute if score game_mode foGameData matches 2 if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 run tellraw @a[tag=foGamePlayer,team=foRunner] [{"text":""},{"text":"増え鬼","color":"yellow","bold":"true"},{"text":" » ","color":"gray"},{"text":"鬼が解放される前にできるだけ逃げろ！","color":"gold"}]
#count 0
execute if score game_mode foGameData matches 2 if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 run execute as @a[tag=foGamePlayer] at @s run playsound block.note_block.pling voice @s ~ ~ ~ 1.0 1.0
#change gamemode
execute if score game_mode foGameData matches 2 if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 run scoreboard players set game_timer foGameData 0
execute if score game_mode foGameData matches 2 if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 run scoreboard players set game_mode foGameData 3

#GAMEMODE 3: ONI WAITING
execute if score game_mode foGameData matches 3 run scoreboard players add game_timer foGameData 1
execute if score game_mode foGameData matches 3 run effect give @a[tag=foGamePlayer] resistance 1000000 255 true
execute if score game_mode foGameData matches 3 run effect give @a[tag=foGamePlayer] instant_health 1000000 250 true
execute if score game_mode foGameData matches 3 run effect give @a[tag=foGamePlayer] saturation 1000000 250 true
execute if score game_mode foGameData matches 3 if score game_timer foGameData matches 1 run scoreboard players set num_20 foGameData 20
execute if score game_mode foGameData matches 3 if score game_timer foGameData matches 1 run scoreboard players set game_timeleft foGameData 10
execute if score game_mode foGameData matches 3 if score game_timer foGameData matches 1 run scoreboard objectives setdisplay sidebar foIngameSidebar
execute if score game_mode foGameData matches 3 if score game_timer foGameData matches 1 run effect give @a[tag=foGamePlayer,team=foOni] blindness 1000000 255 true
execute if score game_mode foGameData matches 3 if score game_timer foGameData matches 1 run effect give @a[tag=foGamePlayer,team=foOni] levitation 1000000 255 true
execute if score game_mode foGameData matches 3 if score game_timer foGameData matches 1 run replaceitem entity @a[tag=foGamePlayer,team=foOni] hotbar.4 minecraft:diamond_axe{Unbreakable:1b,display:{Name:"{\"text\":\"鬼の金斧\",\"color\":\"red\",\"bold\":true,\"italic\":false}",Lore:["{\"text\":\"金棒じゃないよ金斧だよ\",\"color\":\"gray\",\"italic\":\"false\"}","{\"text\":\"逃走者をこれで捕まえろ！\",\"color\":\"gray\",\"italic\":\"false\"}"]},HideFlags:63,Enchantments:[{id:"minecraft:sharpness",lvl:127s},{id:"minecraft:vanishing_curse",lvl:1s}]}
execute if score game_mode foGameData matches 3 if score game_timer foGameData matches 1 run replaceitem entity @a[tag=foGamePlayer,team=foOni] armor.chest minecraft:leather_chestplate{display:{Name:"{\"text\":\"鬼の服\",\"color\":\"red\",\"bold\":true,\"italic\":false}",Lore:["{\"text\":\"トマトジュースで染まった\",\"color\":\"gray\",\"italic\":\"false\"}","{\"text\":\"きれいな赤色！\",\"color\":\"gray\",\"italic\":\"false\"}"],color:16711680},HideFlags:63,Unbreakable:1b,Enchantments:[{id:"minecraft:protection",lvl:127s},{id:"minecraft:binding_curse",lvl:1s},{id:"minecraft:vanishing_curse",lvl:1s}]}
execute if score game_mode foGameData matches 3 run scoreboard players operation game_ticksec foGameData = game_timer foGameData
execute if score game_mode foGameData matches 3 run scoreboard players operation game_ticksec foGameData %= num_20 foGameData
execute if score game_mode foGameData matches 3 if score game_ticksec foGameData matches 0 run scoreboard players remove game_timeleft foGameData 1
execute if score game_mode foGameData matches 3 run scoreboard players operation 鬼解放まで(秒) foIngameSidebar = game_timeleft foGameData
execute if score game_mode foGameData matches 3 if score game_timeleft foGameData matches 1..3 if score game_ticksec foGameData matches 0 run execute as @a[tag=foGamePlayer] at @s run playsound minecraft:ui.button.click voice @s ~ ~ ~ 1.0 1.0
execute if score game_mode foGameData matches 3 if score game_timeleft foGameData matches 1..3 if score game_ticksec foGameData matches 0 run tellraw @a[tag=foGamePlayer] [{"text":""},{"text":"増え鬼","color":"yellow","bold":"true"},{"text":" » ","color":"gray"},{"text":"鬼が","color":"gold"},{"score":{"name":"game_timeleft","objective":"foGameData"},"color":"red","bold":"true"},{"text":"秒後","color":"red","bold":"true"},{"text":"に解放されます！","color":"gold"}]
execute if score game_mode foGameData matches 3 if score game_timeleft foGameData matches 1.. run title @a[tag=foGamePlayer,team=foOni] times 0 40 0
execute if score game_mode foGameData matches 3 if score game_timeleft foGameData matches 1.. run title @a[tag=foGamePlayer,team=foOni] title {"text":"解放待機中","color":"yellow","bold":"true"}
execute if score game_mode foGameData matches 3 if score game_timeleft foGameData matches 1.. run title @a[tag=foGamePlayer,team=foOni] subtitle [{"text":"あと"},{"score":{"name":"game_timeleft","objective":"foGameData"},"color":"aqua","bold":"true"},{"text":"秒","color":"aqua","bold":"true"},{"text":"…"}]
execute if score game_mode foGameData matches 3 if score game_timeleft foGameData matches 1.. at @e[tag=foStartLocation] run teleport @a[tag=foGamePlayer,team=foOni] ~ -10 ~ ~ 90.0
#count 0
execute if score game_mode foGameData matches 3 if score game_timeleft foGameData matches 0 if score game_ticksec foGameData matches 0 run effect clear @a[tag=foGamePlayer,team=foOni] blindness
execute if score game_mode foGameData matches 3 if score game_timeleft foGameData matches 0 if score game_ticksec foGameData matches 0 run effect clear @a[tag=foGamePlayer,team=foOni] levitation
execute if score game_mode foGameData matches 3 if score game_timeleft foGameData matches 0 if score game_ticksec foGameData matches 0 run effect clear @a[tag=foGamePlayer] resistance
execute if score game_mode foGameData matches 3 if score game_timeleft foGameData matches 0 if score game_ticksec foGameData matches 0 run effect clear @a[tag=foGamePlayer] instant_health
execute if score game_mode foGameData matches 3 if score game_timeleft foGameData matches 0 if score game_ticksec foGameData matches 0 run tp @a[tag=foGamePlayer,team=foOni] @e[tag=foStartLocation,limit=1]
execute if score game_mode foGameData matches 3 if score game_timeleft foGameData matches 0 if score game_ticksec foGameData matches 0 run title @a[tag=foGamePlayer] times 20 60 20
execute if score game_mode foGameData matches 3 if score game_timeleft foGameData matches 0 if score game_ticksec foGameData matches 0 run title @a[tag=foGamePlayer] title {"text":"ゲームスタート","color":"gold","bold":"true"}
execute if score game_mode foGameData matches 3 if score game_timeleft foGameData matches 0 if score game_ticksec foGameData matches 0 run title @a[tag=foGamePlayer,team=foRunner] subtitle {"text":"鬼につかまるな！"}
execute if score game_mode foGameData matches 3 if score game_timeleft foGameData matches 0 if score game_ticksec foGameData matches 0 run title @a[tag=foGamePlayer,team=foOni] subtitle {"text":"逃走者をつかまえろ！"}
execute if score game_mode foGameData matches 3 if score game_timeleft foGameData matches 0 if score game_ticksec foGameData matches 0 run execute as @a[tag=foGamePlayer] at @s run playsound minecraft:entity.ender_dragon.growl voice @s ~ ~ ~ 50.0 1.0
execute if score game_mode foGameData matches 3 if score game_timeleft foGameData matches 0 if score game_ticksec foGameData matches 0 run scoreboard players reset 鬼解放まで(秒) foIngameSidebar
execute if score game_mode foGameData matches 3 if score game_timeleft foGameData matches 0 if score game_ticksec foGameData matches 0 run scoreboard players set game_timer foGameData 0
execute if score game_mode foGameData matches 3 if score game_timeleft foGameData matches 0 if score game_ticksec foGameData matches 0 run scoreboard players set game_mode foGameData 4

#GAMEMODE 4: MAIN
execute if score game_mode foGameData matches 4 run scoreboard players add game_timer foGameData 1
execute if score game_mode foGameData matches 4 run effect give @a[tag=foGamePlayer] saturation 1000000 250 true
execute if score game_mode foGameData matches 4 if score game_timer foGameData matches 1 run scoreboard players set num_20 foGameData 20
execute if score game_mode foGameData matches 4 if score game_timer foGameData matches 1 run scoreboard players set num_60 foGameData 60
execute if score game_mode foGameData matches 4 if score game_timer foGameData matches 1 run scoreboard objectives setdisplay sidebar foIngameSidebar
execute if score game_mode foGameData matches 4 if score game_timer foGameData matches 1 run scoreboard players operation game_timeleft foGameData = game_minutes foGameOption
execute if score game_mode foGameData matches 4 if score game_timer foGameData matches 1 run scoreboard players operation game_timeleft foGameData *= num_60 foGameData
execute if score game_mode foGameData matches 4 run scoreboard players operation game_ticksec foGameData = game_timer foGameData
execute if score game_mode foGameData matches 4 run scoreboard players operation game_ticksec foGameData %= num_20 foGameData
execute if score game_mode foGameData matches 4 if score game_ticksec foGameData matches 0 run scoreboard players remove game_timeleft foGameData 1
execute if score game_mode foGameData matches 4 run scoreboard players operation 残り時間(秒) foIngameSidebar = game_timeleft foGameData
#bossbar update
execute if score game_mode foGameData matches 4 if score game_timer foGameData matches 1 store result bossbar fo_ingame max run scoreboard players get game_timeleft foGameData
execute if score game_mode foGameData matches 4 store result bossbar fo_ingame value run scoreboard players get game_timeleft foGameData
execute if score game_mode foGameData matches 4 run scoreboard players operation bar_sec foGameData = game_timeleft foGameData
execute if score game_mode foGameData matches 4 run scoreboard players operation bar_min foGameData = game_timeleft foGameData
execute if score game_mode foGameData matches 4 run scoreboard players operation bar_sec foGameData %= num_60 foGameData
execute if score game_mode foGameData matches 4 run scoreboard players operation bar_min foGameData /= num_60 foGameData
execute if score game_mode foGameData matches 4 if score bar_min foGameData matches ..9 if score bar_sec foGameData matches ..9 run bossbar set fo_ingame name [{"text":"残り時間: ","color":"red"},{"text":"0","color":"gold","bold":"true"},{"score":{"name":"bar_min","objective":"foGameData"},"color":"gold","bold":"true"},{"text":":0","color":"gold","bold":"true"},{"score":{"name":"bar_sec","objective":"foGameData"},"color":"gold","bold":"true"}]
execute if score game_mode foGameData matches 4 if score bar_min foGameData matches 10.. if score bar_sec foGameData matches ..9 run bossbar set fo_ingame name [{"text":"残り時間: ","color":"red"},{"score":{"name":"bar_min","objective":"foGameData"},"color":"gold","bold":"true"},{"text":":0","color":"gold","bold":"true"},{"score":{"name":"bar_sec","objective":"foGameData"},"color":"gold","bold":"true"}]
execute if score game_mode foGameData matches 4 if score bar_min foGameData matches ..9 if score bar_sec foGameData matches 10.. run bossbar set fo_ingame name [{"text":"残り時間: ","color":"red"},{"text":"0","color":"gold","bold":"true"},{"score":{"name":"bar_min","objective":"foGameData"},"color":"gold","bold":"true"},{"text":":","color":"gold","bold":"true"},{"score":{"name":"bar_sec","objective":"foGameData"},"color":"gold","bold":"true"}]
execute if score game_mode foGameData matches 4 if score bar_min foGameData matches 10.. if score bar_sec foGameData matches 10.. run bossbar set fo_ingame name [{"text":"残り時間: ","color":"red"},{"score":{"name":"bar_min","objective":"foGameData"},"color":"gold","bold":"true"},{"text":":","color":"gold","bold":"true"},{"score":{"name":"bar_sec","objective":"foGameData"},"color":"gold","bold":"true"}]
execute if score game_mode foGameData matches 4 run bossbar set fo_ingame players @a[tag=foGamePlayer]
#death
execute if score game_mode foGameData matches 4 run team join foOni @a[tag=foGamePlayer,team=foRunner,scores={foDeathCount=1..}]
execute if score game_mode foGameData matches 4 run scoreboard players reset @a[tag=foGamePlayer,scores={foDeathCount=1..}] foDeathCount
#respawn
execute if score game_mode foGameData matches 4 run replaceitem entity @a[tag=foGamePlayer,team=foOni,scores={foAliveTime=2}] hotbar.4 minecraft:diamond_axe{Unbreakable:1b,display:{Name:"{\"text\":\"鬼の金斧\",\"color\":\"red\",\"bold\":true,\"italic\":false}",Lore:["{\"text\":\"金棒じゃないよ金斧だよ\",\"color\":\"gray\",\"italic\":\"false\"}","{\"text\":\"逃走者をこれで捕まえろ！\",\"color\":\"gray\",\"italic\":\"false\"}"]},HideFlags:63,Enchantments:[{id:"minecraft:sharpness",lvl:127s},{id:"minecraft:vanishing_curse",lvl:1s}]}
execute if score game_mode foGameData matches 4 run replaceitem entity @a[tag=foGamePlayer,team=foOni,scores={foAliveTime=2}] armor.chest minecraft:leather_chestplate{display:{Name:"{\"text\":\"鬼の服\",\"color\":\"red\",\"bold\":true,\"italic\":false}",Lore:["{\"text\":\"トマトジュースで染まった\",\"color\":\"gray\",\"italic\":\"false\"}","{\"text\":\"きれいな赤色！\",\"color\":\"gray\",\"italic\":\"false\"}"],color:16711680},HideFlags:63,Unbreakable:1b,Enchantments:[{id:"minecraft:protection",lvl:127s},{id:"minecraft:binding_curse",lvl:1s},{id:"minecraft:vanishing_curse",lvl:1s}]}
execute if score game_mode foGameData matches 4 run tp @a[tag=foGamePlayer,scores={foAliveTime=2}] @e[tag=foStartLocation,limit=1]
execute if score game_mode foGameData matches 4 run scoreboard players set @a[tag=foGamePlayer,scores={foAliveTime=3..}] foAliveTime 3
#runner wins
execute if score game_mode foGameData matches 4 if score all_onis foGameData matches 0 run scoreboard players set game_winner foGameData 1
#oni wins
execute if score game_mode foGameData matches 4 if score all_runners foGameData matches 0 run scoreboard players set game_winner foGameData 2
#set gamemode to 5 after winning
execute if score game_mode foGameData matches 4 if score game_winner foGameData matches 1.. run scoreboard players set game_timer foGameData 0
execute if score game_mode foGameData matches 4 if score game_winner foGameData matches 1.. run scoreboard players set game_mode foGameData 5

#GAMEMODE 5: ENDING
execute if score game_mode foGameData matches 5 run scoreboard players add game_timer foGameData 1
execute if score game_mode foGameData matches 5 run effect give @a[tag=foGamePlayer] saturation 1000000 250 true
execute if score game_mode foGameData matches 5 run effect give @a[tag=foGamePlayer] resistance 1000000 255 true
execute if score game_mode foGameData matches 5 run effect give @a[tag=foGamePlayer] instant_health 1000000 250 true
execute if score game_mode foGameData matches 5 if score game_timer foGameData matches 1 run execute as @a[tag=foGamePlayer] at @s run playsound minecraft:entity.player.levelup voice @s ~ ~ ~ 50.0 1.0
execute if score game_mode foGameData matches 5 if score game_timer foGameData matches 1 if score game_winner foGameData matches 1 run title @a[tag=foGamePlayer] title {"text":"逃走者の勝利","color":"green","bold":"true"}
execute if score game_mode foGameData matches 5 if score game_timer foGameData matches 1 if score game_winner foGameData matches 1 run title @a[tag=foGamePlayer] subtitle {"text":"全ての鬼がいなくなった！"}
execute if score game_mode foGameData matches 5 if score game_timer foGameData matches 1 if score game_winner foGameData matches 2 run title @a[tag=foGamePlayer] title {"text":"鬼の勝利","color":"red","bold":"true"}
execute if score game_mode foGameData matches 5 if score game_timer foGameData matches 1 if score game_winner foGameData matches 2 run title @a[tag=foGamePlayer] subtitle {"text":"逃走者が全員つかまった！"}
execute if score game_mode foGameData matches 5 if score game_timer foGameData matches 100.. run function fueoni:reset

#GLOBAL INGAME SIDEBAR
execute if score game_mode foGameData matches 3..4 run scoreboard players operation §c鬼§rの数 foIngameSidebar = all_onis foGameData
execute if score game_mode foGameData matches 3..4 run scoreboard players operation §a逃走者§rの数 foIngameSidebar = all_runners foGameData

#DELETE ADMIN ENTITIES
tp @e[tag=foAdminEntity] ~ ~-5000 ~
kill @e[tag=foAdminEntity]