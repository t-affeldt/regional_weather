if not regional_weather.settings.damage then return end

local EFFECT_NAME = "regional_weather:damage"

local function handle_effect(player_data)
	for playername, data in pairs(player_data) do
		local player = minetest.get_player_by_name(playername)
		local hp = player:get_hp()
		for weather, value in pairs(data) do
			hp = hp - value
		end
		player:set_hp(hp, "weather damage")
	end
end

climate_api.register_effect(EFFECT_NAME, handle_effect, "tick")
climate_api.set_effect_cycle(EFFECT_NAME, climate_api.LONG_CYCLE)