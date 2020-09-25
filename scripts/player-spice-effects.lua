function vehicle_interaction(event)
	apply_spice_to_vehicle(event.player_index)
end

function used_capsule(event)
	local capsule = event.item
	if string.match(capsule.name, 'spice') then
		apply_spice_to_vehicle(event.player_index)
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

function apply_spice_to_vehicle(player_index)
	local player = game.get_player(player_index)
	if (player.character) then
		local character = player.character
		if (character.vehicle) then
			local vehicle = character.vehicle
			-- might add black list for certain vehicles
			if not has_spice(vehicle) and has_spice(character) then
				local surface = vehicle.surface
				local position = vehicle.position
				surface.create_entity({ name = 'spice-speed-sticker', target = vehicle, position = position })
				surface.create_entity({ name = 'spice-vehicle-regen-sticker', target = vehicle, position = position })
			end
		end
	end
end

-- lib
local lib = {}

lib.events = {
	[defines.events.on_player_driving_changed_state] = vehicle_interaction,
	[defines.events.on_player_used_capsule] = used_capsule,
}

return lib
