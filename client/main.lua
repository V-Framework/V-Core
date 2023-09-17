local baseConfig = {
    {
        name = "npc_population",
        label = "Enable NPC Population",
        default = GetConvarInt("vCore:npc_population", 1) == 1,
    },
    {
        name = "npc_licenseplate",
        label = "Defualt Licencse Plate",
        default = GetConvar("vCore:npc_licenseplate", ".... ..."),
        onChange = function(value)
            SetDefaultVehicleNumberPlateTextPattern(-1, value)
        end
    }
}

for i=1, #baseConfig do
    local config = baseConfig[i]
    vCore:AddConfigOption(config.name, config.label, config.default, config.onChange)
end

AddEventHandler('populationPedCreating', function()
    if not vCore:GetConfigValue('npc_population') then
        CancelEvent()
    end
end)