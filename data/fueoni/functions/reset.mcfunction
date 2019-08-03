#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

function fueoni:player/tplobby_all
function fueoni:score/remove_game_objectives
function fueoni:team/remove_teams
function fueoni:score/add_objectives
function fueoni:team/add_teams
kill @e[tag=foGameEntity]
effect clear @a[tag=foGamePlayer]
team join foGameJoinQueue @a[tag=foGamePlayer]