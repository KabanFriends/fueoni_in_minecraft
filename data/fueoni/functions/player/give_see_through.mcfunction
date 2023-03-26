#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

execute as @e[type=arrow,distance=..10,tag=!foArrowEntity] run data modify storage fueoni:give_see_through PlayerUUID set from entity @s UUID
summon item ~ ~ ~ {Tags:["foTempGiveItem"],Item:{id:"minecraft:ender_eye",Count:1b,tag:{display:{Name:'{"translate":"fueoni.item.see_through.name","fallback":"透視の目","color":"#B3E159","bold":true,"italic":false}',Lore:['[{"translate":"fueoni.item.see_through.lore.1","fallback":"%1$sすると数秒間","color":"gray","italic":false,"with":[{"translate":"fueoni.item.see_through.lore.1.right_click","fallback":"右クリック","color":"gold","bold":false,"italic":false}]}]','{"translate":"fueoni.item.see_through.lore.2","fallback":"鬼の位置がわかる。","color":"gray","italic":false}']},HideFlags:63,Enchantments:[{id:"minecraft:vanishing_curse",lvl:1s}]}},PickupDelay:0}
execute as @e[tag=foTempGiveItem,limit=1] run data modify entity @s Owner set from entity @s 
execute as @e[tag=foTempGiveItem,limit=1] run data modify entity @s Item.tag.EntityUUID set from entity @s UUID
tag @e[tag=foTempGiveItem] remove foTempGiveItem