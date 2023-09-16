local PlayerId = PlayerId
local GetPlayerServerId = GetPlayerServerId
local PlayerPedId = PlayerPedId
local CreateThread = CreateThread
local Wait = Wait
local GetVehiclePedIsIn = GetVehiclePedIsIn
local GetSelectedPedWeapon = GetSelectedPedWeapon

Vcore.cache = {}

Vcore.cache.playerId = PlayerId()
Vcore.cache.serverId = GetPlayerServerId(Vcore.cache.playerId)
Vcore.cache.playerPed = PlayerPedId()

function Vcore.cache:SetValue(key, value)
    self[key] = value
end

function Vcore.cache:StartUpdateLoops()
    CreateThread(function()
        while Vcore.playerLoaded do
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
