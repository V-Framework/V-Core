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
    xPlayer.coords = {x = data.coords[1], y = data.coords[2], z = data.coords[3], heading = data.coords[4]}
    xPlayer.metadata = data.metadata
    xPlayer.skin = data.skin

    function xPlayer:Set(key, value)
        self[key] = value
    end

    function xPlayer:SetMetadata(key, value)
        self.metadata[key] = value
    end

    function xPlayer:GetMetadata(key)
        return self.metadata[key]
    end

    function xPlayer:Get(key)
        return self[key]
    end

    function xPlayer:SetGroup(group)
        lib.addPrincipal(('identifier.%s'):format(self.identifier), ('group.%s'):format(self.group))
        self.group = group
        lib.removePrincipal(('identifier.%s'):format(self.identifier), ('group.%s'):format(self.group))
    end

    function xPlayer:HasGroup(group)
        return self.group == group
    end

    function xPlayer:TriggerEvent(event, ...)
        TriggerClientEvent(event, self.source, ...)
    end

    lib.addPrincipal(('identifier.%s'):format(self.identifier), ('group.%s'):format(self.group))
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