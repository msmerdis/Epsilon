local addonName = select(1, ...);

---@class epsilon
local Epsilon = LibStub("AceAddon-3.0"):GetAddon(addonName);

function checkAuras (auras, name)
	for _,aura in pairs(auras) do
		if aura.name == name then
			Module.auraId = aura.auraInstanceID;
			return true;
		end
	end
	return false;
end

function checkAuraIds (ids)
	if Module.auraId == nil then
		return false;
	end;

	for _,id in pairs(ids) do
		if id == Module.auraId then
			Module.auraId = nil;
			return true;
		end
	end
	return false;
end

Module = CreateFrame("Frame");
Module:SetScript("OnEvent", function(self, event, ...)
	local _, details = ...

	if details.addedAuras and checkAuras(details.addedAuras, "G-99 Breakneck") then
		print("added");
	end

	if details.removedAuraInstanceIDs and checkAuraIds(details.removedAuraInstanceIDs) then
		print("removed");
	end
end);

function Module:Attach()
	Module:RegisterUnitEvent("UNIT_AURA", "player");
end

function Module:Detach()
	Module:UnregisterAllEvents();
end

Epsilon.RegisterModule (self, Module, "riders_of_the_storm", "Riders of the Storm");