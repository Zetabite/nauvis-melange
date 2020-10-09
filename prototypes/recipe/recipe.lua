data:extend({
	-- Entities
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
		name = 'alien-growth-chamber',
		localised_name = {'entity-name.alien-growth-chamber'},
		localised_description = {'entity-description.alien-growth-chamber'},
		category = 'crafting',
		energy_required = 20,
		enabled = false,
		ingredients = {
			{ 'solar-panel', 4 },
			{ 'advanced-circuit', 4 },
			{ 'solar-component-foil', 10 },
		},
		result = 'alien-growth-chamber'
	},
	{
		type = 'recipe',
		name = 'travel-worm',
		localised_name = {'entity-name.travel-worm'},
		localised_description = {'entity-description.travel-worm'},
		category = 'alien-growing',
		energy_required = 120,
		enabled = false,
		ingredients = {
			{ 'sandtrout', 1 },
			{ 'spice', 50 }
		},
		result = 'travel-worm'
	},
	{
		type = 'recipe',
		name = 'spacing-guild',
		localised_name = {'entity-name.spacing-guild'},
		localised_description = {'entity-description.spacing-guild'},
		category = 'crafting',
		energy_required = 20,
		enabled = false,
		ingredients = {
			{ 'spice', 40 },
			{ 'pipe', 20 },
			{ 'advanced-circuit', 20 },
			{ 'steel-plate', 20 },
		},
		result = 'spacing-guild'
	},

	-- Items
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
	{
		type = 'recipe',
		name = 'sandtrout',
		localised_name = {'item-name.sandtrout'},
		localised_description = {'item-description.sandtrout'},
		category = 'alien-growing',
		energy_required = 60,
		enabled = false,
		ingredients = {
			{ 'pre-spice-mass', 20 },
			{ 'worm-sample', 20 }
		},
		results = {
    		{ type = 'item', name = 'sandtrout', amount = 20 }
    	},
	},
	{
		type = 'recipe',
		name = 'biter-leech',
		localised_name = {'item-name.biter-leech'},
		localised_description = {'item-description.biter-leech'},
		category = 'alien-growing',
		energy_required = 60,
		enabled = false,
		ingredients = {
			{ 'pre-spice-mass', 20 },
			{ 'biter-sample', 20 }
		},
		results = {
    		{ type = 'item', name = 'biter-leech', amount = 20 }
    	},
	},
	{
		type = 'recipe',
		name = 'alien-probe',
		localised_name = {'item-name.alien-probe'},
		localised_description = {'item-description.alien-probe'},
		category = 'crafting',
		energy_required = 4,
		enabled = false,
		ingredients = {
			{ 'iron-plate', 2 },
			{ 'iron-stick', 1 },
		},
		result = 'alien-probe'
	},
	{
		type = 'recipe',
		name = 'biter-navigator',
		localised_name = {'item-name.biter-navigator'},
		localised_description = {'item-description.biter-navigator'},
		category = 'space-education',
		energy_required = 60,
		enabled = false,
		ingredients = {
			{ type = 'item', name = 'biter-leech', amount = 1 },
			{ type = 'item', name = 'low-density-structure', amount = 10 },
			{ type = 'item', name = 'advanced-circuit', amount = 4 },
			{ type = 'fluid', name = 'spice-gas', amount = 200 },
		},
		result = 'biter-navigator'
	},
	{
		type = 'recipe',
		name = 'fish-navigator',
		localised_name = {'item-name.fish-navigator'},
		localised_description = {'item-description.fish-navigator'},
		category = 'space-education',
		energy_required = 60,
		enabled = false,
		ingredients = {
			{ type = 'item', name = 'raw-fish', amount = 1 },
			{ type = 'item', name = 'low-density-structure', amount = 10 },
			{ type = 'item', name = 'advanced-circuit', amount = 4 },
			{ type = 'fluid', name = 'spice-gas', amount = 200 },
		},
		result = 'fish-navigator'
	},
})
