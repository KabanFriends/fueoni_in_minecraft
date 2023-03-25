#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

#GIVE ADMIN ITEM
execute as @a[nbt={Inventory:[{id:"minecraft:command_block",tag:{display:{Name:'{"text":"fueoni"}'}}}]}] run function fueoni:player/admin

#ADMIN ENTITY: SET LOBBY
execute if entity @e[tag=foSetLobby] unless entity @a[advancements={fueoni:spawn_egg/set_lobby=true},x=0] as @a[advancements={fueoni:spawn_egg/set_lobby=true}] at @s run playsound minecraft:block.note_block.bass voice @s ~ ~ ~ 1.0 1.0
execute if entity @e[tag=foSetLobby] unless entity @a[advancements={fueoni:spawn_egg/set_lobby=true},x=0] run tellraw @a[advancements={fueoni:spawn_egg/set_lobby=true}] [{"text":""},{"translate":"fueoni.message.prefix","fallback":"増え鬼","color":"yellow","bold":true},{"text":" » ","color":"gray","bold":false},{"translate":"fueoni.message.cannot_set_lobby","fallback":"ロビー地点は初期ワールド以外では設定できません！","color":"red"}]
execute if entity @e[tag=foSetLobby] unless entity @a[advancements={fueoni:spawn_egg/set_lobby=true},x=0] run kill @e[tag=foSetLobby]
execute if entity @e[tag=foSetLobby] as @a[advancements={fueoni:spawn_egg/set_lobby=true}] at @s run playsound minecraft:entity.experience_orb.pickup voice @s ~ ~ ~ 0.7 2.0
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
execute as @e[tag=foStart] at @s run function fueoni:game/start

#ADMIN ENTITY: START ALL PLAYERS
execute as @e[tag=foStartAllPlayers] run team join foGameJoinQueue @a[team=!foGameJoinQueue]
execute as @e[tag=foStartAllPlayers] at @s run tag @a[tag=!foGamePlayer] add foGamePlayer
execute as @e[tag=foStartAllPlayers] at @s run function fueoni:game/start

#ADMIN ENTITY: END GAME
execute as @e[tag=foEndGame] run function fueoni:game/reset
execute as @e[tag=foEndGame] run execute as @a[tag=foGamePlayer] at @s run playsound minecraft:block.note_block.bass voice @s ~ ~ ~ 1.0 1.0
execute as @e[tag=foEndGame] run kill @e[tag=foGameEntity]
execute as @e[tag=foEndGame] run team join foGameJoinQueue @a[tag=foGamePlayer]

#ADMIN ENTITY: GAME SETTINGS
execute as @a[advancements={fueoni:spawn_egg/game_settings=true}] at @s run playsound minecraft:block.wooden_button.click_off voice @s ~ ~ ~ 2.5 2.0
execute as @a[advancements={fueoni:spawn_egg/game_settings=true}] at @s run function fueoni:player/game_settings

#item settings
execute as @a[scores={foSettingsTrigger=1}] run scoreboard players set item_eye foGameOption 1
execute as @a[scores={foSettingsTrigger=2}] run scoreboard players set item_eye foGameOption 0
execute as @a[scores={foSettingsTrigger=3}] run scoreboard players set item_speed foGameOption 1
execute as @a[scores={foSettingsTrigger=4}] run scoreboard players set item_speed foGameOption 0
execute as @a[scores={foSettingsTrigger=5}] run scoreboard players set item_invis foGameOption 1
execute as @a[scores={foSettingsTrigger=6}] run scoreboard players set item_invis foGameOption 0
execute as @a[scores={foSettingsTrigger=7}] run scoreboard players set item_arrow foGameOption 1
execute as @a[scores={foSettingsTrigger=8}] run scoreboard players set item_arrow foGameOption 0

#oni count settings
execute as @a[scores={foSettingsTrigger=9}] if score oni_count foGameOption matches 2.. run scoreboard players remove oni_count foGameOption 1
execute as @a[scores={foSettingsTrigger=10}] run scoreboard players add oni_count foGameOption 1

#game time settings
execute as @a[scores={foSettingsTrigger=11}] if score game_seconds foGameOption matches 70.. run scoreboard players remove game_seconds foGameOption 60
execute as @a[scores={foSettingsTrigger=12}] if score game_seconds foGameOption matches 11.. run scoreboard players remove game_seconds foGameOption 10
execute as @a[scores={foSettingsTrigger=13}] run scoreboard players add game_seconds foGameOption 10
execute as @a[scores={foSettingsTrigger=14}] run scoreboard players add game_seconds foGameOption 60

#release time settings
execute as @a[scores={foSettingsTrigger=15}] if score oni_release_seconds foGameOption matches 2.. run scoreboard players remove oni_release_seconds foGameOption 1
execute as @a[scores={foSettingsTrigger=16}] run scoreboard players add oni_release_seconds foGameOption 1

#teleport to lobby settings
execute as @a[scores={foSettingsTrigger=17}] run scoreboard players set tp_lobby foGameOption 1
execute as @a[scores={foSettingsTrigger=18}] run scoreboard players set tp_lobby foGameOption 0

#item spawn frequency settings
execute as @a[scores={foSettingsTrigger=19}] run scoreboard players set item_frequency foGameOption 0
execute as @a[scores={foSettingsTrigger=20}] run scoreboard players set item_frequency foGameOption 1
execute as @a[scores={foSettingsTrigger=21}] run scoreboard players set item_frequency foGameOption 2

#resend settings
tellraw @a[scores={foSettingsTrigger=1..21}] {"text":"\n\n\n\n"}
execute as @a[scores={foSettingsTrigger=1..21}] at @s run playsound minecraft:block.note_block.hat voice @s ~ ~ ~ 1.0 1.2
execute as @a[scores={foSettingsTrigger=1..21}] run function fueoni:player/game_settings

execute as @a[scores={foSettingsTime=1..}] run scoreboard players remove @s foSettingsTime 1
execute as @a[scores={foSettingsTime=..0}] run trigger foSettingsTrigger set 0

#DELETE ADMIN ENTITIES
kill @e[tag=foAdminEntity]

#clear list sidebar every 2s
scoreboard players add listbar_clear_timer foGameData 1
execute if score listbar_clear_timer foGameData matches 40.. run scoreboard players reset * foListSidebar
execute if score listbar_clear_timer foGameData matches 40.. run scoreboard players set listbar_clear_timer foGameData 0

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

#GAMEMODES
execute if score game_mode foGameData matches 1 run function fueoni:game/gamemodes/1_validate
execute if score game_mode foGameData matches 2 run function fueoni:game/gamemodes/2_pre_oni_select
execute if score game_mode foGameData matches 3 run function fueoni:game/gamemodes/3_oni_waiting
execute if score game_mode foGameData matches 4 run function fueoni:game/gamemodes/4_game_main
execute if score game_mode foGameData matches 5 run function fueoni:game/gamemodes/5_ending

#GLOBAL INGAME SIDEBAR
execute if score game_mode foGameData matches 3..4 run team join foOniCount §r§r
execute if score game_mode foGameData matches 3..4 run scoreboard players operation §r§r foIngameSidebar = all_onis foGameData
execute if score game_mode foGameData matches 3..4 run team join foRunnerCount §r§r§r
execute if score game_mode foGameData matches 3..4 run scoreboard players operation §r§r§r foIngameSidebar = all_runners foGameData

#REVOKE ADVANCEMENTS
advancement revoke @a through fueoni:root
