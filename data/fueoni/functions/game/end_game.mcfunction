#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

function fueoni:game/reset
team join foGameJoinQueue @a[tag=foGamePlayer]
gamemode adventure @a[tag=foGamePlayer,gamemode=spectator]
execute if score tp_lobby foGameOption matches 1 run function fueoni:player/tplobby_all
