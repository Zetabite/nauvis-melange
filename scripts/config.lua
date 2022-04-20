local config = {}

-- Constants
config.SPICE_DURATION = 3600
config.SPICE_COOLDOWN = config.SPICE_DURATION
config.PLAYER_CHECK_TICK = 300
config.RENDER_REFRESH_TICK = 20
config.OVERLAY_TIMER = config.RENDER_REFRESH_TICK + 1
config.HIGH_FIDELITY_CHECK_TICK = 60
config.HIGHEST_FIDELITY_CHECK_TICK = 1
config.VICTORY_CHECK_TICK = 120
config.VICTORY_SPICE_AMOUNT = 10000
config.WATER_INJECTOR_THRESHOLD = 1000

config.ZOOM_FACTOR = 1.0

--[[
config.MAX = 3.0
config.MIN = 0.1
config['nauvis-melange-zoom-in'] = -0.1
config['nauvis-melange-zoom-out'] = 0.1
--]]

config.effect_table = {'radar', 'craft_mod', 'bad_trip'}

-- Travel Worm stuff
config.travel_worm_digging_time = 90
config.travel_worm_tier = {}
config.travel_worm_tier['nm-travel-worm-small'] = 'small'
config.travel_worm_tier['nm-travel-worm-medium'] = 'medium'
config.travel_worm_tier['nm-travel-worm-big'] = 'big'
config.travel_worm_tier['nm-travel-worm-behemoth'] = 'behemoth'

config.travel_worm_dust = {}
config.travel_worm_dust.scaling = {}
config.travel_worm_dust.scaling.small = 1.1
config.travel_worm_dust.scaling.medium = 1.5
config.travel_worm_dust.scaling.big = 2.2
config.travel_worm_dust.scaling.behemoth = 2.2

config.travel_worm_dust.color = {}
config.travel_worm_dust.color.top = {r = 0, g = 0, b = 0, a = 1}
config.travel_worm_dust.color.bottom = {r = 0, g = 0, b = 0, a = 1}

config.travel_worm_dust.fade_in = 60
config.travel_worm_dust.fade_out = 60
config.travel_worm_dust.full = config.travel_worm_digging_time

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
    force = {},
    spice_shipped = 0,
    travel_worms = {}
}

config.default.render = {
    spice_overlay = {},
    travel_worms = {}
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

config.default.travel_worm_data = {
    deadline = false,
    lock = 'free'
}

return config
