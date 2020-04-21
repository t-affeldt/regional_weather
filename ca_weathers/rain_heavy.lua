local name = "regional_weather:rain_heavy"

local conditions = {
	min_height		= regional_weather.settings.min_height,
	max_height		= regional_weather.settings.max_height,
	min_heat			= 40,
	min_humidity	= 65,
	daylight			= 15
}

local effects = {}

effects["climate_api:sound"] = {
	name = "weather_rain_heavy",
	gain = 1
}

effects["climate_api:particles"] = {
	min_pos = {x=-9, y=7, z=-9},
	max_pos = {x= 9, y=7, z= 9},
	falling_speed=7,
	amount=17,
	exptime=0.8,
	min_size=25,
	max_size=35,
	textures={
		"weather_rain.png",
		"weather_rain.png",
		"weather_rain_medium.png"
	}
}

climate_api.register_weather(name, conditions, effects)
