function vCore:LoadPlayer(PlayerData, isNew)
    self.PlayerData = PlayerData
    exports.spawnmanager:spawnPlayer({
        x = self.PlayerData.coords.x,
        y = self.PlayerData.coords.y,
        z = self.PlayerData.coords.z + 0.25,
        heading = self.PlayerData.coords.heading,
        model = `mp_m_freemode_01`,
        skipFade = false
    }, function()
        self.playerLoaded = true

        self.cache:StartUpdateLoops()
        ShutdownLoadingScreen()
        ShutdownLoadingScreenNui()
    end)
end

vCore:RegisterNetEvent("vCore:playerLoaded", function(...)
    vCore:LoadPlayer(...)
end)
