if vCore.context == "server" then
    -- do all server-sided functions here.
    -- It is Massively important to have the server side handle all the data.
    vCore.ConfigStorage = KVP("vCore:ConfigStorage")

    if not vCore.ConfigStorage then
        vCore.ConfigStorage = {}
    end

    function vCore:AddConfigOption(name, label, defaultData)
        local existingData = self:GetConfigOption(name)
        vCore.ConfigStorage[name] = {
            label = label,
            defaultData = defaultData,
            value = existingData.value or defaultData,
        }
    end

    ---@param name string
    ---@param value any
    ---@return nil
    function vCore:SetConfigValue(name, value)
        local existingData = self:GetConfigOption(name)
        vCore.ConfigStorage[name].value = value
        TriggerEvent("vCore:ConfigChanged", name, value)
        TriggerClientEvent("vCore:ConfigChanged", -1, name, value)
    end

    lib.callback.register('vCore:getConfigValues', function()
        return vCore.ConfigStorage
    end)
else
    vCore.ConfigStorage = lib.callback.await("vCore:getConfigValues", false)

    vCore:RegisterNetEvent("vCore:ConfigChanged", function(name, value)
        vCore.ConfigStorage[name].value = value
    end)
end

function vCore:GetConfigOption(name)
    return self.ConfigStorage[name]
end

function vCore:GetConfigValue(name)
    return self:GetConfigOption(name)?.value
end