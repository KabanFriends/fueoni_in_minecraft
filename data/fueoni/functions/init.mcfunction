#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

gamerule maxCommandChainLength 65536
gamerule commandBlockOutput false
gamerule logAdminCommands false
function fueoni:score/remove_objectives
function fueoni:team/remove_teams
function fueoni:bossbar/remove_bossbar
function fueoni:score/add_objectives
function fueoni:team/add_teams
function fueoni:bossbar/add_bossbar

#DEFAULT SETTINGS
scoreboard players set game_minutes foGameOption 3
scoreboard players set sessionID foGameOption 0

scoreboard players set init_done foGameOption 1
