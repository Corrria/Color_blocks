local regnew_node = minetest.register_node
local regnew_alias = minetest.register_alias
local regnew_abm = minetest.register_abm
local directions = {
	{x=1, y=0, z=0},
	{x=-1, y=0, z=0},
	{x=0, y=0, z=1},
	{x=0, y=0, z=-1},
	{x=0, y=1, z=0},
	{x=0, y=-1, z=0}
}

--||-----------------
--||----  NODES  ----
--vv-----------------


--||
-->> RED BLOCK
--||
-->>>>DEFINITION
regnew_node('color_blocks:red', 
	{
    description = 'Take care of its oxidation',
    tiles = { 'red.png' },
	light_source = 3,
    groups = { cb = 1, oddly_breakable_by_hand = 3 },
	})
-->>>>ALIAS
regnew_alias('cb:red', 'color_blocks:red')
-->>>>ABM
regnew_abm(
	{
	nodenames = {'cb:red'},
	interval = 3,
	chance = 3,
	action = function(pos, node)
        local dir = directions[math.random(1,4)]
		local next_pos = vector.add(pos, dir)
		local next_node = minetest.get_node(next_pos)
		local next_nodecb = minetest.get_item_group(next_node.name, 'cb')
		if next_nodecb == 0 and not (next_node.name == 'air') then
			minetest.swap_node(next_pos, node)
			minetest.swap_node(pos, next_node)
			end
		end
	})

--||
-->> ORANGE BLOCK
--||
-->>>>DEFINITION
regnew_node('color_blocks:orange', 
	{
    description = 'Es naranja',
    tiles = { 'orange.png' },
	drop = 'cb:yellow',
	light_source = 3,
    groups = { cb = 1, oddly_breakable_by_hand = 3 },
	on_punch = function(pos, node)
		minetest.chat_send_all(node.name)
		end
	})
-->>>>ALIAS
regnew_alias('cb:orange', 'color_blocks:orange')

--YELLOW BLOCK
--------------
--DEFINITION
regnew_node('color_blocks:yellow', 
	{
    description = 'This Node has so much energy!',
    tiles = { 'yellow.png' },
	light_source = 3,
    groups = { cb = 1, oddly_breakable_by_hand = 3 }
	})
--ALIAS
regnew_alias('cb:yellow', 'color_blocks:yellow')
--ABM
regnew_abm(
	{
	nodenames = {'cb:yellow'},
	interval = 3,
	chance = 3,
	action = function(pos, node)
        local dir = directions[math.random(1,4)]
		local next_pos = vector.add(pos, dir)
		local next_node = minetest.get_node(next_pos)	
		if next_node.name == 'air' then
			minetest.swap_node(next_pos, node)
			minetest.swap_node(pos, next_node)
			--minetest.sound_play('sine', { pos, max_hear_distance = 2, gain = 0.3})
			end
		end
	})

--GREEN BLOCK
-------------
--DEFINITION
regnew_node('color_blocks:green', 
	{
    description = 'This Node has so much energy!',
    tiles = { 'green.png' },
	light_source = 3,
    groups = { cb = 1, oddly_breakable_by_hand = 3 }
	})
--ALIAS
regnew_alias('cb:green', 'color_blocks:green')
--ABM
regnew_abm(
	{
	nodenames = {'cb:green'},
	interval = 1,
	chance = 1,
	action = function(pos, node)
        local dir = directions[6]
		local next_pos = vector.add(pos, dir)
		local next_node = minetest.get_node(next_pos)
		if next_node.name == 'air' then
			minetest.swap_node(next_pos, node)
			minetest.swap_node(pos, next_node)
		elseif minetest.get_item_group(next_node.name, 'cb') == 0 then
			minetest.set_node(pos, next_node)
			end
		end
	})

--BORING GLASS
--------------
--DEFINITION
regnew_node('color_blocks:glass', 
	{
    description = 'Simple, plain and boring classic glass',
	drawtype = 'glasslike_framed',
	paramtype = 'light',
	sunlight_propagates = true,
    tiles = { 'glass.png', 'glass_detail.png' },
    groups = { cb = 1, oddly_breakable_by_hand = 3 }
	})
--ALIAS
regnew_alias('cb:glass', 'color_blocks:glass')

--WHITE BLOCK
-------------
--DEFINITION
regnew_node('color_blocks:white', 
	{
    description = 'You sure is white?',
	light_source = 15,
	sunlight_propagates = true,
    tiles = { 'white.png' },
    groups = { cb = 1, oddly_breakable_by_hand = 3 }
	})
--ALIAS
regnew_alias('cb:white', 'color_blocks:white')

--BLUE BLOCK
-------------
--DEFINITION
regnew_node('color_blocks:blue', 
	{
    description = 'Deep blue',
    tiles = { 'blue.png' },
    groups = { cb = 1, oddly_breakable_by_hand = 3 },
	on_punch = function(pos, node, puncher)
		for i=1, #directions do
		local next_pos = vector.add(pos, directions[i])
		local next_node = minetest.get_node(next_pos)
		minetest.chat_send_all(minetest.get_item_group(next_node.name, 'cb'))
			end
		end
	})
--ALIAS
regnew_alias('cb:blue', 'color_blocks:blue')

--PINK BLOCK
------------
--DEFINITION
regnew_node('color_blocks:pink',
	{
    tiles = { 'pink.png' },
	drawtype = 'glasslike',
	use_texture_alpha = 'blend',
	post_effect_color = '#ff00dca6',
	paramtype = 'light',
    description = 'Floats',
    groups = { cb_gas = 1, oddly_breakable_by_hand = 3 },
	sunlight_propagates = true,
	walkable = false,
	pointable = false,
	})
--ALIAS
regnew_alias('cb:pink', 'color_blocks:pink')
--ABM
regnew_abm(
	{
	nodenames = {'cb:pink'},
	interval = 1,
	chance = 3,
	action = function(pos, node)
        local dir = directions[5]
		local next_posup = vector.add(pos, dir)
		local next_nodeup = minetest.get_node(next_posup)
		local randir = directions[math.random(1,4)]
		local next_pos = vector.add(pos, randir)
		local next_node = minetest.get_node(next_pos)
		local iscb = minetest.get_item_group
		if pos.y > 24 then
			minetest.set_node(pos, {name = 'air'})
		elseif next_nodeup.name == 'air' then
			minetest.swap_node(next_posup, node)
			minetest.swap_node(pos, next_nodeup)
		elseif next_node.name == 'air' then
			minetest.swap_node(next_pos, node)
			minetest.swap_node(pos, next_node)
			end
		end
	})

--PINK GENERATOR
------------
--DEFINITION
regnew_node('color_blocks:pinkgen', 
	{
    description = 'gasss',
    tiles = { 'pinkgen.png' },
	light_source = 3,
    groups = { cb = 1, oddly_breakable_by_hand = 3 }
	})
--ALIAS
regnew_alias('cb:pinkgen', 'color_blocks:pinkgen')
--ABM
regnew_abm(
	{
	nodenames = {'cb:pinkgen'},
	interval = 5,
	chance = 2,
	action = function(pos, node)
        local dir = directions[5]
		local next_posup = vector.add(pos, dir)
		local next_nodeup = minetest.get_node(next_posup)
		if next_nodeup.name == 'air' then
			minetest.set_node(next_posup, {name = 'cb:pink'})
			end
		end
	})