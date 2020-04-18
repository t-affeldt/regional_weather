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
	name = "weather_rain",
	gain = 1
}

effects["climate_api:particles"] = {
	min_pos = {x=-9, y=7, z=-9},
	max_pos = {x= 9, y=7, z= 9},
	falling_speed=10,
	amount=20,
	exptime=0.8,
	size=25,
	texture="weather_rain.png"
}

climate_api.register_weather(name, conditions, effects)
