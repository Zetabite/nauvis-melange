data:extend({
    -- Entities
    {
        type = 'recipe',
        name = 'nm-water-injector-proxy',
        localised_name = {'entity-name.nm-water-injector'},
        localised_description = {'entity-description.nm-water-injector'},
        energy_required = 2,
        enabled = false,
        ingredients = {
            { 'steel-plate', 5 },
            { 'pipe', 23 }
        },
        result = 'nm-water-injector-proxy'
    },
    {
        type = 'recipe',
        name = 'nm-drying-rig',
        localised_name = {'entity-name.nm-drying-rig'},
        localised_description = {'entity-description.nm-drying-rig'},
        category = 'crafting',
        energy_required = 20,
        enabled = false,
        ingredients = {
            { 'solar-panel', 4 },
            { 'advanced-circuit', 4 },
            { 'nm-solar-component-foil', 10 },
        },
        result = 'nm-drying-rig'
    },
    {
        type = 'recipe',
        name = 'nm-alien-growth-chamber',
        localised_name = {'entity-name.nm-alien-growth-chamber'},
        localised_description = {'entity-description.nm-alien-growth-chamber'},
        category = 'crafting',
        energy_required = 20,
        enabled = false,
        ingredients = {
            { 'solar-panel', 4 },
            { 'advanced-circuit', 4 },
            { 'nm-solar-component-foil', 10 },
        },
        result = 'nm-alien-growth-chamber'
    },
    {
        type = 'recipe',
        name = 'nm-travel-worm',
        localised_name = {'entity-name.nm-travel-worm'},
        localised_description = {'entity-description.nm-travel-worm'},
        category = 'nm-alien-growing',
        energy_required = 120,
        enabled = false,
        ingredients = {
            { 'nm-sandtrout', 1 },
            { 'nm-spice', 50 }
        },
        result = 'nm-travel-worm'
    },
    {
        type = 'recipe',
        name = 'nm-spacing-guild',
        localised_name = {'entity-name.nm-spacing-guild'},
        localised_description = {'entity-description.nm-spacing-guild'},
        category = 'crafting',
        energy_required = 20,
        enabled = false,
        ingredients = {
            { 'nm-spice', 40 },
            { 'pipe', 20 },
            { 'advanced-circuit', 20 },
            { 'steel-plate', 20 },
        },
        result = 'nm-spacing-guild'
    },
    --[[
    {
        type = 'recipe',
        name = 'nm-d-u-n-e',
        normal = {
          enabled = true,
          energy_required = 5,
          ingredients =
          {
            {'engine-unit', 32},
            {'steel-plate', 50},
            {'iron-gear-wheel', 15},
            {'advanced-circuit', 10}
          },
          result = 'nm-d-u-n-e'
        },
        expensive = {
          enabled = true,
          energy_required = 8,
          ingredients =
          {
            {'engine-unit', 64},
            {'steel-plate', 100},
            {'iron-gear-wheel', 30},
            {'advanced-circuit', 20}
          },
          result = 'nm-d-u-n-e'
        }
    },
    ]]

    -- Items
    {
        type = 'recipe',
        name = 'nm-solar-component-foil',
        localised_name = {'item-name.nm-solar-component-foil'},
        localised_description = {'item-description.nm-solar-component-foil'},
        category = 'crafting',
        energy_required = 10,
        enabled = false,
        ingredients = {
            { 'copper-plate', 3 },
            { 'plastic-bar', 2 },
            { 'iron-plate', 3 },
        },
        results = {
            { type = 'item', name = 'nm-solar-component-foil', amount = 20 }
        },
    },
    --[[
    {
        type = 'recipe',
        name = 'solar-drying-panel',
        localised_name = {'item-name.solar-drying-panel'},
        localised_description = {'item-description.solar-drying-panel'},
        category = 'crafting',
        energy_required = 1,
        enabled = false,
        ingredients = {
            { 'solar-panel', 1 },
        },
        result = 'drying-rig'
    },
    --]]
    {
        type = 'recipe',
        name = 'nm-spice',
        category = 'nm-drying',
        energy_required = 60,
        enabled = false,
        ingredients = {{ 'nm-pre-spice-mass', 20 }},
        results = {
            { type = 'item', name = 'nm-spice', amount = 20 }
        },
    },
    {
        type = 'recipe',
        name = 'nm-sandtrout',
        localised_name = {'item-name.nm-sandtrout'},
        localised_description = {'item-description.nm-sandtrout'},
        category = 'nm-alien-growing',
        energy_required = 60,
        enabled = false,
        ingredients = {
            { 'nm-pre-spice-mass', 20 },
            { 'nm-worm-sample', 20 }
        },
        results = {
            { type = 'item', name = 'nm-sandtrout', amount = 20 }
        },
    },
    {
        type = 'recipe',
        name = 'nm-biter-leech',
        localised_name = {'item-name.nm-biter-leech'},
        localised_description = {'item-description.nm-biter-leech'},
        category = 'nm-alien-growing',
        energy_required = 60,
        enabled = false,
        ingredients = {
            { 'nm-pre-spice-mass', 20 },
            { 'nm-biter-sample', 20 }
        },
        results = {
            { type = 'item', name = 'nm-biter-leech', amount = 20 }
        },
    },
    {
        type = 'recipe',
        name = 'nm-alien-probe',
        localised_name = {'item-name.nm-alien-probe'},
        localised_description = {'item-description.nm-alien-probe'},
        category = 'crafting',
        energy_required = 4,
        enabled = false,
        ingredients = {
            { 'iron-plate', 2 },
            { 'iron-stick', 1 },
        },
        result = 'nm-alien-probe'
    },
    {
        type = 'recipe',
        name = 'nm-biter-navigator',
        localised_name = {'item-name.nm-biter-navigator'},
        localised_description = {'item-description.nm-biter-navigator'},
        category = 'nm-space-education',
        energy_required = 60,
        enabled = false,
        ingredients = {
            { type = 'item', name = 'nm-biter-leech', amount = 1 },
            { type = 'item', name = 'low-density-structure', amount = 10 },
            { type = 'item', name = 'advanced-circuit', amount = 4 },
            { type = 'fluid', name = 'nm-spice-gas', amount = 200 },
        },
        result = 'nm-biter-navigator'
    },
    {
        type = 'recipe',
        name = 'nm-fish-navigator',
        localised_name = {'item-name.nm-fish-navigator'},
        localised_description = {'item-description.nm-fish-navigator'},
        category = 'nm-space-education',
        energy_required = 60,
        enabled = false,
        ingredients = {
            { type = 'item', name = 'raw-fish', amount = 1 },
            { type = 'item', name = 'low-density-structure', amount = 10 },
            { type = 'item', name = 'advanced-circuit', amount = 4 },
            { type = 'fluid', name = 'nm-spice-gas', amount = 200 },
        },
        result = 'nm-fish-navigator'
    },
})
