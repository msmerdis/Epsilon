--[[
   Epsilon (c) 2025 All rights reserved
   Licensed under LGPLv3 - No Warranty
]] --

print("epsilon addon db - start");

---@class epsilon
local epsilon = select(2, ...)

epsilon.defaults = {
	modules = {},
}

epsilon.settings = {}

for idx, module in ipairs(epsilon:getRegisteredModules()) do
	epsilon.defaults.modules[module.code] = true;
	epsilon.settings[#epsilon.settings] = {
		code = module.code,
		name = module.name,
		type = boolean
	}
	print("epsilon addon db - " .. module.code);
end


print("epsilon addon db - end");