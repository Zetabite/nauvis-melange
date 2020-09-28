data:extend({
	{
		type = 'recipe',
		name = 'water-injector-proxy',
		localised_name = {'entity-name.water-injector'},
		localised_description = {'entity-description.water-injector'},
		energy_required = 2,
		enabled = false,
		ingredients = {
			{ 'steel-plate', 5 },
			{ 'pipe', 23 }
		},
		result = 'water-injector-proxy'
	},
	{
		type = 'recipe',
		name = 'drying-rig',
		localised_name = {'entity-name.drying-rig'},
		localised_description = {'entity-description.drying-rig'},
		category = 'crafting',
		energy_required = 20,
		enabled = false,
		ingredients = {
			{ 'solar-panel', 4 },
			{ 'advanced-circuit', 4 },
			{ 'solar-component-foil', 10 },
		},
		result = 'drying-rig'
	},
	{
		type = 'recipe',
		name = 'solar-component-foil',
		localised_name = {'item-name.solar-component-foil'},
		localised_description = {'item-description.solar-component-foil'},
		category = 'crafting',
		energy_required = 10,
		enabled = false,
		ingredients = {
			{ 'copper-plate', 3 },
			{ 'plastic-bar', 2 },
			{ 'iron-plate', 3 },
		},
		results = {
    		{ type = 'item', name = 'solar-component-foil', amount = 20 }
    	},
	},
	--[[
	{
		type = 'recipe',
		name = 'solar-drying-panel',
		localised_name = {'item-name.solar-drying-panel'},
		localised_description = {'item-description.solar-drying-panel'},
		category = 'crafting',
		energy_required = 1,
		enabled = false,
		ingredients = {
			{ 'solar-panel', 1 },
		},
		result = 'drying-rig'
	},
	--]]
	{
		type = 'recipe',
		name = 'spice',
		category = 'drying',
		energy_required = 60,
		enabled = false,
		ingredients = {{ 'pre-spice-mass', 20 }},
		results = {
    		{ type = 'item', name = 'spice', amount = 20 }
    	},
	},
})
