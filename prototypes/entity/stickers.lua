data:extend({
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
