local name = "regional_weather:wind"

local CLOUD_SPEED = 1.8

local conditions = {}

local function generate_effects(params)
	local override = {}

	override["climate_api:clouds"] = {
		size = climate_api.utility.rangelim(params.humidity, 0.25, 0.9),
		speed = vector.multiply(params.wind, CLOUD_SPEED)
	}

	local movement = params.player:get_player_velocity()
	local movement_direction
	if (vector.length(movement) < 0.1) then
		movement_direction = vector.new(0, 0, 0)
	else
		movement_direction = vector.normalize(movement)
	end
	local vector_product = vector.dot(movement_direction, params.wind)
	local movement_penalty = climate_api.utility.sigmoid(vector_product, 1.6, 0.2, 0.8) + 0.2
	override["regional_weather:speed_buff"] = movement_penalty
	return override
end

climate_api.register_weather(name, conditions, generate_effects)
