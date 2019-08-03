#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

particle minecraft:happy_villager ^ ^ ^3 0 0 0 0 1 force @a
tp @s ~ ~ ~ ~5 ~
execute unless entity @s[y_rotation=0..4] at @s run function fueoni:particle/circle_happy_villager