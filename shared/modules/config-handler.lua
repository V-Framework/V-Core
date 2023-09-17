Vcore.ConfigStorage = {
    client = {},
    server = {}
}

function Vcore:GetConfigOption(name)
    return Vcore.ConfigStorage[self.context][name]
end

function Vcore:GetConfigValue(name)
    return self:GetConfigOption(name).value
end

function Vcore:AddConfigOption(name, label, defaultData, onChange)
    local existingData = self:GetConfigOption(name)
    Vcore.ConfigStorage[self.context][name] = {
        label = label,
        defaultData = defaultData,
        value = existingData.value or defaultData,
        onChange = onChange
    }
    if onChange then
        onChange(existingData.value or defaultData)
    end
end

function Vcore:SetConfigValue(name, value)
    local configOption = self:GetConfigOption(name)
    Vcore.ConfigStorage[self.context][name].value = value
    if configOption.onChange then
        configOption.onChange(value)
    end
end