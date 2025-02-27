local addonName = select(1, ...);

---@class epsilon
local Epsilon = LibStub("AceAddon-3.0"):GetAddon(addonName);

local Module = {};

function Module:Attach()
	print("register riders of the storm module");
end

function Module:Detach()
	print("remove riders of the storm module");
end

Epsilon.RegisterModule (self, Module, "riders_of_the_storm", "Riders of the Storm");