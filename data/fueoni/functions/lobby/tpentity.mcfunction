#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

execute store result entity @s Pos[0] double 1 run scoreboard players get lobby_x foGameOption
execute store result entity @s Pos[1] double 1 run scoreboard players get lobby_y foGameOption
execute store result entity @s Pos[2] double 1 run scoreboard players get lobby_z foGameOption

execute as @s at @s run teleport @a[tag=foTPLobbyTarget] ~0.5 ~ ~0.5 0 0

tag @a[tag=foTPLobbyTarget] remove foTPLobbyTarget
kill @s