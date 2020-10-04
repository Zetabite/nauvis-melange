-- Addiction System
function addiction_system_init()
	global.addiction_system = {}
end

function addiction_system_reload()
	if global.addiction_system then
		local addiction_system = {}
		for key, value in pairs(global.addiction_system) do
			addiction_system[key] = value
		end
		global.addiction_system = addiction_system
	else
		addiction_system_init()
	end
end

-- Aliens Table
function aliens_table_init()
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
	global.enum_aliens = enum_aliens
	global.enum_alien_names = enum_alien_names
	global.enum_alien_collector = enum_alien_collector
	global.enum_alien_melee = enum_alien_melee
	global.enum_aliens_reverse = enum_aliens_reverse
end

-- lib
local lib = {}

lib.events = {
	[defines.events.on_trigger_created_entity] = created_entity,
}

lib.on_init = function()
	addiction_system_init()
	aliens_table_init()
end

lib.on_configuration_changed = function()
	addiction_system_reload()
	aliens_table_init()
end

return lib
