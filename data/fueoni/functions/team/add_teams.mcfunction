#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

#player teams
team add foGameJoinQueue
team modify foGameJoinQueue prefix [{"text":"","color":"aqua"}]
team modify foGameJoinQueue color aqua
team modify foGameJoinQueue friendlyFire false
team add foRunner
team modify foRunner prefix [{"text":"","color":"green"}]
team modify foRunner color green
team modify foRunner collisionRule never
team modify foRunner nametagVisibility hideForOtherTeams
team modify foRunner seeFriendlyInvisibles true
team modify foRunner friendlyFire false
team add foOni
team modify foOni prefix [{"text":"","color":"red"}]
team modify foOni color red
team modify foOni collisionRule never
team modify foOni nametagVisibility hideForOtherTeams
team modify foOni seeFriendlyInvisibles true
team modify foOni friendlyFire false

#sidebar display teams
team add foPlayerCount
team modify foPlayerCount prefix [{"translate":"参加人数"}]
team add foCountdownTime
team modify foCountdownTime prefix [{"translate":"鬼抽選まで(秒)"}]
team add foReleaseTime
team modify foReleaseTime prefix [{"translate":"鬼解放まで(秒)"}]
team add foRemainingTime
team modify foRemainingTime prefix [{"translate":"残り時間(秒)"}]
team add foOniCount
team modify foOniCount prefix [{"translate":"%1$sの数","with":[{"translate":"鬼","color":"red"}]}]
team add foRunnerCount
team modify foRunnerCount prefix [{"translate":"%1$sの数","with":[{"translate":"逃走者","color":"green"}]}]

