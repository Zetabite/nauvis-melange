local hit_effects = require ('__base__.prototypes.entity.demo-hit-effects')
local sounds = require('__base__.prototypes.entity.demo-sounds')
local blank = {
	filename = '__nauvis-melange__/graphics/blank.png',
	priority = 'very-low',
	width = 64,
	height = 64,
}

function spacing_guild_fluid_box(production_type, position)
	local base_level = {['input'] = -1, ['output'] = 1}
	return {
		filter = 'spice-gas',
		production_type = production_type,
		--pipe_picture = assembler3pipepictures(),
		pipe_covers = pipecoverspictures(),
		base_area = 10,
		base_level = base_level[production_type],
		pipe_connections = {{ type=production_type, position = position }},
		--secondary_draw_orders = { north = -1 }
	}
end

function spacing_guild_picture(version)
	return {
		layers = {
			{
				filename = '__nauvis-melange__/graphics/entity/spacing-guild/spacing-guild-'..version..'.png',
				priority = 'high',
				width = 110,
				height = 108,
				frame_count = 1,
				shift = util.by_pixel(0, 4),
				hr_version = {
					filename = '__nauvis-melange__/graphics/entity/spacing-guild/hr-spacing-guild-'..version..'.png',
					priority = 'high',
					width = 219,
					height = 215,
					frame_count = 1,
					shift = util.by_pixel(-0.25, 3.75),
					scale = 0.5
				}
			},
			{
				filename = '__nauvis-melange__/graphics/entity/spacing-guild/spacing-guild-shadow.png',
				priority = 'high',
				width = 122,
				height = 68,
				shift = util.by_pixel(13, 11),
				draw_as_shadow = true,
				hr_version = {
					filename = '__nauvis-melange__/graphics/entity/spacing-guild/hr-spacing-guild-shadow.png',
					priority = 'high',
					width = 243,
					height = 136,
					shift = util.by_pixel(13, 11),
					draw_as_shadow = true,
					scale = 0.5
				}
			},
			--[[
			{
				filename = '__nauvis-melange__/graphics/entity/spacing-guild/hr-spacing-guild-'..version..'-shadow.png',
				priority = 'high',
				width = 146,
				height = 77,
				shift = util.by_pixel(30, 22.5),
				draw_as_shadow = true,
				hr_version = {
					filename = '__nauvis-melange__/graphics/entity/spacing-guild/hr-spacing-guild-'..version..'-shadow.png',
					priority = 'high',
					width = 291,
					height = 153,
					shift = util.by_pixel(29.75, 22.25),
					draw_as_shadow = true,
					scale = 0.5
				}
			}
			--]]
		}
	}
end

data:extend({
	{
		type = 'mining-drill',
		name = 'water-injector-proxy',
		localised_name = {'entity-name.water-injector'},
		localised_description = {'entity-description.water-injector'},
		icon = '__nauvis-melange__/graphics/icons/water-injector.png',
		icon_size = 64, icon_mipmaps = 4,
		collision_box = {{ -1.2, -1.2}, {1.2, 1.2}},
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
		type = 'assembling-machine',
		name = 'alien-growth-chamber',
		icon = '__nauvis-melange__/graphics/icons/alien-growth-chamber.png',
		icon_size = 64, icon_mipmaps = 4,
		flags = {'placeable-neutral', 'placeable-player', 'player-creation'},
		minable = {mining_time = 0.1, result = 'alien-growth-chamber'},
		max_health = 200,
		corpse = 'alien-growth-chamber-remnants',
		dying_explosion = 'assembling-machine-1-explosion',
		collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
		selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
		damaged_trigger_effect = hit_effects.entity(),
		energy_source = {
			type = 'electric',
			usage_priority = 'secondary-input'
		},
		crafting_categories = {'alien-growing'},
		energy_usage = '150kW',
		crafting_speed = 1,
		animation = {
			layers = {
				{
					filename = '__nauvis-melange__/graphics/entity/alien-growth-chamber/alien-growth-chamber.png',
					priority = 'high',
					width = 91,
					height = 96,
					frame_count = 1,
					shift = util.by_pixel(-6, -6),
					hr_version = {
						filename = '__nauvis-melange__/graphics/entity/alien-growth-chamber/hr-alien-growth-chamber.png',
						priority = 'high',
						width = 181,
						height = 191,
						frame_count = 1,
						shift = util.by_pixel(-5, -7),
						scale = 0.5
					}
				},
				{
					filename = '__nauvis-melange__/graphics/entity/alien-growth-chamber/alien-growth-chamber-shadow.png',
					priority = 'high',
					width = 158,
					height = 97,
					shift = { 1.625 , 0 },
					draw_as_shadow = true,
					hr_version = {
						filename = '__nauvis-melange__/graphics/entity/alien-growth-chamber/hr-alien-growth-chamber-shadow.png',
						priority = 'high',
						width = 315,
						height = 194,
						shift = { 1.625, 0 },
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
		type = 'radar',
		name = 'spice-radar',
		icon = '__nauvis-melange__/graphics/blank.png',
		icon_size = 64,
		collision_mask = {},
		energy_usage = '200kW',
		energy_per_nearby_scan = '0.1kJ',
		energy_per_sector = '0.1kJ',
		energy_source = {
			type = 'void'
		},
		max_distance_of_nearby_sector_revealed = 3,
		max_distance_of_sector_revealed = 10,
		pictures = {
			filename = '__nauvis-melange__/graphics/blank.png',
			priority = 'very-low',
			width = 64,
			height = 64,
			direction_count = 1,
		}
	},
	{
		type = 'assembling-machine',
		name = 'spacing-guild',
		icon = '__nauvis-melange__/graphics/icons/spacing-guild.png',
		icon_size = 64, icon_mipmaps = 4,
		flags = {'placeable-neutral', 'placeable-player', 'player-creation'},
		minable = {mining_time = 0.1, result = 'spacing-guild'},
		max_health = 500,
		corpse = 'lab-remnants',
		dying_explosion = 'lab-explosion',
		collision_box = {{-1.3, -1.3}, {1.3, 1.3}},
		selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
		damaged_trigger_effect = hit_effects.entity(),
		energy_source = {
			type = 'electric',
			usage_priority = 'primary-input'
		},
		fluid_usage_per_tick = 0.5,
		burns_fluid = true,
		crafting_categories = {'space-education'},
		crafting_speed = 1,
		energy_usage = '150kW',
		--[[
        { position = {-1, -2} },
        { position = {2, 1} },
        { position = {1, 2} },
        { position = {-2, -1} }
		--]]
		fluid_boxes = {
			spacing_guild_fluid_box('input', {-1, -2}),
			spacing_guild_fluid_box('input', {-2, -1}),
			spacing_guild_fluid_box('output', {2, 1}),
			spacing_guild_fluid_box('output', {1, 2}),
			off_when_no_fluid_recipe = false
		},
		animation = {
			north = spacing_guild_picture(1),
			east = spacing_guild_picture(2),
			south = spacing_guild_picture(1),
			west = spacing_guild_picture(2)
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
})
