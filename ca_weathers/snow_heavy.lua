local name = "regional_weather:snow_heavy"

local conditions = {
	min_height = regional_weather.settings.min_height,
	max_height = regional_weather.settings.max_height,
	max_heat				= 30,
	min_humidity		= 65,
	daylight				= 15
}

local effects = {}

effects["climate_api:hud_overlay"] = {
	file = "weather_hud_frost.png",
	z_index = -100,
	color_correction = true
}

effects["climate_api:particles"] = {
	min_pos = {x=-7, y=3, z=-7},
	max_pos = {x= 7, y=6, z= 7},
	exptime=7.5,
	size=15,
	amount=6,
	falling_speed = 0.75,
	texture="weather_snow.png"
}

climate_api.register_weather(name, conditions, effects)
