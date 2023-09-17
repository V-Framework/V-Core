vCore.Preferences = KVP("vCore:PlayerPreferences")

if not vCore.Preferences then
    vCore.Preferences = {}
end

function vCore:SetPlayerPreference(key, value)
    self.Preferences[key] = value
end

function vCore:GetPlayerPreference(key)
    return self.Preferences[key]
end
