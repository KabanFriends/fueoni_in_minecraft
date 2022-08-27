#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

scoreboard players set rng_min foRandom 450
scoreboard players set rng_max foRandom 750
function fueoni:random/uniform
scoreboard players operation @s foSpawnTimerEnd = rng_out foRandom
scoreboard players set rng_min foRandom 1
scoreboard players operation rng_max foRandom = item_count foGameData
function fueoni:random/uniform
scoreboard players operation @s foItemSpawnId = rng_out foRandom
