#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

playsound minecraft:block.note_block.bass voice @s[type=player,tag=foGamePlayer,team=foGameJoinQueue] ~ ~ ~ 1.0 1.0
team leave @s[type=player,tag=foGamePlayer,team=foGameJoinQueue]
tellraw @s[type=player,tag=foGamePlayer] [{"text":""},{"text":"増え鬼","color":"yellow","bold":"true"},{"text":" » ","color":"gray"},{"text":"あなたは次の増え鬼ゲームに参加しません。","color":"red"}]
function fueoni:player/remove_tags
tag @s[type=player,tag=foGamePlayer] remove foGamePlayer