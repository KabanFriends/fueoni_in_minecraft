#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

function fueoni:score/remove_game_objectives
function fueoni:team/remove_teams
function fueoni:bossbar/remove_bossbar
function fueoni:score/add_objectives
function fueoni:team/add_teams
function fueoni:bossbar/add_bossbar
kill @e[tag=foGameEntity]
clear @a[tag=foGamePlayer]
effect clear @a[tag=foGamePlayer]
team join foGameJoinQueue @a[tag=foGamePlayer]
gamemode adventure @a[tag=foGamePlayer,gamemode=spectator]
execute if score tp_lobby foGameOption matches 1 run function fueoni:player/tplobby_all
