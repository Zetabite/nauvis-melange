-- Creating enums from mods
global.enum_aliens = {
	['biter'] = {},
	['spitter'] = {},
	['worm-turret'] = {}
}

for mod_name,_ in pairs(script.active_mods) do
	if mod_name == 'base' then
		require('scripts.base.aliens')
	elseif mod_name == 'SchallEndgameEvolution' then
		require('scripts.schall-endgame-evolution.aliens')
	end
end

local enum_aliens = global.enum_aliens
local enum_alien_names = {}
local enum_alien_collector = {}
local enum_aliens_reverse = {}

for type_name, entry in pairs(enum_aliens) do
	local reverse = {}
	for tier, alien in pairs(enum_aliens[type_name]) do
		reverse[alien.name] = tier
		table.insert(enum_alien_names, alien.name)
		if entry[tier].collector then
			enum_alien_collector[alien.name] = true
		end
	end
	enum_aliens_reverse[type_name] = reverse
end

local spice_evolution_factor = settings.global['spice-evolution-factor'].value
local spice_direct_evolution_level = settings.global['spice-direct-evolution-level'].value
local spice_evolve_neighbours = settings.global['spice-evolve-neighbours'].value
local spice_evolve_neighbours_radius = settings.global['spice-evolve-neighbours-radius'].value

function update_vars(event)
	local setting = event.setting
	if setting == 'spice-evolution-factor' then
		spice_evolution_factor = settings.global['spice-evolution-factor'].value
	elseif setting == 'spice-direct-evolution-level' then
		spice_direct_evolution_level = settings.global['spice-direct-evolution-level'].value
	elseif setting == 'spice-evolve-neighbours' then
		spice_evolve_neighbours = settings.global['spice-evolve-neighbours'].value
	elseif setting == 'spice-evolve-neighbours-radius' then
		spice_evolve_neighbours_radius = settings.global['spice-evolve-neighbours-radius'].value
	end
end

function destroyed_entity(event)
	if (event.cause) then
		local cause = event.cause
		if spice_elligible_alien(cause.name) then
			local entity = event.entity
			-- in case we later want to scale effect based on this
			local spice_amount = has_spice_in_fluidbox(entity) or has_spice_in_inventory(entity)
			if spice_amount then
				local force = cause.force
				force.evolution_factor = force.evolution_factor * spice_evolution_factor
				cause = apply_spice_to_alien(evolve_alien(cause, spice_direct_evolution_level))
				if spice_evolve_neighbours then
					local surface = cause.surface
					local position = cause.position
					local aliens = surface.find_entities_filtered({ name = enum_alien_names, position = position, radius = spice_evolve_neighbours_radius, force = 'enemy'})
					for _, alien in pairs(aliens) do
						if alien ~= cause then
							evolve_alien(alien, spice_direct_evolution_level - 1)
						end
					end
				end
			end
		end
	end
end

function has_spice_in_fluidbox(entity)
	if (entity.fluidbox) then
		local fluidbox = entity.fluidbox
		for i = 1, #fluidbox, 1 do
			if fluidbox.get_locked_fluid(i) == 'spice-gas' then
				return fluidbox.get_capacity(i)
			end
		end
	end
	return false
end

function has_spice_in_inventory(entity)
	local inventory = nil
	if entity.type == 'character' then
		inventory = entity.get_inventory(defines.inventory.character_main)
	elseif entity.type == 'car' then
		inventory = entity.get_inventory(defines.inventory.car_trunk)
	elseif entity.type == 'cargo-wagon' then
		inventory = entity.get_inventory(defines.inventory.cargo_wagon)
	else
		return false
	end
	if inventory.find_item_stack('spice') then
		local amount = inventory.find_item_stack('spice').count
		inventory.find_item_stack('spice').count = 0
		return amount
	else
		return false
	end
end

function evolve_alien(alien, steps)
	local next_level = get_next_level(alien.name, steps)
	if next_level ~= alien.name then
		local surface = alien.surface
		local position = alien.position
		alien.destroy()
		alien = surface.create_entity({ name = next_level, position = position, force = 'enemy'})
	end
	return alien
end

function get_next_level(name, steps)
	for type_name, entry in pairs(enum_aliens) do
		if enum_aliens_reverse[type_name][name] then
			local tier = enum_aliens_reverse[type_name][name]
			local next_tier = tier + steps
			if entry[next_tier] then
				return entry[next_tier].name
			else
				return entry[#entry].name
			end
		end
	end
	return name
end

-- only allows melee units to collect spice
function apply_spice_to_alien(alien)
	local surface = alien.surface
	local position = alien.position
	surface.create_entity({ name = 'spice-speed-sticker', target = alien, position = position })
	surface.create_entity({ name = 'spice-vehicle-regen-sticker', target = alien, position = position })
	return alien
end

function spice_elligible_alien(name)
	return enum_alien_collector[name]
end

-- lib
local lib = {}

lib.events = {
	[defines.events.on_entity_died] = destroyed_entity,
	[defines.events.on_runtime_mod_setting_changed] = update_vars,
}

return lib
