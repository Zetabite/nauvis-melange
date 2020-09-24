local spice_evolution_factor = settings.global['spice-evolution-factor'].value

function update_vars(event)
	local setting = event.setting
	if setting == 'spice-evolution-factor' then
		spice_evolution_factor = settings.global['spice-evolution-factor'].value
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
				apply_spice_to_alien(evolve_biter(cause))
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

function evolve_biter(cause)
	local next_level = get_next_level(cause.name)
	if (next_level) then
		local surface = cause.surface
		local position = cause.position
		cause.destroy()
		cause = surface.create_entity({ name = next_level, position = position, force = 'enemy'})
	end
	return cause
end

function get_next_level(name)
	if name == 'small-biter' then
		return 'medium-biter'
	elseif name == 'medium-biter' then
		return 'big-biter'
	elseif name == 'big-biter' then
		return 'behemoth-biter'
	else
		return nil
	end
end

function apply_spice_to_alien(cause)
	local surface = cause.surface
	local position = cause.position
	surface.create_entity({ name = 'spice-speed-sticker', target = cause, position = position })
	surface.create_entity({ name = 'spice-vehicle-regen-sticker', target = cause, position = position })
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
