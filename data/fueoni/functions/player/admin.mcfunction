#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

clear @s command_block{display:{Name:'{"text":"fueoni"}'}}

give @s minecraft:llama_spawn_egg{display:{Name:'{"text":"§6§l増え鬼のロビー地点を設定"}',Lore:['{"text":"§7増え鬼のゲーム終了後に参加者が移動する"}','{"text":"§7場所をアイテムを使用した場所に設定します。"}']},EntityTag:{id:"minecraft:marker",Tags:["foSetLobby","foAdminEntity"]},HideFlags:1,Enchantments:[{lvl:1s,id:"minecraft:bane_of_arthropods"}]} 1
give @s minecraft:pig_spawn_egg{display:{Name:'{"text":"§d§l増え鬼の参加者を追加"}',Lore:['{"text":"§b半径3ブロック§7以内にいる全ての"}','{"text":"§7プレイヤーを増え鬼の参加者にします。"}','{"text":"§7このアイテムの使用者も参加対象に含まれます。"}']},EntityTag:{id:"minecraft:marker",Tags:["foAddPlayers","foAdminEntity"]},HideFlags:1,Enchantments:[{lvl:1s,id:"minecraft:bane_of_arthropods"}]} 1
give @s minecraft:rabbit_spawn_egg{display:{Name:'{"text":"§6§l増え鬼の参加者一覧を表示"}',Lore:['{"text":"§7画面の右側(サイドバー)に、現時点の"}','{"text":"§7増え鬼に参加するプレイヤーの"}','{"text":"§7一覧を表示します。"}']},EntityTag:{id:"minecraft:marker",Tags:["foShowJoinedPlayers","foAdminEntity"]},HideFlags:1,Enchantments:[{lvl:1s,id:"minecraft:bane_of_arthropods"}]} 1
give @s minecraft:chicken_spawn_egg{display:{Name:'{"text":"§c§l増え鬼の参加者を削除"}',Lore:['{"text":"§b半径3ブロック§7以内にいる全ての"}','{"text":"§7プレイヤーを増え鬼の参加者から"}','{"text":"§7除外します。このアイテムの使用者も"}','{"text":"§7除外対象に含まれます。"}']},EntityTag:{id:"minecraft:marker",Tags:["foRemovePlayers","foAdminEntity"]},HideFlags:1,Enchantments:[{lvl:1s,id:"minecraft:bane_of_arthropods"}]} 1
give @s minecraft:mooshroom_spawn_egg{display:{Name:'{"text":"§c§l増え鬼の参加者を全て削除"}',Lore:['{"text":"§7全てのプレイヤーを増え鬼の"}','{"text":"§7参加者から除外します。"}']},EntityTag:{id:"minecraft:marker",Tags:["foRemoveAllPlayers","foAdminEntity"],ActiveEffects:[{Id:14b,Amplifier:0b,Duration:200000000,ShowParticles:0b}]},HideFlags:1,Enchantments:[{lvl:1s,id:"minecraft:bane_of_arthropods"}]} 1
give @s minecraft:zombie_horse_spawn_egg{display:{Name:'{"text":"§2§l増え鬼スタート(現在の参加者)"}',Lore:['{"text":"§7現時点で増え鬼に参加予定の"}','{"text":"§7プレイヤーで増え鬼を開始します。"}','{"text":"§7増え鬼の開始位置は§bアイテムを使用した"}','{"text":"§b場所§7になります。"}']},EntityTag:{id:"minecraft:marker",Tags:["foStart","foAdminEntity"]},HideFlags:1,Enchantments:[{lvl:1s,id:"minecraft:bane_of_arthropods"}]} 1
give @s minecraft:parrot_spawn_egg{display:{Name:'{"text":"§a§l増え鬼スタート(全員)"}',Lore:['{"text":"§7全てのプレイヤーを強制的に"}','{"text":"§7参加者にして増え鬼を開始します。"}','{"text":"§7増え鬼の開始位置は§bアイテムを使用した"}','{"text":"§b場所§7になります。"}']},EntityTag:{id:"minecraft:marker",Tags:["foStartAllPlayers","foAdminEntity"]},HideFlags:1,Enchantments:[{lvl:1s,id:"minecraft:bane_of_arthropods"}]} 1
give @s minecraft:polar_bear_spawn_egg{display:{Name:'{"text":"§f§l増え鬼強制終了"}',Lore:['{"text":"§7増え鬼を強制的に終了して、"}','{"text":"§7参加者をロビーに移動させます。"}']},EntityTag:{id:"minecraft:marker",Tags:["foEndGame","foAdminEntity"]},HideFlags:1,Enchantments:[{lvl:1s,id:"minecraft:bane_of_arthropods"}]} 1
give @s minecraft:squid_spawn_egg{display:{Name:'{"text":"§b§l増え鬼ゲーム時間の長さを変更"}',Lore:['{"text":"§7スニークしないでアイテム使用➡§b1分追加"}','{"text":"§7スニークしながらアイテム使用➡§b1分短縮"}']},EntityTag:{id:"minecraft:marker",Tags:["foChangeTime","foAdminEntity"]},HideFlags:1,Enchantments:[{lvl:1s,id:"minecraft:bane_of_arthropods"}]} 1

tellraw @s [{"text":""},{"text":"増え鬼","color":"yellow","bold":true},{"text":" » ","color":"gray"},{"text":"管理者用アイテムを付与しました。","color":"green"}]
tellraw @s [{"text":""},{"text":"増え鬼","color":"yellow","bold":true},{"text":" » ","color":"gray"},{"text":"アイテムを使用する前に必ず"},{"text":"インベントリで説明を読んでください","color":"aqua","bold":true},{"text":"。"}]
