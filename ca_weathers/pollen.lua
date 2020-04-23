local name = "regional_weather:pollen"

local conditions = {
	min_height			= regional_weather.settings.min_height,
	max_height			= regional_weather.settings.max_height,
	min_heat				= 40,
	min_humidity		= 30,
	max_humidity		= 40,
	max_windspeed		= 2,
	daylight				= 15,
	has_biome				= {
		"default",
		"deciduous_forest",
		"deciduous_forest_ocean",
		"deciduous_forest_shore",
		"grassland",
		"grassland_dunes",
		"grassland_ocean",
		"snowy_grassland",
		"snowy_grassland_ocean",
		"grassy",
		"grassy_ocean",
		"grassytwo",
		"grassytwo_ocean",
		"mushroom",
		"mushroom_ocean",
		"plains",
		"plains_ocean",
		"sakura",
		"sakura_ocean"
	}
}

local effects = {}

effects["climate_api:particles"] = {
	min_pos = {x=-12, y=-4, z=-12},
	max_pos = {x= 12, y= 1, z= 12},
	falling_speed = -0.1,
	acceleration = {x=0,y=-0.03,z=0},
	amount = 1,
	exptime = 5,
	size = 0.8,
	texture = "weather_pollen.png"
}

climate_api.register_weather(name, conditions, effects)
