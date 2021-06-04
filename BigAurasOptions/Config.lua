local addon, ns = ...;
local version = GetAddOnMetadata(addon, "Version");
local TOTAL_IMMUNITIES_slider = 10;
local IMMINITIES_slider = 9;
local CROWD_CONTROL_slider = 8;
local BUFF_DEFENSIVE_slider = 7;
local BUFF_OFFENSIVE_slider = 6;
local ROOTS_slider = 5;
local OTHER_slider = 4
-- Я ЕЩЕ ПЕРЕДЕЛАЛ ТАБЛИЦУ ДЕФОЛТНУЮ. ТЕПЕРЬ ОНА ВЫГЛЯДИТ ВОТ ТАК
function ns:GetCategories()
	return {
		{
			name = "crowdcontrol",
			slider = CROWD_CONTROL_slider,
			spells = {
			}
		},
		{
			name = "defensive",
			slider = BUFF_DEFENSIVE_slider,
			spells = {
				[11426] = 1, -- Ice Barrier
					[13031] = {parent = 11426},
					[13032] = {parent = 11426},
					[13033] = {parent = 11426},
					[27134] = {parent = 11426},
					[33405] = {parent = 11426},
				[10193] = 1, -- Mana Shield
					[1463] = {parent = 10193},
			}
		},
		{
			name = "offensive",
			slider = BUFF_OFFENSIVE_slider,
			spells = {
			}
		},
		{
			name = "other",
			slider = OTHER_slider,
			spells = {
			}
		},
		{
			name = "totalimmunity",
			slider = TOTAL_IMMUNITIES_slider,
			spells = {
			}
		},
		{
			name = "immunity",
			slider = IMMINITIES_slider,
			spells = {
			}
		},
		{
			name = "roots",
			slider = ROOTS_slider,
			spells = {
			}
		},
	};
end

local categories = ns:GetCategories()
function ns:GetCategoryByName(category)
    for key, tab in pairs(categories) do
        if ( tab.name == category ) then
            return tab;
        end
    end
end


function ns:GetCategoryBySpellID(spellID) -- А ВОТ КАТЕГОРИИ ПО СПЕЛЛ АЙДИ
    for i, category in pairs(categories) do
		for spellId in pairs(category.spells) do
			if ( spellID == spellId ) then
				return category.name
			end
		end
    end
end

function ns:GetPriorityBySpellID(unit, spellID) -- // ВОТ ПО ЮНИТЫ МОЖНО ПОЛУЧИТЬ ПРИОРИТЕТ СПЕЛЛ АЙДИ ЕСЛИ ОН ЕСТЬ В БД ВЕРНЕТ ЕГО ЗНАЧЕНИЕ ИЛИ 1 ПО ДЕФОЛТУ
    return GetBigAurasUnitProfileSetting("DEFAULT_PROFILE_NAME", unit, spellID, "value") or 1
end

function ns:CreateDefaultProfile()
	return  {
		-- main
		["enable"] = true,
		["alpha"] = 1,
		["showSwipe"] = true,
		["timertext"] = true,
		["unlock"] = false,
		["offsetX"] = 0,
		["offsetY"] = 0,
		["size"] = 48,
		-- category
		["crowdcontrol"] = { enabled = true, value = ns:GetCategoryByName("crowdcontrol").slider},
		["defensive"] = { enabled = true, value = ns:GetCategoryByName("defensive").slider},
		["offensive"] = { enabled = true, value = ns:GetCategoryByName("offensive").slider},
		["other"] = { enabled = true, value = ns:GetCategoryByName("other").slider},
		["totalimmunity"] = { enabled = true, value = ns:GetCategoryByName("totalimmunity").slider},
		["immunity"] = { enabled = true, value = ns:GetCategoryByName("immunity").slider},
		["roots"] = { enabled = true, value = ns:GetCategoryByName("roots").slider},
	}
end

function ns:GetDefaultProfile()
	return {
		["name"] = "DEFAULT",
		["anchor"] = "Blizzard",
		["OptionVersion"] = version,
		["player"] = ns:CreateDefaultProfile(),
		["pet"] = ns:CreateDefaultProfile(),
		["target"] = ns:CreateDefaultProfile(),
		["focus"] = ns:CreateDefaultProfile(),
		["party1"] = ns:CreateDefaultProfile(),
		["party2"] = ns:CreateDefaultProfile(),
		["party3"] = ns:CreateDefaultProfile(),
		["party4"] = ns:CreateDefaultProfile(),
		["partypet1"] = ns:CreateDefaultProfile(),
		["partypet2"] = ns:CreateDefaultProfile(),
		["partypet3"] = ns:CreateDefaultProfile(),
		["partypet4"] = ns:CreateDefaultProfile(),
		["arena1"] = ns:CreateDefaultProfile(),
		["arena2"] = ns:CreateDefaultProfile(),
		["arena3"] = ns:CreateDefaultProfile(),
		["arena4"] = ns:CreateDefaultProfile(),
		["arena5"] = ns:CreateDefaultProfile(),
		["arenapet1"] = ns:CreateDefaultProfile(),
		["arenapet2"] = ns:CreateDefaultProfile(),
		["arenapet3"] = ns:CreateDefaultProfile(),
		["arenapet4"] = ns:CreateDefaultProfile(),
		["arenapet5"] = ns:CreateDefaultProfile(),
	}
end