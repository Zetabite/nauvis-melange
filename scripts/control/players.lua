local config = require('scripts.config')

local PLAYER_CHECK_TICK = config.PLAYER_CHECK_TICK
local RENDER_REFRESH_TICK = config.RENDER_REFRESH_TICK
local OVERLAY_TIMER = config.OVERLAY_TIMER
local SPICE_DURATION = config.SPICE_DURATION
local effect_table = config.effect_table

remote.add_interface('nauvis_melange_player', {
	consume_spice = function(player_index, factor, consequence, pre_consumption)
		return consume_spice(player_index, factor, consequence, pre_consumption)
	end,
	onZoomFactorChanged = function(event)
		global.players[event.playerIndex].zoom_factor = event.zoomFactor
	end,
	spice_influence_changed_add = function(interface_name, function_name)
		global.callbacks = global.callbacks or {}
		global.callbacks.spice_influence_changed = global.callbacks.spice_influence_changed or {}

		local id = interface_name..'-'..function_name
		local entry = {
			interface_name = interface_name,
			function_name = function_name,
		}
		global.callbacks.spice_influence_changed[id] = entry
	end,
	spice_influence_changed_remove = function(interface_name, function_name)
		global.callbacks = global.callbacks or {}
		global.callbacks.spice_influence_changed = global.callbacks.spice_influence_changed or {}
		local id = interface_name..'-'..function_name
		global.callbacks.spice_influence_changed[id] = nil
	end,
	has_spice_influence = function(player_index)
		return has_spice_influence(player_index)
	end
})

function has_spice_influence(player_index)
	local entry = global.players[player_index]
	if entry.radar.tick or entry.craft_mod.tick then
		return true
	end
	return false
end

function has_bad_trip(player_index)
	if global.players[player_index].bad_trip.tick then
		return true
	end
	return false
end

function spice_influence_changed_raise(player_index)
	global.callbacks = global.callbacks or {}
	global.callbacks.spice_effects_changed = global.callbacks.spice_effects_changed or {}
	if has_spice_influence(player_index) then
		game.get_player(player_index).print("Spice status: on")
	else
		game.get_player(player_index).print("Spice status: off")
	end
	local event = {
		player_index = player_index,
		on_spice = has_spice_influence(player_index)
	}
	for _, entry in pairs(global.callbacks.spice_effects_changed) do
		if entry then
			remote.call(entry.interface_name, entry.function_name, event)
		end
	end
end

function apply_spice_to_vehicle(player)
	if (player.vehicle) then
		local vehicle = player.vehicle
		if vehicle.type == 'car' and not global.spice_effects_blacklist['name'][vehicle.name] then
			if not has_spice_effects(vehicle) then
				local surface = vehicle.surface
				local position = vehicle.position
				surface.create_entity({ name = 'spice-applied-sticker', target = vehicle, position = position })
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

-- This is where the spice effects for the player are applied
local manage = {
	radar = {
		enable = function(player_index)
			local player = game.get_player(player_index)
			local radar = global.players[player_index].radar
			local character = player.character
			local surface = character.surface
			local position = character.position
			local reference = surface.create_entity({name = 'spice-radar', position = position, force = character.force})
			radar.reference = reference
			radar.tick = game.tick
		end,
		disable = function(player_index)
			local radar = global.players[player_index].radar
			if radar.reference then
				radar.reference.destroy()
			end
			radar.reference = false
			radar.tick = false
		end,
	},

	craft_mod = {
		enable = function(player_index)
			local player = game.get_player(player_index)
			local craft_modifier = player.character_crafting_speed_modifier
			player.character_crafting_speed_modifier = craft_modifier + 2
			craft_modifier = player.character_crafting_speed_modifier
			global.players[player_index].craft_mod.tick = game.tick
		end,
		disable = function(player_index)
			local player = game.get_player(player_index)
			local craft_modifier = player.character_crafting_speed_modifier
			player.character_crafting_speed_modifier = craft_modifier - 2
			global.players[player_index].craft_mod.tick = false
		end,
	},

	bad_trip = {
		enable = function(player_index)
			if not settings.global['Kux-Running_Enable'].value then
				local player = game.get_player(player_index)
				local speed_modifier = player.character_running_speed_modifier
				player.character_running_speed_modifier = speed_modifier * 0.8
			end
			global.players[player_index].bad_trip.tick = game.tick
		end,
		disable = function(player_index)
			if not settings.global['Kux-Running_Enable'].value then
				local player = game.get_player(player_index)
				local speed_modifier = player.character_running_speed_modifier
				player.character_running_speed_modifier = speed_modifier * 0.5
			end
			global.players[player_index].bad_trip.tick = false
		end
	}
}

function used_capsule(event)
	local capsule = event.item
	if capsule.name == 'spice' then
		local player_index = event.player_index
		local player = game.get_player(player_index)
		if (player.character) then
			consume_spice(player_index, 1.0, 'bad_trip', 1)
		end
	end
end

