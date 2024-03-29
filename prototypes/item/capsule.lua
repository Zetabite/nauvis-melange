local config = require('scripts.config')

local SPICE_COOLDOWN = config.SPICE_COOLDOWN

data:extend({
    {
        type = 'capsule',
        name = 'nm-spice',
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
        order = 'd[nm-spice]',
        stack_size = 100
    },
    {
        type = 'capsule',
        name = 'nm-alien-probe',
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
                            projectile = 'nm-alien-probe-projectile',
                            starting_speed = 0.5
                        }
                    }
                }
            }
        },
        subgroup = 'nm-alien-breeding',
        order = 'd[nm-alien-probe]',
        stack_size = 50
    },
    {
        type = 'capsule',
        name = 'nm-thumper',
        icon = '__nauvis-melange__/graphics/icons/thumper.png',
        icon_size = 64, icon_mipmaps = 4,
        capsule_action = {
            type = 'use-on-self',
            uses_stack = false,
            attack_parameters = {
                type = 'projectile',
                ammo_type = {
                    category = 'capsule',
                    target_type = 'position'
                },
                cooldown = 20,
                range = 5,
                sound = {
                    {
                        filename = '__base__/sound/heartbeat.ogg',
                        volume = 0.75
                    }
                }
            }
        },
        subgroup = 'nm-alien-breeding',
        order = 'd[nm-thumper]',
        stack_size = 1
    },
    {
        type = 'capsule',
        name = 'nm-thumper-creative',
        icon = '__nauvis-melange__/graphics/icons/thumper.png',
        icon_size = 64, icon_mipmaps = 4,
        capsule_action = {
            type = 'throw',
            uses_stack = false,
            attack_parameters = {
                type = 'projectile',
                ammo_type = {
                    category = 'capsule',
                    target_type = 'position'
                },
                cooldown = 20,
                range = 5,
                --[[
                sound = {
                    {
                        filename = '__base__/sound/heartbeat.ogg',
                        volume = 0.75
                    }
                }
                ]]
            }
        },
        subgroup = 'nm-alien-breeding',
        order = 'd[nm-thumper-creative]',
        stack_size = 1
    }
})
