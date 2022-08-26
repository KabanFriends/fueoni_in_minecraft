#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

#GIVE ADMIN ITEM
execute as @e[nbt={Inventory:[{id:"minecraft:command_block",tag:{display:{Name:'{"text":"fueoni"}'}}}]}] run function fueoni:player/admin

#ADMIN ENTITY: SET LOBBY
execute if entity @e[tag=foSetLobby] as @e[tag=foSetLobby] store result score lobby_xpos foGameOption run data get entity @s Pos[0] 100
execute if entity @e[tag=foSetLobby] as @e[tag=foSetLobby] store result score lobby_ypos foGameOption run data get entity @s Pos[1] 100
execute if entity @e[tag=foSetLobby] as @e[tag=foSetLobby] store result score lobby_zpos foGameOption run data get entity @s Pos[2] 100
execute if entity @e[tag=foSetLobby] as @e[tag=foSetLobby] at @s run particle minecraft:end_rod ~ ~ ~ 0 3 0 0 100 force @a

#ADMIN ENTITY: ADD PLAYERS
execute as @e[tag=foAddPlayers] at @s run execute as @a[tag=!foGamePlayer,distance=..3] run function fueoni:player/join
execute as @e[tag=foAddPlayers] at @s run summon marker ~ ~ ~ {Tags:["foAddParticleOrigin"]}
execute as @e[tag=foAddParticleOrigin] at @s run particle minecraft:crit ~ ~ ~ 0 3 0 0 100 force @a
execute as @e[tag=foAddParticleOrigin] at @s run function fueoni:particle/circle_happy_villager
kill @e[tag=foAddParticleOrigin]

#ADMIN ENTITY: SHOW JOINED PLAYERS
execute as @e[tag=foShowJoinedPlayers] at @s run scoreboard objectives setdisplay sidebar foListSidebar

#ADMIN ENTITY: REMOVE PLAYERS
execute as @e[tag=foRemovePlayers] at @s run execute as @a[tag=foGamePlayer,distance=..3,team=foGameJoinQueue] run function fueoni:player/quit
execute as @e[tag=foRemovePlayers] at @s run summon marker ~ ~ ~ {Tags:["foRemoveParticleOrigin"]}
execute as @e[tag=foRemoveParticleOrigin] at @s run particle minecraft:crit ~ ~ ~ 0 3 0 0 100 force @a
execute as @e[tag=foRemoveParticleOrigin] at @s run function fueoni:particle/circle_reddust
kill @e[tag=foRemoveParticleOrigin]

#ADMIN ENTITY: REMOVE ALL PLAYERS
execute as @e[tag=foRemoveAllPlayers] run execute as @a[tag=foGamePlayer] at @s run playsound minecraft:block.note_block.bass voice @s ~ ~ ~ 1.0 1.0
execute as @e[tag=foRemoveAllPlayers] run execute as @a[tag=foGamePlayer,team=foGameJoinQueue] run function fueoni:player/quit

#ADMIN ENTITY: START
execute as @e[tag=foStart] at @s run function fueoni:start

#ADMIN ENTITY: START ALL PLAYERS
execute as @e[tag=foStartAllPlayers] run team join foGameJoinQueue @a[team=!foGameJoinQueue]
execute as @e[tag=foStartAllPlayers] at @s run tag @a[tag=!foGamePlayer] add foGamePlayer
execute as @e[tag=foStartAllPlayers] at @s run function fueoni:start

#ADMIN ENTITY: END GAME
execute as @e[tag=foEndGame] run function fueoni:reset
execute as @e[tag=foEndGame] run execute as @a[tag=foGamePlayer] at @s run playsound minecraft:block.note_block.bass voice @s ~ ~ ~ 1.0 1.0
execute as @e[tag=foEndGame] run kill @e[tag=foGameEntity]
execute as @e[tag=foEndGame] run team join foGameJoinQueue @a[tag=foGamePlayer]

