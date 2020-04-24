local BLOCK_PREFIX = "regional_weather:puddle_"
local VARIANT_COUNT = 30
local MIN_DISTANCE = 2

if not regional_weather.settings.puddles then
	for i=1,VARIANT_COUNT do
		for r=0,270,90  do
			minetest.register_alias(BLOCK_PREFIX .. i .. "_" .. r, "air")
		end
	end
	return
end

local node_box = {
	type  = "fixed",
	fixed = {-0.5, -0.5, -0.5, 0.5, -0.49, 0.5}
}

for i = 1,VARIANT_COUNT do
	for rotation = 0,270,90 do
		for flip = 0,1 do
			local name = BLOCK_PREFIX .. i .. "_" .. rotation
			local texture = "weather_puddle." .. i .. ".png^[opacity:128"
			if flip == 1 or rotation > 0 then
				texture = texture .. "^[transform"
			end
			if flip == 1 then
				name = name .. "_flipped"
				texture = texture .. "FX"
			end
			if rotation > 0 then
				texture = texture .. "R" .. rotation
			end
			minetest.register_node(name, {
				tiles = { texture },
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
					water = 1,
					regional_weather_puddle = 1
				},
				drop = "",
				sounds = {
					footstep = {
						name = "weather_puddle",
						gain = 0.8
					}
				}
			})
		end
	end
end

minetest.register_alias("regional_weather:puddle", BLOCK_PREFIX .. "14_0")

local function get_random_puddle()
	local index = math.random(1, VARIANT_COUNT)
	local rotation = math.random(0, 3) * 90
	local flip = math.random(0, 1)
	local name = BLOCK_PREFIX .. index .. "_" .. rotation
	if flip == 1 then
		name = name .. "_flipped"
	end
	return name
end

-- Makes Puddles when raining
climate_api.register_abm({
	label			= "create rain puddles",
	nodenames	= { "group:soil", "group:stone" },
	neighbors	= { "air" },
	interval	= 10,
	chance		= 50,
	catch_up	= false,

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
		 if minetest.find_node_near(pos, MIN_DISTANCE, "group:regional_weather_puddle") then return end
		 local puddle_name = get_random_puddle()
		 minetest.set_node(pos, {name = puddle_name})
	 end
})

-- Makes puddles dry up when not raining
climate_api.register_abm({
	label = "remove rain puddles",
	nodenames	= { "group:regional_weather_puddle" },
	interval	= 5,
	chance		= 5,
	catch_up	= true,

	action = function (pos, node, env)
		if env.humidity < 55 then
			minetest.remove_node(pos)
		elseif env.heat < 30 and regional_weather.settings.snow_cover then
			minetest.set_node(pos, {name = "regional_weather:snow_cover_1"})
    end
	end
})
