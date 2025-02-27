--[[
   Epsilon (c) 2025 All rights reserved
   Licensed under LGPLv3 - No Warranty
]] --

local addonName = select(1, ...);

---@class epsilon
local Epsilon = LibStub("AceAddon-3.0"):GetAddon(addonName);

Epsilon.defaults = {
	global = {
		module = {}
	},
}

Epsilon.settings = {}

for idx, module in ipairs(Epsilon:GetRegisteredModules()) do
	Epsilon.defaults.global.module[module.code] = true;
	Epsilon.settings[#Epsilon.settings + 1] = {
		code = module.code,
		name = module.name,
		type = "checkbox",
	}
end