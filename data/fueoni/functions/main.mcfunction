#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

#GET ADMIN ITEM
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
execute as @e[tag=foStart] at @s run execute as @a[tag=foGamePlayer] at @s run playsound minecraft:entity.player.levelup voice @s ~ ~ ~ 1.0 1.0
execute as @e[tag=foStart] at @s run particle minecraft:flame ~ ~ ~ 0 3 0 0 100 force @a

#ADMIN ENTITY: START ALL PLAYERS
execute as @e[tag=foStartAllPlayers] run team join foGameJoinQueue @a
execute as @e[tag=foStartAllPlayers] at @s run tag @a[tag=!foGamePlayer] add foGamePlayer
execute as @e[tag=foStartAllPlayers] at @s run execute as @a[tag=foGamePlayer] at @s run playsound minecraft:entity.player.levelup voice @s ~ ~ ~ 1.0 1.0
execute as @e[tag=foStartAllPlayers] at @s run particle minecraft:flame ~ ~ ~ 0 3 0 0 100 force @a

#VARIOUS DATA COLLECTION
scoreboard players set all_players foGameData 0
scoreboard players set all_queues foGameData 0
scoreboard players set all_runners foGameData 0
scoreboard players set all_onis foGameData 0
execute as @a[tag=foGamePlayer] run scoreboard players add all_players foGameData 1
execute as @a[tag=foGamePlayer,team=foGameJoinQueue] run scoreboard players add all_queues foGameData 1
execute as @a[tag=foGamePlayer,team=foRunner] run scoreboard players add all_runners foGameData 1
execute as @a[tag=foGamePlayer,team=foOni] run scoreboard players add all_onis foGameData 1

scoreboard players operation §a参加人数 foListSidebar = all_players foGameData 
scoreboard players set @a[tag=foGamePlayer] foListSidebar 0
scoreboard players reset @a[tag=!foGamePlayer] foListSidebar


#DELETE ADMIN ENTITIES
tp @e[tag=foAdminEntity] ~ ~-5000 ~
kill @e[tag=foAdminEntity]