local aliens_table
local spice_evolution_factor = settings.global['spice-evolution-factor'].value
local spice_direct_evolution_level = settings.global['spice-direct-evolution-level'].value
local spice_evolve_neighbours = settings.global['spice-evolve-neighbours'].value
local spice_evolve_neighbours_radius = settings.global['spice-evolve-neighbours-radius'].value

function update_vars(event)
	if event.setting == 'spice-evolution-factor' then
		spice_evolution_factor = settings.global['spice-evolution-factor'].value
	elseif event.setting == 'spice-direct-evolution-level' then
		spice_direct_evolution_level = settings.global['spice-direct-evolution-level'].value
	elseif event.setting == 'spice-evolve-neighbours' then
		spice_evolve_neighbours = settings.global['spice-evolve-neighbours'].value
	elseif event.setting == 'spice-evolve-neighbours-radius' then
		spice_evolve_neighbours_radius = settings.global['spice-evolve-neighbours-radius'].value
	end
end

function created_entity(event)
	local entity = event.entity
	if entity.name == 'alien-probe-proxy' then
		local surface = entity.surface
		local position = entity.position
		local radius = 5
		local alien = surface.find_entities_filtered({type = 'unit', position = position, radius = radius, force = 'enemy', limit = 1})
		if (alien) then
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
	if (event.cause) then
		local cause = event.cause
		if (event.entity) then
			spice_effects(cause, event.entity, false)
		elseif (event.player_index) then
			spice_effects(cause, game.get_player(event.player_index), event.player_index)
		end
	end
end

function spice_effects(cause, victim, player_index)
	local spice_collector = is_spice_collector(cause, victim)
	if spice_collector then
		-- in case we later want to scale effect based on this
		local spice_amount = has_spice_in_fluidbox(victim, player_index) or has_spice_in_inventory(cause, victim, player_index)
		if spice_amount then
			local force = cause.force
			force.evolution_factor = force.evolution_factor * spice_evolution_factor
			apply_spice_to_alien(spice_collector)
			cause = evolve_alien(cause, spice_direct_evolution_level)
			if spice_evolve_neighbours then
				local surface = cause.surface
				local position = cause.position
				local aliens = surface.find_entities_filtered({ name = aliens_table.names, position = position, radius = spice_evolve_neighbours_radius, force = 'enemy'})
				for _, alien in pairs(aliens) do
					if alien ~= cause then evolve_alien(alien, spice_direct_evolution_level - 1) end
				end
			end
		end
	end
end

function has_spice_in_fluidbox(victim, player_index)
	if not player_index then
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

function has_spice_in_inventory(collector, victim, player_index)
	local amount = 0
	local inventory = nil
	if player_index then
		local surface = collector.surface
		local position = collector.position
		local corpses = surface.find_entities_filtered({type = 'character-corpse', position = position, radius = 2})
		for _, corpse in pairs(corpses) do
			if corpse.character_corpse_player_index == player_index then
				local corpse_inv = corpse.get_inventory(defines.inventory.character_corpse)
				if corpse_inv.get_item_count('spice') > 0 then inventory = corpse_inv break end
			end
		end
	else
		if victim.type == 'car' then inventory = victim.get_inventory(defines.inventory.car_trunk)
		elseif victim.type == 'cargo-wagon' then inventory = victim.get_inventory(defines.inventory.cargo_wagon)
		else return false end
	end
	amount = inventory.get_item_count('spice')
	if amount > 0 then
		inventory.remove({name = 'spice', count = amount})
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
	for type_name, entry in pairs(aliens_table) do
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
	[defines.events.on_trigger_created_entity] = created_entity,
	[defines.events.on_runtime_mod_setting_changed] = update_vars,
}

lib.on_init = function()
	aliens_table = global.aliens
end

lib.on_configuration_changed = function()
	aliens_table = global.aliens
end

lib.on_load = function ()
	aliens_table = global.aliens
end

return lib
