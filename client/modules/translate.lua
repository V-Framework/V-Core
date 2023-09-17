Translations = {}

function vCore:Translate(string, ...)
    local playerLocale = self:GetPlayerPreference('language')
    if not playerLocale then
        playerLocale = "en"
    end

    local languageTranslations = Translations[playerLocale]
    local englishTranslations = Translations['en']
    if languageTranslations then
        if languageTranslations[string] then
            return languageTranslations[string]:format(...)
        elseif playerLocale ~= 'en' and englishTranslations and englishTranslations[string] then
            return englishTranslations[string]:format(...)
        else
            return ('Translation [%s][%s] does not exist'):format(playerLocale, string)
        end
    elseif playerLocale ~= 'en' and englishTranslations and englishTranslations[string] then
        return englishTranslations[string]:format(...)
    else
        return ('Locale [%s] does not exist'):format(playerLocale)
    end
end
