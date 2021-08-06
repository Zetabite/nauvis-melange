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
    }
})
