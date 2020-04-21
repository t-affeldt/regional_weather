local name = "regional_weather:fog"

local conditions = {

}

local effects = {}

effects["climate_api:hud_overlay"] = {
	file = "weather_hud_fog.png",
	z_index = -200
}

effects["climate_api:skybox"] = {
	cloud_data = {
		density = 1,
		color = "#ffffffff",
		thickness = 40,
		speed = {x=0,y=0,z=0}
	},
	priority = 50
}

local function generate_effects(params)
	local override = {}
	override["climate_api:skybox"] = {
		cloud_data = {
			height = params.player:get_pos().y
		}
	}
	return climate_api.utility.merge_tables(effects, override)
end

climate_api.register_weather(name, conditions, generate_effects)
