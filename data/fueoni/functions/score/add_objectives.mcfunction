#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

scoreboard objectives add foIngameSidebar dummy [{"translate":"増え鬼 %1$s","color":"yellow","bold":true,"with":[{"translate":"[ゲーム中]","color":"gold","bold":false}]}]
scoreboard objectives add foListSidebar dummy [{"translate":"増え鬼 %1$s","color":"yellow","bold":true,"with":[{"translate":"[参加者]","color":"gold","bold":false}]}]
scoreboard objectives add foGameOption dummy
scoreboard objectives add foGameData dummy
scoreboard objectives add foRandom dummy
scoreboard objectives add foEntityTick dummy
scoreboard objectives add foPlayerSID dummy
scoreboard objectives add foItemSpawnTimer dummy
scoreboard objectives add foItemSpawnId dummy
scoreboard objectives add foItemSpawnType dummy
scoreboard objectives add foSpawnTimerEnd dummy
scoreboard objectives add foSettingsTime dummy
scoreboard objectives add foSettingsTrigger trigger
scoreboard objectives add foAliveTime minecraft.custom:minecraft.time_since_death
scoreboard objectives add foDeathCount minecraft.custom:minecraft.deaths
scoreboard objectives add foQuitGame minecraft.custom:minecraft.leave_game
scoreboard objectives add foUseEnderPearl minecraft.used:minecraft.ender_pearl
