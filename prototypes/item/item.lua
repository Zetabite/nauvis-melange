data:extend({
	-- Entities
	{
		type = 'item',
		name = 'water-injector-proxy',
		localised_name = {'entity-name.water-injector'},
		localised_description = {'entity-description.water-injector'},
		icon = '__nauvis-melange__/graphics/icons/water-injector.png',
		icon_size = 64, icon_mipmaps = 4,
		subgroup = 'extraction-machine',
		order = 'b[water-injector]',
		place_result = 'water-injector-proxy',
		stack_size = 50
	},
	{
		type = 'item',
		name = 'alien-growth-chamber',
		localised_name = {'entity-name.alien-growth-chamber'},
		localised_description = {'entity-description.alien-growth-chamber'},
		icon = '__nauvis-melange__/graphics/icons/alien-growth-chamber.png',
		icon_size = 64, icon_mipmaps = 4,
		subgroup = 'production-machine',
		place_result = 'alien-growth-chamber',
		stack_size = 50
	},
	{
		type = 'item',
		name = 'spacing-guild',
		localised_name = {'entity-name.spacing-guild'},
		localised_description = {'entity-description.spacing-guild'},
		icon = '__nauvis-melange__/graphics/icons/spacing-guild.png',
		icon_size = 64, icon_mipmaps = 4,
		subgroup = 'production-machine',
		place_result = 'spacing-guild',
		stack_size = 50
	},
	{
		type = 'item',
		name = 'drying-rig',
		localised_name = {'entity-name.drying-rig'},
		localised_description = {'entity-description.drying-rig'},
		icon = '__nauvis-melange__/graphics/icons/drying-rig.png',
		icon_size = 64, icon_mipmaps = 4,
		subgroup = 'production-machine',
		order = 'a[drying-rig]',
		place_result = 'drying-rig',
		stack_size = 50
	},
	{
		type = 'item-with-entity-data',
		name = 'travel-worm',
		localised_name = {'entity-name.travel-worm'},
		localised_description = {'entity-description.travel-worm'},
		icon = '__nauvis-melange__/graphics/icons/travel-worm.png',
		icon_size = 64, icon_mipmaps = 4,
		subgroup = 'transport',
		order = 'b[personal-transport]-a[travel-worm]',
		place_result = 'travel-worm',
		stack_size = 1
	},

	-- Items
	{
		type = 'item',
		name = 'solar-component-foil',
		icon = '__nauvis-melange__/graphics/icons/solar-component-foil.png',
		icon_size = 64, icon_mipmaps = 4,
		subgroup = 'intermediate-product',
		order = 'd[solar-component-foil]',
		stack_size = 200
	},
	--[[
	{
		type = 'item',
		name = 'solar-drying-panel',
		icon = '__nauvis-melange__/graphics/icons/solar-drying-panel.png',
		icon_size = 64, icon_mipmaps = 4,
		subgroup = 'intermediate-product',
		order = 'a[solar-drying-panel]',
		stack_size = 20
	},
	--]]
	{
		type = 'item',
		name = 'biter-navigator',
		icons =  {
			{
				icon = '__nauvis-melange__/graphics/icons/navigator.png',
				icon_size = 64, icon_mipmaps = 4,
			},
			{
				icon = '__nauvis-melange__/graphics/icons/biter-overlay.png',
				icon_size = 64, icon_mipmaps = 4,
			},
		},
		subgroup = 'intermediate-product',
		stack_size = 50
	},
	{
		type = 'item',
		name = 'fish-navigator',
		icons =  {
			{
				icon = '__nauvis-melange__/graphics/icons/navigator.png',
				icon_size = 64, icon_mipmaps = 4,
			},
			{
				icon = '__nauvis-melange__/graphics/icons/fish-overlay.png',
				icon_size = 64, icon_mipmaps = 4,
			},
		},
		subgroup = 'intermediate-product',
		stack_size = 50
	},
	--[[
	{
		type = 'item',
		name = 'thumper',
		localised_name = {'entity-name.thumper'},
		localised_description = {'entity-description.thumper'},
		icon = '__nauvis-melange__/graphics/icons/drying-rig.png',
		icon_size = 64, icon_mipmaps = 4,
		subgroup = 'intermediate-product',
		place_result = 'thumper',
		stack_size = 50
	},
	--]]
	{
		type = 'item',
		name = 'pre-spice-mass',
		icon = '__nauvis-melange__/graphics/icons/pre-spice-mass.png',
		icon_size = 64, icon_mipmaps = 4,
		subgroup = 'raw-resource',
		order = 'b[pre-spice-mass]',
		stack_size = 100
	},
	{
		type = 'item',
		name = 'sandtrout',
		icons =  {
			{
				icon = '__nauvis-melange__/graphics/icons/leech.png',
				icon_size = 64, icon_mipmaps = 4,
			},
			{
				icon = '__nauvis-melange__/graphics/icons/worm-overlay.png',
				icon_size = 64, icon_mipmaps = 4,
			},
		},
		subgroup = 'alien-breeding',
		order = 'b[sandtrout]',
		place_result = 'worm-hole',
		stack_size = 100
	},
	{
		type = 'item',
		name = 'biter-leech',
		icons =  {
			{
				icon = '__nauvis-melange__/graphics/icons/leech.png',
				icon_size = 64, icon_mipmaps = 4,
			},
			{
				icon = '__nauvis-melange__/graphics/icons/biter-overlay.png',
				icon_size = 64, icon_mipmaps = 4,
			},
		},
		subgroup = 'alien-breeding',
		order = 'b[biter-leech]',
		stack_size = 100
	},
	{
		type = 'item',
		name = 'worm-sample',
		icons =  {
			{
				icon = '__nauvis-melange__/graphics/icons/sample.png',
				icon_size = 64, icon_mipmaps = 4,
			},
			{
				icon = '__nauvis-melange__/graphics/icons/worm-overlay.png',
				icon_size = 64, icon_mipmaps = 4,
			},
		},
		subgroup = 'alien-breeding',
		order = 'b[worm-sample]',
		stack_size = 100
	},
	{
		type = 'item',
		name = 'biter-sample',
		icons =  {
			{
				icon = '__nauvis-melange__/graphics/icons/sample.png',
				icon_size = 64, icon_mipmaps = 4,
			},
			{
				icon = '__nauvis-melange__/graphics/icons/biter-overlay.png',
				icon_size = 64, icon_mipmaps = 4,
			},
		},
		subgroup = 'alien-breeding',
		order = 'b[biter-sample]',
		stack_size = 100
	},

	-- Misc
	{
		type = 'item',
		name = 'spice-overlay',
		icon = '__nauvis-melange__/graphics/spice-overlay.png',
		icon_size = 12,
		stack_size = 1
	}
})
