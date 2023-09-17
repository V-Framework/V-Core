-- @class
-- Player Class
vCore.Players = {}

---@class ExtendedPlayer
---@field identifier string
---@field source number
---@field group string
---@field name string
---@field coords table
---@field metadata table
---@field Set function
---@field Get function
---@field HasGroup function
---@field TriggerEvent function

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

    function xPlayer:Set(key, value)
        self[key] = value
    end

    function xPlayer:Get(key)
        return self[key]
    end

    function xPlayer:HasGroup(group)
        return self.group == group
    end

    function xPlayer:TriggerEvent(event, ...)
        TriggerClientEvent(event, self.source, ...)
    end
    
    return xPlayer
end

---@param player number
---@return ExtendedPlayer
function vCore:GetPlayerFromId(player)
    if type(player) ~= "number" then
        player = tonumber(player)
    end
    return self.Players[player]
end

---@param identifier string
---@return ExtendedPlayer|nil
function vCore:GetPlayerFromIdentifier(identifier)
    for _, player in pairs(self.Players) do
        if player.identifier == identifier then
            return player
        end
    end
    return nil
end

AddEventHandler('playerDropped', function(reason)
    local source = source
    vCore:SavePlayer(source)
    vCore.Players[source] = nil
end)