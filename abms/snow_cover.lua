local BLOCK_PREFIX = "regional_weather:snow_cover_"

if not minetest.get_modpath("default")
or default.node_sound_snow_defaults == nil
or not regional_weather.settings.snow then
	for i = 1,5 do
		minetest.register_alias(BLOCK_PREFIX .. i, "air")
	end
	return
end

local destruction_handler = function(pos)
	pos.y = pos.y - 1
	if minetest.get_node(pos).name == "default:dirt_with_snow" then
		minetest.set_node(pos, {name = "default:dirt_with_grass"})
	end
end

for i = 1,5 do
	local node_box = {
		type  = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0.2*i - 0.5, 0.5}
	}

	minetest.register_node(BLOCK_PREFIX .. i, {
		tiles = { "default_snow.png" },
		drawtype = "nodebox",
		buildable_to = i < 3,
		floodable = true,
		walkable = i > 3,
		paramtype = "light",
		node_box = node_box,
		groups = {
			not_in_creative_inventory = 1,
			crumbly = 3,
			falling_node = 1,
			snowy = 1,
			regional_weather_snow_cover = i
		},
		sounds = default.node_sound_snow_defaults(),
		drop = "default:snow " .. math.ceil(i / 2),
		on_construct = function(pos)
			pos.y = pos.y - 1
			if minetest.get_node(pos).name == "default:dirt_with_grass" then
				minetest.set_node(pos, {name = "default:dirt_with_snow"})
			end
		end,
		on_destruct = destruction_handler,
		on_flood = destruction_handler
	})
end

climate_api.register_abm({
	label			= "create snow covers",
	nodenames	= {
		"group:soil",
		"group:leaves",
		"group:stone",
		"default:snowblock",
		"group:coverable_by_snow"
	},
	neighbors	= { "air" },
	interval	= 25,
	chance		= 40,
	catch_up	= false,

	 conditions	= {
		 min_height		= regional_weather.settings.min_height,
		 max_height		= regional_weather.settings.max_height,
		 min_humidity	= 55,
		 max_heat			= 30,
		 daylight			= 15
	 },

	 pos_override = function(pos)
		 return vector.add(pos, { x = 0, y = 1, z = 0 })
	 end,

   action = function (pos, node, env)
		 if node.name ~= "air" then return end
		 local base = minetest.get_node(vector.add(pos, {x=0, y=-1, z=0})).name
		 local is_soil = minetest.get_item_group(base, "soil") or 0
		 local is_stone = minetest.get_item_group(base, "stone") or 0
		 if not (is_soil == 0 and is_stone == 0) then
		 	minetest.set_node(pos, { name = BLOCK_PREFIX .. "1" })
		end
	 end
})

climate_api.register_abm({
	label			= "replace flora with snow covers and stack covers higher",
	nodenames	= {
		"group:flora",
		"group:grass",
		"group:plant",
		"group:regional_weather_snow_cover"
	},
	neighbors	= { "air" },
	interval	= 25,
	chance		= 30,
	catch_up	= false,

	 conditions	= {
		 min_height		= regional_weather.settings.min_height,
		 max_height		= regional_weather.settings.max_height,
		 min_humidity	= 55,
		 max_heat			= 30,
		 daylight			= 15
	 },

   action = function (pos, node, env)
		 local value = minetest.get_item_group(node.name, "regional_weather_snow_cover")
		 if value == nil then value = 0 end
		 if value < 5 then
			 minetest.set_node(pos, { name = BLOCK_PREFIX .. (value + 1) })
		 end
	 end
})

climate_api.register_abm({
	label			= "melt snow covers",
	nodenames	= { "group:regional_weather_snow_cover" },
	interval	= 25,
	chance		= 10,
	catch_up	= true,

	 conditions	= {
		 min_heat = 30
	 },

   action = function (pos, node, env)
			local value = minetest.get_item_group(node.name, "regional_weather_snow_cover")
			if value == nil then value = 0 end
			if value > 1 then
				minetest.set_node(pos, { name = BLOCK_PREFIX .. (value - 1) })
			elseif regional_weather.settings.puddles then
				minetest.set_node(pos, { name = "regional_weather:puddle" })
			else
				minetest.set_node(pos, { name = "air" })
			end
	 end
})
