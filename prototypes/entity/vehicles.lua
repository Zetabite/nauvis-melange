require ('__base__.prototypes.entity.worm-animations')
local travel_worm_sounds = require('prototypes.entity.travel-worm-sounds')
local movement_triggers = require('__base__.prototypes.entity.movement-triggers')
local hit_effects = require ('__base__.prototypes.entity.hit-effects')
local sounds = require('__base__.prototypes.entity.sounds')

local scale_worm_small = 0.65
local tint_worm_small = {r = 0.917, g = 1.000, b = 0.282, a = 1.000}
local tank_shift_y = 6

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
    --[[
    {
        type = 'car',
        name = 'nm-d-u-n-e', -- Deison United - Newton Extractor
        icon = '__base__/graphics/icons/tank.png',
        icon_size = 64, icon_mipmaps = 4,
        flags = {'placeable-neutral', 'player-creation', 'placeable-off-grid', 'not-flammable'},
        minable = {mining_time = 0.5, result = 'tank'},
        mined_sound = {filename = '__core__/sound/deconstruct-large.ogg',volume = 0.8},
        max_health = 2000,
        corpse = 'tank-remnants',
        dying_explosion = 'tank-explosion',
        alert_icon_shift = util.by_pixel(0, -13),
        immune_to_tree_impacts = true,
        immune_to_rock_impacts = true,
        energy_per_hit_point = 0.5,
        resistances = {},
        collision_box = {{-0.9, -1.3}, {0.9, 1.3}},
        selection_box = {{-0.9, -1.3}, {0.9, 1.3}},
        damaged_trigger_effect = hit_effects.entity(),
        drawing_box = {{-1.8, -1.8}, {1.8, 1.5}},
        effectivity = 0.9,
        braking_power = '800kW',
        burner =
        {
          fuel_category = 'chemical',
          effectivity = 1,
          fuel_inventory_size = 2,
          smoke =
          {
            {
              name = 'tank-smoke',
              deviation = {0.25, 0.25},
              frequency = 50,
              position = {0, 1.5},
              starting_frame = 0,
              starting_frame_deviation = 60
            }
          }
        },
        consumption = '600kW',
        terrain_friction_modifier = 0.2,
        friction = 0.002,
        light =
        {
          {
            type = 'oriented',
            minimum_darkness = 0.3,
            picture =
            {
              filename = '__core__/graphics/light-cone.png',
              priority = 'extra-high',
              flags = { 'light' },
              scale = 2,
              width = 200,
              height = 200
            },
            shift = {-0.1, -14 + tank_shift_y / 32},
            size = 2,
            intensity = 0.8,
            color = {r = 1.0, g = 1.0, b = 0.8},
            source_orientation_offset = -0.02
          },
          {
            type = 'oriented',
            minimum_darkness = 0.3,
            picture =
            {
              filename = '__core__/graphics/light-cone.png',
              priority = 'extra-high',
              flags = { 'light' },
              scale = 2,
              width = 200,
              height = 200
            },
            shift = {0.1, -14 + tank_shift_y / 32},
            size = 2,
            intensity = 0.8,
            color = {r = 1.0, g = 1.0, b = 0.8},
            source_orientation_offset = 0.02
          }
        },
        light_animation =
        {
          filename = '__base__/graphics/entity/tank/tank-light.png',
          priority = 'low',
          blend_mode = 'additive',
          draw_as_glow = true,
          width = 132,
          height = 108,
          line_length = 8,
          direction_count = 64,
          shift = util.by_pixel(-2, -18 + 6),
          repeat_count = 2,
          hr_version =
          {
            filename = '__base__/graphics/entity/tank/hr-tank-light.png',
            priority = 'low',
            blend_mode = 'additive',
            draw_as_glow = true,
            width = 260,
            height = 210,
            line_length = 8,
            direction_count = 64,
            scale = 0.5,
            shift = util.by_pixel(-1, -17 + 6),
            repeat_count = 2,
          }
        },
        animation =
        {
          layers =
          {
            {
              priority = 'low',
              width = 136,
              height = 106,
              frame_count = 2,
              direction_count = 64,
              shift = util.by_pixel(0, -16 + tank_shift_y),
              animation_speed = 8,
              max_advance = 1,
              stripes =
              {
                {
                 filename = '__base__/graphics/entity/tank/tank-base-1.png',
                 width_in_frames = 2,
                 height_in_frames = 16
                },
                {
                 filename = '__base__/graphics/entity/tank/tank-base-2.png',
                 width_in_frames = 2,
                 height_in_frames = 16
                },
                {
                 filename = '__base__/graphics/entity/tank/tank-base-3.png',
                 width_in_frames = 2,
                 height_in_frames = 16
                },
                {
                 filename = '__base__/graphics/entity/tank/tank-base-4.png',
                 width_in_frames = 2,
                 height_in_frames = 16
                }
              },
              hr_version =
              {
                priority = 'low',
                width = 270,
                height = 212,
                frame_count = 2,
                direction_count = 64,
                shift = util.by_pixel(0, -16 + tank_shift_y),
                animation_speed = 8,
                max_advance = 1,
                stripes =
                {
                  {
                   filename = '__base__/graphics/entity/tank/hr-tank-base-1.png',
                   width_in_frames = 2,
                   height_in_frames = 16
                  },
                  {
                   filename = '__base__/graphics/entity/tank/hr-tank-base-2.png',
                   width_in_frames = 2,
                   height_in_frames = 16
                  },
                  {
                   filename = '__base__/graphics/entity/tank/hr-tank-base-3.png',
                   width_in_frames = 2,
                   height_in_frames = 16
                  },
                  {
                   filename = '__base__/graphics/entity/tank/hr-tank-base-4.png',
                   width_in_frames = 2,
                   height_in_frames = 16
                  }
                },
                scale = 0.5
              }
            },
            {
              priority = 'low',
              width = 104,
              height = 83,
              frame_count = 2,
              apply_runtime_tint = true,
              direction_count = 64,
              shift = util.by_pixel(0, -27.5 + tank_shift_y),
              max_advance = 1,
              line_length = 2,
              stripes = util.multiplystripes(2,
              {
                {
                  filename = '__base__/graphics/entity/tank/tank-base-mask-1.png',
                  width_in_frames = 1,
                  height_in_frames = 22
                },
                {
                  filename = '__base__/graphics/entity/tank/tank-base-mask-2.png',
                  width_in_frames = 1,
                  height_in_frames = 22
                },
                {
                  filename = '__base__/graphics/entity/tank/tank-base-mask-3.png',
                  width_in_frames = 1,
                  height_in_frames = 20
                }
              }),
              hr_version =
              {
                priority = 'low',
                width = 208,
                height = 166,
                frame_count = 2,
                apply_runtime_tint = true,
                direction_count = 64,
                shift = util.by_pixel(0, -27.5 + tank_shift_y),
                max_advance = 1,
                line_length = 2,
                stripes = util.multiplystripes(2,
                {
                  {
                    filename = '__base__/graphics/entity/tank/hr-tank-base-mask-1.png',
                    width_in_frames = 1,
                    height_in_frames = 22
                  },
                  {
                    filename = '__base__/graphics/entity/tank/hr-tank-base-mask-2.png',
                    width_in_frames = 1,
                    height_in_frames = 22
                  },
                  {
                    filename = '__base__/graphics/entity/tank/hr-tank-base-mask-3.png',
                    width_in_frames = 1,
                    height_in_frames = 20
                  }
                }),
                scale = 0.5
              }
            },
            {
              priority = 'low',
              width = 151,
              height = 98,
              frame_count = 2,
              draw_as_shadow = true,
              direction_count = 64,
              shift = util.by_pixel(22.5, 1 + tank_shift_y),
              max_advance = 1,
              stripes = util.multiplystripes(2,
              {
               {
                filename = '__base__/graphics/entity/tank/tank-base-shadow-1.png',
                width_in_frames = 1,
                height_in_frames = 16
               },
               {
                filename = '__base__/graphics/entity/tank/tank-base-shadow-2.png',
                width_in_frames = 1,
                height_in_frames = 16
               },
               {
                filename = '__base__/graphics/entity/tank/tank-base-shadow-3.png',
                width_in_frames = 1,
                height_in_frames = 16
               },
               {
                filename = '__base__/graphics/entity/tank/tank-base-shadow-4.png',
                width_in_frames = 1,
                height_in_frames = 16
               }
              }),
              hr_version =
              {
                priority = 'low',
                width = 302,
                height = 194,
                frame_count = 2,
                draw_as_shadow = true,
                direction_count = 64,
                shift = util.by_pixel(22.5, 1 + tank_shift_y),
                max_advance = 1,
                stripes = util.multiplystripes(2,
                {
                 {
                  filename = '__base__/graphics/entity/tank/hr-tank-base-shadow-1.png',
                  width_in_frames = 1,
                  height_in_frames = 16
                 },
                 {
                  filename = '__base__/graphics/entity/tank/hr-tank-base-shadow-2.png',
                  width_in_frames = 1,
                  height_in_frames = 16
                 },
                 {
                  filename = '__base__/graphics/entity/tank/hr-tank-base-shadow-3.png',
                  width_in_frames = 1,
                  height_in_frames = 16
                 },
                 {
                  filename = '__base__/graphics/entity/tank/hr-tank-base-shadow-4.png',
                  width_in_frames = 1,
                  height_in_frames = 16
                 }
                }),
                scale = 0.5
              }
            }
          }
        },
        turret_rotation_speed = 0,
        turret_return_timeout = 0,
        sound_no_fuel =
        {
          {
            filename = '__base__/sound/fight/tank-no-fuel-1.ogg',
            volume = 0.4
          }
        },
        sound_minimum_speed = 0.2,
        sound_scaling_ratio = 0.8,
        vehicle_impact_sound = sounds.generic_impact,
        working_sound =
        {
          sound =
          {
            filename = '__base__/sound/fight/tank-engine.ogg',
            volume = 0.37
          },
          activate_sound =
          {
            filename = '__base__/sound/fight/tank-engine-start.ogg',
            volume = 0.37
          },
          deactivate_sound =
          {
            filename = '__base__/sound/fight/tank-engine-stop.ogg',
            volume = 0.37
          },
          match_speed_to_activity = true
        },
        stop_trigger_speed = 0.1,
        stop_trigger =
        {
          {
            type = 'play-sound',
            sound =
            {
              {
                filename = '__base__/sound/fight/tank-brakes.ogg',
                volume = 0.3
              }
            }
          }
        },
        open_sound = { filename = '__base__/sound/fight/tank-door-open.ogg', volume=0.48 },
        close_sound = { filename = '__base__/sound/fight/tank-door-close.ogg', volume = 0.43 },
        rotation_speed = 0.0035,
        tank_driving = true,
        weight = 20000,
        inventory_size = 80,
        track_particle_triggers = movement_triggers.tank,
        guns = {},
        water_reflection = {
            pictures = {
                filename = '__base__/graphics/entity/car/car-reflection.png',
                priority = 'extra-high',
                width = 20,
                height = 24,
                shift = util.by_pixel(0, 35),
                variation_count = 1,
                scale = 5 * 1.2
            },
            rotate = true,
            orientation_to_variation = false
        }
    }
    ]]
})
