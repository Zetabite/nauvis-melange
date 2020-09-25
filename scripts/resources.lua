function destroyed_entity(event)
	local entity = event.entity
	if (entity) then
		if entity.type == 'turret' and string.match(entity.name, 'worm') then
			create_worm_hole(entity)
		end
	end
end

function create_worm_hole(entity)
	local surface = entity.surface
	local pos = entity.position
	pos = surface.find_non_colliding_position({ name = 'worm-hole', position = pos, radius = 2, force_to_tile_center = true, precision = 0.5 })
	if (pos) then
		surface.create_entity({ name = 'worm-hole', position = pos })
	end
end

-- lib
local lib = {}

lib.events = {
	[defines.events.script_raised_destroy] = destroyed_entity,
	[defines.events.on_entity_died] = destroyed_entity,
}

return lib
