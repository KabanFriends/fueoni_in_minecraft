#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

tag @a add foTPLobbyTarget
summon armor_stand 0 0 0 {Tags:["foTPLobbyTemp"],Invisible:true,Invulnerable:true,NoGravity:true,Marker:true,Small:true}
execute as @e[tag=foTPLobbyTemp] at @s run function fueoni:lobby/tpentity