local config = require('scripts.config')
local SPICE_DURATION = config.SPICE_DURATION

data:extend({
    {
        type = 'sticker',
        name = 'nm-spice-applied-sticker',
        duration_in_ticks = SPICE_DURATION
    },
    {
        type = 'sticker',
        name = 'nm-spice-speed-sticker',
        duration_in_ticks = SPICE_DURATION,
        target_movement_modifier = 2
    },
    -- negative damage, aka healing for stickers doesnt work in 1.0.0, should be fixed in next release
    {
        type = 'sticker',
        name = 'nm-spice-regen-sticker',
        duration_in_ticks = SPICE_DURATION,
        damage_per_tick = {type = 'physical', amount = -10},
        damage_interval = 30
    },
    {
        type = 'sticker',
        name = 'nm-spice-vehicle-regen-sticker',
        duration_in_ticks = SPICE_DURATION,
        damage_per_tick = {type = 'physical', amount = -1000},
        damage_interval = 30
    },
})
