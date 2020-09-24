data:extend({
	{
		type = 'capsule',
		name = 'spice',
		icon = '__nauvis-melange__/graphics/icons/spice.png',
		icon_size = 64, icon_mipmaps = 4,
		capsule_action = {
			type = 'use-on-self',
			attack_parameters = {
				type = 'projectile',
				ammo_category = 'capsule',
				cooldown = 60 * 300,
				range = 0,
				sound = {
					{
						filename = '__base__/sound/fight/pulse.ogg',
						volume = 1.0
					},
				},
				ammo_type = {
					category = 'capsule',
					target_type = 'position',
					action = {
						{
							type = 'direct',
							action_delivery = {
								type = 'instant',
								target_effects = {
									{
										type = 'damage',
										damage = {type = 'physical', amount = -50}
									},
									{
										type = 'create-sticker',
										sticker = 'spice-speed-sticker'
									},
									{
										type = 'create-sticker',
										sticker = 'spice-regen-sticker'
									},
									{
										type = "play-sound",
										sound = {
											{
												filename = '__base__/sound/heartbeat.ogg',
												volume = 1.0
											}
										},
									 },
								}
							}
						},
					}
				}
			}
		},
		subgroup = 'intermediate-product',
		order = 'b[spice]',
		stack_size = 50
	},
})