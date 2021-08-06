local config = require('scripts.config')

local VICTORY_SPICE_AMOUNT = config.VICTORY_SPICE_AMOUNT

force_created = function(event)
    local force_index = event.force.index
    global.forces[force_index] = config.default.forces
end

forces_merged = function(event)
    local force_table = global.forces
    local source_index = event.source_index
    local force_index = event.destination.index
    local spice_count = force_table[source_index].spice_shipped
    spice_count = spice_count + force_table[force_index].spice_shipped
    force_table[force_index].spice_shipped = spice_count
    force_table[source_index] = nil
end

force_reset = function(event)
    global.forces[event.force.index] = config.default.forces
end

checkSpiceVictory = function()
    for force_index, entry in pairs(global.forces) do
        if entry.spice_shipped >= VICTORY_SPICE_AMOUNT then
            if remote.interfaces['kr-intergalactic-transceiver'] and remote.interfaces['kr-intergalactic-transceiver']['set_no_victory'] then
                remote.call('kr-intergalactic-transceiver', 'set_no_victory', true)
            else
                game.set_game_state({game_finished = true, player_won = true, can_continue = true, victorious_force = game.forces[force_index]})
            end
        end
    end
end

rocket_launched = function(event)
    local force_table = global.forces
    local force_index = event.rocket.force.index
    local spice_count = event.rocket.get_inventory(defines.inventory.rocket).get_item_count('spice')
    spice_count = spice_count + force_table[force_index].spice_shipped
    force_table[force_index].spice_shipped = spice_count
end

-- lib
local lib = {}

lib.events = {
    [defines.events.on_force_created] = force_created,
    [defines.events.on_forces_merged] = forces_merged,
    [defines.events.on_force_reset] = force_reset,
    [defines.events.on_rocket_launched] = rocket_launched,
}

lib.on_nth_tick = {
    [config.VICTORY_CHECK_TICK] = function()
        checkSpiceVictory()
    end
}

return lib
