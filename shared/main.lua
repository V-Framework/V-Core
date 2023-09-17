local vClass = {}
vClass.__index = vClass
vCore = setmetatable({}, vClass)
vCore.context = IsDuplicityVersion() and 'server' or 'client'