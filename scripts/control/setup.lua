remote.add_interface('nauvis_melange_table_defaults', {
	players_default = function()
		return {
			addiction_level = 0,
			zoom_factor = global.ZOOM_FACTOR,
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
	end,
	forces_default = function()
		return {spice_shipped = 0}
	end,
	render_default = function()
		return {
			spice_overlay = {}
		}
	end,
	spice_effects_blacklist_default = function()
		return {
			type = {
				['locomotive'] = true,
				['artillery-wagon'] = true,
				['cargo-wagon'] = true,
				['fluid-wagon'] = true
			},
			name = {}
		}
	end
})

remote.add_interface('nauvis_melange_constants', {
	VICTORY_SPICE_AMOUNT = function()
		return global.VICTORY_SPICE_AMOUNT
	end,
	SPICE_COOLDOWN = function()
		return global.SPICE_COOLDOWN
	end,
	SPICE_DURATION = function()
		return global.SPICE_DURATION
	end,
	OVERLAY_REFRESH = function()
		return global.OVERLAY_REFRESH
	end,
	ZOOM_FACTOR = function()
		return global.ZOOM_FACTOR
	end,
	OVERLAY_TIMER = function()
		return global.OVERLAY_TIMER
	end
})

-- Mostly for modders usage
remote.add_interface('nauvis_melange_functions', {
	add_to_spice_effects_blacklist = function(key, value)
		table.insert(global.spice_effects_blacklist[key], value)
	end,
	remove_from_spice_effects_blacklist = function(key, value)
		table.remove(global.spice_effects_blacklist[key], value)
	end
})

remote.add_interface('nauvis_melange_player', {
	consume_spice = function(player_index, factor, consequence, pre_consumption)
		return consume_spice(player_index, factor, consequence, pre_consumption)
	end,
	onZoomFactorChanged = function(event)
		if global.zoom_table[event.playerIndex] then
			global.zoom_table[event.playerIndex] = event.zoomFactor
		end
	end
})

-- Render table
function render_table_init()
	global.render_table = remote.call('nauvis_melange_table_defaults', 'render_default')
end

-- Player table
function players_table_init()
	global.players = {}
	for _, player in pairs(game.connected_players) do
		global.players[player.index] = remote.call('nauvis_melange_table_defaults', 'forces_default')
	end
end

function players_table_configuration_changed()
	-- For older version
	if global.addiction_system then
		players_table_init()
		local players = {}
		for player_name, entry in pairs(global.addiction_system) do
			if #entry <= 0 then
				for subkey, value in pairs(remote.call('nauvis_melange_table_defaults', 'players_default')) do
					if not entry[subkey] then
						entry[subkey] = value
					end
				end
			end
			local player_index = game.get_player(player_name).index
			players[player_index] = entry
		end
		global.players = players
	end
	-- For current version
	if global.players then
		local players = {}
		for _, entry in pairs(global.players) do
			for subkey, value in pairs(remote.call('nauvis_melange_table_defaults', 'players_default')) do
				if not entry[subkey] then
					entry[subkey] = value
				else
					if subkey == 'radar' and type(entry['radar']) ~= 'table' then
						local radar_reference = entry['radar']
						local remaining_ticks = entry['radar_tick']
						entry['radar'] = {
							active = false,
							reference = false,
							remaining_ticks = 0,
						}
						if radar_reference then
							entry['radar'].active = true
							entry['radar'].reference = radar_reference
							entry['radar'].remaining_ticks = remaining_ticks
						end
						table.remove(entry, 'radar_tick')
					elseif subkey == 'counter' then
						entry['addiction_level'] = entry['counter']
						table.remove(entry, 'counter')
					end
				end
			end
		end
		global.players = players
	else
		players_table_init()
	end
end

-- Forces table for winning condition
function forces_table_init()
	global.forces = {}
	for _, force in pairs(game.forces) do
		global.forces[force.index] = remote.call('nauvis_melange_table_defaults', 'forces_default')
	end
end

function forces_table_configuration_changed()
	if global.forces then
		local forces = {}
		for force_index, entry in pairs(global.forces) do
			if #entry <= 0 then
				for subkey, value in pairs(remote.call('nauvis_melange_table_defaults', 'forces_default')) do
					if not entry[subkey] then
						entry[subkey] = value
					end
				end
			end
			forces[force_index] = entry
		end
		global.forces = forces
	else
		forces_table_init()
	end
end

-- Aliens Table
function aliens_table_init()
	global.aliens = {}
	-- Creating enums from mods
	local enum_aliens = {
		['biter'] = {},
		['spitter'] = {},
		['worm-turret'] = {}
	}

	if script.active_mods['base'] then
		local tiers = {[1] = 'small', [2] = 'medium', [3] = 'big', [4] = 'behemoth'}
		for type_name, _ in pairs(enum_aliens) do
			for tier, tier_name in pairs(tiers) do
				local alien = {}
				alien.name = tier_name .. '-' .. type_name
				alien.collector = type_name == 'biter' or type_name == 'spitter'
				alien.melee = type_name == 'biter'
				table.insert(enum_aliens[type_name], tier, alien)
			end
		end
		if script.active_mods['SchallEndgameEvolution'] then
			local tier_max = settings.startup['endgameevolution-alien-tier-max'].value
			for type_name, _ in pairs(enum_aliens) do
				if type_name ~= 'worm-turret' then
					for tier = 5, tier_max, 1 do
						local alien = {}
						alien.name = 'Schall-category-' .. tier .. '-' .. type_name
						alien.collector = type_name == 'biter' or type_name == 'spitter'
						alien.melee = type_name == 'biter'
						table.insert(enum_aliens[type_name], tier, alien)
					end
				end
			end
		end
	end

	local enum_alien_names = {}
	local enum_alien_collector = {}
	local enum_alien_melee = {}
	local enum_aliens_reverse = {}

	for type_name, entry in pairs(enum_aliens) do
		local reverse = {}
		for tier, alien in pairs(enum_aliens[type_name]) do
			reverse[alien.name] = tier
			table.insert(enum_alien_names, alien.name)
			enum_alien_collector[alien.name] = entry[tier].collector
			enum_alien_melee[alien.name] = entry[tier].melee
		end
		enum_aliens_reverse[type_name] = reverse
	end

	global.aliens.names = enum_alien_names
	global.aliens.collector = enum_alien_collector
	global.aliens.melee = enum_alien_melee
	global.aliens.reverse = enum_aliens_reverse
end

-- Competitor spice table
function competitor_spice_table_init()
	global.competitor_spice = {}
	if script.active_mods['space-exploration'] then
		local spice_name = 'se-vitamelange'
		local spice_suffix = { '', '-spice', '-nugget', '-roast', '-extract'}
		for _, suffix in pairs(spice_suffix) do
			table.insert(global.competitor_spice, (spice_name..suffix))
		end
	end
end

-- Spice effects blacklist
function spice_effects_blacklist_init()
	global.spice_effects_blacklist = remote.call('nauvis_melange_table_defaults', 'spice_effects_blacklist_default')
end

-- lib
local lib = {}

lib.on_init = function()
	players_table_init()
	aliens_table_init()
	competitor_spice_table_init()
	forces_table_init()
	spice_effects_blacklist_init()
	render_table_init()
end

lib.on_configuration_changed = function()
	players_table_configuration_changed()
	aliens_table_init()
	competitor_spice_table_init()
	forces_table_configuration_changed()
	spice_effects_blacklist_init()
	render_table_init()
end

return lib
