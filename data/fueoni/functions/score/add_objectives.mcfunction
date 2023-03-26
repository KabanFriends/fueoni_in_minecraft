#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

scoreboard objectives add foIngameSidebar dummy [{"translate":"fueoni.scoreboard.title","fallback":"増え鬼","color":"yellow","bold":true,"with":[{"translate":"fueoni.scoreboard.title.ingame","fallback":"[ゲーム中]","color":"gold","bold":false}]}]
scoreboard objectives add foListSidebar dummy [{"translate":"fueoni.scoreboard.title","fallback":"増え鬼","color":"yellow","bold":true,"with":[{"translate":"fueoni.scoreboard.title.players","fallback":"[参加者]","color":"gold","bold":false}]}]
scoreboard objectives add foGameOption dummy
scoreboard objectives add foGameData dummy
scoreboard objectives add foRandom dummy
scoreboard objectives add foEntityTick dummy
scoreboard objectives add foPlayerSID dummy
scoreboard objectives add foItemSpawnTimer dummy
scoreboard objectives add foItemSpawnId dummy
scoreboard objectives add foItemSpawnType dummy
scoreboard objectives add foSpawnTimerEnd dummy
scoreboard objectives add foInvisibleTimer dummy
scoreboard objectives add foPlayerTickTemp1 dummy
scoreboard objectives add foPlayerTickTemp2 dummy
scoreboard objectives add foSettingsTime dummy
scoreboard objectives add foSettingsTrigger trigger
scoreboard objectives add foAliveTime minecraft.custom:minecraft.time_since_death
scoreboard objectives add foDeathCount minecraft.custom:minecraft.deaths
scoreboard objectives add foQuitGame minecraft.custom:minecraft.leave_game
