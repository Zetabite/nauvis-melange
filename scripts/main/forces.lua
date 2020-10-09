local forces_table
local competitor_spice_table

function force_created(event)
	local force_index = event.force.index
	forces_table[force_index] = remote.call('nauvis_melange_interface', 'forces_init_values')
end

function forces_merged(event)
	local source_index = event.source_index
	local force_index = event.destination.index
	local spice_count = forces_table[source_index].spice_shipped
	spice_count = spice_count + forces_table[force_index].spice_shipped
	forces_table[force_index].spice_shipped = spice_count
	table.remove(forces_table, source_index)
end

function force_reset(event)
	forces_table[event.force.index] = remote.call('nauvis_melange_interface', 'forces_init_values')
end

function checkSpiceVictory()
	for force_index, entry in pairs(forces_table) do
		if entry.spice_shipped >= remote.call('nauvis_melange_interface', 'spice_for_victory_count') then
			if remote.interfaces['kr-intergalactic-transceiver'] and remote.interfaces['kr-intergalactic-transceiver']['set_no_victory'] then
				remote.call('kr-intergalactic-transceiver', 'set_no_victory', true)
			else
				game.set_game_state({game_finished = true, player_won = true, can_continue = true, victorious_force = game.forces[force_index]})
			end
		end
	end
end

function rocket_launched(event)
	local force_index = event.rocket.force.index
	local spice_count = event.rocket.get_inventory(defines.inventory.rocket).get_item_count('spice')
	spice_count = spice_count + forces_table[force_index].spice_shipped
	forces_table[force_index].spice_shipped = spice_count
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
	[120] = function()
		checkSpiceVictory()
	end
}

lib.on_init = function()
	forces_table = global.forces
	competitor_spice_table = global.competitor_spice
end

lib.on_configuration_changed = function()
	forces_table = global.forces
	competitor_spice_table = global.competitor_spice
end

lib.on_load = function ()
	forces_table = global.forces
	competitor_spice_table = global.competitor_spice
end

return lib
