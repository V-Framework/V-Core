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