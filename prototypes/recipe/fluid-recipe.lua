data:extend({
	{
		type = 'recipe',
		name = 'spice-gas',
		localised_name = {'fluid-name.spice-gas'},
		localised_description = {'fluid-description.spice-gas'},
		category = 'chemistry',
		energy_required = 4,
		enabled = false,
		ingredients = {
			{ type = 'item', name = 'spice', amount = 20 },
			{ type = 'fluid', name = 'water', amount = 10 },
		},
		results = {
    		{ type = 'fluid', name = 'spice-gas', amount = 22 }
		},
		subgroup = 'fluid-recipes',
	}
})
