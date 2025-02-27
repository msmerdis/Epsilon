--[[
   Epsilon (c) 2025 All rights reserved
   Licensed under LGPLv3 - No Warranty
]] --

print("epsilon addon db - start");

---@class epsilon
local epsilon = select(2, ...)

local _G = _G

function initialize (frame, settings)
        local title = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	title:SetText(frame.name);
	title:SetWordWrap(false);
        title:SetPoint("TOPLEFT", frame, "TOPLEFT", 4, -4);
        title:SetScale(1.5);
        title:SetJustifyH("LEFT");

        local version = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	version:SetText(epsilon.version);
	version:SetWordWrap(false);
        version:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -8, 0);
        version:SetJustifyH("RIGHT");

        local separator = frame:CreateTexture(nil, "ARTWORK");
        separator:SetPoint("LEFT", frame, "LEFT", 4, 0);
        separator:SetPoint("RIGHT", frame, "RIGHT", -4, 0);
        separator:SetPoint("TOP", title, "BOTTOM", 0, -2);
        separator:SetColorTexture(1, 1, 1, 0.4);
        separator:SetHeight(2);
        frame.separator = separator;

end

--[[-----------------------------------------
-- Create main frame
-------------------------------------------]]
local panel = CreateFrame("Frame");
panel.name = "Epsilon";
initialize(panel, epsilon.settings);

local category = _G.Settings.RegisterCanvasLayoutCategory(panel, panel.name);
_G.Settings.RegisterAddOnCategory(category);

--local title = panel:CreateFontString("Epsilon", nil, "GamejFontNormalLarge");
--title:SetPoint("TOP");
--title:SetText("Epsilon");

--[[-----------------------------------------
-- Create module frames
-------------------------------------------]]

for idx, module in ipairs(epsilon:getRegisteredModules()) do
	if module.settings ~= nil then
		moduleFrame = CreateFrame("Frame");
		moduleFrame.name = module.name;
		initialize(moduleFrame, module.settings);

		subcategory = _G.Settings.RegisterCanvasLayoutSubcategory(category, moduleFrame, moduleFrame.name);
		subcategory.category = category;
	end
end

print("epsilon addon db - end");