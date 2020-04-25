local name = "regional_weather:rain"

local conditions = {
	min_height		= regional_weather.settings.min_height,
	max_height		= regional_weather.settings.max_height,
	min_heat			= 35,
	min_humidity	= 50,
	max_humidity	= 65,
	daylight			= 15
}

local effects = {}

effects["climate_api:sound"] = {
	name = "weather_rain",
	gain = 1.5
}

effects["climate_api:particles"] = {
	min_pos = {x=-9, y=8, z=-9},
	max_pos = {x= 9, y=6, z= 9},
	exptime = 1.1,
	size = 2,
	amount = 15,
	falling_speed = 6,
	acceleration={x=0, y=-0.05, z=0},
	texture = "weather_raindrop.png"
}

climate_api.register_weather(name, conditions, effects)
