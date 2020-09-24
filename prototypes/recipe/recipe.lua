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
		energy_required = 4,
		enabled = false,
		ingredients = {
			{ 'steel-plate', 5 },
			{ 'electronic-circuit', 15 },
			{ 'copper-plate', 5 }
		},
		result = 'drying-rig'
	},
	{
		type = 'recipe',
		name = 'drying-rig',
		localised_name = {'entity-name.drying-rig'},
		localised_description = {'entity-description.drying-rig'},
		category = 'crafting',
		energy_required = 1,
		enabled = false,
		ingredients = {
			{ 'solar-panel', 5 },
		},
		result = 'drying-rig'
	},
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
