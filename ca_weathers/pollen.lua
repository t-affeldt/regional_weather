local name = "regional_weather:pollen"

local conditions = {
	min_height			= regional_weather.settings.min_height,
	max_height			= regional_weather.settings.max_height,
	min_heat				= 40,
	min_humidity		= 30,
	max_humidity		= 40,
	max_windspeed		= 2
}

local effects = {}

effects["climate_api:particles"] = {
	min_pos = {x=-12, y=-4, z=-12},
	max_pos = {x= 12, y= 1, z= 12},
	falling_speed=-0.1,
	amount=2,
	exptime=5,
	size=1,
	texture="weather_pollen.png"
}

climate_api.register_weather(name, conditions, effects)
