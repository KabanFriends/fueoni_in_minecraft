#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

execute unless score item_frequency foGameOption = item_frequency foGameOption run scoreboard players set item_frequency foGameOption 1
execute unless score item_eye foGameOption = item_eye foGameOption run scoreboard players set item_eye foGameOption 1
execute unless score item_speed foGameOption = item_speed foGameOption run scoreboard players set item_speed foGameOption 1
execute unless score item_invis foGameOption = item_invis foGameOption run scoreboard players set item_invis foGameOption 1
execute unless score item_arrow foGameOption = item_arrow foGameOption run scoreboard players set item_arrow foGameOption 1
execute unless score tp_lobby foGameOption = tp_lobby foGameOption run scoreboard players set tp_lobby foGameOption 1
execute unless score oni_count foGameOption = oni_count foGameOption run scoreboard players set oni_count foGameOption 1
execute unless score oni_release_seconds foGameOption = oni_release_seconds foGameOption run scoreboard players set oni_release_seconds foGameOption 15
execute unless score oni_speed_seconds foGameOption = oni_speed_seconds foGameOption run scoreboard players set oni_speed_seconds foGameOption 25
execute unless score game_seconds foGameOption = game_seconds foGameOption run scoreboard players set game_seconds foGameOption 240
scoreboard players set sessionID foGameOption 0
