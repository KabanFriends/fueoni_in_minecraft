#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

tag @r[tag=foOniSelection] add foTempOni
team join foOni @a[tag=foTempOni]
tag @a[tag=foTempOni] remove foOniSelection
tag @a[tag=foTempOni] remove foTempOni

scoreboard players remove onis_to_sel foGameData 1
execute unless score onis_to_sel foGameData matches ..0 run function fueoni:game/iterate_select_oni
