function vCore:SavePlayer(player)
    local xPlayer = self.Players[player]
    local parameters <const> = {
		xPlayer.group,
        xPlayer.metadata,
		xPlayer.identifier
	}

	MySQL.prepare(
		'UPDATE `users` SET group` = ?, `metadata` = ? WHERE `identifier` = ?',
		parameters,
		function(affectedRows)
			if affectedRows == 1 then
				print(('[^2INFO^7] Saved player ^5"%s^7"'):format(xPlayer.name))
			end
		end
	)
end

local baseConfig = {
    {
        name = "server.npc_population",
        label = "Enable NPC Population",
        default = GetConvarInt("vCore:npc_population", 1) == 1,
    },
    {
        name = "client.npc_licenseplate",
        label = "Defualt Licencse Plate",
        default = GetConvar("vCore:npc_licenseplate", ".... ..."),
    }
}

for i=1, #baseConfig do
    local config = baseConfig[i]
    vCore:AddConfigOption(config.name, config.label, config.default, config.onChange)
end
