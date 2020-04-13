local name = "regional_weather:rain"

local conditions = {
	min_height		= regional_weather.settings.min_height,
	max_height		= regional_weather.settings.max_height,
	min_heat			= 30,
	min_humidity	= 50,
	max_humidity	= 65
}

local effects = {}
effects["regional_weather:spawn_puddles"] = true
effects["regional_weather:wetten_farmland"] = true

effects["climate_api:sound"] = {
	name = "weather_rain",
}

effects["climate_api:particles"] = {
	min_pos = {x=-9, y=7, z=-9},
	max_pos = {x= 9, y=7, z= 9},
	exptime=0.8,
	size=1,
	texture = "weather_raindrop.png"
}

local function generate_effects(params)
	local avg_humidity = 40
	local intensity = params.humidity / avg_humidity
	local override = {}

	override["climate_api:sound"] = {
		gain = math.min(intensity, 1.2)
	}

	override["climate_api:particles"] = {
		amount = 20 * math.min(intensity, 1.5),
		falling_speed = 10 / math.min(intensity, 1.3)
	}

	return climate_api.utility.merge_tables(effects, override)
end

climate_api.register_weather(name, conditions, generate_effects)
