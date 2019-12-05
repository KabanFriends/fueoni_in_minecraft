#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

say 「増え鬼 in Minecraft」を準備しています…
forceload add 0 0
function fueoni:score/add_objectives
execute unless score init_done foGameOption matches 1 run function fueoni:init
say 準備が完了しました。
tellraw @a [{"text":""},{"text":"増え鬼 in Minecraft","color":"yellow","bold":"true"},{"text":" "},{"text":"(ver1.0.1)","color":"gray"},{"text":"\n"},{"text":"制作: "},{"text":"KabanFriends","color":"gold","bold":"true"},{"text":"\n\n"},{"text":"管理者用アイテムの入手方法:","color":"aqua","bold":"true"},{"text":"\n"},{"text":"①","color":"aqua","bold":"true"},{"text":"コマンドブロック","color":"light_purple"},{"text":"を１つ用意してください。","color":"green"},{"text":"\n"},{"text":"②","color":"aqua","bold":"true"},{"text":"金床でコマンドブロックに「","color":"green"},{"text":"fueoni","color":"light_purple"},{"text":"」という名前を付けてください。","color":"green"},{"text":"\n"},{"text":"③","color":"aqua","bold":"true"},{"text":"名前を付けたコマンドブロックをインベントリに入れてください。","color":"green"},{"text":"\n"},{"text":"※コマンド"},{"text":"/function fueoni:player/admin","color":"gold"},{"text":"でも入手できます"}]
