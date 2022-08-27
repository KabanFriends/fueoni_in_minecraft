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
function fueoni:random/init

#DEFAULT SETTINGS
scoreboard players set item_eye foGameOption 1
scoreboard players set item_speed foGameOption 1
scoreboard players set item_invis foGameOption 1
scoreboard players set item_arrow foGameOption 1
scoreboard players set tp_lobby foGameOption 1
scoreboard players set oni_count foGameOption 1
scoreboard players set oni_release_seconds foGameOption 15
scoreboard players set game_seconds foGameOption 240
scoreboard players set sessionID foGameOption 0

scoreboard players set init_ver foGameOption 1
