local name = "regional_weather:hail"

local conditions = {
	min_height			= regional_weather.settings.min_height,
	max_height			= regional_weather.settings.max_height,
	max_heat				= 45,
	min_humidity		= 65,
	min_windspeed		= 2.5
}

local effects = {}

effects["regional_weather:spawn_puddles"] = true
effects["regional_weather:lightning"] = true
effects["climate_api:damage"] = 1

effects["climate_api:sound"] = {
	name = "weather_hail",
	gain = 1
}

effects["climate_api:particles"] = {
	min_pos = {x=-9, y=7, z=-9},
	max_pos = {x= 9, y=7, z= 9},
	falling_speed=15,
	amount=5,
	exptime=0.8,
	size=1,
	textures = {}
}

for i = 1,5,1 do
	effects["climate_api:particles"].textures[i] = "weather_hail" .. i .. ".png"
end

climate_api.register_weather(name, conditions, effects)
