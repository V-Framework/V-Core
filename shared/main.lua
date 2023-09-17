local vClass = {}
vClass.__index = vClass
Vcore = setmetatable({}, vClass)
Vcore.context = IsDuplicityVersion() and 'server' or 'client'