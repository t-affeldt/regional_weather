local EFFECT_NAME = "regional_weather:speed_buff"

local function handle_effect(player_data)
	for playername, data in pairs(player_data) do
		local player = minetest.get_player_by_name(playername)
		local product = 1
		for weather, value in pairs(data) do
			product = product * value
		end
		climate_api.utility.add_physics(EFFECT_NAME, player, "speed", product)
	end
end

local function remove_effect(player_data)
	for playername, data in ipairs(player_data) do
		local player = minetest.get_player_by_name(playername)
		climate_api.utility.remove_physics(EFFECT_NAME, player, "speed")
	end
end

climate_api.register_effect(EFFECT_NAME, handle_effect, "tick")
climate_api.register_effect(EFFECT_NAME, remove_effect, "stop")
climate_api.set_effect_cycle(EFFECT_NAME, climate_api.SHORT_CYCLE)