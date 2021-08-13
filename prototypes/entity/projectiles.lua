data:extend({
    {
        type = 'projectile',
        name = 'nm-alien-probe-projectile',
        icon = '__nauvis-melange__/graphics/icons/blank.png',
        icon_size = 64,
        flags = {'not-on-map'},
        acceleration = 0.005,
        action = {
            type = 'direct',
            action_delivery = {
                type = 'instant',
                target_effects = {
                    {
                        type = 'create-entity',
                        show_in_tooltip = false,
                        entity_name = 'nm-alien-probe-proxy',
                        trigger_created_entity = 'true',
                    }
                }
            }
        }
    },
    {
        type = 'projectile',
        name = 'nm-water-injector-explosion',
        flags = {'not-on-map'},
        acceleration = 0.005,
        turn_speed = 0.003,
        turning_speed_increases_exponentially_with_projectile_speed = true,
        action =
        {
          type = 'direct',
          action_delivery =
          {
            type = 'instant',
            target_effects =
            {
              {
                type = 'create-entity',
                entity_name = 'big-explosion'
              },
              {
                type = 'damage',
                damage = {amount = 50, type = 'explosion'}
              },
              {
                type = 'invoke-tile-trigger',
                repeat_count = 1
              },
              {
                type = 'destroy-decoratives',
                from_render_layer = 'decorative',
                to_render_layer = 'object',
                include_soft_decoratives = true, -- soft decoratives are decoratives with grows_through_rail_path = true
                include_decals = false,
                invoke_decorative_trigger = true,
                decoratives_with_trigger_only = false, -- if true, destroys only decoratives that have trigger_effect set
                radius = 3.5 -- large radius for demostrative purposes
              },
              {
                type = 'nested-result',
                action =
                {
                  type = 'area',
                  radius = 6.5,
                  action_delivery =
                  {
                    type = 'instant',
                    target_effects =
                    {
                      {
                        type = 'damage',
                        damage = {amount = 100, type = 'explosion'}
                      },
                      {
                        type = 'create-entity',
                        entity_name = 'explosion'
                      }
                    }
                  }
                }
              }
            }
          }
        },
        --light = {intensity = 0.5, size = 4},
        smoke =
        {
          {
            name = 'smoke-fast',
            deviation = {0.15, 0.15},
            frequency = 1,
            position = {0, 1},
            slow_down_factor = 1,
            starting_frame = 3,
            starting_frame_deviation = 5,
            starting_frame_speed = 0,
            starting_frame_speed_deviation = 5
          }
        }
    }
})
