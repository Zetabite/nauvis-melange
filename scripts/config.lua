local config = {}
-- Constants
config.SPICE_DURATION = 3600
config.SPICE_COOLDOWN = config.SPICE_DURATION
config.OVERLAY_REFRESH = 30
config.OVERLAY_TIMER = config.OVERLAY_REFRESH + 1
config.ZOOM_FACTOR = 3.0
config.VICTORY_SPICE_AMOUNT = 10000

-- Defaults
config.players_default = {
	addiction_level = 0,
	zoom_factor = config.ZOOM_FACTOR,
	under_influence = false,
	radar = {
		active = false,
		reference = false,
		remaining_ticks = 0,
	},
	craft_mod = {
		active = false,
		remaining_ticks = 0,
	},
	bad_trip = {
		active = false,
		remaining_ticks = 0,
	}
}

config.forces_default = {
	spice_shipped = 0
}

config.render_default = {
		spice_overlay = {}
}

config.spice_effects_blacklist_default = {
	type = {
		['locomotive'] = true,
		['artillery-wagon'] = true,
		['cargo-wagon'] = true,
		['fluid-wagon'] = true
	},
	name = {}
}
return config
