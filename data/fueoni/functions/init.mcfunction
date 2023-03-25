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

scoreboard players operation init_ver foGameOption = current_data_ver foInitTemp
