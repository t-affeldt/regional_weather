local name = "regional_weather:deep_cave"

local conditions = {
	max_daylight	= minetest.LIGHT_MAX,
	max_height		= -100
}

local effects = {}
effects["climate_api:skybox"] = {
	sky_data = {
		type = "plain",
		base_color = { r = 0, g = 0, b = 0 },
		clouds = false
	},
	sun_data = {
		visible = false,
		sunrise_visible = false
	},
	moon_data = { visible = false },
	stars_data = { visible = false }
}

climate_api.register_weather(name, conditions, effects)
