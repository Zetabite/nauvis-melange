require ('util')

function travel_worm_item(tier)
    return {
        type = 'item-with-entity-data',
        name = 'nm-travel-worm-'..tier,
        localised_name = {'entity-name.nm-travel-worm-'..tier},
        localised_description = {'entity-description.nm-travel-worm-'..tier},
        icon = '__nauvis-melange__/graphics/icons/'..tier..'-travel-worm.png',
        icon_size = 64, icon_mipmaps = 4,
        subgroup = 'transport',
        order = 'b[personal-transport]-a[nm-travel-worm'..tier..']',
        place_result = 'nm-travel-worm-'..tier,
        stack_size = 1
    }
end

function worm_sample(tier)
    return {
        type = 'item',
        name = 'nm-worm-sample-'..tier,
        icons = {
            {
                icon = '__nauvis-melange__/graphics/icons/sample.png',
                icon_size = 64, icon_mipmaps = 4,
            },
            {
                icon = '__nauvis-melange__/graphics/icons/'..tier..'-worm-overlay.png',
                icon_size = 64, icon_mipmaps = 4,
            },
        },
        subgroup = 'nm-alien-breeding',
        order = 'b[nm-worm-sample-'..tier..']',
        stack_size = 100
    }
end

function sandtrout(tier)
    return {
        type = 'item',
        name = 'nm-sandtrout-'..tier,
        icons =  {
            {
                icon = '__nauvis-melange__/graphics/icons/leech.png',
                icon_size = 64, icon_mipmaps = 4,
            },
            {
                icon = '__nauvis-melange__/graphics/icons/'..tier..'-worm-overlay.png',
                icon_size = 64, icon_mipmaps = 4,
            },
        },
        subgroup = 'nm-alien-breeding',
        order = 'b[nm-sandtrout-'..tier..']',
        place_result = 'nm-worm-hole',
        stack_size = 50
    }
end

data:extend({
    -- Entities
    {
        type = 'item',
        name = 'nm-water-injector-proxy',
        localised_name = {'entity-name.nm-water-injector'},
        localised_description = {'entity-description.nm-water-injector'},
        icon = '__nauvis-melange__/graphics/icons/water-injector.png',
        icon_size = 64, icon_mipmaps = 4,
        subgroup = 'extraction-machine',
        order = 'b[nm-water-injector]',
        place_result = 'nm-water-injector-proxy',
        stack_size = 50
    },
    {
        type = 'item',
        name = 'nm-alien-growth-chamber',
        localised_name = {'entity-name.nm-alien-growth-chamber'},
        localised_description = {'entity-description.nm-alien-growth-chamber'},
        icon = '__nauvis-melange__/graphics/icons/alien-growth-chamber.png',
        icon_size = 64, icon_mipmaps = 4,
        subgroup = 'production-machine',
        order = 'zb[nm-alien-growth-chamber]',
        place_result = 'nm-alien-growth-chamber',
        stack_size = 50
    },
    {
        type = 'item',
        name = 'nm-spacing-guild',
        localised_name = {'entity-name.nm-spacing-guild'},
        localised_description = {'entity-description.nm-spacing-guild'},
        icon = '__nauvis-melange__/graphics/icons/spacing-guild.png',
        icon_size = 64, icon_mipmaps = 4,
        subgroup = 'production-machine',
        order = 'zb[nm-spacing-guild]',
        place_result = 'nm-spacing-guild',
        stack_size = 50
    },
    {
        type = 'item',
        name = 'nm-drying-rig',
        localised_name = {'entity-name.nm-drying-rig'},
        localised_description = {'entity-description.nm-drying-rig'},
        icon = '__nauvis-melange__/graphics/icons/drying-rig.png',
        icon_size = 64, icon_mipmaps = 4,
        subgroup = 'production-machine',
        order = 'za[nm-drying-rig]',
        place_result = 'nm-drying-rig',
        stack_size = 50
    },
    travel_worm_item('small'),
    travel_worm_item('medium'),
    travel_worm_item('big'),
    travel_worm_item('behemoth'),
    {
        type = 'item-with-entity-data',
        name = 'nm-d-u-n-e',
        icon = '__base__/graphics/icons/tank.png',
        icon_size = 64, icon_mipmaps = 4,
        subgroup = 'transport',
        order = 'b[personal-transport]-b[nm-d-u-n-e]',
        place_result = 'nm-d-u-n-e',
        stack_size = 1
    },

    -- Items
    {
        type = 'item',
        name = 'nm-solar-component-foil',
        icon = '__nauvis-melange__/graphics/icons/solar-component-foil.png',
        icon_size = 64, icon_mipmaps = 4,
        subgroup = 'intermediate-product',
        order = 'd[nm-solar-component-foil]',
        stack_size = 200
    },
    {
        type = 'item',
        name = 'nm-biter-navigator',
        icons =  {
            {
                icon = '__nauvis-melange__/graphics/icons/navigator.png',
                icon_size = 64, icon_mipmaps = 4,
            },
            {
                icon = '__nauvis-melange__/graphics/icons/biter-overlay.png',
                icon_size = 64, icon_mipmaps = 4,
            },
        },
        subgroup = 'intermediate-product',
        stack_size = 50
    },
    {
        type = 'item',
        name = 'nm-fish-navigator',
        icons =  {
            {
                icon = '__nauvis-melange__/graphics/icons/navigator.png',
                icon_size = 64, icon_mipmaps = 4,
            },
            {
                icon = '__nauvis-melange__/graphics/icons/fish-overlay.png',
                icon_size = 64, icon_mipmaps = 4,
            },
        },
        subgroup = 'intermediate-product',
        stack_size = 50
    },
    {
        type = 'item',
        name = 'nm-pre-spice-mass',
        icon = '__nauvis-melange__/graphics/icons/pre-spice-mass.png',
        icon_size = 64, icon_mipmaps = 4,
        subgroup = 'raw-resource',
        order = 'b[nm-pre-spice-mass]',
        stack_size = 100
    },
    sandtrout('small'),
    sandtrout('medium'),
    sandtrout('big'),
    sandtrout('behemoth'),
    {
        type = 'item',
        name = 'nm-biter-leech',
        icons =  {
            {
                icon = '__nauvis-melange__/graphics/icons/leech.png',
                icon_size = 64, icon_mipmaps = 4,
            },
            {
                icon = '__nauvis-melange__/graphics/icons/biter-overlay.png',
                icon_size = 64, icon_mipmaps = 4,
            },
        },
        subgroup = 'nm-alien-breeding',
        order = 'b[nm-biter-leech]',
        stack_size = 100
    },
    worm_sample('small'),
    worm_sample('medium'),
    worm_sample('big'),
    worm_sample('behemoth'),
    {
        type = 'item',
        name = 'nm-biter-sample',
        icons =  {
            {
                icon = '__nauvis-melange__/graphics/icons/sample.png',
                icon_size = 64, icon_mipmaps = 4,
            },
            {
                icon = '__nauvis-melange__/graphics/icons/biter-overlay.png',
                icon_size = 64, icon_mipmaps = 4,
            },
        },
        subgroup = 'nm-alien-breeding',
        order = 'b[nm-biter-sample]',
        stack_size = 100
    },

    -- Misc
    {
        type = 'item',
        name = 'nm-spice-overlay',
        icon = '__nauvis-melange__/graphics/spice-overlay.png',
        icon_size = 12,
        stack_size = 1
    }
})
