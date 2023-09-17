AddEventHandler('populationPedCreating', function()
    if not vCore:GetConfigValue('npc_population') then
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
    if name == "npc_licenseplate" then
        SetDefaultVehicleNumberPlateTextPattern(-1, value)
    end
end)