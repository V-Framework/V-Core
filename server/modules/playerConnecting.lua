-- Add Config option for whether or not to check for License

vCore:AddConfigOption("join_check", "Check for License", GetConvarInt("vCore:join_check", 1) == 1)

local function OnPlayerConnecting(_, _, deferrals)
    local source = source
    local license = GetPlayerIdentifierByType(source, "license")
    deferrals.defer()
    Wait(0)

    if vCore:GetConfigValue("join_check") and not license then
        return deferrals.done("No Identifier Found.")
    end

    --[[
    local user = MySQL.query.await("SELECT * FROM `users` WHERE `identifier` = ?", {license})
    
    if user and user[1] then
        local userInfo = user[1]
        vCore:CreatePlayer(license, {
            source = source,
            group = userInfo.group,
            metadata = json.decode(userInfo.metadata)
        })
    else
        MySQL.insert("INSERT INTO `users` (`identifier`, `group`, `metadata`) VALUES (?, ?, ?)", {
            license,
            "user",
            json.encode({})
        })
        vCore:CreatePlayer(license, {
            source = source,
            group = "user",
            metadata = {}
        })
    end]]

    deferrals.done()
end

AddEventHandler("playerConnecting", OnPlayerConnecting)

local function OnPlayerJoined()
    local source = source
    local license = GetPlayerIdentifierByType(source, "license")
    local user = MySQL.query.await("SELECT * FROM `users` WHERE `identifier` = ?", {license})
    if user and user[1] then
        local userInfo = user[1]
        vCore:CreatePlayer(license, {
            source = source,
            group = userInfo.group,
            metadata = json.decode(userInfo.metadata)
        })
    else
        MySQL.insert("INSERT INTO `users` (`identifier`, `group`, `metadata`) VALUES (?, ?, ?)", {
            license,
            "user",
            json.encode({})
        })
        vCore:CreatePlayer(license, {
            source = source,
            group = "user",
            metadata = {}
        })
    end
end

AddEventHandler("playerJoining", OnPlayerJoined)