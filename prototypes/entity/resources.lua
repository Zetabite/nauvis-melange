local resource_autoplace = require('resource-autoplace')

data:extend({
	{
		type = 'resource',
		name = 'worm-hole',
		icon = '__nauvis-melange__/graphics/icons/worm-hole.png',
		icon_size = 64, icon_mipmaps = 4,
		flags = {'placeable-neutral'},
		collision_mask = {'water-tile'},
		collision_box = {{ -1.45, -1.45}, {1.45, 1.45}},
		selection_box = {{ -1.5, -1.5}, {1.5, 1.5}},
		highlight = true,
		minable = {mining_time = 1},
		category = 'deep-solid',
		minimum = 1,
		normal = 1,
		--collision_mask = { 'item-layer', 'player-layer', 'water-tile', 'not-colliding-with-itself' },
		autoplace = resource_autoplace.resource_autoplace_settings {
			name = 'worm-hole',
			order = 'c',
			base_density = 1,
			base_spots_per_km2 = 0.42,
			random_probability = 1/128,
			random_spot_size_minimum = 1,
			random_spot_size_maximum = 1, -- don't randomize spot size
			has_starting_area_placement = false,
			regular_rq_factor_multiplier = 1
		},
		stage_counts = {0},
		stages = {
			sheet = {
				filename = '__base__/graphics/entity/worm/worm-integration.png',
				priority = 'extra-high',
				width = 166,
				height = 122,
				--frame_count = 4,
				variation_count = 1,
				--shift = util.by_pixel(0, -2),
				hr_version = {
					filename = '__base__/graphics/entity/worm/hr-worm-integration.png',
					priority = 'extra-high',
					width = 332,
					height = 240,
					--frame_count = 4,
					variation_count = 1,
					--shift = util.by_pixel(0, -2),
					scale = 0.5,
				}
			}
		},
		map_color = {r=0.02, g=0.16, b=0.03},
    	map_grid = false
	},
	{
		type = 'resource',
		name = 'pre-spice-mass-ore',
		icon = '__nauvis-melange__/graphics/icons/pre-spice-mass-ore.png',
		icon_size = 64, icon_mipmaps = 4,
		flags = {'placeable-neutral'},
		collision_box = {{-1.4, -1.4}, {1.4, 1.4}},
		selection_box = {{ -0.5, -0.5}, {0.5, 0.5}},
		highlight = true,
		minable = { mining_time = 1, result = 'pre-spice-mass' },
		category = 'basic-solid',
		minimum = 16000,
		normal = math.random(16000, 42000),
		--collision_mask = { 'item-layer', 'player-layer', 'water-tile', 'not-colliding-with-itself' },
		autoplace = resource_autoplace.resource_autoplace_settings {
			name = 'pre-spice-mass-ore',
			order = 'b',
			base_density = 1.2,
			base_spots_per_km2 = 0.42,
			random_probability = 1/256,
			random_spot_size_minimum = 1,
			random_spot_size_maximum = 1, -- don't randomize spot size
			additional_richness = 4200, -- this increases the total everywhere, so base_density needs to be decreased to compensate
			has_starting_area_placement = false,
			regular_rq_factor_multiplier = 1
		},
		stage_counts = {0},
		stages = {
			sheet = {
				filename = '__nauvis-melange__/graphics/entity/pre-spice-mass/pre-spice-mass.png',
				priority = 'extra-high',
				width = 74,
				height = 60,
				frame_count = 4,
				variation_count = 1,
				hr_version = {
					filename = '__nauvis-melange__/graphics/entity/pre-spice-mass/hr-pre-spice-mass.png',
					priority = 'extra-high',
					width = 148,
					height = 120,
					frame_count = 4,
					variation_count = 1,
					scale = 0.5,
				}
			}
		},
		map_color = {r=0.02, g=0.16, b=0.03},
    	map_grid = false
	}
})
