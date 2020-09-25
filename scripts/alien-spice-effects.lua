local spice_evolution_factor = settings.global['spice-evolution-factor'].value
local spice_direct_evolution_level = settings.global['spice-direct-evolution-level'].value
local spice_evolve_neighbours = settings.global['spice-evolve-neighbours'].value
local spice_evolve_neighbours_radius = settings.global['spice-evolve-neighbours-radius'].value

local enum_next_level = {
	['small-spitter'] = {
		[1] = 'medium-spitter', [2] = 'big-spitter', [3] = 'behemoth-spitter'
	},
	['medium-spitter'] = {
		[1] = 'big-spitter', [2] = 'behemoth-spitter', [3] = 'behemoth-spitter'
	},
	['big-spitter'] = {
		[1] = 'big-spitter', [2] = 'behemoth-spitter', [3] = 'behemoth-spitter'
	},
	['behemoth-spitter'] = {
		[1] = 'big-spitter', [2] = 'behemoth-spitter', [3] = 'behemoth-spitter'
	},
	['small-biter'] = {
		[1] = 'medium-biter', [2] = 'big-biter', [3] = 'behemoth-biter'
	},
	['medium-biter'] = {
		[1] = 'big-biter', [2] = 'behemoth-biter', [3] = 'behemoth-biter'
	},
	['big-biter'] = {
		[1] = 'big-biter', [2] = 'behemoth-biter', [3] = 'behemoth-biter'
	},
	['behemoth-biter'] = {
		[1] = 'big-biter', [2] = 'behemoth-biter', [3] = 'behemoth-biter'
	},
	['small-worm-turret'] = {
		[1] = 'medium-worm-turret', [2] = 'big-worm-turret', [3] = 'behemoth-worm-turret'
	},
	['medium-worm-turret'] = {
		[1] = 'big-worm-turret', [2] = 'behemoth-worm-turret', [3] = 'behemoth-worm-turret'
	},
	['big-worm-turret'] = {
		[1] = 'big-worm-turret', [2] = 'behemoth-worm-turret', [3] = 'behemoth-worm-turret'
	},
	['behemoth-worm-turret'] = {
		[1] = 'big-worm-turret', [2] = 'behemoth-worm-turret', [3] = 'behemoth-worm-turret'
	}
}

local enum_aliens = {
	'small-biter', 'medium-biter', 'big-biter', 'behemoth-biter',
	'small-spitter', 'medium-spitter', 'big-spitter', 'behemoth-spitter',
	'small-worm-turret', 'medium-worm-turret', 'big-worm-turret', 'behemoth-worm-turret',
}

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
		if spice_elligible_alien(cause) then
			local entity = event.entity
			if has_spice_in_fluidbox(entity) or has_spice_in_inventory(entity) then
				local force = cause.force
				local evolution_factor = force.evolution_factor
				force.evolution_factor = evolution_factor * spice_evolution_factor
				cause = apply_spice_to_alien(evolve_alien(cause, spice_direct_evolution_level))
				if spice_evolve_neighbours then
					local surface = cause.surface
					local position = cause.position
					local aliens = surface.find_entities_filtered({ name = enum_aliens, position = position, radius = spice_evolve_neighbours_radius, force = 'enemy'})
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
				return true
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
		return true
	end
	return false
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
	if steps > 0 then
		return enum_next_level[name][steps]
	elseif steps > 3 then
		return enum_next_level[name][3]
	else
		return name
	end
end

-- only allows melee units to collect
function apply_spice_to_alien(alien)
	local surface = alien.surface
	local position = alien.position
	surface.create_entity({ name = 'spice-speed-sticker', target = alien, position = position })
	surface.create_entity({ name = 'spice-vehicle-regen-sticker', target = alien, position = position })
	return alien
end

function spice_elligible_alien(cause)
	return (cause.name == 'small-biter' or cause.name == 'medium-biter' or cause.name == 'big-biter' or cause.name == 'behemoth-biter')
end

-- lib
local lib = {}

lib.events = {
	[defines.events.on_entity_died] = destroyed_entity,
	[defines.events.on_runtime_mod_setting_changed] = update_vars,
}

return lib
