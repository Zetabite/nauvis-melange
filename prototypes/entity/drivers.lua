local no_animation = {
    layers = {
        {
            filename = '__nauvis-melange__/graphics/blank.png',
            width = 1,
            height = 1,
            frame_count = 1,
            direction_count = 18
        }
    }
}

data:extend({
    {
        type = 'character',
        name = 'nm-driver',
        icon = '__nauvis-melange__/graphics/icons/blank.png',
        icon_size = 64, icon_mipmaps = 4,
        flags = {
            'placeable-off-grid',
            'not-repairable',
            'not-on-map',
            'not-flammable',
            'no-copy-paste',
            'not-in-kill-statistics',
            'not-selectable-in-game'
        },
        max_health = 250,
        alert_when_damaged = false,
        healing_per_tick = 0.15,
        hit_visualization_box = {{-0.2, -1.1}, {0.2, 0.2}},
        inventory_size = 0,
        build_distance = 10,
        drop_item_distance = 10,
        reach_distance = 10,
        item_pickup_distance = 1,
        loot_pickup_distance = 2,
        enter_vehicle_distance = 3,
        reach_resource_distance = 2.7,
        ticks_to_keep_gun = 600,
        ticks_to_keep_aiming_direction = 100,
        ticks_to_stay_in_combat = 600,
        damage_hit_tint = {r = 0, g = 0, b = 0, a = 0},
        running_speed = 0.15,
        distance_per_frame = 0.13,
        maximum_corner_sliding_distance = 0.7,
        eat = {
          {
            filename = '__base__/sound/eat.ogg',
            volume = 0
          }
        },
        heartbeat =
        {
          {
            filename = '__base__/sound/heartbeat.ogg',
            volume = 0
          }
        },
        animations = {
            {
                idle = no_animation,
                idle_with_gun = no_animation,
                mining_with_tool = no_animation,
                running_with_gun = no_animation,
                running = no_animation
            }
        },
        mining_speed = 0,
        mining_with_tool_particles_animation_positions = {0},
        running_sound_animation_positions = {0},
    }
})
