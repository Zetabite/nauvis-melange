local config = require('scripts.config')

global.callbacks = {}

-- Mostly for modders usage
remote.add_interface('nauvis_melange_functions', {
	add_to_spice_effects_blacklist = function(key, value)
		table.insert(global.spice_effects_blacklist[key], value)
	end,
	remove_from_spice_effects_blacklist = function(key, value)
		table.remove(global.spice_effects_blacklist[key], value)
	end
})

-- Inits
init = {
	players = function()
		global.players = {}
		for _, player in pairs(game.connected_players) do
			global.players[player.index] = config.default.players
		end
	end,

	-- Forces table for winning condition
	forces = function()
		global.forces = {}
		for _, force in pairs(game.forces) do
			global.forces[force.index] = config.default.forces
		end
	end,

	-- Aliens Table
	aliens = function()
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

	global.aliens.dict = enum_aliens
	global.aliens.names = enum_alien_names
	global.aliens.collector = enum_alien_collector
	global.aliens.melee = enum_alien_melee
	global.aliens.reverse = enum_aliens_reverse
	end,
	competitor_spice = function()
		global.competitor_spice = {}
		if script.active_mods['space-exploration'] then
			local spice_name = 'se-vitamelange'
			local spice_suffix = { '', '-spice', '-nugget', '-roast', '-extract'}
			for _, suffix in pairs(spice_suffix) do
				table.insert(global.competitor_spice, (spice_name..suffix))
			end
		end
	end
}

-- Inits
configuration_changed = {
	players = function()
		-- Change for next version in case of change
		local players_table = global.players
		if players_table then
			for player_index,_ in pairs(players_table) do
				local default = config.default.players
				if players_table[player_index].under_influence ~= nil then
					players_table[player_index] = default
				else
					for key, entry in pairs(default) do
						if not players_table[player_index][key] then
							players_table[player_index][key] = entry
						end
						if type(default[key]) == 'table' then
							for subkey, subentry in pairs(default[key]) do
								if not entry[subkey] then
									entry[subkey] = subentry
								end
							end
						end
					end
				end
			end
		else
			init.players()
		end
	end,
	-- Forces table for winning condition
	forces = function()
		if global.forces then
			local forces = {}
			for force_index, entry in pairs(global.forces) do
				if #entry <= 0 then
					for subkey, value in pairs(config.default.forces) do
						if not entry[subkey] then
							entry[subkey] = value
						end
					end
				end
				forces[force_index] = entry
			end
			global.forces = forces
		else
			init.forces()
		end
	end,
	aliens = function()
		init.aliens()
	end,
	competitor_spice = function()
		init.competitor_spice()
	end
}

-- lib
local lib = {}

lib.on_init = function()
	global.render_table = config.default.render
	global.spice_effects_blacklist = config.default.spice_effects_blacklist
	init.aliens()
	init.players()
	init.forces()
	init.competitor_spice()
end

lib.on_configuration_changed = function()
	global.render_table = global.render_table or config.default.render
	global.spice_effects_blacklist = global.spice_effects_blacklist or config.default.spice_effects_blacklist
	configuration_changed.aliens()
	configuration_changed.players()
	configuration_changed.forces()
	configuration_changed.competitor_spice()
end

return lib
