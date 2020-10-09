local players_table
local SPICE_COOLDOWN = 18000
local SPICE_DURATION = 3600

function vehicle_interaction(event)
	local player = game.get_player(event.player_index)
	apply_spice_to_vehicle(player)
end

function used_capsule(event)
	local capsule = event.item
	if string.match(capsule.name, 'spice') then
		local player_index = event.player_index
		local player = game.get_player(player_index)
		if (player.character) then
			local character = player.character
			local counter = players_table[player_index].counter
			local inventory = character.get_main_inventory()
			local needed = math.floor(-2 + 0.5 * counter * counter)
			if needed >= 1 then
				local item = { name = 'spice', count = needed}
				local actual = inventory.remove(item)
				if actual < needed then
					character.damage(50 * (needed - actual), 'enemy')
					local speed_modifier = character.character_running_speed_modifier
					character.character_running_speed_modifier = speed_modifier - 2
				end
			end
			players_table[player_index].counter = counter + 1
			local surface = character.surface
			local radar = surface.create_entity({name = 'spice-radar', position = character.position, force = character.force})
			players_table[player_index].radar = radar
			players_table[player_index].radar_tick = SPICE_COOLDOWN
			draw_spice_overlay(player)
		end
		apply_spice_to_vehicle(player)
	end
end

function has_spice(entity)
	if (entity.stickers) then
		for _, sticker in pairs(entity.stickers) do
			if string.match(sticker.name, 'spice') then
				return true
			end
		end
	end
	return false
end
--[[
function trigger_addiction(character)
end


function apply_spice_to_character(character)
end
--]]

function apply_spice_to_vehicle(player)
	if (player.vehicle) then
		local vehicle = player.vehicle
		-- might add black list for certain vehicles
		if not has_spice(vehicle) then
			local surface = vehicle.surface
			local position = vehicle.position
			surface.create_entity({ name = 'spice-speed-sticker', target = vehicle, position = position })
			surface.create_entity({ name = 'spice-vehicle-regen-sticker', target = vehicle, position = position })
		end
	end
end

function player_joined(event)
	local player_index = event.player_index
	if not (players_table[player_index]) then
		players_table[player_index] = remote.call('nauvis_melange_interface', 'forces_init_values')
	end
end

function player_died(event)
	local player_index = event.player_index
	players_table[player_index].counter = 0
	players_table[player_index].radar.destroy()
	players_table[player_index].radar = nil
end

function remove_addiction()
	for _, player in pairs(game.connected_players) do
		local player_index = player.index
		if player.character then
			local counter = players_table[player_index].counter
			if math.random(0, 100) > 75 and counter > 0 then
				players_table[player_index].counter = counter - 1
			end
		end
	end
end

function remove_spice_radar()
	if (players_table) then
		for player_index, value in pairs(players_table) do
			if value['radar'] then
				value['radar_tick'] = value['radar_tick'] - SPICE_DURATION
				if value['radar_tick'] <= 0 then
					value['radar'].destroy()
					value['radar'] = false
				end
				players_table[player_index] = value
			end
		end
	end
end

function player_moved(event)
	local player_index = event.player_index
	local player = game.get_player(player_index)
	if (player.character) then
		local character = player.character
		if has_spice(character) then
			local surface = player.surface
			local radar = surface.create_entity({name = 'spice-radar', position = character.position, force = character.force})
			players_table[player_index].radar.destroy()
			players_table[player_index].radar = radar
		end
	end
end

function draw_spice_overlay(player)
	--[[
	rendering.draw_rectangle({
		color = {r = 0.04, g = 0.18, b = 0.66, a = 0.01},
		left_top = {
			player.character.position.x - 960,
			player.character.position.y - 540
		},
		right_bottom = {
			player.character.position.x + 960,
			player.character.position.y + 540
		},
		filled = true,
		target = player.character,
		surface = player.surface,
		time_to_live = SPICE_DURATION,
		player = {player}
	})
	--]]
	rendering.draw_sprite({
		sprite = 'item.spice-overlay',
		x_scale = 160,
		y_scale = 90,
		tint = {r = 0.04, g = 0.18, b = 0.66},
		target = player.character,
		surface = player.surface,
		time_to_live = SPICE_DURATION,
		player = {player}
	})
end

function player_removed(event)
	table.remove(players_table, event.player_index)
end

-- lib
local lib = {}

lib.events = {
	[defines.events.on_player_driving_changed_state] = vehicle_interaction,
	[defines.events.on_player_used_capsule] = used_capsule,
	[defines.events.on_player_joined_game] = player_joined,
	[defines.events.on_player_died] = player_died,
	[defines.events.on_player_changed_position] = player_moved,
	[defines.events.on_player_changed_surface] = player_moved,
	[defines.events.on_player_removed] = player_removed,
}

lib.on_nth_tick = {
	[SPICE_COOLDOWN] = function()
		remove_addiction()
	end,
	[SPICE_DURATION] = function()
		remove_spice_radar()
	end
}

lib.on_init = function()
	players_table = global.players
end

lib.on_configuration_changed = function()
	players_table = global.players
end

lib.on_load = function ()
	players_table = global.players
end

return lib
