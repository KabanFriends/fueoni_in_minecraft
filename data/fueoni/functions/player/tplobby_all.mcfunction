#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

summon armor_stand 0 0 0 {Tags:["foTPLobbyTemp"],Invisible:true,Invulnerable:true,NoGravity:true,Marker:true,Small:true}
execute as @e[tag=foTPLobbyTemp] at @s run function fueoni:entity/tplobby
execute at @e[tag=foTPLobbyTemp] run tp @a[tag=foTPLobbyTarget] ~0.5 ~ ~0.5 0 0
kill @e[tag=tpLobbyTemp]
