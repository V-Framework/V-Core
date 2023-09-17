local cache, map = {}

local mt = {
	-- the object is iterated
	__pairs = function(t)
		-- returns an interator of the know keys
		return pairs(map[t].keys)
	end,
	-- The object is read
	__index = function(t, k)
		-- Fetching the map
		local obj = map[t]
		-- Skips if the value is already cached
		-- Otherwise checks if the key is present on database
		if not obj.values[k] and obj.keys[k] then
			-- Fetchs the value
			local value = GetResourceKvpString(obj.path .. k)
			-- Caches it as a number if is recognized
			obj.values[k] = tonumber(value) or value
		end
		-- Cached value is returned
		return obj.values[k]
	end,
	-- The object is wrote
	__newindex = function(t, k, v)
		local obj = map[t]
		if v then -- A value is written
			-- Attempts to delete an existing value and its content if exist
			-- This calls the same method again causing mind-breaks (__newindex)
			t[k] = nil
			if type(v) == 'table' then
				-- Creates a proxy
				obj.values[k] = CreateKvp(obj.path .. k .. ':')
				-- Iterates content
				for i in pairs(v) do
					-- Forces (__newindex) to repeat this proccess recurively
					t[k][i] = v[i]
				end
			else
				-- Saves the value in the database
				SetResourceKvp(obj.path .. k, tostring(v))
				-- Saves the value in cache
				obj.values[k] = v
			end
			-- Marks the key as know
			obj.keys[k] = true
		elseif obj.keys[k] then -- If the key is know, the value and it's content is being deleted
			-- The key is no longer referenced
			obj.keys[k] = nil
			-- The value is deleted from the database
			DeleteResourceKvp(obj.path .. k)
			-- Check for the value in cache
			local value = obj.values[k] if value then
				-- If is a table the content is deleted recursively
				-- (Antoher debug madness)
				if type(value) == 'table' then
					-- Iterates keys in the map (__pairs)
					for key in pairs(value) do
						-- Attempts to delete children value calling again this same method (__newindex) 
						t[k][key] = nil
					end
				end
				-- Deletes the value from the cache
				obj.values[k] = nil
			end
		end
	end
}

function CreateKvp(path)
	-- Creates an empty object
	local obj = {}
	-- Creates a map to store the path, known nested keys and cached values
	map[obj] = {keys = {}, values = {}, path = path}
	-- Proxifies the object
	return setmetatable(obj, mt)
end



function KVP(key)
	-- If the object already exist is returned
	if cache[key] then return cache[key] end
	-- The path of the value is saved in the key using ':' as separator
	key = key .. ':'
	-- Creates a proxified object 
	local obj = CreateKvp(key)
	-- Requests handle to iterate all keys matching preffix stored as '${key}:'
	local handle = StartFindKvp(key)
	-- An invalid handle means no keys found
	if handle ~= -1 then
		-- Iterates known keys in database under requested prefix/node
		local path repeat path = FindKvp(handle) if path then
			-- Stores last node and creates a value to iterate children objects
			local last, data = path:gmatch'[^:]*$'(), obj
			-- Iterates path nodes between the first and the last one
			for node in path:sub(#key, -#last - 1):gmatch'[^:]+' do
				-- The node is converted to a number if is recognized
				node = tonumber(node) or node
				-- Creates a object for the inner node if it does not exist yet
				-- It triggers (__newindex) so the object is proxified
				if not data[node] then data[node] = {} end
				-- Joins the object to keep buildind its inner structure
				data = data[node]
			end
			-- The map of the parent node is updated to mark the last as know
			map[data].keys[tonumber(last) or last] = true
		end until not path
		-- Releases the handle
		EndFindKvp(handle)
	end
	-- The object is cached and returned
	cache[key] = obj return obj
end