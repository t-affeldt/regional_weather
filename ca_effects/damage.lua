--[[
# Player Damage Effect
Use this effect to damage a player during dangerous weather events.
Expects a table as the parameter containing the following values:
- ``value <number>``: The amount of damage to be applied per successful roll per cycle
- ``chance <number>``: Defines a 1/x chance for the player to get damaged. Higher values result in less frequent damage.
]]

if not minetest.is_yes(minetest.settings:get_bool("enable_damage"))
or not regional_weather.settings.damage then return end

local EFFECT_NAME = "regional_weather:damage"

local rng = PcgRandom(7819792)

local function handle_effect(player_data)
	for playername, data in pairs(player_data) do
		local player = minetest.get_player_by_name(playername)
		local hp = player:get_hp()
		for weather, dmg in pairs(data) do
			if rng:next(1, dmg.chance) == 1 then
				hp = hp - dmg.value
			end
		end
		player:set_hp(hp, "weather damage")
	end
end

climate_api.register_effect(EFFECT_NAME, handle_effect, "tick")
climate_api.set_effect_cycle(EFFECT_NAME, climate_api.MEDIUM_CYCLE)