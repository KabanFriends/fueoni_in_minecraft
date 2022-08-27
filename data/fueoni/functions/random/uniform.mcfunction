#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

scoreboard players operation size foRandom = rng_max foRandom
scoreboard players operation size foRandom -= rng_min foRandom
scoreboard players add size foRandom 1

scoreboard players operation lcg foRandom *= lcg_a foRandom
scoreboard players operation lcg foRandom += lcg_c foRandom
scoreboard players operation lcg foRandom %= lcg_m foRandom

scoreboard players operation rng_out foRandom = lcg foRandom
scoreboard players operation rng_out foRandom /= num_8 foRandom

scoreboard players operation rng_out foRandom %= size foRandom
scoreboard players operation rng_out foRandom += rng_min foRandom
