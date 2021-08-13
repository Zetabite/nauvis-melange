created_entity = function(event)
    local entity = event.entity

    if entity and entity.valid and entity.name == 'nm-alien-probe-proxy' then
        local surface = entity.surface
        local position = entity.position
        local radius = 5
        local alien = surface.find_entities_filtered({type = 'unit', position = position, radius = radius, force = 'enemy', limit = 1})
        if alien[1] and alien[1].valid then
            local aliens_table = global.aliens
            alien = alien[1]
            local sample = nil
            if aliens_table.reverse['biter'][alien.name] then
                sample = { name = 'nm-biter-sample', count = 1 }
            elseif aliens_table.reverse['worm-turret'][alien.name] then
                sample = { name = 'nm-worm-sample', count = 1 }
            end
            if sample then
                if event.source then
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

destroyed_entity = function(event)
    local cause = event.cause
    local entity = event.entity
    if entity and entity.valid then
        if entity.type == 'turret' and string.match(entity.name, 'worm') then
            create_worm_hole(entity)
        else
            if cause and cause.valid then
                spice_effects(cause, entity)
            end
        end
    end
end

create_worm_hole = function(entity)
    local surface = entity.surface
    local position = entity.position
    position = surface.find_non_colliding_position('nm-worm-hole', position, 2, 0.5, true)
    if position then
        surface.create_entity({ name = 'nm-worm-hole', position = position })
    end
end

spice_effects = function(cause, victim)
    cause = is_spice_collector(cause, victim)
    if cause and cause.valid then
        -- in case we later want to scale effect based on this
        local spice_amount = has_spice_in_fluidbox(victim) or has_spice_in_inventory(victim)
        if spice_amount then
            local force = cause.force
            if force.valid and force.name == 'enemy' then
                local spice_settings = {
                    ['nm-spice-evolution-factor'] = settings.global['nm-spice-evolution-factor'].value,
                    ['nm-spice-direct-evolution-level'] = settings.global['nm-spice-direct-evolution-level'].value,
                    ['nm-spice-evolve-neighbours'] = settings.global['nm-spice-evolve-neighbours'].value,
                    ['nm-spice-evolve-neighbours-radius'] = settings.global['nm-spice-evolve-neighbours-radius'].value
                }
                force.evolution_factor = force.evolution_factor * spice_settings['nm-spice-evolution-factor']
                cause = evolve_alien(cause, spice_settings['nm-spice-direct-evolution-level'])
                apply_spice_to_alien(cause)
                if spice_settings['nm-spice-evolve-neighbours'] then
                    local surface = cause.surface
                    local position = cause.position
                    local aliens = surface.find_entities_filtered({ name = global.aliens.names, position = position, radius = spice_settings['nm-spice-evolve-neighbours-radius'], force = 'enemy'})
                    for _, alien in pairs(aliens) do
                        if alien ~= cause then evolve_alien(alien, spice_settings['nm-spice-direct-evolution-level'] - 1) end
                    end
                end
            end
        end
    end
end

has_spice_in_fluidbox = function(victim)
    if victim.type ~= 'character' then
        local fluidbox = victim.fluidbox
        if fluidbox and fluidbox.valid then
            for i = 1, #fluidbox, 1 do
                if fluidbox.get_locked_fluid(i) == 'nm-spice-gas' then
                    return fluidbox.get_capacity(i)
                end
            end
        end
    end
    return false
end

has_spice_in_inventory = function(victim)
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
        local amount = inventory.get_item_count('nm-spice')
        if amount > 0 then
            inventory.remove({name = 'nm-spice', count = amount})
            return amount
        end
    end
    return false
end

evolve_alien = function(alien, steps)
    local next_level = get_next_level(alien.name, steps)
    if next_level ~= alien.name then
        local surface = alien.surface
        local position = alien.position
        alien.destroy()
        alien = surface.create_entity({ name = next_level, position = position, force = 'enemy'})
    end
    return alien
end

get_next_level = function(name, steps)
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

apply_spice_to_alien = function(alien)
    local surface = alien.surface
    local position = alien.position
    surface.create_entity({ name = 'nm-spice-speed-sticker', target = alien, position = position })
    surface.create_entity({ name = 'nm-spice-vehicle-regen-sticker', target = alien, position = position })
    return alien
end

-- only allows melee units to collect spice
is_spice_collector = function(cause, victim)
    local aliens_table = global.aliens
    if aliens_table.melee[cause.name] then
        return cause
    else
        local surface = victim.surface
        local position = victim.position
        local brutus = surface.find_entities_filtered({name = aliens_table.names, position = position, radius = 1, force = 'enemy', limit = 1})
        if brutus and brutus.valid then return brutus end
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
