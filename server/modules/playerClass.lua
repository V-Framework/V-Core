-- @class
-- Player Class
vCore.Players = {}

ExtendedPlayer = {
    __index = ExtendedPlayer
}

function vCore:CreatePlayer(identifer, data)
    local xPlayer = setmetatable({}, ExtendedPlayer)

    xPlayer.identifier = identifer
    xPlayer.source = data.source
    xPlayer.group = data.group
    xPlayer.name = GetPlayerName(data.source)
    xPlayer.coords = { x = 222.2027, y = -864.0162, z = 30.2922, heading = 1.0 }
    xPlayer.metadata = data.metadata

    function xPlayer:set(key, value)
        self[key] = value
    end

    function xPlayer:get(key)
        return self[key]
    end

    function xPlayer:hasGroup(group)
        return self.group == group
    end

    function xPlayer:triggerEvent(event, ...)
        TriggerClientEvent(event, self.source, ...)
    end
    
    return xPlayer
end

AddEventHandler('playerDropped', function(reason)
    local source = source
    vCore:SavePlayer(source)
    vCore.Players[source] = nil
end)