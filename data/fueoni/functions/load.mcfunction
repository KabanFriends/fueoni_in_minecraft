#Function file for "FUEONI in Minecraft"
#Made by KabanFriends

gamerule maxCommandChainLength 65536
say 「増え鬼 in Minecraft」を準備しています…
forceload add 0 0
scoreboard objectives add foInitTemp dummy
scoreboard players set current_data_ver foInitTemp 2
execute unless score init_ver foGameOption = current_data_ver foInitTemp run function fueoni:init
scoreboard objectives remove foInitTemp
scoreboard players set sessionID foGameOption 0
function fueoni:game/default_settings
say 準備が完了しました。
tellraw @a [{"text":""},{"translate":"fueoni.message.load.title","fallback":"増え鬼 in Minecraft","color":"yellow","bold":true},{"text":" "},{"translate":"fueoni.message.load.version","fallback":"(ver%1$s)","color":"gray","with":[{"text":"2.0.0"}]},{"text":"\n"},{"translate":"fueoni.message.load.created_by","fallback":"制作: %1$s","with":[{"text":"KabanFriends","color":"gold","bold":true}]},{"text":"\n\n"},{"translate":"fueoni.message.load.instruction.title","fallback":"管理者用アイテムの入手方法:","color":"aqua","bold":true},{"text":"\n"},{"translate":"fueoni.message.load.instruction.number_1","fallback":"①","color":"aqua"},{"translate":"fueoni.message.load.instruction.step_1","fallback":"%1$sを１つ用意してください。","color":"green","with":[{"translate":"fueoni.message.load.instruction.step_1.command_block","fallback":"コマンドブロック","color":"light_purple"}]},{"text":"\n"},{"translate":"fueoni.message.load.instruction.number_2","fallback":"②","color":"aqua"},{"translate":"fueoni.message.load.instruction.step_2","fallback":"金床でコマンドブロックに「%1$s」という名前を付けてください。","color":"green","with":[{"text":"fueoni","color":"light_purple"}]},{"text":"\n"},{"translate":"fueoni.message.load.instruction.number_3","fallback":"③","color":"aqua"},{"translate":"fueoni.message.load.instruction.step_3","fallback":"名前を付けたコマンドブロックをインベントリに入れてください。","color":"green"},{"text":"\n"},{"translate":"fueoni.message.load.instruction.alternative_step","fallback":"※コマンド%1$sでも入手できます","with":[{"text":"/function fueoni:admin","color":"gold"}]}]
