require ('__base__.prototypes.entity.worm-animations')
local travel_worm_sounds = require('prototypes.entity.travel-worm-sounds')
local scale_worm_small = 0.65
local tint_worm_small = {r = 0.917, g = 1.000, b = 0.282, a = 1.000}
local hit_effects = require ('__base__.prototypes.entity.hit-effects')

data:extend({
    {
        type = 'car',
        name = 'nm-travel-worm',
        icon = '__nauvis-melange__/graphics/icons/travel-worm.png',
        icon_size = 64, icon_mipmaps = 4,
        flags = {'placeable-neutral', 'player-creation', 'placeable-off-grid', 'not-flammable'},
        minable = {mining_time = 0.4, result = 'nm-travel-worm'},
        mined_sound = travel_worm_sounds.mined,
        max_health = 200,
        corpse = 'small-worm-corpse',
           dying_explosion = 'small-worm-die',
        alert_icon_shift = util.by_pixel(0, -13),
        energy_per_hit_point = 1,
        crash_trigger = crash_trigger(),
        resistances = {},
        collision_box = {{-0.9, -1.5 }, {0.9, 0.8}},
        selection_box = {{-0.9, -1.5 }, {0.9, 0.8}},
        damaged_trigger_effect = hit_effects.entity(),
        effectivity = 0.5,
        braking_power = '400kW',
        consumption = '50kW',
        terrain_friction_modifier = 0.2,
        friction = 0.002,
        render_layer = 'object',
        animation = worm_start_attack_animation(scale_worm_small, tint_worm_small),
        energy_source = {
            type = 'void'
        },
        working_sound = {
            sound = travel_worm_sounds.working,
            activate_sound = travel_worm_sounds.starting,
            --deactivate_sound = travel_worm_sounds.stopping,
            idle_sound = travel_worm_sounds.idling,
            match_speed_to_activity = true
        },
        stop_trigger_speed = 0.15,
        stop_trigger = {
            {
                type = 'play-sound',
                sound = travel_worm_sounds.stopping
            }
        },
        sound_minimum_speed = 0.25,
        vehicle_impact_sound = travel_worm_sounds.impact,
        open_sound = travel_worm_sounds.slimy,
        close_sound = travel_worm_sounds.slimy,
        rotation_speed = 0.025,
        weight = 700,
        turret_rotation_speed = 0,
        turret_return_timeout = 0,
        --guns = { 'travel-worm-gun' },
        guns = {},
        inventory_size = 0,
    },
})
