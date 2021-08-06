data:extend({
    {
        type = 'recipe',
        name = 'nm-spice-gas',
        localised_name = {'fluid-name.nm-spice-gas'},
        localised_description = {'fluid-description.nm-spice-gas'},
        category = 'chemistry',
        energy_required = 4,
        enabled = false,
        ingredients = {
            { type = 'item', name = 'nm-spice', amount = 20 },
            { type = 'fluid', name = 'water', amount = 10 },
        },
        results = {
            { type = 'fluid', name = 'nm-spice-gas', amount = 22 }
        },
        subgroup = 'fluid-recipes',
    }
})