#ADMIN ENTITY: CHANGE TIME
execute as @e[tag=foChangeTime] at @s run execute as @a[distance=..5,scores={foSneakTime=1..}] run tag @e[tag=foChangeTime] add foHasSneaker
execute as @e[tag=foChangeTime,tag=!foHasSneaker] at @s run execute as @a[distance=..5] at @s run playsound minecraft:block.wooden_button.click_on voice @s ~ ~ ~ 1.0 1.8
execute as @e[tag=foChangeTime,tag=!foHasSneaker] run scoreboard players add game_minutes foGameOption 1 
execute as @e[tag=foChangeTime,tag=foHasSneaker] at @s if score game_minutes foGameOption matches 1 run execute as @a[distance=..5] at @s run playsound minecraft:block.note_block.bass voice @s ~ ~ ~ 1.0 1.0
execute as @e[tag=foChangeTime,tag=foHasSneaker] at @s if score game_minutes foGameOption matches 1 run tellraw @a[distance=..5] [{"text":""},{"translate":"増え鬼%1$s","color":"yellow","bold":true,"with":[{"text":" » ","color":"gray","bold":false}]},{"translate":"ゲームの長さは%1$sである必要があります。","color":"red","with":[{"translate":"1分以上","color":"gold"}]}]
execute as @e[tag=foChangeTime,tag=foHasSneaker] at @s if score game_minutes foGameOption matches 2.. run execute as @a[distance=..5] at @s run playsound minecraft:block.wooden_button.click_on voice @s ~ ~ ~ 1.0 1.0
execute as @e[tag=foChangeTime,tag=foHasSneaker] if score game_minutes foGameOption matches 2.. run scoreboard players remove game_minutes foGameOption 1
execute as @e[tag=foChangeTime] at @s run title @a[distance=..5] actionbar [{"text":""},{"text":">","color":"gray","bold":true},{"text":" "},{"translate":"ゲームの長さ: %1$s","color":"green","with":[{"translate":"%1$s分間","color":"aqua","bold":true,"with":[{"score":{"name":"game_minutes","objective":"foGameOption"},"color":"aqua","bold":true}]}]}]

#DELETE ADMIN ENTITIES
kill @e[tag=foAdminEntity]

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
execute as @a[tag=foGamePlayer,scores={foQuitGame=1..}] run team join foGameJoinQueue @s
execute as @a[tag=foGamePlayer,scores={foQuitGame=1..}] run clear @s
#before oni selection -> teleport to game start location
execute as @a[tag=foGamePlayer,scores={foQuitGame=1..}] if score game_mode foGameData matches 1..2 run gamemode adventure @s
execute as @a[tag=foGamePlayer,scores={foQuitGame=1..}] if score game_mode foGameData matches 1..2 run tp @s @e[tag=foStartLocation,limit=1]
#after oni selection -> rejoin in same game -> continue
#after oni selection -> rejoin in different game -> spectator / teleport to random player
execute as @a[tag=foGamePlayer,scores={foQuitGame=1..}] if score game_mode foGameData matches 3..5 unless score @s foPlayerSID = sessionID foGameOption run gamemode spectator @s
execute as @a[tag=foGamePlayer,scores={foQuitGame=1..}] if score game_mode foGameData matches 3..5 unless score @s foPlayerSID = sessionID foGameOption run tp @s @a[tag=foGamePlayer,sort=random,limit=1]
#reset quit game score
scoreboard players reset @a[scores={foQuitGame=1..}] foQuitGame

#CREATE LIST SIDEBAR
team join foPlayerCount §r
scoreboard players operation §r foListSidebar = all_players foGameData 
scoreboard players set @a[tag=foGamePlayer] foListSidebar 0
scoreboard players reset @a[tag=!foGamePlayer] foListSidebar

#SNEAK DETECTION
scoreboard players set @a[scores={foSneakTime=1..}] foSneakTime 1
scoreboard players reset @a[scores={foSneakTime=1..}] foSneakTime

#GAMEMODES
execute if score game_mode foGameData matches 1 run function fueoni:gamemodes/1_validate
execute if score game_mode foGameData matches 2 run function fueoni:gamemodes/2_pre_oni_select
execute if score game_mode foGameData matches 3 run function fueoni:gamemodes/3_oni_waiting
execute if score game_mode foGameData matches 4 run function fueoni:gamemodes/4_game_main
execute if score game_mode foGameData matches 5 run function fueoni:gamemodes/5_ending

#GLOBAL INGAME SIDEBAR
execute if score game_mode foGameData matches 3..4 run team join foOniCount §r§r
execute if score game_mode foGameData matches 3..4 run scoreboard players operation §r§r foIngameSidebar = all_onis foGameData
execute if score game_mode foGameData matches 3..4 run team join foRunnerCount §r§r§r
execute if score game_mode foGameData matches 3..4 run scoreboard players operation §r§r§r foIngameSidebar = all_runners foGameData
