function created_entity(event)
	local entity = event.entity
	if entity.name == 'alien-probe-proxy' then
		local surface = entity.surface
		local position = entity.position
		local radius = 5
		local alien = surface.find_entities_filtered({type = 'unit', position = position, radius = radius, force = 'enemy', limit = 1})
		if alien[1] then
			local aliens_table = global.aliens
			alien = alien[1]
			local sample = nil
			if aliens_table.reverse['biter'][alien.name] then
				sample = { name = 'biter-sample', count = 1 }
			elseif aliens_table.reverse['worm-turret'][alien.name] then
				sample = { name = 'worm-sample', count = 1 }
			end
			if (sample) then
				if (event.source) then
					local player = event.source
					local inventory = player.get_main_inventory()
					if inventory.can_insert(sample) then
						inventory.insert(sample)
					end
				else
					surface.spill_item_stack(position, sample, true)
				end
			end
		end
	end
end

function destroyed_entity(event)
	local cause = event.cause
	local entity = event.entity
	if (cause) then
		if (entity) then
			if entity.type == 'turret' and string.match(entity.name, 'worm') then
				create_worm_hole(entity)
			else
				spice_effects(cause, entity)
			end
		end
	end
end

function create_worm_hole(entity)
	local surface = entity.surface
	local pos = entity.position
	pos = surface.find_non_colliding_position('worm-hole', pos, 2, 0.5, true)
	if (pos) then
		surface.create_entity({ name = 'worm-hole', position = pos })
	end
end

function spice_effects(cause, victim)
	cause = is_spice_collector(cause, victim)
	if cause then
		-- in case we later want to scale effect based on this
		local spice_amount = has_spice_in_fluidbox(victim) or has_spice_in_inventory(victim)
		if spice_amount then
			local spice_settings = {
				['spice-evolution-factor'] = settings.global['spice-evolution-factor'].value,
				['spice-direct-evolution-level'] = settings.global['spice-direct-evolution-level'].value,
				['spice-evolve-neighbours'] = settings.global['spice-evolve-neighbours'].value,
				['spice-evolve-neighbours-radius'] = settings.global['spice-evolve-neighbours-radius'].value
			}
			local force = cause.force
			force.evolution_factor = force.evolution_factor * spice_settings['spice-evolution-factor']
			cause = evolve_alien(cause, spice_settings['spice-direct-evolution-level'])
			apply_spice_to_alien(cause)
			if spice_settings['spice-evolve-neighbours'] then
				local surface = cause.surface
				local position = cause.position
				local aliens = surface.find_entities_filtered({ name = global.aliens.names, position = position, radius = spice_settings['spice-evolve-neighbours-radius'], force = 'enemy'})
				for _, alien in pairs(aliens) do
					if alien ~= cause then evolve_alien(alien, spice_settings['spice-direct-evolution-level'] - 1) end
				end
			end
		end
	end
end

function has_spice_in_fluidbox(victim)
	if victim.type ~= 'character' then
		if (victim.fluidbox) then
			local fluidbox = victim.fluidbox
			for i = 1, #fluidbox, 1 do
				if fluidbox.get_locked_fluid(i) == 'spice-gas' then
					return fluidbox.get_capacity(i)
				end
			end
		end
	end
	return false
end

function has_spice_in_inventory(victim)
	local inventory = nil
	if victim.type == 'car' then
		inventory = victim.get_inventory(defines.inventory.car_trunk)
	elseif victim.type == 'cargo-wagon' then
		inventory = victim.get_inventory(defines.inventory.cargo_wagon)
	elseif victim.type == 'character' then
		local surface = victim.surface
		local position = victim.position
		local corpse = surface.find_entities_filtered({type = 'character-corpse', position = position, radius = 2, limit = 1})
		if corpse[1] then
			corpse = corpse[1]
			inventory = corpse.get_inventory(defines.inventory.character_corpse)
		end
	else
		return false
	end
	if inventory then
		local amount = inventory.get_item_count('spice')
		if amount > 0 then
			inventory.remove({name = 'spice', count = amount})
			return amount
		end
	end
	return false
end

function evolve_alien(alien, steps)
	local next_level = get_next_level(alien.name, steps)
	if next_level ~= alien.name then
		local surface = alien.surface
		local position = alien.position
		local force = alien.force
		alien.destroy()
		alien = surface.create_entity({ name = next_level, position = position, force = force})
	end
	return alien
end

function get_next_level(name, steps)
	local aliens_table = global.aliens
	for type_name, entry in pairs(aliens_table.dict) do
		if aliens_table.reverse[type_name][name] then
			local tier = aliens_table.reverse[type_name][name]
			local next_tier = tier + steps
			if entry[next_tier] then return entry[next_tier].name
			else return entry[#entry].name end
		end
	end
	return name
end

function apply_spice_to_alien(alien)
	local surface = alien.surface
	local position = alien.position
	surface.create_entity({ name = 'spice-speed-sticker', target = alien, position = position })
	surface.create_entity({ name = 'spice-vehicle-regen-sticker', target = alien, position = position })
	return alien
end

-- only allows melee units to collect spice
function is_spice_collector(cause, victim)
	local aliens_table = global.aliens
	if aliens_table.melee[cause.name] then
		return cause
	else
		local surface = victim.surface
		local position = victim.position
		local brutus = surface.find_entities_filtered({name = aliens_table.names, position = position, radius = 1, force = 'enemy', limit = 1})
		if (brutus) then return brutus end
	end
	return false
end

-- lib
local lib = {}

lib.events = {
	[defines.events.on_player_died] = destroyed_entity,
	[defines.events.on_entity_died] = destroyed_entity,
	[defines.events.script_raised_destroy] = destroyed_entity,
	[defines.events.on_trigger_created_entity] = created_entity,
}

return lib
