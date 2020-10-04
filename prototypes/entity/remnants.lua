data:extend({
	{
		type = 'corpse',
		name = 'drying-rig-remnants',
		icon = '__nauvis-melange__/graphics/icons/drying-rig.png',
		icon_size = 64, icon_mipmaps = 4,
		flags = {'placeable-neutral', 'not-on-map'},
		subgroup = 'energy-remnants',
		order = 'a-c-a',
		selection_box = {{-3, -3}, {3, 3}},
		tile_width = 6,
		tile_height = 6,
		selectable_in_game = false,
		time_before_removed = 60 * 60 * 15, -- 15 minutes
		final_render_layer = 'remnants',
		remove_on_tile_placement = false,
		animation = {
			layers = {
				{
					filename = '__nauvis-melange__/graphics/entity/drying-rig/remnants/drying-rig-remnants.png',
					width = 290,
					height = 282,
					frame_count = 1,
					direction_count = 1,
					shift = util.by_pixel(4, 0),
					hr_version = {
						filename = '__nauvis-melange__/graphics/entity/drying-rig/remnants/hr-drying-rig-remnants.png',
						width = 580,
						height = 564,
						frame_count = 1,
						direction_count = 1,
						shift = util.by_pixel(3.5, 0),
						scale = 0.5,
					},
				}
			}
		}
	},
	{
		type = 'corpse',
		name = 'alien-growth-chamber-remnants',
		icon = '__nauvis-melange__/graphics/icons/alien-growth-chamber.png',
		icon_size = 64, icon_mipmaps = 4,
		flags = {'placeable-neutral', 'not-on-map'},
		subgroup = 'energy-remnants',
		order = 'a-c-a',
		selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
		tile_width = 3,
		tile_height = 3,
		selectable_in_game = false,
		time_before_removed = 60 * 60 * 15, -- 15 minutes
		final_render_layer = 'remnants',
		remove_on_tile_placement = false,
		animation = {
			layers = {
				{
					filename = '__nauvis-melange__/graphics/entity/alien-growth-chamber/remnants/alien-growth-chamber-remnants.png',
					width = 123,
					height = 119,
					frame_count = 1,
					direction_count = 1,
					--shift = util.by_pixel(4, 0),
					hr_version = {
						filename = '__nauvis-melange__/graphics/entity/alien-growth-chamber/remnants/hr-alien-growth-chamber-remnants.png',
						width = 246,
						height = 238,
						frame_count = 1,
						direction_count = 1,
						--shift = util.by_pixel(3.5, 0),
						scale = 0.5,
					},
				}
			}
		}
	},
})
