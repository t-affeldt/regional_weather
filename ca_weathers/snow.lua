local name = "regional_weather:snow"

local conditions = {
	min_height = regional_weather.settings.min_height,
	max_height = regional_weather.settings.max_height,
	max_heat				= 40,
	min_humidity		= 50,
	max_humidity		= 65,
	min_light				= 15
}

local effects = {}

effects["climate_api:particles"] = {
	min_pos = {x=-20, y= 3, z=-20},
	max_pos = {x= 20, y=12, z= 20},
	exptime=8,
	size=1,
	textures = {}
}

for i = 1,12,1 do
	effects["climate_api:particles"].textures[i] = "weather_snowflake" .. i .. ".png"
end

local function generate_effects(params)
	local avg_humidity = 40
	local intensity = params.humidity / avg_humidity
	local override = {}

	override["climate_api:particles"] = {
		amount = 50 * math.min(intensity, 1.5),
		falling_speed = 1 / math.min(intensity, 1.3)
	}

	return climate_api.utility.merge_tables(effects, override)
end

climate_api.register_weather(name, conditions, generate_effects)
