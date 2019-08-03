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
execute as @e[tag=foAddPlayers] at @s run execute as @a[tag=!foGamePlayer,distance=..3] at @s run playsound minecraft:entity.player.levelup voice @s ~ ~ ~ 1.0 2.0
execute as @e[tag=foAddPlayers] at @s run team join foGameJoinQueue @a[tag=!foGamePlayer,distance=..3] 
execute as @e[tag=foAddPlayers] at @s run tellraw @a[tag=!foGamePlayer,distance=..3] [{"text":""},{"text":"増え鬼","color":"yellow","bold":"true"},{"text":" » ","color":"gray"},{"text":"あなたは次の増え鬼ゲームの参加者になりました。","color":"green"}]
execute as @e[tag=foAddPlayers] at @s run tag @a[tag=!foGamePlayer,distance=..3] add foGamePlayer
execute as @e[tag=foAddPlayers] at @s run summon armor_stand ~ ~ ~ {Tags:["foAddParticleOrigin"],Invisible:true,Invulnerable:true,Marker:true,NoGravity:true,Small:true}
execute as @e[tag=foAddParticleOrigin] at @s run particle minecraft:crit ~ ~ ~ 0 3 0 0 100 force @a
execute as @e[tag=foAddParticleOrigin] at @s run function fueoni:particle/circle_happy_villager
kill @e[tag=foAddParticleOrigin]

#ADMIN ENTITY: SHOW JOINED PLAYERS
execute as @e[tag=foShowJoinedPlayers] at @s run scoreboard objectives setdisplay sidebar foListSidebar

#ADMIN ENTITY: REMOVE PLAYERS
execute as @e[tag=foRemovePlayers] at @s run execute as @a[tag=foGamePlayer,distance=..3] at @s run playsound minecraft:block.note_block.bass voice @s ~ ~ ~ 1.0 1.0
execute as @e[tag=foRemovePlayers] at @s run team leave @a[tag=foGamePlayer,distance=..3,team=foGameJoinQueue] 
execute as @e[tag=foRemovePlayers] at @s run tellraw @a[tag=foGamePlayer,distance=..3] [{"text":""},{"text":"増え鬼","color":"yellow","bold":"true"},{"text":" » ","color":"gray"},{"text":"あなたは次の増え鬼ゲームに参加しません。","color":"red"}]
execute as @e[tag=foRemovePlayers] at @s run tag @a[tag=foGamePlayer,distance=..3] remove foGamePlayer
execute as @e[tag=foRemovePlayers] at @s run summon armor_stand ~ ~ ~ {Tags:["foRemoveParticleOrigin"],Invisible:true,Invulnerable:true,Marker:true,NoGravity:true,Small:true}
execute as @e[tag=foRemoveParticleOrigin] at @s run particle minecraft:crit ~ ~ ~ 0 3 0 0 100 force @a
execute as @e[tag=foRemoveParticleOrigin] at @s run function fueoni:particle/circle_reddust
kill @e[tag=foRemoveParticleOrigin]

#ADMIN ENTITY: REMOVE ALL PLAYERS
execute as @e[tag=foRemoveAllPlayers] run execute as @a[tag=foGamePlayer] at @s run playsound minecraft:block.note_block.bass voice @s ~ ~ ~ 1.0 1.0
execute as @e[tag=foRemoveAllPlayers] run team leave @a[tag=foGamePlayer,team=foGameJoinQueue] 
execute as @e[tag=foRemoveAllPlayers] run tellraw @a[tag=foGamePlayer] [{"text":""},{"text":"増え鬼","color":"yellow","bold":"true"},{"text":" » ","color":"gray"},{"text":"あなたは次の増え鬼ゲームに参加しません。","color":"red"}]
execute as @e[tag=foRemoveAllPlayers] run tag @a[tag=foGamePlayer] remove foGamePlayer

#ADMIN ENTITY: START
execute as @e[tag=foStart] at @s run summon armor_stand ~ ~ ~ {Tags:["foStartLocation","foGameEntity"],Invisible:true,Invulnerable:true,Marker:true,NoGravity:true}
execute as @e[tag=foStart] run scoreboard players set game_timer foGameData 0
execute as @e[tag=foStart] run scoreboard players set game_mode foGameData 1

