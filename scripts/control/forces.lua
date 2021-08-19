local config = require('scripts.config')
local util = require('util')

local VICTORY_SPICE_AMOUNT = config.VICTORY_SPICE_AMOUNT

force_created = function(event)
    local force = event.force
    local force_index = force.index
    global.forces[force_index] = util.copy(config.default.forces)
    global.forces[force_index].force = force
end

forces_merged = function(event)
    local force_table = global.forces
    local source_index = event.source_index
    local force_index = event.destination.index
    local spice_count = force_table[source_index].spice_shipped
    spice_count = spice_count + force_table[force_index].spice_shipped
    force_table[force_index].spice_shipped = spice_count
    for registration_number, travel_worm in pairs(force_table[source_index]) do
        force_table[force_index]['travel_worms'][registration_number] = travel_worm
    end
    force_table[source_index] = nil
    global.forces = force_table
end

force_reset = function(event)
    local force = event.force
    local force_index = force.index
    global.forces[force_index] = util.copy(config.default.forces)
    global.forces[force_index].force = force
end

checkSpiceVictory = function()
    for force_index, entry in pairs(global.forces) do
        local force = global.forces[force_index]
        if entry.spice_shipped >= VICTORY_SPICE_AMOUNT then
            if remote.interfaces['kr-intergalactic-transceiver'] and remote.interfaces['kr-intergalactic-transceiver']['set_no_victory'] then
                remote.call('kr-intergalactic-transceiver', 'set_no_victory', true)
            else
                game.set_game_state({game_finished = true, player_won = true, can_continue = true, victorious_force = force})
            end
        end
    end
end

rocket_launched = function(event)
    local force_table = global.forces
    local rocket = event.rocket
    local force = rocket.force
    local force_index = force.index
    local spice_count = rocket.get_inventory(defines.inventory.rocket).get_item_count('spice')
    spice_count = spice_count + force_table[force_index].spice_shipped
    force_table[force_index].spice_shipped = spice_count
    global.forces = force_table
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
