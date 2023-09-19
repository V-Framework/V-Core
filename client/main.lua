AddEventHandler('populationPedCreating', function()
    if not vCore:GetConfigValue('client.npc_population') then
        CancelEvent()
    end
end)

function vCore:RegisterNetEvent(event, callback)
    RegisterNetEvent(event, function(...)
        -- stops the event from being called if it is being called from the client.
        if source == '' then
            return
        end
        callback(...)
    end)
end

vCore:RegisterNetEvent("vCore:ConfigChanged", function(name, value)
    if name == "client.npc_licenseplate" then
        SetDefaultVehicleNumberPlateTextPattern(-1, value)
    end
    if name == "client.wanted_level" then
        ClearPlayerWantedLevel(cache.playerId)
        SetMaxWantedLevel(value and 0 or 5)
    end
end)

CreateThread(function()
    exports.spawnmanager:setAutoSpawn(false)
    while not vCore.ConfigStorage do
        Wait(0)
    end
    SetDefaultVehicleNumberPlateTextPattern(-1, vCore:GetConfigValue('client.npc_licenseplate'))
end)