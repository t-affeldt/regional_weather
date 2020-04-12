local name = "regional_weather:sandstorm"

local conditions = {
	min_height = regional_weather.settings.min_height,
	max_height = regional_weather.settings.max_height,
	min_heat				= 50,
	max_humidity		= 25,
	min_windspeed		= 6
}

local effects = {}

effects["regional_weather:damage"] = true

effects["climate_api:particles"] = {
	min_pos = {x=-9, y=-5, z=-9},
	max_pos = {x= 9, y= 5, z= 9},
	falling_speed=1,
	amount=40,
	exptime=0.8,
	size=15,
	texture="weather_sand.png"
}

climate_api.register_weather(name, conditions, effects)
