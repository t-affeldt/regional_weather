local name = "regional_weather:snow_heavy"

local conditions = {
	min_height = regional_weather.settings.min_height,
	max_height = regional_weather.settings.max_height,
	max_heat				= 30,
	min_humidity		= 65
}

local effects = {}

effects["regional_weather:spawn_snow"] = true

effects["climate_api:particles"] = {
	min_pos = {x=-12, y= 5, z=-12},
	max_pos = {x= 12, y=9, z= 12},
	exptime=8,
	size=12,
	texture="weather_snow.png"
}

local function generate_effects(params)
	local avg_humidity = 55
	local intensity = params.humidity / avg_humidity
	local override = {}

	override["climate_api:sound"] = {
		gain = math.min(intensity, 1.2)
	}

	override["climate_api:particles"] = {
		amount = 50 * math.min(intensity, 1.5),
		falling_speed = 1 / math.min(intensity, 1.3)
	}

	return climate_api.utility.merge_tables(effects, override)
end

climate_api.register_weather(name, conditions, generate_effects)
