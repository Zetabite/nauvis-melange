data:extend({
	{
		type = 'fluid',
		name = 'spice-gas',
		default_temperature = 15,
		max_temperature = 100,
		heat_capacity = '0.1KJ',
		base_color = {r=0.87, g=0.56, b=0.01},
		flow_color = {r=0.7, g=0.7, b=0.7},
		icon = '__nauvis-melange__/graphics/icons/fluid/spice-gas.png',
		icon_size = 64, icon_mipmaps = 4,
		order = 'a[gas]-a[spice-gas]'
	},
})