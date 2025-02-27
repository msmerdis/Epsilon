--[[
   Epsilon (c) 2025 All rights reserved
   Licensed under LGPLv3 - No Warranty
]] --

local addonName = select(1, ...);

---@class addon
local Epsilon = LibStub("AceAddon-3.0"):NewAddon(addonName);

-- Globals used in this library
local GetAddOnMetadata = C_AddOns and C_AddOns.GetAddOnMetadata or GetAddOnMetadata;

-- Extract version information from TOC file
Epsilon.version = GetAddOnMetadata(addonName, "Version")

local errorHandler = geterrorhandler()

--[[--------------------------------------------------------------------
-- Database management
----------------------------------------------------------------------]]

function Epsilon:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("EpsilonDB", Epsilon.defaults, true).global;
	self.CreateOptionFrames();
	self.AttachModules();
end

--[[--------------------------------------------------------------------
-- Module management
----------------------------------------------------------------------]]

local modules = {}

function Epsilon:RegisterModule(module, code, name)
	module.code = code;
	module.name = name;
	module.attached = false;

	for idx, value in ipairs(modules) do
		if value.name == name then
			error(string.format("Attempt to re-register module: %s (%s)", name, tostring(module)))
		end
	end

	table.insert(modules, module)
end

function Epsilon:GetRegisteredModules()
	return modules;
end

function Epsilon:AttachModules()
	for idx, module in ipairs(modules) do
		if module.attached == false and Epsilon.db.module[module.code] == true then
			module:Attach();
			module.attached = true;
		end
		if module.attached == true and Epsilon.db.module[module.code] == false then
			module:Detach();
			module.attached = false;
		end
	end
end