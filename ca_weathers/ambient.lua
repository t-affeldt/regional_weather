local name = "regional_weather:ambient"

local CLOUD_SPEED = 1.8

local conditions = {
	min_daylight = 15
}

local function generate_effects(params)
	local override = {}
	local wind = climate_api.environment.get_wind()

	override["climate_api:skybox"] = {
		cloud_data = {
			size = climate_api.utility.rangelim(params.humidity / 100, 0.25, 0.98),
			speed = vector.multiply(wind, CLOUD_SPEED)
		}
	}

	local movement = params.player:get_player_velocity()
	local movement_direction
	if (vector.length(movement) < 0.1) then
		movement_direction = vector.new(0, 0, 0)
	else
		movement_direction = vector.normalize(movement)
	end
	local vector_product = vector.dot(movement_direction, wind)
	local movement_penalty = climate_api.utility.sigmoid(vector_product, 1.6, 0.2, 0.8) + 0.2
	override["regional_weather:speed_buff"] = movement_penalty
	return override
end

climate_api.register_weather(name, conditions, generate_effects)
