local config = {}

-- Constants
config.SPICE_DURATION = 3600
config.SPICE_COOLDOWN = config.SPICE_DURATION
config.PLAYER_CHECK_TICK = 300
config.RENDER_REFRESH_TICK = 20
config.OVERLAY_TIMER = config.RENDER_REFRESH_TICK + 1
config.WATER_INJECTOR_CHECK_TICK = 60
config.VICTORY_CHECK_TICK = 120
config.VICTORY_SPICE_AMOUNT = 10000
config.DUNE_MINERS_CHECK_TICK = config.WATER_INJECTOR_CHECK_TICK
config.WATER_INJECTOR_THRESHOLD = 1000

config.ZOOM_FACTOR = 1.0
--[[
config.MAX = 3.0
config.MIN = 0.1
config['nauvis-melange-zoom-in'] = -0.1
config['nauvis-melange-zoom-out'] = 0.1
--]]

config.effect_table = {'radar', 'craft_mod', 'bad_trip'}

-- Defaults
config.default = {}
config.default.players = {
    addiction_level = 0,
    zoom_factor = config.ZOOM_FACTOR,
	vehicle = false,
    radar = {
        reference = false,
        tick = false,
        duration = config.SPICE_DURATION
    },
    bad_trip = {
        tick = false,
        duration = config.SPICE_DURATION
    },
    craft_mod = {
        tick = false,
        duration = config.SPICE_DURATION
    }
}

config.default.forces = {
    spice_shipped = 0
}

config.default.render = {
        spice_overlay = {}
}

config.default.spice_effects_blacklist = {
    type = {
        ['locomotive'] = true,
        ['artillery-wagon'] = true,
        ['cargo-wagon'] = true,
        ['fluid-wagon'] = true
    },
    name = {}
}

return config
