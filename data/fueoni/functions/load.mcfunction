#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

gamerule maxCommandChainLength 65536
say 「増え鬼 in Minecraft」を準備しています…
forceload add 0 0
execute unless score init_ver foGameOption matches 1 run function fueoni:init
scoreboard players set sessionID foGameOption 0
say 準備が完了しました。
tellraw @a [{"text":""},{"translate":"増え鬼 in Minecraft","color":"yellow","bold":true},{"text":" "},{"translate":"(ver%1$s)","color":"gray","with":[{"text":"2.0.0"}]},{"text":"\n"},{"translate":"制作: %1$s","with":[{"text":"KabanFriends","color":"gold","bold":true}]},{"text":"\n\n"},{"translate":"管理者用アイテムの入手方法:","color":"aqua","bold":true},{"text":"\n"},{"translate":"①","color":"aqua"},{"translate":"%1$sを１つ用意してください。","color":"green","with":[{"translate":"コマンドブロック","color":"light_purple"}]},{"text":"\n"},{"translate":"②","color":"aqua"},{"translate":"金床でコマンドブロックに「%1$s」という名前を付けてください。","color":"green","with":[{"text":"fueoni","color":"light_purple"}]},{"text":"\n"},{"translate":"③","color":"aqua"},{"translate":"名前を付けたコマンドブロックをインベントリに入れてください。","color":"green"},{"text":"\n"},{"translate":"※コマンド%1$sでも入手できます","with":[{"text":"/function fueoni:player/admin","color":"gold"}]}]
