data:extend({
    {
        type = 'technology',
        name = 'nm-spice-processing',
        icon_size = 64,
        icon = '__nauvis-melange__/graphics/technology/spice-processing.png',
        prerequisites = {'solar-energy', 'oil-processing', 'advanced-electronics'},
        effects = {
            {
                type = 'unlock-recipe',
                recipe = 'nm-drying-rig'
            },
            {
                type = 'unlock-recipe',
                recipe = 'nm-solar-component-foil'
            },
            {
                type = 'unlock-recipe',
                recipe = 'nm-water-injector-proxy'
            },
            {
                type = 'unlock-recipe',
                recipe = 'nm-spice'
            },
            {
                type = 'unlock-recipe',
                recipe = 'nm-spice-gas'
            }
        },
        unit = {
            count = 250,
            ingredients = {
                {'automation-science-pack', 1},
                {'logistic-science-pack', 1}
            },
            time = 30
        },
    },
    {
        type = 'technology',
        name = 'nm-alien-breeding',
        icon_size = 64,
        icon = '__nauvis-melange__/graphics/technology/alien-breeding.png',
        prerequisites = {'nm-spice-processing'},
        effects = {
            {
                type = 'unlock-recipe',
                recipe = 'nm-alien-growth-chamber'
            },
            {
                type = 'unlock-recipe',
                recipe = 'nm-alien-probe'
            },
            {
                type = 'unlock-recipe',
                recipe = 'nm-biter-leech'
            },
            {
                type = 'unlock-recipe',
                recipe = 'nm-sandtrout'
            },
            {
                type = 'unlock-recipe',
                recipe = 'nm-travel-worm'
            },
        },
        unit = {
            count = 250,
            ingredients = {
                {'automation-science-pack', 1},
                {'logistic-science-pack', 1}
            },
            time = 30
        },
    },
    {
        type = 'technology',
        name = 'nm-spacing-guild',
        icon_size = 128,
        icon = '__nauvis-melange__/graphics/technology/spacing-guild.png',
        prerequisites = {'nm-spice-processing', 'nm-alien-breeding'},
        effects = {
            {
                type = 'unlock-recipe',
                recipe = 'nm-biter-navigator'
            },
            {
                type = 'unlock-recipe',
                recipe = 'nm-fish-navigator'
            },
            {
                type = 'unlock-recipe',
                recipe = 'nm-spacing-guild'
            },
        },
        unit = {
            count = 100,
            ingredients = {
                {'automation-science-pack', 1},
                {'logistic-science-pack', 1},
                {'chemical-science-pack', 1}
            },
            time = 30
        },
    },
})
