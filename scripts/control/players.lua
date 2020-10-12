local players_table, spice_effects_blacklist, render_table
local config = require('scripts.config')
local SPICE_DURATION = config.SPICE_DURATION
local SPICE_COOLDOWN = config.SPICE_COOLDOWN
local OVERLAY_REFRESH = config.OVERLAY_REFRESH
local OVERLAY_TIMER = config.OVERLAY_TIMER
local ZOOM_FACTOR = config.ZOOM_FACTOR

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

function vehicle_interaction(event)
	local player = game.get_player(event.player_index)
	apply_spice_to_vehicle(player)
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

-- This is where the spice effects for the player are applied
function used_capsule(event)
	local capsule = event.item
	if string.match(capsule.name, 'spice') then
		local player_index = event.player_index
		local player = game.get_player(player_index)
		if (player.character) then
			consume_spice(player_index, 1.0, 'bad_trip', 1)
		end
	end
end

--[[
-- pre_consumption: in case an initial amount or so was needed that should not be added to the calculation
-- consequence:	'bad_trip': bad_trip should be applied
				'no_consumption': all items should be returned to the inventory if not enough (includes pre_consumed)
				'no_further_consumption': the pre consumed items are not returned
				'nil': proceeds as if enough spice is avaible
--]]
function consume_spice(player_index, factor, consequence, pre_consumed)
	local player = game.get_player(player_index)
	local character = player.character
	local addiction_level = players_table[player_index].addiction_level
	local inventory = character.get_main_inventory()
	local needed = ((1 + addiction_level * addiction_level) * factor)
	if pre_consumed then
		needed = needed - pre_consumed
	end
	if needed > 0 then
		local item = {name = 'spice', count = needed}
		local actual = inventory.remove(item)
		if actual < needed and consequence then
			-- Consequences
			if consequence == 'bad_trip' then
				players_table[player_index].bad_trip.active = true
				players_table[player_index].bad_trip.remaining_ticks = SPICE_DURATION
				if not settings.global['Kux-Running_Enable'].value then
					local speed_modifier = player.character_running_speed_modifier
					player.character_running_speed_modifier = speed_modifier * 0.8
				end
				character.damage(50 * (needed - actual), 'enemy')
			elseif consequence == 'no_consumption' or consequence == 'no_further_consumption' then
				if consequence == 'no_consumption' and pre_consumed then
					actual = actual + pre_consumed
				end
				item = {name = 'spice', count = actual}
				actual = inventory.insert(item)
				if actual > 0 then
					item = {name = 'spice', count = actual}
					local surface = character.surface
					local position = character.position
					surface.spill_item_stack({position = position, items = item, enable_looted = false, force = 'neutral'})
				end
			end
			return false
		end
	end
	if not has_spice_effects(player.character) then
		apply_spice_to_player(player)
	end
	return true
end

function apply_spice_to_player(player)
	local character = player.character
	local surface = player.surface
	local position = player.position
	local addiction_level = players_table[player.index].addiction_level
	players_table[player.index].addiction_level = addiction_level + 1
	-- Create entities/effects
	local radar = surface.create_entity({name = 'spice-radar', position = character.position, force = character.force})
	surface.create_entity({ name = 'spice-speed-sticker', target = character, position = position })
	surface.create_entity({ name = 'spice-regen-sticker', target = character, position = position })
	players_table[player.index].radar.reference = radar
	local craft_modifier = player.character_crafting_speed_modifier
	player.character_crafting_speed_modifier = craft_modifier + 2
	craft_modifier = player.character_crafting_speed_modifier
	-- Table changes
	players_table[player.index].radar.active = true
	players_table[player.index].craft_mod.active = true
	players_table[player.index].radar.remaining_ticks = SPICE_COOLDOWN
	players_table[player.index].craft_mod.remaining_ticks = SPICE_COOLDOWN
	render_table.spice_overlay[player.index] = true
	apply_spice_to_vehicle(player)
end

function player_joined(event)
	local player_index = event.player_index
	if not (players_table[player_index]) then
		players_table[player_index] = remote.call('nauvis_melange_table_defaults', 'players_default')
	end
end

function player_died(event)
	local player_index = event.player_index
	if players_table[player_index].radar.reference then
		players_table[player_index].radar.reference.destroy()
	end
	players_table[player_index] = remote.call('nauvis_melange_table_defaults', 'players_default')
	if render_table.spice_overlay[player_index] then
		table.remove(render_table.spice_overlay, player_index)
	end
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
						if not settings.global['Kux-Running_Enable'].value then
							local speed_modifier = player.character_running_speed_modifier
							player.character_running_speed_modifier = speed_modifier * 1.25
						end
						entry.bad_trip.active = false
					end
				end
				if render_table.spice_overlay[player_index] then
					table.remove(render_table.spice_overlay, player_index)
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

function player_removed(event)
	table.remove(players_table, event.player_index)
	if render_table.spice_overlay[event.player_index] then
		table.remove(render_table.spice_overlay, event.player_index)
	end
end

function overlay_refresh()
	for player_index, _ in pairs(render_table.spice_overlay) do
		local player = game.get_player(player_index)
		local zoom_factor = players_table[player_index].zoom_factor
		rendering.draw_sprite({
			sprite = 'item.spice-overlay',
			x_scale = 160 * zoom_factor,
			y_scale = 90 * zoom_factor,
			tint = {r = 0.04, g = 0.18, b = 0.66},
			target = player.character,
			surface = player.surface,
			time_to_live = OVERLAY_REFRESH + 1,
			player = {player}
		})
	end
end

function load()
	players_table = global.players
	spice_effects_blacklist = global.spice_effects_blacklist
	render_table = global.render_table

	global.SPICE_COOLDOWN = SPICE_COOLDOWN
	global.SPICE_DURATION = SPICE_DURATION
	global.OVERLAY_REFRESH = OVERLAY_REFRESH
	global.OVERLAY_TIMER = OVERLAY_TIMER
	global.ZOOM_FACTOR = ZOOM_FACTOR

	if script.active_mods['Kux-Zooming'] then
		if remote.interfaces['Kux-Zooming'] and remote.interfaces['Kux-Zooming']['onZoomFactorChanged'] then
			remote.call('Kux-Zooming', 'onZoomFactorChanged_add', 'nauvis_melange_player', 'onZoomFactorChanged')
		end
	end
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
	load()
end

lib.on_configuration_changed = function()
	load()
end

lib.on_load = function ()
	load()
end

lib.on_nth_tick = {
	[SPICE_DURATION] = function()
		remove_addiction()
		remove_spice_effects()
	end,
	[OVERLAY_REFRESH] = function()
		overlay_refresh()
	end
}

return lib