#ADMIN ENTITY: START ALL PLAYERS
execute as @e[tag=foStartAllPlayers] run team join foGameJoinQueue @a[tag=!foGamePlayer]
execute as @e[tag=foStartAllPlayers] at @s run tag @a[tag=!foGamePlayer] add foGamePlayer
execute as @e[tag=foStartAllPlayers] at @s run summon armor_stand ~ ~ ~ {Tags:["foStartLocation","foGameEntity"],Invisible:true,Invulnerable:true,Marker:true,NoGravity:true}
execute as @e[tag=foStartAllPlayers] run scoreboard players set game_timer foGameData 0
execute as @e[tag=foStartAllPlayers] run scoreboard players set game_mode foGameData 1

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

#CREATE LIST SIDEBAR
scoreboard players operation §a参加人数 foListSidebar = all_players foGameData 
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
execute if score game_mode foGameData matches 2 if score game_timer foGameData matches 1 run scoreboard players set num_20 foGameData 20
execute if score game_mode foGameData matches 2 if score game_timer foGameData matches 1 run scoreboard players set game_timeleft foGameData 5
execute if score game_mode foGameData matches 2 run scoreboard players operation game_ticksec foGameData = game_timer foGameData
execute if score game_mode foGameData matches 2 run scoreboard players operation game_ticksec foGameData %= num_20 foGameData
execute if score game_mode foGameData matches 2 if score game_timeleft foGameData matches 2.. if score game_ticksec foGameData matches 0 run execute as @a[tag=foGamePlayer] at @s run playsound minecraft:block.note_block.hat voice @s ~ ~ ~ 1.0 1.0
execute if score game_mode foGameData matches 2 if score game_ticksec foGameData matches 0 run execute as @a[tag=foGamePlayer] at @s run scoreboard players remove game_timeleft foGameData 1
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
execute if score game_mode foGameData matches 2 if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 run replaceitem entity @a[tag=foGamePlayer] armor.chest minecraft:leather_chestplate{display:{Name:"{\"text\":\"逃走者の服\",\"color\":\"green\",\"bold\":true,\"italic\":false}",Lore:["{\"text\":\"普通の服だよ\",\"color\":\"gray\"}","{\"text\":\"脱げないけどね\",\"color\":\"gray\"}"],color:65280},HideFlags:63,Unbreakable:1b,Enchantments:[{id:"minecraft:protection",lvl:128s},{id:"minecraft:binding_curse",lvl:1s},{id:"minecraft:vanishing_curse",lvl:1s}]}
execute if score game_mode foGameData matches 2 if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 run tag @a[tag=foOniSelection,limit=1,sort=random] add foTempOni
execute if score game_mode foGameData matches 2 if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 run team join foOni @a[tag=foTempOni]
execute if score game_mode foGameData matches 2 if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 at @e[tag=foStartLocation] run teleport @a[tag=foGamePlayer,team=foOni] ~ -10 ~ ~ 90.0
execute if score game_mode foGameData matches 2 if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 run tellraw @a[tag=foGamePlayer] [{"text":""},{"text":"増え鬼","color":"yellow","bold":"true"},{"text":" » ","color":"gray"},{"text":"最初の鬼は","color":"yellow"},{"selector":"@a[tag=foTempOni]"},{"text":"さんになりました！","color":"yellow"}]
execute if score game_mode foGameData matches 2 if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 run tellraw @a[tag=foGamePlayer,team=foRunner] [{"text":""},{"text":"増え鬼","color":"yellow","bold":"true"},{"text":" » ","color":"gray"},{"text":"鬼が	解放される前にできるだけ逃げろ！","color":"gold"}]
#count 0
execute if score game_mode foGameData matches 2 if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 run execute as @a[tag=foGamePlayer] at @s run playsound block.note_block.pling voice @s ~ ~ ~ 1.0 1.0
#change gamemode
execute if score game_mode foGameData matches 2 if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 run scoreboard players set game_timer foGameData 0
execute if score game_mode foGameData matches 2 if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 run scoreboard players set game_mode foGameData 3

