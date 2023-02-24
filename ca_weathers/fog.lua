local name = "regional_weather:fog"

local conditions = {
	min_height = regional_weather.settings.min_height,
	max_height = regional_weather.settings.max_height,
	min_humidity = 25,
	max_humidity = 50,
	max_windspeed = 2,
	max_heat = 50,
	min_time = 4 / 24,
	max_time = 8 / 24,
	not_biome = {
		"cold_desert",
		"cold_desert_ocean",
		"desert",
		"desert_ocean",
		"sandstone_desert",
		"sandstone_desert_ocean",
		"tundra"
	}
}

local effects = {}

effects["climate_api:hud_overlay"] = {
    file = "weather_hud_fog.png^[opacity:100",
    z_index = -200,
    color_correction = true
}

effects["climate_api:skybox"] = {
	sky_data = {
		type = "plain",
		base_color = "#c0c0c08f",
		clouds = true
	},
	cloud_data = {
		density = 1,
		color = "#ffffff80",
		thickness = 40,
		speed = {x=0,y=0,z=0}
	},
	light_data = {
		shadow_intensity = 0.1,
		saturation = 0.5
	},
	priority = 50
}

local function generate_effects(params)
	local override = {}
	override["climate_api:skybox"] = {
		cloud_data = {
			height = params.player:get_pos().y - 20
		}
	}
	return climate_api.utility.merge_tables(effects, override)
end

climate_api.register_weather(name, conditions, generate_effects)
