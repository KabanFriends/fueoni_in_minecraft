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
#before oni selection -> teleport to game start location
execute as @a[tag=foGamePlayer,scores={foQuitGame=1..}] if score game_mode foGameData matches 1..2 run function fueoni:player/remove_tags
execute as @a[tag=foGamePlayer,scores={foQuitGame=1..}] if score game_mode foGameData matches 1..2 run team join foGameJoinQueue @s
execute as @a[tag=foGamePlayer,scores={foQuitGame=1..}] if score game_mode foGameData matches 1..2 run clear @s
execute as @a[tag=foGamePlayer,scores={foQuitGame=1..}] if score game_mode foGameData matches 1..2 run gamemode adventure @s
execute as @a[tag=foGamePlayer,scores={foQuitGame=1..}] if score game_mode foGameData matches 1..2 run tp @s @e[tag=foStartLocation,limit=1]
#after oni selection -> rejoin in same game -> continue
#after oni selection -> rejoin in different game -> spectator / teleport to random player
execute as @a[tag=foGamePlayer,scores={foQuitGame=1..}] if score game_mode foGameData matches 3..4 unless score @s foPlayerSID = sessionID foGameOption run function fueoni:player/remove_tags
execute as @a[tag=foGamePlayer,scores={foQuitGame=1..}] if score game_mode foGameData matches 3..4 unless score @s foPlayerSID = sessionID foGameOption run team join foGameJoinQueue @s
execute as @a[tag=foGamePlayer,scores={foQuitGame=1..}] if score game_mode foGameData matches 3..4 unless score @s foPlayerSID = sessionID foGameOption run clear @s
execute as @a[tag=foGamePlayer,scores={foQuitGame=1..}] if score game_mode foGameData matches 3..4 unless score @s foPlayerSID = sessionID foGameOption run gamemode spectator @s
execute as @a[tag=foGamePlayer,scores={foQuitGame=1..}] if score game_mode foGameData matches 3..4 unless score @s foPlayerSID = sessionID foGameOption run tp @s @a[tag=foGamePlayer,sort=random,limit=1]
#after winning -> spectator / teleport to random player
execute as @a[tag=foGamePlayer,scores={foQuitGame=1..}] if score game_mode foGameData matches 5 run function fueoni:player/remove_tags
execute as @a[tag=foGamePlayer,scores={foQuitGame=1..}] if score game_mode foGameData matches 5 run team join foGameJoinQueue @s
execute as @a[tag=foGamePlayer,scores={foQuitGame=1..}] if score game_mode foGameData matches 5 run clear @s
execute as @a[tag=foGamePlayer,scores={foQuitGame=1..}] if score game_mode foGameData matches 5 run gamemode spectator @s
execute as @a[tag=foGamePlayer,scores={foQuitGame=1..}] if score game_mode foGameData matches 5 run tp @s @a[tag=foGamePlayer,sort=random,limit=1]
#reset quit game score
scoreboard players reset @a[scores={foQuitGame=1..}] foQuitGame

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
execute if score game_mode foGameData matches 1 if score all_players foGameData matches 2.. run scoreboard players add game_checks foGameData 1
execute if score game_mode foGameData matches 1 unless score all_players foGameData matches 2.. run scoreboard players set game_noplayer foGameData 1
#check pass
execute if score game_mode foGameData matches 1 if score game_checks foGameData matches 4.. as @e[tag=foStartLocation] run tp @a[tag=foGamePlayer] @s
execute if score game_mode foGameData matches 1 if score game_checks foGameData matches 4.. as @a[tag=foGamePlayer] run function fueoni:player/remove_tags
execute if score game_mode foGameData matches 1 if score game_checks foGameData matches 4.. run tag @a[tag=foGamePlayer] add foOniSelection
execute if score game_mode foGameData matches 1 if score game_checks foGameData matches 4.. run gamemode adventure @a[tag=foGamePlayer]
execute if score game_mode foGameData matches 1 if score game_checks foGameData matches 4.. run clear @a[tag=foGamePlayer]
execute if score game_mode foGameData matches 1 if score game_checks foGameData matches 4.. run scoreboard players add sessionID foGameOption 1
execute if score game_mode foGameData matches 1 if score game_checks foGameData matches 4.. run scoreboard players operation @a[tag=foGamePlayer] foPlayerSID = sessionID foGameOption
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
execute if score game_mode foGameData matches 2 run effect give @a[tag=foGamePlayer] resistance 1000000 127 true
execute if score game_mode foGameData matches 2 run effect give @a[tag=foGamePlayer] instant_health 1000000 127 true
execute if score game_mode foGameData matches 2 run effect give @a[tag=foGamePlayer] saturation 1000000 127 true
execute if score game_mode foGameData matches 2 if score game_timer foGameData matches 1 run scoreboard players set num_20 foGameData 20
execute if score game_mode foGameData matches 2 if score game_timer foGameData matches 1 run scoreboard players set game_timeleft foGameData 15
execute if score game_mode foGameData matches 2 if score game_timer foGameData matches 1 run scoreboard objectives setdisplay sidebar foListSidebar
execute if score game_mode foGameData matches 2 if score game_timer foGameData matches 1 run scoreboard players set @a[tag=foGamePlayer] foAliveTime 3
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
execute if score game_mode foGameData matches 2 if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 run tag @r[tag=foOniSelection] add foTempOni
execute if score game_mode foGameData matches 2 if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 run team join foOni @a[tag=foTempOni]
execute if score game_mode foGameData matches 2 if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 run replaceitem entity @a[tag=foGamePlayer,team=foRunner] hotbar.0 minecraft:wooden_shovel{display:{Name:"{\"text\":\"逃走者の鈍器\",\"color\":\"yellow\",\"bold\":true,\"italic\":false}",Lore:["{\"text\":\"鬼が来たらこれで引き離せ！\",\"color\":\"gray\",\"italic\":false}","{\"text\":\"使いづらいけど頑張れ！！\",\"color\":\"gray\",\"italic\":false}"]},Unbreakable:1b,HideFlags:63,Enchantments:[{id:"minecraft:knockback",lvl:2s},{id:"minecraft:vanishing_curse",lvl:1s}]}
execute if score game_mode foGameData matches 2 if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 run replaceitem entity @a[tag=foGamePlayer,team=foRunner] armor.chest minecraft:leather_chestplate{display:{Name:"{\"text\":\"逃走者の服\",\"color\":\"green\",\"bold\":true,\"italic\":false}",Lore:["{\"text\":\"普通の服だよ\",\"color\":\"gray\",\"italic\":\"false\"}","{\"text\":\"脱げないけどね\",\"color\":\"gray\",\"italic\":\"false\"}"],color:65280},HideFlags:63,Unbreakable:1b,Enchantments:[{id:"minecraft:binding_curse",lvl:1s},{id:"minecraft:vanishing_curse",lvl:1s}]}
execute if score game_mode foGameData matches 2 if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 at @e[tag=foStartLocation] run teleport @a[tag=foGamePlayer,team=foOni] ~ -10 ~ ~ 90.0
execute if score game_mode foGameData matches 2 if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 run tellraw @a[tag=foGamePlayer] [{"text":""},{"text":"増え鬼","color":"yellow","bold":"true"},{"text":" » ","color":"gray"},{"text":"最初の鬼は","color":"yellow"},{"selector":"@a[tag=foTempOni]"},{"text":"さんになりました！","color":"yellow"}]
execute if score game_mode foGameData matches 2 if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 run tellraw @a[tag=foGamePlayer,team=foRunner] [{"text":""},{"text":"増え鬼","color":"yellow","bold":"true"},{"text":" » ","color":"gray"},{"text":"鬼が解放される前にできるだけ逃げろ！","color":"gold"}]
#count 0
execute if score game_mode foGameData matches 2 if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 run execute as @a[tag=foGamePlayer] at @s run playsound block.note_block.pling voice @s ~ ~ ~ 1.0 1.0
#change gamemode
execute if score game_mode foGameData matches 2 if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 run scoreboard players set game_timer foGameData 0
execute if score game_mode foGameData matches 2 if score game_timeleft foGameData matches ..0 if score game_ticksec foGameData matches 0 run scoreboard players set game_mode foGameData 3
#respawn
execute if score game_mode foGameData matches 2 run tp @a[tag=foGamePlayer,scores={foAliveTime=2}] @e[tag=foStartLocation,limit=1]
execute if score game_mode foGameData matches 2 run scoreboard players set @a[tag=foGamePlayer,scores={foAliveTime=3..}] foAliveTime 3