#GAMEMODE 3: ONI WAITING
execute if score game_mode foGameData matches 3 run scoreboard players add game_timer foGameData 1
execute if score game_mode foGameData matches 3 if score game_timer foGameData matches 1 run scoreboard players set num_20 foGameData 20
execute if score game_mode foGameData matches 3 if score game_timer foGameData matches 1 run scoreboard players set game_timeleft foGameData 10
execute if score game_mode foGameData matches 3 if score game_timer foGameData matches 1 run effect give @a[tag=foGamePlayer,team=foOni] blindness 1000000 255 true
execute if score game_mode foGameData matches 3 if score game_timer foGameData matches 1 run effect give @a[tag=foGamePlayer,team=foOni] levitation 1000000 255 true
execute if score game_mode foGameData matches 3 if score game_timer foGameData matches 1 run replaceitem entity @a[tag=foGamePlayer,team=foOni] hotbar.4 minecraft:diamond_axe{Unbreakable:1b,display:{Name:"{\"text\":\"鬼の金斧\",\"color\":\"red\",\"bold\":true,\"italic\":false}",Lore:["{\"text\":\"金棒じゃないよ金斧だよ\",\"color\":\"gray\"}","{\"text\":\"逃走者をこれで捕まえろ！\",\"color\":\"gray\"}"]},HideFlags:63,Enchantments:[{id:"minecraft:sharpness",lvl:128s},{id:"minecraft:vanishing_curse",lvl:1s}]}
execute if score game_mode foGameData matches 3 if score game_timer foGameData matches 1 run replaceitem entity @a[tag=foGamePlayer,team=foOni] armor.chest minecraft:leather_chestplate{display:{Name:"{\"text\":\"鬼の服\",\"color\":\"red\",\"bold\":true,\"italic\":false}",Lore:["{\"text\":\"トマトジュースで染まった\",\"color\":\"gray\"}","{\"text\":\"きれいな赤色！\",\"color\":\"gray\"}"],color:16711680},HideFlags:63,Unbreakable:1b,Enchantments:[{id:"minecraft:protection",lvl:128s},{id:"minecraft:binding_curse",lvl:1s},{id:"minecraft:vanishing_curse",lvl:1s}]}
execute if score game_mode foGameData matches 3 run scoreboard players operation game_ticksec foGameData = game_timer foGameData
execute if score game_mode foGameData matches 3 run scoreboard players operation game_ticksec foGameData %= num_20 foGameData
execute if score game_mode foGameData matches 3 if score game_ticksec foGameData matches 0 run execute as @a[tag=foGamePlayer] at @s run scoreboard players remove game_timeleft foGameData 1
execute if score game_mode foGameData matches 3 if score game_timeleft foGameData matches 1..3 if score game_ticksec foGameData matches 0 run execute as @a[tag=foGamePlayer] at @s run playsound minecraft:ui.button.click voice @s ~ ~ ~ 1.0 1.0
execute if score game_mode foGameData matches 3 if score game_timeleft foGameData matches 1..3 if score game_ticksec foGameData matches 0 run tellraw @a[tag=foGamePlayer] [{"text":""},{"text":"増え鬼","color":"yellow","bold":"true"},{"text":" » ","color":"gray"},{"text":"鬼が","color":"gold"},{"score":{"name":"game_timeleft","objective":"foGameData"},"color":"red","bold":"true"},{"text":"秒後","color":"red","bold":"true"},{"text":"に解放されます！","color":"gold"}]
execute if score game_mode foGameData matches 3 run title @a[tag=foGamePlayer,team=foOni] times 0 40 0
execute if score game_mode foGameData matches 3 run title @a[tag=foGamePlayer,team=foOni] title {"text":"解放待機中","color":"yellow","bold":"true"}
execute if score game_mode foGameData matches 3 run title @a[tag=foGamePlayer,team=foOni] subtitle [{"text":"あと"},{"score":{"name":"game_timeleft","objective":"foGameData"},"color":"aqua","bold":"true"},{"text":"秒","color":"aqua","bold":"true"},{"text":"…"}]
execute if score game_mode foGameData matches 3 at @e[tag=foStartLocation] run teleport @a[tag=foGamePlayer,team=foOni] ~ -10 ~ ~ 90.0

#DELETE ADMIN ENTITIES
tp @e[tag=foAdminEntity] ~ ~-5000 ~
kill @e[tag=foAdminEntity]