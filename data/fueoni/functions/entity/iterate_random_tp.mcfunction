#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

tp @s ~ ~-1 ~
execute at @s unless block ~ ~ ~ chest{foImpossible:1b} if block ~ ~1 ~ #fueoni:fo_nonsolid if block ~ ~ ~ #fueoni:fo_nonsolid unless block ~ ~-1 ~ #fueoni:fo_nonsolid_liquid run summon marker ~ ~ ~ {Tags:["foTPTarget","foGameEntity"]}
execute at @s unless block ~ ~ ~ chest{foImpossible:1b} run function fueoni:entity/iterate_random_tp
