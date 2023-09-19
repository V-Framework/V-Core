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

function vCore:PreferencesMenu()
    local elements = {}

    for key, value in pairs(self.Preferences) do
        elements[#elements + 1] = {
            label = self:Translate(key),
            description = self:Translate("current_value", value),
            key = key,
        }
    end

    lib.registerMenu({
        id = 'vCore.PreferencesMenu',
        title = self:Translate('preferences_title'),
        position = 'top-right',
        canClose = true,
        options = elements
    }, function(selected)
        local preference = elements[selected].key
        local input = lib.inputDialog(self:Translate("preference_set_title"), {self:Translate("preference_set", preference)})
        if not input then
            return
        end
        self:SetPlayerPreference(preference, input[1])
        lib.showMenu('vCore.PreferencesMenu')
    end)
    lib.showMenu('vCore.PreferencesMenu')
end

vCore.keybindings["PlayerPreferences"] = lib.addKeybind({
    name = 'PlayerPreferences',
    description = 'Open the Preferences Menu',
    defaultKey = 'F7',
    onPressed = function()
        vCore:PreferencesMenu()
    end,
})