--[[
-- pre_consumption: in case an initial amount or so was needed that should not be added to the calculation
-- consequence:	'bad_trip': bad_trip should be applied and items are consumed
				'no_consumption': no item is consumed
				'no_effect': nothings happens, but the items are consumed
				'nil': proceeds without checking if enough items exist and removes items
--]]
function consume_spice(player_index, factor, consequence, pre_consumed)
	local player = game.get_player(player_index)
	local character = player.character
	local addiction_level = global.players[player_index].addiction_level
	local inventory = character.get_main_inventory()
	local needed = 0
	if factor > 0 then
		needed = ((1 + addiction_level * addiction_level) * factor)
		if pre_consumed and pre_consumed > 0 then
			needed = needed - pre_consumed
		end
	end
	if needed > 0 then
		local item = {name = 'spice', count = needed}
		if consequence then
			local actual = inventory.get_item_count('spice')
			if actual < needed then
				-- Consequences
				if consequence == 'no_effect' or consequence == 'bad_trip' then
					inventory.remove(item)
					if consequence == 'bad_trip' then
						manage.bad_trip.enable(player_index)
						character.damage(50 * (needed - actual), 'enemy')
					end
				elseif consequence == 'no_consumption' then
					if pre_consumed > 0 then
						item = {name = 'spice', count = pre_consumed}
						inventory.insert(item)
					end
				end
				return false
			end
		end
		inventory.remove(item)
	end
	if not has_spice_influence(player_index) then
		apply_spice_to_player(player)
	end
	return true
end

function apply_spice_to_player(player)
	local players_table = global.players
	local character = player.character
	local surface = character.surface
	local position = character.position
	local player_index = player.index
	local addiction_level = players_table[player_index].addiction_level
	players_table[player_index].addiction_level = addiction_level + 1
	-- Create entities/effects
	if not settings.global['Kux-Running_Enable'].value then
		surface.create_entity({ name = 'spice-speed-sticker', target = character, position = position })
	end
	surface.create_entity({ name = 'spice-regen-sticker', target = character, position = position })
	-- Table changes
	global.render_table.spice_overlay[player_index] = true
	manage.radar.enable(player_index)
	manage.craft_mod.enable(player_index)
	apply_spice_to_vehicle(player)
	spice_influence_changed_raise(player_index)
end

function player_joined(event)
	local players_table = global.players
	local player_index = event.player_index
	players_table[player_index] = players_table[player_index] or config.default.players
	if has_spice_influence(player_index) then
		global.render_table.spice_overlay[player_index] = true
	end
end

function player_died(event)
	local player_index = event.player_index
	try_to_remove_spice_effects(player_index, true)
end

function remove_addiction()
	for _, player in pairs(game.connected_players) do
		if player.character then
			local players_table = global.players
			local addiction_level = players_table[player.index].addiction_level
			if addiction_level > 0 and math.random(0, 100) > 90 then
				players_table[player.index].addiction_level = addiction_level - 1
			end
		end
	end
end

function try_to_remove_spice_effects(player_index, ignore)
	local players_table = global.players or {}
	local player = game.get_player(player_index)
	if player.character or ignore then
		local entry = players_table[player_index]
		for _, key in pairs(effect_table) do
			local value = entry[key]
			if value.tick then
				if value.tick <= (game.tick - value.duration) or ignore then
					manage[key].disable(player_index)
				end
			end
		end
		if not has_spice_influence(player_index) then
			local render_table = global.render_table
			if render_table.spice_overlay[player_index] then
				render_table.spice_overlay[player_index] = nil
			end
			spice_influence_changed_raise(player_index)
		end
	end
end

function player_check()
	for _, player in pairs(game.connected_players) do
		local player_index = player.index
		if has_spice_influence(player_index) or has_bad_trip(player_index) then
			try_to_remove_spice_effects(player_index, false)
		end
	end
end

function player_moved(event)
	local player_index = event.player_index
	local player = game.get_player(player_index)
	if (player.character) then
		local character = player.character
		if has_spice_influence(player_index) then
			local radar = global.players[player_index].radar
			local surface = character.surface
			local reference = surface.create_entity({name = 'spice-radar', position = character.position, force = character.force})
			if radar.reference then
				radar.reference.destroy()
			end
			radar.reference = reference
		end
	end
end

function player_removed(event)
	local player_index = event.player_index
	global.players[player_index] = nil
	global.render_table.spice_overlay[player_index] = nil
end

function player_left(event)
	local player_index = event.player_index
	global.render_table.spice_overlay[player_index] = nil
end

function has_spice_effects(entity)
	if (entity.stickers) then
		for _, sticker in pairs(entity.stickers) do
			if sticker.name == 'spice-applied-sticker' then
				return true
			end
		end
	end
	return false
end

function render_refresh()
	for player_index, _ in pairs(global.render_table.spice_overlay) do
		local player = game.get_player(player_index)
		local zoom_factor = global.players[player_index].zoom_factor
		rendering.draw_sprite({
			sprite = 'item.spice-overlay',
			x_scale = 160 * zoom_factor,
			y_scale = 90 * zoom_factor,
			tint = {r = 0.04, g = 0.18, b = 0.66},
			target = player.character,
			surface = player.surface,
			time_to_live = OVERLAY_TIMER,
			player = {player}
		})
	end
end

function check_and_call_kux_zooming()
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
	[defines.events.on_player_left_game] = player_left,
	[defines.events.on_player_kicked] = player_left,
}

lib.on_init = function()
	check_and_call_kux_zooming()
end

lib.on_configuration_changed = function()
	check_and_call_kux_zooming()
end

lib.on_load = function ()
	check_and_call_kux_zooming()
end

lib.on_nth_tick = {
	[SPICE_DURATION] = function()
		remove_addiction()
	end,
	[PLAYER_CHECK_TICK] = function()
		player_check()
	end,
	[RENDER_REFRESH_TICK] = function()
		render_refresh()
	end
}

return lib
