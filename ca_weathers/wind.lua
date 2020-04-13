local name = "regional_weather:wind"

local CLOUD_SPEED_MULTIPLICATOR = 1.8

local conditions = {}

local function generate_effects(params)
	local override = {}

	override["climate_api:skybox"] = {
		clouds_data = {
			speed = params.wind * CLOUD_SPEED_MULTIPLICATOR
		}
	}

	local movement_direction = vector.normalize(params.player:get_player_velocity())
	local vector_product = vector.dot(movement_direction, params.wind)
	local movement_penalty = climate_api.utility.logistic_growth(vector_product, 1.6, 0.15, 0.8) + 0.1
	override["regional_weather:speed_buff"] = movement_penalty

	return override
end

climate_api.register_weather(name, conditions, generate_effects)
