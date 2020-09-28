data:extend({
	{
		type = 'technology',
		name = 'spice-processing',
		icon_size = 64,
		icon = '__nauvis-melange__/graphics/technology/spice-processing.png',
		prerequisites = {'solar-energy', 'oil-processing', 'advanced-electronics'},
		effects = {
			{
				type = 'unlock-recipe',
				recipe = 'drying-rig'
			},
			{
				type = 'unlock-recipe',
				recipe = 'solar-component-foil'
			},
			{
				type = 'unlock-recipe',
				recipe = 'water-injector-proxy'
			},
			{
				type = 'unlock-recipe',
				recipe = 'spice'
			},
			{
				type = 'unlock-recipe',
				recipe = 'spice-gas'
			}
		},
		unit = {
			count = 250,
			ingredients = {
				{'automation-science-pack', 1},
				{'logistic-science-pack', 1}
			},
			time = 30
		},
	},
})
