local name = "regional_weather:sandstorm"

local conditions = {
	min_height = regional_weather.settings.min_height,
	max_height = regional_weather.settings.max_height,
	min_heat				= 50,
	max_humidity		= 25,
	min_windspeed		= 4.5,
	has_biome				= {
		"cold_desert",
		"cold_desert_ocean",
		"desert",
		"desert_ocean",
		"sandstone_desert",
		"sandstone_desert_ocean"
	}
}

local effects = {}

effects["climate_api:hud_overlay"] = {
	file = "weather_hud_sand.png",
	z_index = -100
}

effects["regional_weather:damage"] = {
	chance = 3,
	value = 1
}

effects["climate_api:particles"] = {
	min_pos = {x=-5, y=-4, z=-5},
	max_pos = {x= 5, y= 4.5, z= 5},
	falling_speed=1.2,
	acceleration={x=0,y=0.8,z=0},
	amount=40,
	exptime=1.8,
	size=20,
	textures={
		"weather_sandstorm.png",
		"weather_sandstorm.png^[transformR180"
	}
}

effects["climate_api:skybox"] = {
	sky_data = {
		type = "plain",
		base_color = "#f7e4bfff",
		clouds = true,
	},
	cloud_data = {
		density = 1,
		color = "#f7e4bfc0",
		thickness = 40,
		speed = {x=0,y=0,z=0}
	},
	priority = 60
}

local function generate_effects(params)
	local override = {}
	override["climate_api:skybox"] = {
		cloud_data= {
			height = params.player:get_pos().y - 20
		}
	}
	override = climate_api.utility.merge_tables(effects, override)
	if params.daylight < 15 then
		local result = {}
		result["climate_api:skybox"] = override["climate_api:skybox"]
		return result
	end
	return override
end

climate_api.register_weather(name, conditions, generate_effects)
