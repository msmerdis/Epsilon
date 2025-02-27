--[[
   Epsilon (c) 2025 All rights reserved
   Licensed under LGPLv3 - No Warranty
]] --

print("epsilon addon - start");

local addonName = select(1, ...)

---@class addon
local epsilon = select(2, ...)

-- Set global name of addon
_G[addonName] = epsilon

-- Globals used in this library
local GetAddOnMetadata = C_AddOns and C_AddOns.GetAddOnMetadata or GetAddOnMetadata

-- Extract version information from TOC file
epsilon.version = GetAddOnMetadata(addonName, "Version")

local errorHandler = geterrorhandler()

--[[--------------------------------------------------------------------
-- Module management
----------------------------------------------------------------------]]

local modules = {}

function epsilon:registerModule(module, code, name)
	module.code = code;
	module.name = name;

	for idx, value in ipairs(modules) do
		if value.name == name then
			error(string.format("Attempt to re-register module: %s (%s)", name, tostring(module)))
		end
	end

	table.insert(modules, module)
end

function epsilon:getRegisteredModules()
	return modules;
end

print("epsilon addon - end");