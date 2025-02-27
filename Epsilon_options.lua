--[[
   Epsilon (c) 2025 All rights reserved
   Licensed under LGPLv3 - No Warranty
]] --

local addonName = select(1, ...);

---@class epsilon
local Epsilon = LibStub("AceAddon-3.0"):GetAddon(addonName);

local _G = _G

function createOptionCheckbox (idx, opt, frame)
	checkbox = CreateFrame("CheckButton", "Epsilon_module_" .. opt.code .. "_enable", frame, "ChatConfigCheckButtonTemplate");
	checkbox.tooltip = "Enable/Disable the " .. opt.name .. " module";
	checkbox:SetPoint("TOPLEFT", frame.separator, "BOTTOMLEFT", 0, -20 * idx);
	checkbox:SetChecked(Epsilon.db.module[opt.code]);
	checkbox:SetScript("OnClick", function ()
		Epsilon.db.module[opt.code] = checkbox:GetChecked();
	end);

	optName = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal");
	optName:SetText(opt.name);
	optName:SetWordWrap(false);
	optName:SetPoint("CENTER", checkbox, "CENTER", 0, 0);
	optName:SetPoint("LEFT", checkbox, "RIGHT", 0, 0);
	optName:SetJustifyH("LEFT");
end

function createOption(idx, opt, frame)
	if opt.type == "checkbox" then
		createOptionCheckbox (idx, opt, frame);
	end
end

function initializeFrame (frame, settings)
	local title = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	title:SetText(frame.name);
	title:SetWordWrap(false);
	title:SetPoint("TOPLEFT", frame, "TOPLEFT", 4, -4);
	title:SetScale(1.5);
	title:SetJustifyH("LEFT");

	local version = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	version:SetText(Epsilon.version);
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

	-- setup settings
	for idx, opt in ipairs(settings) do
		createOption (idx, opt, frame);
	end
end

function Epsilon:CreateOptionFrames()
	--[[-----------------------------------------
	-- Create main frame
	-------------------------------------------]]
	local panel = CreateFrame("Frame");
	panel.name = "Epsilon";
	initializeFrame(panel, Epsilon.settings);
	panel:SetScript("OnHide", function ()
		Epsilon:AttachModules();
	end)

	local category = _G.Settings.RegisterCanvasLayoutCategory(panel, panel.name);
	_G.Settings.RegisterAddOnCategory(category);

	--[[-----------------------------------------
	-- Create module frames
	-------------------------------------------]]

	for idx, module in ipairs(Epsilon:GetRegisteredModules()) do
		if module.settings ~= nil then
			moduleFrame = CreateFrame("Frame");
			moduleFrame.name = module.name;
			initializeFrame(moduleFrame, module.settings);

			subcategory = _G.Settings.RegisterCanvasLayoutSubcategory(category, moduleFrame, moduleFrame.name);
			subcategory.category = category;
		end
	end
end