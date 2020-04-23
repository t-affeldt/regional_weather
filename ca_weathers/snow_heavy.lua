local name = "regional_weather:snow_heavy"

local conditions = {
	min_height = regional_weather.settings.min_height,
	max_height = regional_weather.settings.max_height,
	max_heat				= 30,
	min_humidity		= 65,
	daylight				= 15
}

local effects = {}

effects["climate_api:hud_overlay"] = {
	file = "weather_hud_frost.png",
	z_index = -100
}

effects["climate_api:particles"] = {
	min_pos = {x=-8, y=3, z=-8},
	max_pos = {x= 8, y=6, z= 8},
	exptime=6,
	size=10,
	texture="weather_snow.png"
}

local function generate_effects(params)
	local avg_humidity = 55
	local intensity = params.humidity / avg_humidity
	local override = {}

	override["climate_api:particles"] = {
		amount = 16 * math.min(intensity, 1.5),
		falling_speed = 1 / math.min(intensity, 1.3)
	}

	return climate_api.utility.merge_tables(effects, override)
end

climate_api.register_weather(name, conditions, generate_effects)
