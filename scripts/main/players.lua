local players_table
local SPICE_COOLDOWN = 18000
local SPICE_DURATION = 3600

function vehicle_interaction(event)
	local player = game.get_player(event.player_index)
	apply_spice_to_vehicle(player)
end

-- This is where the spice effects for the player are applied
function used_capsule(event)
	local capsule = event.item
	if string.match(capsule.name, 'spice') then
		local player_index = event.player_index
		local player = game.get_player(player_index)
		if (player.character) then
			local character = player.character
			local addiction_level = players_table[player_index].addiction_level
			local inventory = character.get_main_inventory()
			local needed = math.floor(-2 + 0.5 * addiction_level * addiction_level)
			if needed >= 1 then
				local item = { name = 'spice', count = needed}
				local actual = inventory.remove(item)
				if actual < needed then
					players_table[player_index].bad_trip.active = true
					players_table[player_index].bad_trip.remaining_ticks = SPICE_COOLDOWN
					local speed_modifier = player.character_running_speed_modifier
					player.character_running_speed_modifier = speed_modifier * 0.8
					character.damage(50 * (needed - actual), 'enemy')
				end
			end
			players_table[player_index].addiction_level = addiction_level + 1
			local surface = character.surface
			local radar = surface.create_entity({name = 'spice-radar', position = character.position, force = character.force})
			players_table[player_index].radar.reference = radar
			local craft_modifier = player.character_crafting_speed_modifier
			player.character_crafting_speed_modifier = craft_modifier + 2
			craft_modifier = player.character_crafting_speed_modifier
			players_table[player_index].radar.active = true
			players_table[player_index].craft_mod.active = true
			players_table[player_index].radar.remaining_ticks = SPICE_COOLDOWN
			players_table[player_index].craft_mod.remaining_ticks = SPICE_COOLDOWN
			draw_spice_overlay(player)
		end
		apply_spice_to_vehicle(player)
	end
end

function has_spice_effects(entity)
	if (entity.stickers) then
		for _, sticker in pairs(entity.stickers) do
			if string.match(sticker.name, 'spice') then
				return true
			end
		end
	end
	return false
end

function apply_spice_to_vehicle(player)
	if (player.vehicle) then
		local vehicle = player.vehicle
		if vehicle.type == 'car' and not spice_effects_blacklist['name'][vehicle.name] then
			if not has_spice_effects(vehicle) then
				local surface = vehicle.surface
				local position = vehicle.position
				surface.create_entity({ name = 'spice-speed-sticker', target = vehicle, position = position })
				surface.create_entity({ name = 'spice-vehicle-regen-sticker', target = vehicle, position = position })
			end
		end
	end
end

function player_joined(event)
	local player_index = event.player_index
	if not (players_table[player_index]) then
		players_table[player_index] = remote.call('nauvis_melange_table_defaults', 'players_default')
	end
end

function player_died(event)
	local player_index = event.player_index
	players_table[player_index].radar.reference.destroy()
	players_table[player_index] = remote.call('nauvis_melange_table_defaults', 'players_default')
end

function remove_addiction()
	for _, player in pairs(game.connected_players) do
		local player_index = player.index
		if player.character then
			local addiction_level = players_table[player_index].addiction_level
			if math.random(0, 100) > 75 and addiction_level > 0 then
				players_table[player_index].addiction_level = addiction_level - 1
			end
		end
	end
end

function remove_spice_effects()
	if (players_table) then
		for player_index, entry in pairs(players_table) do
			local player = game.get_player(player_index)
			if player.character then
				if entry.radar.reference then
					if entry.radar.remaining_ticks > 0 then
						entry.radar.remaining_ticks = entry.radar.remaining_ticks - SPICE_DURATION
					end
					if entry.radar.remaining_ticks <= 0 then
						entry.radar.reference.destroy()
						entry.radar.reference = false
						entry.radar.active = false
					end
				end
				if entry.craft_mod.active then
					if entry.craft_mod.remaining_ticks > 0 then
						entry.craft_mod.remaining_ticks = entry.craft_mod.remaining_ticks - SPICE_DURATION
					end
					if entry.craft_mod.remaining_ticks <= 0 then
						local craft_modifier = player.character_crafting_speed_modifier
						player.character_crafting_speed_modifier = craft_modifier - 2
						entry.craft_mod.active = false
					end
				end
				if entry.bad_trip.active then
					if entry.bad_trip.remaining_ticks > 0 then
						entry.bad_trip.remaining_ticks = entry.bad_trip.remaining_ticks - SPICE_DURATION
					end
					if entry.bad_trip.remaining_ticks <= 0 then
						local speed_modifier = player.character_running_speed_modifier
						player.character_running_speed_modifier = speed_modifier * 1.25
						entry.bad_trip.active = false
					end
				end
			end
		end
	end
end

function player_moved(event)
	local player_index = event.player_index
	local player = game.get_player(player_index)
	if (player.character) then
		local character = player.character
		if has_spice_effects(character) then
			local surface = player.surface
			local radar = surface.create_entity({name = 'spice-radar', position = character.position, force = character.force})
			players_table[player_index].radar.reference.destroy()
			players_table[player_index].radar.reference = radar
		end
	end
end

function draw_spice_overlay(player)
	rendering.draw_sprite({
		sprite = 'item.spice-overlay',
		x_scale = 500,
		y_scale = 300,
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

lib.on_init = function()
	players_table = global.players
	spice_effects_blacklist = global.spice_effects_blacklist
	global.SPICE_COOLDOWN = SPICE_COOLDOWN
	global.SPICE_DURATION = SPICE_DURATION
end

lib.on_configuration_changed = function()
	players_table = global.players
	spice_effects_blacklist = global.spice_effects_blacklist
	global.SPICE_COOLDOWN = SPICE_COOLDOWN
	global.SPICE_DURATION = SPICE_DURATION
end

lib.on_load = function ()
	players_table = global.players
	spice_effects_blacklist = global.spice_effects_blacklist
	global.SPICE_COOLDOWN = SPICE_COOLDOWN
	global.SPICE_DURATION = SPICE_DURATION
end

lib.on_nth_tick = {
	[SPICE_COOLDOWN] = function()
		remove_addiction()
	end,
	[SPICE_DURATION] = function()
		remove_spice_effects()
	end
}

return lib
