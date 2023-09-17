fx_version 'cerulean'
game 'gta5'

name "V-Core"
description "The Ultimate All In 1 Framework"
author "Mycroft, FeelFreeToFee"
version "0.0.1"
lua54 'yes'

shared_scripts {
	"@ox_lib/init.lua",
	'shared/*.lua',
	"shared/modules/*.lua"
}

client_scripts {
	"client/modules/*.lua",
	'client/*.lua',
}

server_scripts {
	"@oxmysql/lib/MySQL.lua",
	"server/modules/*.lua",
	'server/*.lua'
}
