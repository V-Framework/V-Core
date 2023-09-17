vCore.ConfigStorage = {
    client = {},
    server = {}
}

function vCore:GetConfigOption(name)
    return vCore.ConfigStorage[self.context][name]
end

function vCore:GetConfigValue(name)
    return self:GetConfigOption(name).value
end

function vCore:AddConfigOption(name, label, defaultData, onChange)
    local existingData = self:GetConfigOption(name)
    vCore.ConfigStorage[self.context][name] = {
        label = label,
        defaultData = defaultData,
        value = existingData.value or defaultData,
        onChange = onChange
    }
    if onChange then
        onChange(existingData.value or defaultData)
    end
end

function vCore:SetConfigValue(name, value)
    local configOption = self:GetConfigOption(name)
    vCore.ConfigStorage[self.context][name].value = value
    if configOption.onChange then
        configOption.onChange(value)
    end
end