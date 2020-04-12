local function handle_effect(player_data)
	for playername, data in ipairs(player_data) do
		local player = minetest.get_player_by_name(playername)
		local product = 1
		for weather, value in pairs(data) do
			product = product * value
		end
		climate_api.utility.add_physics("regional_weather:speed_buff", player, "speed", product)
	end
end

local function remove_effect(player_data)
	for playername, data in ipairs(player_data) do
		local player = minetest.get_player_by_name(playername)
		climate_api.utility.remove_physics("regional_weather:speed_buff", player, "speed")
	end
end

climate_api.register_effect("regional_weather:speed_buff", handle_effect, "tick")
climate_api.register_effect("regional_weather:speed_buff", remove_effect, "end")
climate_api.set_effect_cycle("regional_weather:speed_buff", climate_api.SHORT_CYCLE)