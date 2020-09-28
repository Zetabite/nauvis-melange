data:extend({
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
		type = 'item',
		name = 'pre-spice-mass',
		icon = '__nauvis-melange__/graphics/icons/pre-spice-mass.png',
		icon_size = 64, icon_mipmaps = 4,
		subgroup = 'raw-resource',
		order = 'b[pre-spice-mass]',
		stack_size = 100
	},
})
