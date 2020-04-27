local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)

local function get_setting_bool(name, default)
	local value = minetest.settings:get_bool("regional_weather_" .. name)
	if type(value) == "nil" then value = default end
	return minetest.is_yes(value)
end

local function get_setting_number(name, default)
	local value = minetest.settings:get("regional_weather_" .. name)
	if type(value) == "nil" then value = default end
	return tonumber(value)
end

regional_weather = {}
regional_weather.settings = {}
regional_weather.settings.snow				= get_setting_bool("snow_layers", true)
regional_weather.settings.puddles			= get_setting_bool("puddles", true)
regional_weather.settings.soil				= get_setting_bool("soil", true)
regional_weather.settings.fire				= get_setting_bool("fire", true)
regional_weather.settings.ice					= get_setting_bool("ice", true)
regional_weather.settings.pedology		= get_setting_bool("pedology", true)
regional_weather.settings.max_height	= get_setting_number("max_height", 120)
regional_weather.settings.min_height	= get_setting_number("min_height", -50)
regional_weather.settings.cloud_height= get_setting_number("cloud_height", 120)
regional_weather.settings.cloud_scale	= get_setting_number("cloud_scale", 40)

-- warn about clouds being overriden by MTG weather
if climate_mod.settings.skybox
and minetest.get_modpath("weather")
and get_setting_bool("enable_weather", true) then
	minetest.log("warning", "[Regional Weather] Disable MTG weather for the best experience")
end

-- import individual weather types
dofile(modpath.."/ca_weathers/ambient.lua")
dofile(modpath.."/ca_weathers/deep_cave.lua")
dofile(modpath.."/ca_weathers/fog.lua")
dofile(modpath.."/ca_weathers/fog_heavy.lua")
dofile(modpath.."/ca_weathers/hail.lua")
dofile(modpath.."/ca_weathers/pollen.lua")
dofile(modpath.."/ca_weathers/rain.lua")
dofile(modpath.."/ca_weathers/rain_heavy.lua")
dofile(modpath.."/ca_weathers/sandstorm.lua")
dofile(modpath.."/ca_weathers/snow.lua")
dofile(modpath.."/ca_weathers/snow_heavy.lua")
dofile(modpath.."/ca_weathers/storm.lua")

-- register environment effects
dofile(modpath.."/ca_effects/lightning.lua")
dofile(modpath.."/ca_effects/speed_buff.lua")

-- register ABM cycles and custom nodes
dofile(modpath .. "/abms/puddle.lua")
dofile(modpath .. "/abms/snow_cover.lua")
dofile(modpath .. "/abms/fire.lua")
dofile(modpath .. "/abms/ice.lua")
dofile(modpath .. "/abms/pedology.lua")
dofile(modpath .. "/abms/soil.lua")
