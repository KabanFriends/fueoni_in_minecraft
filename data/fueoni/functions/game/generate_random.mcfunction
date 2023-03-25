#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

#ITEM SPAWN INTERVAL
#low frequency
execute if score item_frequency foGameOption matches 0 run scoreboard players set rng_min foRandom 810
execute if score item_frequency foGameOption matches 0 run scoreboard players set rng_max foRandom 1110
#normal frequency
execute if score item_frequency foGameOption matches 1 run scoreboard players set rng_min foRandom 450
execute if score item_frequency foGameOption matches 1 run scoreboard players set rng_max foRandom 750
#high frequency
execute if score item_frequency foGameOption matches 2 run scoreboard players set rng_min foRandom 90
execute if score item_frequency foGameOption matches 2 run scoreboard players set rng_max foRandom 390
#generate random
function fueoni:random/uniform
scoreboard players operation @s foSpawnTimerEnd = rng_out foRandom

#ITEM TYPE
scoreboard players set rng_min foRandom 1
scoreboard players operation rng_max foRandom = item_count foGameData
#generate random
function fueoni:random/uniform
scoreboard players operation @s foItemSpawnId = rng_out foRandom
