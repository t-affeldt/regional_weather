local name = "regional_weather:ambient"
local CLOUD_SPEED = 1.8

local conditions = {}

local function generate_effects(params)
	local override = {}
	local wind = climate_api.environment.get_wind()

	local skybox = {priority = 0}
	skybox.cloud_data = {
		density = climate_api.utility.rangelim(params.humidity / 100, 0.25, 0.98),
		speed = vector.multiply(wind, CLOUD_SPEED),
		thickness = climate_api.utility.rangelim(params.base_humidity * 0.2, 1, 18)
	}

	if params.height > -100 and params.humidity > 65 then
		skybox.sky_data = {
			type = "regular",
			clouds = true,
			sky_color = {
				day_sky = "#6a828e",
				day_horizon = "#5c7a8a",
				dawn_sky = "#b2b5d7",
				dawn_horizon = "#b7bce1",
				night_sky = "#2373e1",
				night_horizon = "#315d9b"
			}
		}
	end

	--override["climate_api:skybox"] = skybox

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
