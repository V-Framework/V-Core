function vCore:LoadPlayer(playerData, isNew)
    self.playerData = playerData
    exports.spawnmanager:spawnPlayer({
        x = self.playerData.coords.x,
        y = self.playerData.coords.y,
        z = self.playerData.coords.z + 0.25,
        heading = self.playerData.coords.heading,
        model = `mp_m_freemode_01`,
        skipFade = false
    }, function()
        self.playerLoaded = true

        ShutdownLoadingScreen()
        ShutdownLoadingScreenNui()

        if not vCore:GetPlayerPreference("language") then
            vCore:SetPlayerPreference("language", "en")
        end

        if vCore:GetConfigValue("client.wanted_level") then
            ClearPlayerWantedLevel(cache.playerId)
            SetMaxWantedLevel(0)
        end
    end)
end

vCore:RegisterNetEvent("vCore:playerLoaded", function(...)
    vCore:LoadPlayer(...)
end)
