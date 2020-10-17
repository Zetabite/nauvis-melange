local config = require('scripts.config')
local SPICE_COOLDOWN = config.SPICE_COOLDOWN

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
				cooldown = SPICE_COOLDOWN,
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
										type = 'play-sound',
										sound = {
											{
												filename = '__base__/sound/heartbeat.ogg',
												volume = 0.75
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
		order = 'd[spice]',
		stack_size = 100
	},
	{
		type = 'capsule',
		name = 'alien-probe',
		icon = '__nauvis-melange__/graphics/icons/sample.png',
		icon_size = 64, icon_mipmaps = 4,
		capsule_action = {
			type = 'throw',
			attack_parameters = {
				type = 'projectile',
				ammo_category = 'capsule',
				cooldown = 20,
				range = 5,
				ammo_type = {
					category = 'capsule',
					target_type = 'position',
					action = {
						type = 'direct',
						action_delivery = {
							type = 'projectile',
							projectile = 'alien-probe-projectile',
							starting_speed = 0.5
						}
					}
				}
			}
		},
		subgroup = 'alien-breeding',
		order = 'd[alien-probe]',
		stack_size = 50
	}
})
