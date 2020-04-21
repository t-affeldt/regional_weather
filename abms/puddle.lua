-- code of this file is partially taken from and otherwise inspired by
-- mymonths on https://github.com/minetest-mods/mymonths (licensed under DWYWPL)
-- contributers available at https://github.com/minetest-mods/mymonths/graphs/contributors
-- all changes of mine remain under LGPL v3

local BLOCK_NAME = "regional_weather:puddle"
local MIN_DISTANCE = 12

if not regional_weather.settings.puddles then
	minetest.register_alias(BLOCK_NAME, "air")
	return
end

local node_box = {
	type  = "fixed",
	fixed = {-0.5, -0.5, -0.5, 0.5, -0.49, 0.5}
}

minetest.register_node(BLOCK_NAME, {
	tiles = { "weather_puddle.png" },
	drawtype = "nodebox",
	pointable = false,
	buildable_to = true,
	floodable = true,
	walkable = false,
	sunlight_propagates = true,
	paramtype = "light",
	use_texture_alpha = true,
	node_box = node_box,
	groups = {
		not_in_creative_inventory = 1,
		crumbly = 3,
		attached_node = 1,
		slippery = 1,
		flora = 1,
		water = 1
	},
	drop = "",
})

-- Makes Puddles when raining
climate_api.register_abm({
	label			= "create rain puddles",
	nodenames	= { "group:soil", "group:stone" },
	neighbors	= { "air" },
	interval	= 10,
	chance		= 50,

	 conditions	= {
		 min_height		= regional_weather.settings.min_height,
		 max_height		= regional_weather.settings.max_height,
		 min_humidity	= 55,
		 min_heat			= 30,
		 daylight			= 15
	 },

	 pos_override = function(pos)
		 return vector.add(pos, { x = 0, y = 1, z = 0 })
	 end,

   action = function (pos, node, env)
		 if minetest.get_node(pos).name ~= "air" then return end
		 if minetest.find_node_near(pos, MIN_DISTANCE, BLOCK_NAME) then return end
		 minetest.set_node(pos, {name = BLOCK_NAME})
	 end
})

-- Makes puddles dry up when not raining
climate_api.register_abm({
	label = "remove rain puddles",
	nodenames	= { BLOCK_NAME },
	interval	= 5,
	chance		= 5,

	action = function (pos, node, env)
		if env.humidity < 55 then
			minetest.remove_node(pos)
		elseif env.heat < 30 and regional_weather.settings.snow_cover then
			minetest.set_node(pos, {name = "regional_weather:snow_cover_1"})
    end
	end
})