local baseConfig = {
    {
        name = "npc_population",
        label = "Enable NPC Population",
        default = GetConvarInt("vcore:npc_population", 1) == 1,
    },
    {
        name = "npc_licenseplate",
        label = "Defualt Licencse Plate",
        default = GetConvar("vcore:npc_licenseplate", ".... ..."),
        onChange = function(value)
            SetDefaultVehicleNumberPlateTextPattern(-1, value)
        end
    }
}