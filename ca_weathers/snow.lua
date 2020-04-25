local name = "regional_weather:snow"

local conditions = {
	min_height = regional_weather.settings.min_height,
	max_height = regional_weather.settings.max_height,
	max_heat				= 35,
	min_humidity		= 50,
	max_humidity		= 65,
	daylight				= 15
}

local effects = {}

effects["climate_api:particles"] = {
	min_pos = {x=-12, y=2, z=-12},
	max_pos = {x= 12, y=8, z= 12},
	amount = 4,
	exptime = 7,
	size = 1,
	falling_speed = 0.85,
	acceleration = {x=0, y=0.06, z=0},
	textures = {}
}

for i = 1,12,1 do
	effects["climate_api:particles"].textures[i] = "weather_snowflake" .. i .. ".png"
end

climate_api.register_weather(name, conditions, effects)
