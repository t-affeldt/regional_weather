local name = "regional_weather:ambient"

local conditions = {}

-- see https://en.wikipedia.org/wiki/Cloud_base
local function calc_cloud_height(heat, humidity, dewpoint)
	local base = regional_weather.settings.cloud_height
	-- much lower scale like 20 instead of 1000 fitting for Minetest
	local scale = regional_weather.settings.cloud_scale
	local spread = heat - dewpoint
	local variation = spread / 4.4 * scale * 0.3
	return base + climate_api.utility.rangelim(variation, -scale, scale)
end

-- maps range of 0 to 1 to any other range
local function map_range(val, low, high)
	return (val + low) * (high - low)
end

local function generate_effects(params)
	local override = {}

	local cloud_density = climate_api.utility.rangelim(params.humidity / 100, 0.15, 0.65)
	local cloud_thickness = climate_api.utility.rangelim(params.biome_humidity * 0.2, 1, 18)
	local cloud_height = calc_cloud_height(params.heat, params.humidity, params.dewpoint)
	local wind = climate_api.environment.get_wind({ x = 0, y = cloud_height, z = 0 })

	-- diffuse shadows when cloudy
	-- zero at density 0.65 and one at 0.15
	local cloud_shadows = 1.075 - (cloud_density / 0.5)

	-- diffuse shadows at dawn / dusk
	-- 15 hours between dawn and dusk accoring to https://wiki.minetest.net/Time_of_day
	local daylight_duration = 15 / 24
	local daytime = climate_api.utility.rangelim(minetest.get_timeofday(), 0.1875, 0.8125)
	-- zero at dawn / dusk and one at midday
	local daytime_shadows = 1 - (math.abs(0.5 - daytime) * 2 / daylight_duration)

	local shadow_intensity = map_range(cloud_shadows + daytime_shadows, 0.15, 0.4)
	local light_saturation = map_range(cloud_shadows + daytime_shadows, 0.9, 1.1)

	local skybox = {priority = 10}
	skybox.cloud_data = {
		density = cloud_density,
		speed = wind,
		thickness = cloud_thickness,
		height = cloud_height,
		ambient = "#0f0f1050"
	}

	skybox.light_data = {
		shadow_intensity = shadow_intensity,
		saturation = light_saturation
	}

	if params.height > -100 and params.humidity > 40 then
		skybox.cloud_data.color  = "#b2a4a4b0"
	end

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
		skybox.cloud_data.color = "#828e97b5"
		skybox.cloud_data.ambient = "#20212250"
	end

	override["climate_api:skybox"] = skybox

	if params.height > - 50 and not params.indoors then
		local movement = params.player:get_velocity()
		local movement_direction
		if (vector.length(movement) < 0.1) then
			movement_direction = vector.new(0, 0, 0)
		else
			movement_direction = vector.normalize(movement)
		end
		local vector_product = vector.dot(movement_direction, wind)
		local movement_penalty = climate_api.utility.sigmoid(vector_product, 1.5, 0.15, 0.9) + 0.2
		override["regional_weather:speed_buff"] = movement_penalty
	end

	return override
end

climate_api.register_weather(name, conditions, generate_effects)