#GAMEMODE 3: ONI WAITING
execute if score game_mode foGameData matches 3 run scoreboard players add game_timer foGameData 1
execute if score game_mode foGameData matches 3 run effect give @a[tag=foGamePlayer] resistance 1000000 127 true
execute if score game_mode foGameData matches 3 run effect give @a[tag=foGamePlayer] instant_health 1000000 127 true
execute if score game_mode foGameData matches 3 run effect give @a[tag=foGamePlayer] saturation 1000000 127 true
execute if score game_mode foGameData matches 3 if score game_timer foGameData matches 1 run scoreboard players set num_20 foGameData 20
execute if score game_mode foGameData matches 3 if score game_timer foGameData matches 1 run scoreboard players set game_timeleft foGameData 15
execute if score game_mode foGameData matches 3 if score game_timer foGameData matches 1 run scoreboard objectives setdisplay sidebar foIngameSidebar
execute if score game_mode foGameData matches 3 if score game_timer foGameData matches 1 run scoreboard players set @a[tag=foGamePlayer] foAliveTime 3
execute if score game_mode foGameData matches 3 if score game_timer foGameData matches 1 run effect give @a[tag=foGamePlayer,team=foOni] blindness 1000000 0 true
execute if score game_mode foGameData matches 3 if score game_timer foGameData matches 1 run effect give @a[tag=foGamePlayer,team=foOni] levitation 1000000 255 true
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
#respawn
execute if score game_mode foGameData matches 3 run tp @a[tag=foGamePlayer,scores={foAliveTime=2}] @e[tag=foStartLocation,limit=1]
execute if score game_mode foGameData matches 3 run scoreboard players set @a[tag=foGamePlayer,scores={foAliveTime=3..}] foAliveTime 3

