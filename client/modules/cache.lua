local PlayerId = PlayerId
local GetPlayerServerId = GetPlayerServerId
local PlayerPedId = PlayerPedId
local CreateThread = CreateThread
local Wait = Wait
local GetVehiclePedIsIn = GetVehiclePedIsIn
local GetSelectedPedWeapon = GetSelectedPedWeapon

vCore.cache = {}

vCore.cache.playerId = PlayerId()
vCore.cache.serverId = GetPlayerServerId(vCore.cache.playerId)
vCore.cache.playerPed = PlayerPedId()

function vCore.cache:SetValue(key, value)
    self[key] = value
end

function vCore.cache:StartUpdateLoops()
    CreateThread(function()
        while vCore.playerLoaded do
            Wait(150)
            local PlayerPed = PlayerPedId()
            if PlayerPed ~= self.playerPed then
                self:SetValue('playerPed', PlayerPed)
            end

            local currentVehicle = GetVehiclePedIsIn(PlayerPed, false)
            if currentVehicle ~= self.currentVehicle then
                self:SetValue('currentVehicle', currentVehicle > 0 and currentVehicle or false)
            end

            local currentWeapon = GetSelectedPedWeapon(PlayerPed)
            if currentWeapon ~= self.currentWeapon then
                self:SetValue('currentWeapon', currentWeapon)
            end
        end
    end)
end
