#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

summon marker 0 0 0 {Tags:["foTPLobbyTemp"]}
execute as @e[tag=foTPLobbyTemp] at @s run function fueoni:entity/tplobby
tp @a[tag=foGamePlayer] @e[tag=foTPLobbyTemp,limit=1]
kill @e[tag=tpLobbyTemp]