#GAMEMODE 4: MAIN
execute if score game_mode foGameData matches 4 run scoreboard players add game_timer foGameData 1
execute if score game_mode foGameData matches 4 run effect give @a[tag=foGamePlayer] saturation 1000000 127 true
execute if score game_mode foGameData matches 4 run effect give @a[tag=foGamePlayer,team=foOni] strength 1000000 127 true
execute if score game_mode foGameData matches 4 if score game_timer foGameData matches 1 run scoreboard players set num_20 foGameData 20
execute if score game_mode foGameData matches 4 if score game_timer foGameData matches 1 run scoreboard players set num_60 foGameData 60
execute if score game_mode foGameData matches 4 if score game_timer foGameData matches 1 run scoreboard players reset @a[tag=foGamePlayer] foDeathCount
execute if score game_mode foGameData matches 4 if score game_timer foGameData matches 1 run scoreboard players set @a[tag=foGamePlayer] foAliveTime 3
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
execute if score game_mode foGameData matches 4 run clear @a[tag=foGamePlayer,team=foOni,scores={foAliveTime=2}]
execute if score game_mode foGameData matches 4 run replaceitem entity @a[tag=foGamePlayer,team=foOni,scores={foAliveTime=2}] armor.chest minecraft:leather_chestplate{display:{Name:"{\"text\":\"鬼の服\",\"color\":\"red\",\"bold\":true,\"italic\":false}",Lore:["{\"text\":\"トマトジュースで染まった\",\"color\":\"gray\",\"italic\":\"false\"}","{\"text\":\"きれいな赤色！\",\"color\":\"gray\",\"italic\":\"false\"}"],color:16711680},HideFlags:63,Unbreakable:1b,Enchantments:[{id:"minecraft:protection",lvl:127s},{id:"minecraft:binding_curse",lvl:1s},{id:"minecraft:vanishing_curse",lvl:1s}]}
execute if score game_mode foGameData matches 4 run tp @a[tag=foGamePlayer,scores={foAliveTime=2}] @e[tag=foStartLocation,limit=1]
execute if score game_mode foGameData matches 4 as @a[tag=foGamePlayer,scores={foAliveTime=2}] run tellraw @s [{"text":""},{"text":"増え鬼","color":"yellow","bold":"true"},{"text":" » ","color":"gray"},{"text":"つかまってしまった！","color":"red","bold":"true"},{"text":" あなたは鬼になりました。"}]
execute if score game_mode foGameData matches 4 run scoreboard players set @a[tag=foGamePlayer,scores={foAliveTime=3..}] foAliveTime 3
#set item
execute if score game_mode foGameData matches 4 run scoreboard players add @e[tag=foItemEntity] foEntityTick 1
execute if score game_mode foGameData matches 4 as @e[tag=foNeedItem,scores={foEntityTick=2}] run execute as @s[tag=foEye] run data merge entity @s {ArmorItems:[{},{},{},{id:"minecraft:player_head",Count:1b,tag:{SkullOwner:{Id:"36122cdc-6c97-4b97-990a-ef4df57db922",Properties:{textures:[{Value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvZGFhOGZjOGRlNjQxN2I0OGQ0OGM4MGI0NDNjZjUzMjZlM2Q5ZGE0ZGJlOWIyNWZjZDQ5NTQ5ZDk2MTY4ZmMwIn19fQ=="}]}}}}],CustomName:"{\"text\":\"透視\",\"color\":\"aqua\",\"bold\":true}"}
execute if score game_mode foGameData matches 4 as @e[tag=foNeedItem,scores={foEntityTick=2}] run execute as @s[tag=foSpeed] run data merge entity @s {Tags:["foSpeed","foGameEntity","foItemEntity"],ArmorItems:[{},{},{},{id:"minecraft:player_head",Count:1b,tag:{SkullOwner:{Id:"032642cc-f548-416e-95b1-656a0e25fffc",Properties:{textures:[{Value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvZmI0YzFkYmQ4NTQ0Y2ZhZWQ5NjNkZjRkMTM5YmM4YmFjNGI3NmFjNGJiYjMwYWI4NmY3NmZiYzMxYWI5YTcwIn19fQ=="}]}}}}],CustomName:"{\"text\":\"スピード\",\"color\":\"green\",\"bold\":true}"}
execute if score game_mode foGameData matches 4 as @e[tag=foNeedItem,scores={foEntityTick=2}] run execute as @s[tag=foInvisible] run data merge entity @s {Tags:["foInvisible","foGameEntity","foItemEntity"],ArmorItems:[{},{},{},{id:"minecraft:player_head",Count:1b,tag:{SkullOwner:{Id:"99e42a6d-44c4-4b62-a2f8-eabe9cdf2933",Properties:{textures:[{Value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvZGYyYzlkYzMxNGJlZmM4ZDEyZjJlODc4NmM5NDM1YmZkMjRkOTExNmZjOTRjNWVjNDVmZDgzYmQyZGM4NGE0ZiJ9fX0="}]}}}}],CustomName:"{\"text\":\"透明化\",\"color\":\"white\",\"bold\":true}"}
execute if score game_mode foGameData matches 4 as @e[tag=foNeedItem,scores={foEntityTick=2}] run execute as @s[tag=foKillOni] run data merge entity @s {Tags:["foKillOni","foGameEntity","foItemEntity"],ArmorItems:[{},{},{},{id:"minecraft:player_head",Count:1b,tag:{SkullOwner:{Id:"498ddc33-8486-468f-bf0c-f788034d724d",Properties:{textures:[{Value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvY2IzOWI1YWFkNWVjZmY5NDY3M2NjYTRmOTFmZTc0ZWQyYTQyODhjZjY3M2E3NzAxMGY3NTcwZjFhNTc1MjAifX19"}]}}}}],CustomName:"{\"text\":\"鬼退治\",\"color\":\"red\",\"bold\":true}"}
execute if score game_mode foGameData matches 4 run tag @e[tag=foNeedItem,scores={foEntityTick=2}] remove foNeedItem
#item spawning
#increase timer
execute if score game_mode foGameData matches 4 run scoreboard players add @a[tag=foGamePlayer,team=foRunner] foItemSpawnTimer 1
#create rng numbers
execute if score game_mode foGameData matches 4 as @a[tag=foGamePlayer,team=foRunner] if score @s foItemSpawnTimer matches 1 store result score @s foSpawnTimerEnd run loot spawn ~ -500 ~ loot fueoni:fo_rng_spawntimer
execute if score game_mode foGameData matches 4 as @a[tag=foGamePlayer,team=foRunner] if score @s foItemSpawnTimer matches 1 store result score @s foItemSpawnType run loot spawn ~ -500 ~ loot fueoni:fo_rng_itemtype
#detect timer and spawn
execute if score game_mode foGameData matches 4 as @a[tag=foGamePlayer,team=foRunner] at @s positioned ~ -10 ~ if score @s foItemSpawnTimer >= @s foSpawnTimerEnd if score @s foItemSpawnType matches 0 run summon armor_stand ~ ~ ~ {CustomNameVisible:1b,NoGravity:1b,Invulnerable:1b,Marker:0b,Invisible:1b,Tags:["foNeedItem","foNeedTeleport","foEye","foGameEntity","foItemEntity"],DisabledSlots:4144959}
execute if score game_mode foGameData matches 4 as @a[tag=foGamePlayer,team=foRunner] at @s positioned ~ -10 ~ if score @s foItemSpawnTimer >= @s foSpawnTimerEnd if score @s foItemSpawnType matches 1 run summon armor_stand ~ ~ ~ {CustomNameVisible:1b,NoGravity:1b,Invulnerable:1b,Marker:0b,Invisible:1b,Tags:["foNeedItem","foNeedTeleport","foSpeed","foGameEntity","foItemEntity"],DisabledSlots:4144959}
execute if score game_mode foGameData matches 4 as @a[tag=foGamePlayer,team=foRunner] at @s positioned ~ -10 ~ if score @s foItemSpawnTimer >= @s foSpawnTimerEnd if score @s foItemSpawnType matches 2 run summon armor_stand ~ ~ ~ {CustomNameVisible:1b,NoGravity:1b,Invulnerable:1b,Marker:0b,Invisible:1b,Tags:["foNeedItem","foNeedTeleport","foInvisible","foGameEntity","foItemEntity"],DisabledSlots:4144959}
execute if score game_mode foGameData matches 4 as @a[tag=foGamePlayer,team=foRunner] at @s positioned ~ -10 ~ if score @s foItemSpawnTimer >= @s foSpawnTimerEnd if score @s foItemSpawnType matches 3 run summon armor_stand ~ ~ ~ {CustomNameVisible:1b,NoGravity:1b,Invulnerable:1b,Marker:0b,Invisible:1b,Tags:["foNeedItem","foNeedTeleport","foKillOni","foGameEntity","foItemEntity"],DisabledSlots:4144959}
#spread spawned item
execute if score game_mode foGameData matches 4 as @a[tag=foGamePlayer,team=foRunner] at @s positioned ~ -10 ~ if score @s foItemSpawnTimer >= @s foSpawnTimerEnd run spreadplayers ~ ~ 30 30 false @e[tag=foItemEntity,limit=1,sort=nearest]
#reset timer
execute if score game_mode foGameData matches 4 as @a[tag=foGamePlayer,team=foRunner] if score @s foItemSpawnTimer >= @s foSpawnTimerEnd run scoreboard players set @s foItemSpawnTimer 0
#teleport item entity
execute if score game_mode foGameData matches 4 as @e[tag=foNeedTeleport] at @s run function fueoni:entity/random_tp
#rotate and kill item entity
execute if score game_mode foGameData matches 4 as @e[tag=foItemEntity] at @s run tp @s ~ ~ ~ ~3 ~
execute if score game_mode foGameData matches 4 as @e[tag=foItemEntity,scores={foEntityTick=1200..}] run kill @s
#give item to runner
execute if score game_mode foGameData matches 4 as @e[tag=foItemEntity] at @s if entity @a[tag=foGamePlayer,team=foRunner,distance=..1] if entity @s[tag=foEye] run give @a[tag=foGamePlayer,team=foRunner,distance=..1] ender_pearl{display:{Name:"{\"text\":\"透視の目\",\"color\":\"aqua\",\"bold\":true,\"italic\":false}",Lore:["[{\"text\":\"右クリック\",\"color\":\"gold\",\"bold\":false,\"italic\":false},{\"text\":\"すると数秒間\",\"color\":\"gray\",\"italic\":false}]","{\"text\":\"鬼の位置がわかる\",\"color\":\"gray\",\"italic\":false}"]},HideFlags:63,Enchantments:[{id:"minecraft:vanishing_curse",lvl:1s}]}
execute if score game_mode foGameData matches 4 as @e[tag=foItemEntity] at @s if entity @a[tag=foGamePlayer,team=foRunner,distance=..1] if entity @s[tag=foSpeed] run give @a[tag=foGamePlayer,team=foRunner,distance=..1] splash_potion{display:{Name:"{\"text\":\"スピードポーション\",\"color\":\"aqua\",\"bold\":true,\"italic\":false}"},HideFlags:1,Enchantments:[{id:"minecraft:vanishing_curse",lvl:1s}],CustomPotionEffects:[{Id:1b,Amplifier:0b,Duration:600}],CustomPotionColor:56831}
execute if score game_mode foGameData matches 4 as @e[tag=foItemEntity] at @s if entity @a[tag=foGamePlayer,team=foRunner,distance=..1] if entity @s[tag=foInvisible] run give @a[tag=foGamePlayer,team=foRunner,distance=..1] potion{display:{Name:"{\"text\":\"透明化ポーション\",\"color\":\"light_purple\",\"bold\":true,\"italic\":false}"},HideFlags:1,Enchantments:[{id:"minecraft:vanishing_curse",lvl:1s}],CustomPotionEffects:[{Id:14b,Amplifier:0b,Duration:400,ShowParticles:0b}],CustomPotionColor:16717792}
execute if score game_mode foGameData matches 4 as @e[tag=foItemEntity] at @s if entity @a[tag=foGamePlayer,team=foRunner,distance=..1] if entity @s[tag=foKillOni] run clear @a[tag=foGamePlayer,team=foRunner,distance=..1] bow
execute if score game_mode foGameData matches 4 as @e[tag=foItemEntity] at @s if entity @a[tag=foGamePlayer,team=foRunner,distance=..1] if entity @s[tag=foKillOni] run give @a[tag=foGamePlayer,team=foRunner,distance=..1] bow{HideFlags:63,Enchantments:[{id:"minecraft:vanishing_curse",lvl:1s}]}
execute if score game_mode foGameData matches 4 as @e[tag=foItemEntity] at @s if entity @a[tag=foGamePlayer,team=foRunner,distance=..1] if entity @s[tag=foKillOni] run give @a[tag=foGamePlayer,team=foRunner,distance=..1] tipped_arrow{display:{Name:"{\"text\":\"鬼退治の矢\",\"color\":\"red\",\"bold\":true,\"italic\":false}",Lore:["{\"text\":\"この矢で鬼を撃つと\",\"color\":\"gray\",\"italic\":false}","[{\"text\":\"その鬼はスポーン地点に戻される。\",\"color\":\"gray\",\"italic\":false}]"]},HideFlags:63,Enchantments:[{id:"minecraft:vanishing_curse",lvl:1s}],CustomPotionEffects:[{Id:27b,Amplifier:0b,Duration:1000000,ShowParticles:0b}],CustomPotionColor:16711680}
execute if score game_mode foGameData matches 4 as @e[tag=foItemEntity] at @s if entity @a[tag=foGamePlayer,team=foRunner,distance=..1] run kill @s
#item warning for onis
execute if score game_mode foGameData matches 4 at @e[tag=foItemEntity] run execute as @a[tag=foGamePlayer,team=foOni,distance=..1] run execute as @s[tag=!foItemWarn] run tellraw @s [{"text":""},{"text":"増え鬼","color":"yellow","bold":"true"},{"text":" » ","color":"gray"},{"text":"鬼はアイテムを取ることができません！","color":"red"}]
execute if score game_mode foGameData matches 4 at @e[tag=foItemEntity] run tag @a[tag=foGamePlayer,team=foOni,distance=..1] add foItemWarn
#item: speed
#make sure onis cant get speed
execute if score game_mode foGameData matches 4 as @a[tag=foGamePlayer,team=foOni,nbt={ActiveEffects:[{Id:1b,Amplifier:0b}]}] run tellraw @s [{"text":""},{"text":"増え鬼","color":"yellow","bold":"true"},{"text":" » ","color":"gray"},{"text":"鬼は移動速度上昇を使えません！","color":"red"}]
execute if score game_mode foGameData matches 4 as @a[tag=foGamePlayer,team=foOni,nbt={ActiveEffects:[{Id:1b,Amplifier:0b}]}] run tag @s remove foInvisible
execute if score game_mode foGameData matches 4 as @a[tag=foGamePlayer,team=foOni,nbt={ActiveEffects:[{Id:1b,Amplifier:0b}]}] run effect clear @s minecraft:speed
#item: invisible
execute if score game_mode foGameData matches 4 as @a[tag=foGamePlayer] run tag @s remove foInvisible
execute if score game_mode foGameData matches 4 as @a[tag=foGamePlayer] run tag @s[nbt={ActiveEffects:[{Id:14b,Amplifier:0b}]}] add foInvisible
execute if score game_mode foGameData matches 4 as @a[tag=foGamePlayer,team=foRunner] run replaceitem entity @s[tag=foInvisible] armor.chest air
execute if score game_mode foGameData matches 4 as @a[tag=foGamePlayer,team=foRunner] run replaceitem entity @s[tag=!foInvisible] armor.chest minecraft:leather_chestplate{display:{Name:"{\"text\":\"逃走者の服\",\"color\":\"green\",\"bold\":true,\"italic\":false}",Lore:["{\"text\":\"普通の服だよ\",\"color\":\"gray\",\"italic\":\"false\"}","{\"text\":\"脱げないけどね\",\"color\":\"gray\",\"italic\":\"false\"}"],color:65280},HideFlags:63,Unbreakable:1b,Enchantments:[{id:"minecraft:binding_curse",lvl:1s},{id:"minecraft:vanishing_curse",lvl:1s}]}
execute if score game_mode foGameData matches 4 as @a[tag=foGamePlayer,team=foOni] run replaceitem entity @s[tag=!foInvisible] armor.chest minecraft:leather_chestplate{display:{Name:"{\"text\":\"鬼の服\",\"color\":\"red\",\"bold\":true,\"italic\":false}",Lore:["{\"text\":\"トマトジュースで染まった\",\"color\":\"gray\",\"italic\":\"false\"}","{\"text\":\"きれいな赤色！\",\"color\":\"gray\",\"italic\":\"false\"}"],color:16711680},HideFlags:63,Unbreakable:1b,Enchantments:[{id:"minecraft:protection",lvl:127s},{id:"minecraft:binding_curse",lvl:1s},{id:"minecraft:vanishing_curse",lvl:1s}]}
#make sure onis cant get invisibility too
execute if score game_mode foGameData matches 4 as @a[tag=foGamePlayer,team=foOni,nbt={ActiveEffects:[{Id:14b,Amplifier:0b}]}] run tellraw @s [{"text":""},{"text":"増え鬼","color":"yellow","bold":"true"},{"text":" » ","color":"gray"},{"text":"鬼は透明化を使えません！","color":"red"}]
execute if score game_mode foGameData matches 4 as @a[tag=foGamePlayer,team=foOni,nbt={ActiveEffects:[{Id:14b,Amplifier:0b}]}] run tag @s remove foInvisible
execute if score game_mode foGameData matches 4 as @a[tag=foGamePlayer,team=foOni,nbt={ActiveEffects:[{Id:14b,Amplifier:0b}]}] run effect clear @s minecraft:invisibility
#clear empty bottles
execute if score game_mode foGameData matches 4 run clear @a[tag=foGamePlayer] minecraft:glass_bottle
#item: eye
execute if score game_mode foGameData matches 4 as @a[tag=foGamePlayer,scores={foUseEnderPearl=1..}] run execute as @a[tag=foGamePlayer] at @s run playsound entity.evoker.prepare_summon voice @s ~ ~ ~ 50.0 1.0
execute if score game_mode foGameData matches 4 as @a[tag=foGamePlayer,scores={foUseEnderPearl=1..}] run tellraw @a[tag=foGamePlayer] [{"text":""},{"text":"増え鬼","color":"yellow","bold":"true"},{"text":" » ","color":"gray"},{"text":"誰かが透視の目を使いました！","color":"light_purple","bold":"true"},{"text":" これから"},{"text":"10秒間","color":"gold"},{"text":"、鬼の位置が光って見えます！"}]
execute if score game_mode foGameData matches 4 as @a[tag=foGamePlayer,scores={foUseEnderPearl=1..}] run effect give @a[tag=foGamePlayer,team=foOni] glowing 10 0 true
execute if score game_mode foGameData matches 4 as @a[tag=foGamePlayer,scores={foUseEnderPearl=1..}] at @s run kill @e[type=ender_pearl,distance=..5]
execute if score game_mode foGameData matches 4 as @a[tag=foGamePlayer,scores={foUseEnderPearl=1..}] run scoreboard players reset @s foUseEnderPearl
#item: kill oni
execute if score game_mode foGameData matches 4 as @a[tag=foGamePlayer,team=foOni,nbt={ActiveEffects:[{Id:27b,Amplifier:0b}]}] run clear @s
execute if score game_mode foGameData matches 4 as @a[tag=foGamePlayer,team=foOni,nbt={ActiveEffects:[{Id:27b,Amplifier:0b}]}] run tellraw @s [{"text":""},{"text":"増え鬼","color":"yellow","bold":"true"},{"text":" » ","color":"gray"},{"text":"あなたは","color":"gold"},{"text":"鬼退治","color":"red","bold":"true"},{"text":"されました！","color":"gold"},{"text":" 退治されて、スポーン地点に戻されました。"}]
execute if score game_mode foGameData matches 4 as @a[tag=foGamePlayer,team=foOni,nbt={ActiveEffects:[{Id:27b,Amplifier:0b}]}] run effect give @s blindness 5 0 true
execute if score game_mode foGameData matches 4 as @a[tag=foGamePlayer,team=foOni,nbt={ActiveEffects:[{Id:27b,Amplifier:0b}]}] run tp @s @e[tag=foStartLocation,limit=1]
execute if score game_mode foGameData matches 4 as @a[tag=foGamePlayer,nbt={ActiveEffects:[{Id:27b,Amplifier:0b}]}] run effect clear @s unluck
#kill arrows in ground
execute if score game_mode foGameData matches 4 as @a[tag=foGamePlayer] at @s run kill @e[type=arrow,nbt={inGround:true},distance=..30]
#clear bow after use
execute if score game_mode foGameData matches 4 run clear @a[tag=foGamePlayer,nbt=!{Inventory:[{id:"minecraft:tipped_arrow"}]}] minecraft:bow
#runner wins
execute if score game_mode foGameData matches 4 if score all_onis foGameData matches ..0 run scoreboard players set game_winner foGameData 1
#oni wins
execute if score game_mode foGameData matches 4 if score all_runners foGameData matches ..0 run scoreboard players set game_winner foGameData 2
#timer ran out
execute if score game_mode foGameData matches 4 if score game_timeleft foGameData matches ..0 run scoreboard players set game_winner foGameData 3
#set gamemode to 5 after winning
execute if score game_mode foGameData matches 4 if score game_winner foGameData matches 1.. run scoreboard players set game_timer foGameData 0
execute if score game_mode foGameData matches 4 if score game_winner foGameData matches 1.. run scoreboard players set game_mode foGameData 5

#GAMEMODE 5: ENDING
execute if score game_mode foGameData matches 5 run scoreboard players add game_timer foGameData 1
execute if score game_mode foGameData matches 5 run effect give @a[tag=foGamePlayer] saturation 1000000 127 true
execute if score game_mode foGameData matches 5 run effect give @a[tag=foGamePlayer] resistance 1000000 127 true
execute if score game_mode foGameData matches 5 run effect give @a[tag=foGamePlayer] instant_health 1000000 127 true
execute if score game_mode foGameData matches 5 if score game_timer foGameData matches 1 run execute as @a[tag=foGamePlayer] at @s run playsound minecraft:entity.player.levelup voice @s ~ ~ ~ 50.0 1.0
execute if score game_mode foGameData matches 5 if score game_timer foGameData matches 1 if score game_winner foGameData matches 1 run title @a[tag=foGamePlayer] title {"text":"逃走者の勝利","color":"green","bold":"true"}
execute if score game_mode foGameData matches 5 if score game_timer foGameData matches 1 if score game_winner foGameData matches 1 run title @a[tag=foGamePlayer] subtitle {"text":"全ての鬼がいなくなった！"}
execute if score game_mode foGameData matches 5 if score game_timer foGameData matches 1 if score game_winner foGameData matches 2 run title @a[tag=foGamePlayer] title {"text":"鬼の勝利","color":"red","bold":"true"}
execute if score game_mode foGameData matches 5 if score game_timer foGameData matches 1 if score game_winner foGameData matches 2 run title @a[tag=foGamePlayer] subtitle {"text":"逃走者が全員つかまった！"}
execute if score game_mode foGameData matches 5 if score game_timer foGameData matches 1 if score game_winner foGameData matches 3 run title @a[tag=foGamePlayer] title {"text":"逃走者の勝利","color":"green","bold":"true"}
execute if score game_mode foGameData matches 5 if score game_timer foGameData matches 1 if score game_winner foGameData matches 3 run title @a[tag=foGamePlayer] subtitle {"text":"制限時間切れになった！"}
execute if score game_mode foGameData matches 5 if score game_timer foGameData matches 100.. run function fueoni:reset

#GLOBAL INGAME SIDEBAR
execute if score game_mode foGameData matches 3..4 run scoreboard players operation §c鬼§rの数 foIngameSidebar = all_onis foGameData
execute if score game_mode foGameData matches 3..4 run scoreboard players operation §a逃走者§rの数 foIngameSidebar = all_runners foGameData

#DELETE ADMIN ENTITIES
tp @e[tag=foAdminEntity] ~ ~-5000 ~
kill @e[tag=foAdminEntity]
