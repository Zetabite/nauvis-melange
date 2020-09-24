local hit_effects = require ('__base__/prototypes/entity/demo-hit-effects')
local sounds = require('__base__/prototypes/entity/demo-sounds')
local blank = {
	filename = '__nauvis-melange__/graphics/entity/water-injector/blank.png',
	priority = 'very-low',
	width = 64,
	height = 64,
}

data:extend({
	{
		type = 'mining-drill',
		name = 'water-injector-proxy',
		localised_name = {'entity-name.water-injector'},
		localised_description = {'entity-description.water-injector'},
		icon = '__nauvis-melange__/graphics/icons/water-injector.png',
		icon_size = 64, icon_mipmaps = 4,
		collision_box = {{ -1.25, -1.25}, {1.25, 1.25}},
		selection_box = {{ -1.5, -1.5}, {1.5, 1.5}},
		drawing_box = {{ -1.5, -1.5}, {1.5, 1.5}},
		--collision_mask = { 'item-layer', 'player-layer', 'water-tile', 'not-colliding-with-itself' },
		vector_to_place_result = {0, 0},
		resource_searching_radius = 0.49,
		mining_speed = 0.1,
		energy_source = {
			type = 'void'
		},
		energy_usage = '1kW',
		resource_categories = {'deep-solid'},
		base_picture = {
			sheets = {
				{
					filename = '__nauvis-melange__/graphics/entity/water-injector/water-injector-proxy.png',
					priority = 'extra-high',
					frames = 1,
					width = 96,
					height = 96,
					--shift = util.by_pixel(0, 4),
					hr_version = {
						filename = '__nauvis-melange__/graphics/entity/water-injector/hr-water-injector-proxy.png',
						priority = 'extra-high',
						frames = 1,
						width = 192,
						height = 192,
						--shift = util.by_pixel(-0.25, 3.75),
						scale = 0.5
					}
				}
			}
		},
	},
	{
		type = 'storage-tank',
		name = 'water-injector',
		icon = '__nauvis-melange__/graphics/icons/water-injector.png',
		icon_size = 64, icon_mipmaps = 4,
		collision_box = {{ -1.25, -1.25}, {1.25, 1.25}},
		selection_box = {{ -1.5, -1.5}, {1.5, 1.5}},
		window_bounding_box = {{ 0, 0}, {0, 0}},
		minable = {mining_time = 0.3, result = 'water-injector-proxy'},
		flags = {'placeable-neutral', 'player-creation'},
		max_health = 150,
		corpse = 'burner-mining-drill-remnants',
		damaged_trigger_effect = hit_effects.entity(),
		flow_length_in_ticks = 1,
		pictures = {
			picture = {
				sheets = {
					{
						filename = '__nauvis-melange__/graphics/entity/water-injector/water-injector.png',
						priority = 'extra-high',
						frames = 1,
						width = 96,
						height = 96,
						--shift = util.by_pixel(0, 4),
						hr_version = {
							filename = '__nauvis-melange__/graphics/entity/water-injector/hr-water-injector.png',
							priority = 'extra-high',
							frames = 1,
							width = 192,
							height = 192,
							--shift = util.by_pixel(-5, 0),
							scale = 0.5
						}
					},
					{
						filename = '__nauvis-melange__/graphics/entity/water-injector/water-injector-shadow.png',
						priority = 'extra-high',
						width = 73,
						height = 69,
						frames = 1,
						draw_as_shadow = true,
						shift = util.by_pixel(6, 0.5),
						hr_version = {
							filename = '__nauvis-melange__/graphics/entity/water-injector/hr-water-injector-shadow.png',
							width = 145,
							height = 137,
							frames = 1,
							scale = 0.5,
							draw_as_shadow = true,
							shift = util.by_pixel(6, 0.5)
						}
					}
				}
			},
			fluid_background = blank,
			window_background = blank,
			flow_sprite = blank,
			gas_flow = blank
		},
		integration_patch = {
			filename = '__base__/graphics/entity/worm/worm-integration.png',
			priority = 'extra-high',
			width = 166,
			height = 122,
			--shift = util.by_pixel(-5, 0),
			hr_version = {
				filename = '__base__/graphics/entity/worm/hr-worm-integration.png',
				priority = 'extra-high',
				width = 332,
				height = 240,
				shift = util.by_pixel(6, 3),
				scale = 0.5,
			}
		},
		fluid_box = {
			production_type = 'input',
			pipe_covers = pipecoverspictures(),
			base_area = 2500,
			pipe_connections = {
				{ type='input', position = { 0, 2} },
				{ type='input', position = { 0,-2} },
				{ type='input', position = { 2, 0} },
				{ type='input', position = {-2, 0} }
			},
			filter = 'water'
		},
		vehicle_impact_sound = sounds.generic_impact,
		open_sound = sounds.machine_open,
		close_sound = sounds.machine_close,
		working_sound = {
		  	sound = {
				{
					filename = '__base__/sound/pump.ogg',
					volume = 0.7
				},
			},
		},
	},
	{
		type = 'assembling-machine',
		name = 'drying-rig',
		icon = '__nauvis-melange__/graphics/icons/drying-rig.png',
		icon_size = 64, icon_mipmaps = 4,
		flags = {'placeable-neutral', 'placeable-player', 'player-creation'},
		minable = {mining_time = 0.1, result = 'drying-rig'},
		max_health = 200,
		corpse = 'drying-rig-remnants',
		dying_explosion = 'solar-panel-explosion',
		collision_box = {{-2.8, -2.8}, {2.8, 2.8}},
		selection_box = {{-3, -3}, {3, 3}},
		damaged_trigger_effect = hit_effects.entity(),
		energy_source = {
			type = 'electric',
			usage_priority = 'secondary-input'
		},
		crafting_categories = {'drying'},
		energy_usage = '150kW',
		crafting_speed = 1,
		animation = {
			layers = {
				{
					filename = '__nauvis-melange__/graphics/entity/drying-rig/drying-rig.png',
					priority = 'high',
					width = 210,
					height = 198,
					frame_count = 1,
					shift = util.by_pixel(-3, 3),
					hr_version = {
						filename = '__nauvis-melange__/graphics/entity/drying-rig/hr-drying-rig.png',
						priority = 'high',
						width = 420,
						height = 396,
						frame_count = 1,
						shift = util.by_pixel(-3, 3),
						scale = 0.5
					}
				},
				{
					filename = '__nauvis-melange__/graphics/entity/drying-rig/drying-rig-shadow-overlay.png',
					priority = 'high',
					width = 192,
					height = 177,
					frame_count = 1,
					shift = util.by_pixel(10.5, 6),
					hr_version = {
						filename = '__nauvis-melange__/graphics/entity/drying-rig/hr-drying-rig-shadow-overlay.png',
						priority = 'high',
						width = 385,
						height = 355,
						frame_count = 1,
						shift = util.by_pixel(5.5, 3),
						scale = 0.5
					}
				},
				{
					filename = '__nauvis-melange__/graphics/entity/drying-rig/drying-rig-shadow.png',
					priority = 'high',
					width = 210,
					height = 176,
					shift = util.by_pixel(0, 6),
					draw_as_shadow = true,
					hr_version = {
						filename = '__nauvis-melange__/graphics/entity/drying-rig/hr-drying-rig-shadow.png',
						priority = 'high',
						width = 420,
						height = 352,
						shift = util.by_pixel(0, 6),
						draw_as_shadow = true,
						scale = 0.5
					}
				}
			}
		},
		open_sound = sounds.machine_open,
		close_sound = sounds.machine_close,
		vehicle_impact_sound = sounds.generic_impact,
		working_sound = {
		  sound = {
				{
					filename = '__base__/sound/assembling-machine-t1-1.ogg',
					volume = 0.5
				},
			},
		}
	},
	{
		type = 'sticker',
		name = 'spice-speed-sticker',
		duration_in_ticks = 60 * 60,
		target_movement_modifier = 2
	},
	-- negative damage, aka healing for stickers doesnt work in 1.0.0, should be fixed in next release
	{
		type = 'sticker',
		name = 'spice-regen-sticker',
		duration_in_ticks = 60 * 60,
		damage_per_tick = {type = 'physical', amount = -10},
		damage_interval = 30
	},
	{
		type = 'sticker',
		name = 'spice-vehicle-regen-sticker',
		duration_in_ticks = 60 * 60,
		damage_per_tick = {type = 'physical', amount = -1000},
		damage_interval = 30
	},
})
