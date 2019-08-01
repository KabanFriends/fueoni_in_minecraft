#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

say 「増え鬼 in Minecraft」を準備しています…
execute unless entity @e[tag=foGameMaster] run function fueoni:init
say 準備が完了しました。
tellraw @a [{"text":""},{"text":"増え鬼 in Minecraft","color":"yellow","bold":"true"},{"text":" "},{"text":"(ver0.0.1)","color":"gray"},{"text":"\n"},{"text":"制作: "},{"text":"KabanFriends","color":"gold","bold":"true"},{"text":"\n\n"},{"text":"管理者用アイテムの入手方法:","color":"aqua","bold":"true"},{"text":"\n"},{"text":"①","color":"aqua","bold":"true"},{"text":"次のコマンドを実行する: "},{"text":"/function fueoni:admin","color":"green"}]
