#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

kill @e[tag=foGameEntity]
scoreboard players set start_yaw foGameData 0
execute as @s[type=player] store result score start_yaw foGameData run data get entity @s Rotation[0] 10
execute as @a[advancements={fueoni:spawn_egg/start_game=true}] store result score start_yaw foGameData run data get entity @s Rotation[0] 10
summon marker ~ ~ ~ {Tags:["foStartLocation","foGameEntity"]}
execute as @e[tag=foStartLocation] store result entity @s Rotation[0] float 0.1 run scoreboard players get start_yaw foGameData
scoreboard players set game_timer foGameData 0
scoreboard players set game_mode foGameData 1
