data:extend({
    {
        type = 'bool-setting',
        name = 'nm-spice-overlay',
        setting_type = 'runtime-per-user',
        default_value = true
    },
    {
        type = 'double-setting',
        name = 'nm-spice-evolution-factor',
        setting_type = 'runtime-global',
        minimum_value = 1.0,
        maximum_value = 10.0,
        default_value = 1.1
    },
    {
        type = 'int-setting',
        name = 'nm-spice-direct-evolution-level',
        setting_type = 'runtime-global',
        minimum_value = 0,
        maximum_value = 20,
        default_value = 2
    },
    {
        type = 'bool-setting',
        name = 'nm-spice-evolve-neighbours',
        setting_type = 'runtime-global',
        default_value = true
    },
    {
        type = 'int-setting',
        name = 'nm-spice-evolve-neighbours-radius',
        setting_type = 'runtime-global',
        minimum_value = 0,
        maximum_value = 24,
        default_value = 10
    },
})
