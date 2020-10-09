remote.add_interface('nauvis_melange_interface', {
	players_init_values = function()
		return {counter = 0,radar = false,radar_tick = 0}
	end,
	forces_init_values = function()
		return {spice_shipped = 0}
	end,
	spice_for_victory_count = function()
		return 10000
	end,
	spice_effects_blacklist_init_values = function()
		return {
			type = {
				['locomotive'] = true,
				['artillery-wagon'] = true,
				['cargo-wagon'] = true,
				['fluid-wagon'] = true
			},
			name = {}
		}
	end,
	add_to_spice_effects_blacklist = function(key, value)
		table.insert(global.spice_effects_blacklist[key], value)
	end,
	remove_from_spice_effects_blacklist = function(key, value)
		table.remove(global.spice_effects_blacklist[key], value)
	end
})

-- Player table
function players_table_init()
	global.players = {}
	for _, player in pairs(game.connected_players) do
		global.players[player.index] = remote.call('nauvis_melange_interface', 'forces_init_values')
	end
end

function players_table_configuration_changed()
	if global.addiction_system then
		players_table_init()
		local players = {}
		for player_name, entry in pairs(global.addiction_system) do
			if #entry <= 0 then
				for subkey, value in pairs(remote.call('nauvis_melange_interface', 'players_init_values')) do
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
	if global.players then
		local players = {}
		for player_index, entry in pairs(global.players) do
			if #entry <= 0 then
				for subkey, value in pairs(remote.call('nauvis_melange_interface', 'players_init_values')) do
					if not entry[subkey] then
						entry[subkey] = value
					end
				end
			end
			players[player_index] = entry
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
		global.forces[force.index] = remote.call('nauvis_melange_interface', 'forces_init_values')
	end
end

function forces_table_configuration_changed()
	if global.forces then
		local forces = {}
		for force_index, entry in pairs(global.forces) do
			if #entry <= 0 then
				for subkey, value in pairs(remote.call('nauvis_melange_interface', 'forces_init_values')) do
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
	global.spice_effects_blacklist = remote.call('nauvis_melange_interface', 'spice_effects_blacklist_init_values')
end

-- lib
local lib = {}

lib.on_init = function()
	players_table_init()
	aliens_table_init()
	competitor_spice_table_init()
	forces_table_init()
	spice_effects_blacklist_init()
end

lib.on_configuration_changed = function()
	players_table_configuration_changed()
	aliens_table_init()
	competitor_spice_table_init()
	forces_table_configuration_changed()
	spice_effects_blacklist_init()
end

return lib
