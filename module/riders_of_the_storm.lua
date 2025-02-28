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
		willPlay, soundHandle = PlaySoundFile("Interface\\Addons\\Epsilon\\audio\\sdrots.mp3", "Master");

		if willPlay then
			if Module.sound then
				StopSound(Module.sound, 0.1);
			end
			Module.sound = soundHandle;
			Module.status = GetCVar("Sound_EnableMusic");
			SetCVar("Sound_EnableMusic", false);
		end
	end

	if Module.sound and details.removedAuraInstanceIDs and checkAuraIds(details.removedAuraInstanceIDs) then
		StopSound(Module.sound, 0.1);
		SetCVar("Sound_EnableMusic", Module.status);
	end
end);

function Module:Attach()
	Module:RegisterUnitEvent("UNIT_AURA", "player");
end

function Module:Detach()
	Module:UnregisterAllEvents();
end

Epsilon.RegisterModule (self, Module, "riders_of_the_storm", "Riders of the Storm");