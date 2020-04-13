if not minetest.get_modpath("lightning") then return end

local LIGHTNING_CHANCE = 10
lightning.auto = false

local rng = PcgRandom(82492402425)

local function handle_effect(player_data)
	for playername, data in pairs(player_data) do
		local player = minetest.get_player_by_name(playername)
		local ppos = player:get_pos()
		local random = rng:next(1, LIGHTNING_CHANCE)
		if random == 1 then
			lightning.strike(ppos)
		end
	end
end

climate_api.register_effect("regional_weather:lightning", handle_effect, "tick")
climate_api.set_effect_cycle("regional_weather:lightning", climate_api.LONG_CYCLE)