local config = require('scripts.config')

built_entity = function(event)
    local entity = event.created_entity

    if event.destination then
        entity = event.destination
    end

    if entity and entity.valid then
        if entity.name == 'nm-d-u-n-e' then
            script.register_on_entity_destroyed(entity)
            global.track_dune_miners[entity.unit_number] = entity
        end
    end
end

destroyed_entity = function(event)
    if global.track_dune_miners[event.unit_number] then
        global.track_dune_miners[event.unit_number] = nil
    end
end

check_dunes = function()
    for _,dune_miner in pairs(global.track_dune_miners) do
        local entity = dune_miner

        if entity and entity.valid and entity.speed == 0 then
            local surface = game.surfaces[entity.surface.index]
            local pos = entity.position
            -- entity.force.print('D.U.N.E. at ' .. pos.x .. ', ' .. pos.y .. ' on surface ' .. surface.name)
        end
    end
end

-- lib
local lib = {}

lib.events = {
    [defines.events.on_built_entity] = built_entity,
    [defines.events.on_robot_built_entity] = built_entity,
    [defines.events.on_entity_cloned] = built_entity,
    [defines.events.on_entity_destroyed] = destroyed_entity,
}

lib.on_nth_tick = {
    [config.DUNE_MINERS_CHECK_TICK] = function()
        check_dunes()
    end
}

return lib
