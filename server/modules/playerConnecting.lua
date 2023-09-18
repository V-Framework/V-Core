-- Add Config option for whether or not to check for License

vCore:AddConfigOption("server.join_check", "Check for License", GetConvarInt("vCore:join_check", 1) == 1)

local function OnPlayerConnecting(_, _, deferrals)
    local source = source
    local license = GetPlayerIdentifierByType(source, "license")
    deferrals.defer()
    Wait(0)

    if vCore:GetConfigValue("server.join_check") and not license then
        return deferrals.done("No Identifier Found.")
    end

    deferrals.done()
end

AddEventHandler("playerConnecting", OnPlayerConnecting)

local function OnPlayerJoined()
    local source = source
    local license = GetPlayerIdentifierByType(source, "license")
    local user = MySQL.query.await("SELECT * FROM `users` WHERE `identifier` = ?", {license})
    local xPlayer = nil
    local isNew = false
    if user and user[1] then
        local userInfo = user[1]
        xPlayer = vCore:CreatePlayer(license, {
            source = source,
            group = userInfo.group,
            coords = json.decode(userInfo.coords),
            metadata = json.decode(userInfo.metadata)
        })
    else
        MySQL.insert("INSERT INTO `users` (`identifier`, `group`, `metadata`) VALUES (?, ?, ?)", {
            license,
            "user",
            json.encode({})
        })
        xPlayer = vCore:CreatePlayer(license, {
            source = source,
            group = "user",
            coords = json.decode(vCore:GetConfigValue("server.defualtspawn")),
            metadata = {}
        })
        isNew = true
    end
    vCore.Players[source] = xPlayer
    TriggerClientEvent("vCore:playerLoaded", source, xPlayer, isNew)
end

AddEventHandler("playerJoining", OnPlayerJoined)