require ('__base__.prototypes.entity.worm-animations')
local travel_worm_sounds = require('prototypes.entity.travel-worm-sounds')
local range_worm_small = 25
local damage_modifier_worm_small = 36
local scale_worm_small = 0.65
local scale_worm_stream = 15

data:extend({
    {
        type = 'gun',
        name = 'nm-travel-worm-gun',
        icon = '__base__/graphics/icons/small-worm.png',
        icon_size = 64, icon_mipmaps = 4,
        flags = {'hidden'},
        attack_parameters = {
            type = 'stream',
            cooldown = 4,
            range = range_worm_small,--defined in demo-spitter-projectiles.lua
            damage_modifier = damage_modifier_worm_small,--defined in demo-spitter-projectiles.lua
            min_range = 0,
            projectile_creation_parameters = worm_shoot_shiftings(scale_worm_small, scale_worm_small * scale_worm_stream),
            use_shooter_direction = true,
            lead_target_for_projectile_speed = 0.2* 0.75 * 1.5 *1.5, -- this is same as particle horizontal speed of flamethrower fire stream
            ammo_type = {
                category = 'nm-spiced',
                action = {
                    type = 'direct',
                    action_delivery = {
                        type = 'stream',
                        stream = 'acid-stream-worm-small',
                        source_offset = {0.15, -0.5}
                    }
                }
            },
            cyclic_sound = travel_worm_sounds.attacking,
        },
        stack_size = 1
    }
})
