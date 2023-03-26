#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

scoreboard players set compare_check foGameData -1
data remove storage fueoni:check_arrow_projectile ArrowOwner
data modify storage fueoni:check_arrow_projectile ArrowOwner set from entity @s Owner
execute store success score compare_check foGameData run data modify storage fueoni:check_arrow_projectile ArrowOwner set from storage fueoni:check_arrow_projectile PlayerUUID

execute if score compare_check foGameData matches 0 run tag @s add foGameEntity
