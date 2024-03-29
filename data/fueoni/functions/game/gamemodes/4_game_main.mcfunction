#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

scoreboard players add game_timer foGameData 1
effect give @a[tag=foGamePlayer] saturation infinite 127 true
effect give @a[tag=foGamePlayer,team=foOni] strength infinite 127 true
execute if score game_timer foGameData matches 1 run scoreboard players set num_20 foGameData 20
execute if score game_timer foGameData matches 1 run scoreboard players set num_60 foGameData 60
execute if score game_timer foGameData matches 1 run scoreboard players reset @a[tag=foGamePlayer] foDeathCount
execute if score game_timer foGameData matches 1 run scoreboard players set @a[tag=foGamePlayer] foAliveTime 3
execute if score game_timer foGameData matches 1 run scoreboard objectives setdisplay sidebar foIngameSidebar
execute if score game_timer foGameData matches 1 run scoreboard players operation game_timeleft foGameData = game_seconds foGameOption
execute if score game_timer foGameData matches 1 run item replace entity @a[tag=foGamePlayer,team=foOni] armor.chest with minecraft:leather_chestplate{display:{Name:'{"translate":"fueoni.item.oni_shirt.name","fallback":"鬼の服","color":"red","bold":true,"italic":false}',Lore:['{"translate":"fueoni.item.oni_shirt.lore.1","fallback":"トマトジュースで染まった","color":"gray","italic":false}','{"translate":"fueoni.item.oni_shirt.lore.2","fallback":"きれいな赤色！","color":"gray","italic":false}'],color:16711680},HideFlags: 63,Unbreakable: 1b,Enchantments:[{id:"minecraft:protection",lvl:127s},{id:"minecraft:binding_curse",lvl:1s},{id:"minecraft:vanishing_curse",lvl:1s}]}
execute if score game_timer foGameData matches 1 run effect clear @a[tag=foGamePlayer,team=foOni] invisibility
execute if score game_timer foGameData matches 1 run effect clear @a[tag=foGamePlayer,team=foRunner] strength
scoreboard players operation game_ticksec foGameData = game_timer foGameData
scoreboard players operation game_ticksec foGameData %= num_20 foGameData
execute if score game_ticksec foGameData matches 0 run scoreboard players remove game_timeleft foGameData 1
team join foRemainingTime §r§r§r§r
scoreboard players operation §r§r§r§r foIngameSidebar = game_timeleft foGameData
#bossbar update
execute if score game_timer foGameData matches 1 store result bossbar fo_ingame max run scoreboard players get game_timeleft foGameData
execute store result bossbar fo_ingame value run scoreboard players get game_timeleft foGameData
scoreboard players operation bar_sec foGameData = game_timeleft foGameData
scoreboard players operation bar_min foGameData = game_timeleft foGameData
scoreboard players operation bar_sec foGameData %= num_60 foGameData
scoreboard players operation bar_min foGameData /= num_60 foGameData
execute if score bar_sec foGameData matches ..9 run bossbar set fo_ingame name [{"translate":"fueoni.bossbar.title","fallback":"残り時間: %1$s","color":"red","with":[[{"score":{"name":"bar_min","objective":"foGameData"},"color":"gold","bold":true},{"text":":0","color":"gold","bold":true},{"score":{"name":"bar_sec","objective":"foGameData"},"color":"gold","bold":true}]]}]
execute if score bar_sec foGameData matches 10.. run bossbar set fo_ingame name [{"translate":"fueoni.bossbar.title","fallback":"残り時間: %1$s","color":"red","with":[[{"score":{"name":"bar_min","objective":"foGameData"},"color":"gold","bold":true},{"text":":","color":"gold","bold":true},{"score":{"name":"bar_sec","objective":"foGameData"},"color":"gold","bold":true}]]}]
bossbar set fo_ingame players @a[tag=foGamePlayer]
#death
tag @a[tag=foGamePlayer,team=foRunner,scores={foDeathCount=1..}] add foSwitchRole
team join foOni @a[tag=foGamePlayer,team=foRunner,scores={foDeathCount=1..}]
scoreboard players reset @a[tag=foGamePlayer,scores={foDeathCount=1..}] foDeathCount
#respawn
clear @a[tag=foGamePlayer,team=foOni,scores={foAliveTime=2}]
item replace entity @a[tag=foGamePlayer,team=foOni,scores={foAliveTime=2}] armor.chest with minecraft:leather_chestplate{display:{Name:'{"translate":"fueoni.item.oni_shirt.name","fallback":"鬼の服","color":"red","bold":true,"italic":false}',Lore:['{"translate":"fueoni.item.oni_shirt.lore.1","fallback":"トマトジュースで染まった","color":"gray","italic":false}','{"translate":"fueoni.item.oni_shirt.lore.2","fallback":"きれいな赤色！","color":"gray","italic":false}'],color:16711680},HideFlags:63,Unbreakable:1b,Enchantments:[{id:"minecraft:protection",lvl:127s},{id:"minecraft:binding_curse",lvl:1s},{id:"minecraft:vanishing_curse",lvl:1s}]}
tp @a[tag=foGamePlayer,scores={foAliveTime=2}] @e[tag=foStartLocation,limit=1]
execute as @a[tag=foGamePlayer,scores={foAliveTime=2}] if entity @s[tag=foSwitchRole] run tellraw @s [{"text":""},{"translate":"fueoni.message.prefix","fallback":"増え鬼","color":"yellow","bold":true},{"text":" » ","color":"gray","bold":false},{"translate":"fueoni.message.game.caught","fallback":"つかまってしまった！","color":"red","bold":true},{"text":" "},{"translate":"fueoni.message.game.caught_message","fallback":"あなたは鬼になりました。"}]
execute as @a[tag=foGamePlayer,scores={foAliveTime=2}] if entity @s[tag=foSwitchRole] run tag @s remove foSwitchRole
scoreboard players set @a[tag=foGamePlayer,scores={foAliveTime=3..}] foAliveTime 3
#set item
scoreboard players add @e[tag=foItemEntity] foEntityTick 1
execute as @e[tag=foNeedItem,scores={foEntityTick=2}] run execute as @s[tag=foEye] run data merge entity @s {ArmorItems:[{},{},{},{id:"minecraft:player_head",Count:1b,tag:{SkullOwner:{Id:[I;907160796,1821854615,-1727336627,-176309982],Properties:{textures:[{Value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvZGFhOGZjOGRlNjQxN2I0OGQ0OGM4MGI0NDNjZjUzMjZlM2Q5ZGE0ZGJlOWIyNWZjZDQ5NTQ5ZDk2MTY4ZmMwIn19fQ=="}]}}}}],CustomName:'{"translate":"fueoni.pickup.see_through","fallback":"透視","color":"#B3E159","bold":true}'}
execute as @e[tag=foNeedItem,scores={foEntityTick=2}] run execute as @s[tag=foSpeed] run data merge entity @s {Tags:["foSpeed","foGameEntity","foItemEntity"],ArmorItems:[{},{},{},{id:"minecraft:player_head",Count:1b,tag:{SkullOwner:{Id:[I;52839116,-179814034,-1783536278,237371388],Properties:{textures:[{Value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMjY3MWM0YzA0MzM3YzM4YTVjN2YzMWE1Yzc1MWY5OTFlOTZjMDNkZjczMGNkYmVlOTkzMjA2NTVjMTlkIn19fQ=="}]}}}}],CustomName:'{"translate":"fueoni.pickup.speed","fallback":"スピード","color":"#7FDDFF","bold":true}'}
execute as @e[tag=foNeedItem,scores={foEntityTick=2}] run execute as @s[tag=foInvisible] run data merge entity @s {Tags:["foInvisible","foGameEntity","foItemEntity"],ArmorItems:[{},{},{},{id:"minecraft:player_head",Count:1b,tag:{SkullOwner:{Id:[I;-1713100179,1153715042,-1560745282,-1663096525],Properties:{textures:[{Value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvZGYyYzlkYzMxNGJlZmM4ZDEyZjJlODc4NmM5NDM1YmZkMjRkOTExNmZjOTRjNWVjNDVmZDgzYmQyZGM4NGE0ZiJ9fX0="}]}}}}],CustomName:'{"translate":"fueoni.pickup.invisibility","fallback":"透明化","color":"white","bold":true}'}
execute as @e[tag=foNeedItem,scores={foEntityTick=2}] run execute as @s[tag=foKillOni] run data merge entity @s {Tags:["foKillOni","foGameEntity","foItemEntity"],ArmorItems:[{},{},{},{id:"minecraft:player_head",Count:1b,tag:{SkullOwner:{Id:[I;1234033715,-2071574897,-1089669240,55407181],Properties:{textures:[{Value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvY2IzOWI1YWFkNWVjZmY5NDY3M2NjYTRmOTFmZTc0ZWQyYTQyODhjZjY3M2E3NzAxMGY3NTcwZjFhNTc1MjAifX19"}]}}}}],CustomName:'{"translate":"fueoni.pickup.arrow","fallback":"鬼退治","color":"red","bold":true}'}
tag @e[tag=foNeedItem,scores={foEntityTick=2}] remove foNeedItem
#item spawning
#increase timer
execute if score item_count foGameData matches 1.. run scoreboard players add @a[tag=foGamePlayer,team=foRunner] foItemSpawnTimer 1
#create rng numbers
execute if score item_count foGameData matches 1.. run execute as @a[tag=foGamePlayer,team=foRunner] if score @s foItemSpawnTimer matches 1 run function fueoni:game/generate_random
#item spawning
execute if score item_count foGameData matches 1.. as @a[tag=foGamePlayer,team=foRunner] if score @s foItemSpawnTimer >= @s foSpawnTimerEnd run function fueoni:game/spawn_item
#reset timer
execute if score item_count foGameData matches 1.. as @a[tag=foGamePlayer,team=foRunner] if score @s foItemSpawnTimer >= @s foSpawnTimerEnd run scoreboard players set @s foItemSpawnTimer 0
#teleport item entity
execute as @e[tag=foNeedTeleport] at @s run function fueoni:entity/random_tp
#rotate and kill item entity
execute as @e[tag=foItemEntity] at @s run tp @s ~ ~ ~ ~3 ~
execute as @e[tag=foItemEntity,scores={foEntityTick=1200..}] run kill @s
#give item to runner
execute as @e[tag=foItemEntity] at @s if entity @a[tag=foGamePlayer,team=foRunner,distance=..1] if entity @s[tag=foEye] run execute as @a[tag=foGamePlayer,team=foRunner,distance=..1] at @s run function fueoni:player/give_see_through
execute as @e[tag=foItemEntity] at @s if entity @a[tag=foGamePlayer,team=foRunner,distance=..1] if entity @s[tag=foSpeed] run give @a[tag=foGamePlayer,team=foRunner,distance=..1] splash_potion{display:{Name:'{"translate":"fueoni.item.speed.name","fallback":"スピードポーション","color":"#7FDDFF","bold":true,"italic":false}',Lore:['{"translate":"fueoni.item.speed.lore.1","fallback":"30秒間、早く走れるようになる。","color":"gray","italic":false}']},HideFlags:33,Enchantments:[{id:"minecraft:vanishing_curse",lvl:1s}],CustomPotionEffects:[{Id:26,Duration:45,ShowParticles:false,ShowIcon:false}],CustomPotionColor:8379903}
execute as @e[tag=foItemEntity] at @s if entity @a[tag=foGamePlayer,team=foRunner,distance=..1] if entity @s[tag=foInvisible] run give @a[tag=foGamePlayer,team=foRunner,distance=..1] potion{display:{Name:'{"translate":"fueoni.item.invisibility.name","fallback":"透明化ポーション","color":"light_purple","bold":true,"italic":false}',Lore:['{"translate":"fueoni.item.invisibility.lore.1","fallback":"飲むと20秒間、透明になる。","color":"gray","italic":false}']},HideFlags:33,Enchantments:[{id:"minecraft:vanishing_curse",lvl:1s}],CustomPotionEffects:[{Id:14,Duration:400,ShowParticles:0b}],CustomPotionColor:16717792}
execute as @e[tag=foItemEntity] at @s if entity @a[tag=foGamePlayer,team=foRunner,distance=..1] if entity @s[tag=foKillOni] run give @a[tag=foGamePlayer,team=foRunner,distance=..1,nbt=!{Inventory:[{id:"minecraft:bow"}]}] bow{HideFlags:63,Enchantments:[{id:"minecraft:vanishing_curse",lvl:1s},{id:"minecraft:punch",lvl:3s}],Unbreakable:1b}
execute as @e[tag=foItemEntity] at @s if entity @a[tag=foGamePlayer,team=foRunner,distance=..1] if entity @s[tag=foKillOni] run give @a[tag=foGamePlayer,team=foRunner,distance=..1] tipped_arrow{display:{Name:'{"translate":"fueoni.item.arrow.name","fallback":"鬼退治の矢","color":"red","bold":true,"italic":false}',Lore:['{"translate":"fueoni.item.arrow.lore.1","fallback":"この矢で鬼を撃つと","color":"gray","italic":false}','{"translate":"fueoni.item.arrow.lore.2","fallback":"その鬼は進行方向の逆を向く。","color":"gray","italic":false}']},HideFlags:63,Enchantments:[{id:"minecraft:vanishing_curse",lvl:1s}],CustomPotionEffects:[{Id:27,Duration:-1,ShowParticles:0b}],CustomPotionColor:16711680}
execute as @e[tag=foItemEntity] at @s if entity @a[tag=foGamePlayer,team=foRunner,distance=..1] run kill @s
#item warning for onis
execute at @e[tag=foItemEntity] run execute as @a[tag=foGamePlayer,team=foOni,distance=..1] run execute as @s[tag=!foItemWarn] run tellraw @s [{"text":""},{"translate":"fueoni.message.prefix","fallback":"増え鬼","color":"yellow","bold":true},{"text":" » ","color":"gray","bold":false},{"translate":"fueoni.message.game.oni_item_warning","fallback":"鬼はアイテムを取ることができません！","color":"red"}]
execute at @e[tag=foItemEntity] run tag @a[tag=foGamePlayer,team=foOni,distance=..1] add foItemWarn
#item: speed
execute as @a[tag=foGamePlayer,team=foRunner,nbt={ActiveEffects:[{Id:26}]}] run effect give @s speed 30
execute as @a[tag=foGamePlayer,nbt={ActiveEffects:[{Id:26}]}] run effect clear @s minecraft:luck
#item: invisible
execute as @a[tag=foGamePlayer] run tag @s remove foInvisible
execute as @a[tag=foGamePlayer] run tag @s[nbt={ActiveEffects:[{Id:14}]}] add foInvisible
execute as @a[tag=foGamePlayer,tag=!foInvisible] run scoreboard players reset @s foInvisibleTimer
execute as @a[tag=foGamePlayer,tag=foInvisible] run scoreboard players add @s foInvisibleTimer 1
execute as @a[tag=foGamePlayer,tag=foInvisible,scores={foInvisibleTimer=1}] at @s run playsound minecraft:entity.evoker.cast_spell voice @a ~ ~ ~ 0.7 1.2
execute as @a[tag=foGamePlayer,tag=foInvisible,scores={foInvisibleTimer=1}] at @s run particle minecraft:witch ~ ~0.1 ~ 0.3 0.3 0.3 1 20 force @a
execute as @a[tag=foGamePlayer,team=foRunner] run item replace entity @s[tag=foInvisible] armor.chest with air
execute as @a[tag=foGamePlayer,team=foRunner] unless entity @s[nbt={Inventory:[{Slot:102b,id:"minecraft:leather_chestplate"}]}] run item replace entity @s[tag=!foInvisible] armor.chest with minecraft:leather_chestplate{display:{Name:'{"translate":"fueoni.item.runner_shirt.name","fallback":"逃走者の服","color":"green","bold":true,"italic":false}',Lore:['{"translate":"fueoni.item.runner_shirt.lore.1","fallback":"普通の服だよ","color":"gray","italic":false}','{"translate":"fueoni.item.runner_shirt.lore.2","fallback":"脱げないけどね","color":"gray","italic":false}'],color:65280},HideFlags:63,Unbreakable:1b,Enchantments:[{id:"minecraft:binding_curse",lvl:1s},{id:"minecraft:vanishing_curse",lvl:1s}]}
execute as @a[tag=foGamePlayer,team=foOni] unless entity @s[nbt={Inventory:[{Slot:102b,id:"minecraft:leather_chestplate"}]}] run item replace entity @s[tag=!foInvisible] armor.chest with minecraft:leather_chestplate{display:{Name:'{"translate":"fueoni.item.oni_shirt.name","fallback":"鬼の服","color":"red","bold":true,"italic":false}',Lore:['{"translate":"fueoni.item.oni_shirt.lore.1","fallback":"トマトジュースで染まった","color":"gray","italic":false}','{"translate":"fueoni.item.oni_shirt.lore.2","fallback":"きれいな赤色！","color":"gray","italic":false}'],color:16711680},HideFlags:63,Unbreakable:1b,Enchantments:[{id:"minecraft:protection",lvl:127s},{id:"minecraft:binding_curse",lvl:1s},{id:"minecraft:vanishing_curse",lvl:1s}]}
#make sure onis cant get invisibility too
execute as @a[tag=foGamePlayer,team=foOni,nbt={ActiveEffects:[{Id:14}]}] run tag @s remove foInvisible
execute as @a[tag=foGamePlayer,team=foOni,nbt={ActiveEffects:[{Id:14}]}] run effect clear @s minecraft:invisibility
#clear empty bottles
clear @a[tag=foGamePlayer] minecraft:glass_bottle
#item: eye
execute as @a[tag=foGamePlayer,advancements={fueoni:item/ender_eye=true},nbt=!{Inventory:[{Slot:-106b,id:"minecraft:ender_eye"}]}] run item replace entity @s weapon.mainhand with air
execute as @a[tag=foGamePlayer,advancements={fueoni:item/ender_eye=true},nbt={Inventory:[{Slot:-106b,id:"minecraft:ender_eye"}]}] run item replace entity @s weapon.offhand with air
execute as @a[tag=foGamePlayer,advancements={fueoni:item/ender_eye=true}] run execute as @a[tag=foGamePlayer] at @s run playsound minecraft:entity.evoker.prepare_summon voice @s ~ ~ ~ 50.0 1.0
execute as @a[tag=foGamePlayer,advancements={fueoni:item/ender_eye=true}] run tellraw @a[tag=foGamePlayer] [{"text":""},{"translate":"fueoni.message.prefix","fallback":"増え鬼","color":"yellow","bold":true},{"text":" » ","color":"gray","bold":false},{"translate":"fueoni.message.game.see_through_used.1","fallback":"誰かが透視の目を使った！","color":"#B3E159","bold":true},{"text":" "},{"translate":"fueoni.message.game.see_through_used.2","fallback":"これから%1$s、鬼の位置が光って見えます！","with":[{"translate":"fueoni.unit.seconds_duration","fallback":"%1$s秒間","color":"gold","with":[{"text":"10","color":"gold"}]}]}]
execute as @a[tag=foGamePlayer,advancements={fueoni:item/ender_eye=true}] run effect give @a[tag=foGamePlayer,team=foOni] minecraft:glowing 10 0 false
execute as @a[tag=foGamePlayer,advancements={fueoni:item/ender_eye=true}] run scoreboard players reset @s foUseEnderPearl
#item: kill oni
execute as @a[tag=foGamePlayer,team=foOni,nbt={ActiveEffects:[{Id:27}]}] run clear @s
execute as @a[tag=foGamePlayer,team=foOni,nbt={ActiveEffects:[{Id:27}]}] run tellraw @s [{"text":""},{"translate":"fueoni.message.prefix","fallback":"増え鬼","color":"yellow","bold":true},{"text":" » ","color":"gray","bold":false},{"translate":"fueoni.message.game.arrow_damaged.1","fallback":"鬼退治されてしまった！","color":"red","bold":true},{"text":" "},{"translate":"fueoni.message.game.arrow_damaged.2","fallback":"あなたは鬼退治の矢で撃たれました。"}]
execute as @a[tag=foGamePlayer,team=foOni,nbt={ActiveEffects:[{Id:27}]}] at @s run particle minecraft:sculk_soul ~ ~1.2 ~ 0.5 0.5 0.5 0.05 10 force @a
execute as @a[tag=foGamePlayer,team=foOni,nbt={ActiveEffects:[{Id:27}]}] at @s run playsound minecraft:entity.evoker.prepare_summon voice @a ~ ~ ~ 0.8 2.0
execute as @a[tag=foGamePlayer,team=foOni,nbt={ActiveEffects:[{Id:27}]}] run effect give @s minecraft:slowness 6 2 true
execute as @a[tag=foGamePlayer,team=foOni,nbt={ActiveEffects:[{Id:27}]}] run effect give @s minecraft:blindness 7 0 false
execute as @a[tag=foGamePlayer,team=foOni,nbt={ActiveEffects:[{Id:27}]}] run effect give @s minecraft:nausea 9 0 false
execute as @a[tag=foGamePlayer,team=foOni,nbt={ActiveEffects:[{Id:27}]}] at @s run teleport @s ~ ~ ~ ~180 ~
execute as @a[tag=foGamePlayer,nbt={ActiveEffects:[{Id:27}]}] run effect clear @s minecraft:unluck
#clear bow after use
clear @a[tag=foGamePlayer,nbt=!{Inventory:[{id:"minecraft:tipped_arrow"}]}] minecraft:bow
#disable dropping items
execute as @a[tag=foGamePlayer] at @s run function fueoni:player/check/dropped_item/start
#tag arrows shot by game player
execute as @a[tag=foGamePlayer] at @s run function fueoni:player/check/arrow_projectile/start
#kill arrows in ground
execute as @a[tag=foGamePlayer] at @s run kill @e[type=arrow,tag=foGameEntity,nbt={inGround:true}]
#runner wins
execute if score all_onis foGameData matches ..0 run scoreboard players set game_winner foGameData 1
#oni wins
execute if score all_runners foGameData matches ..0 run scoreboard players set game_winner foGameData 2
#timer ran out
execute if score game_timeleft foGameData matches ..0 run scoreboard players set game_winner foGameData 3
#set gamemode to 5 after winning
execute if score game_winner foGameData matches 1.. run scoreboard players set game_timer foGameData 0
execute if score game_winner foGameData matches 1.. run scoreboard players set game_mode foGameData 5
