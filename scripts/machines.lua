function built_entity(event)
	local entity = event.created_entity
	if(entity) then
		if entity.name == 'water-injector-proxy' then
			local surface = entity.surface
			local pos = entity.position
			entity.destroy()
			surface.create_entity({name = 'water-injector', position = pos, force = 'neutral'})
		end
	end
end

-- lib
local lib = {}

lib.events = {
	[defines.events.on_built_entity] = built_entity,
	[defines.events.on_robot_built_entity] = built_entity,
}

lib.on_nth_tick = {
	[60] = function()
		local surface = game.surfaces[1]
		local water_injectors = surface.find_entities_filtered({name = 'water-injector'})
		for _, entity in pairs(water_injectors) do
			local capacity = entity.fluidbox.get_capacity(1)
			local fluid_count = entity.get_fluid_count('water')
			if (capacity - fluid_count) <= 1000 then
				-- do explosion, create pre spice mass
				local pos = entity.position
				local deposit = surface.find_entity('worm-hole', pos)
				deposit.destroy()
				surface.create_entity({ name = 'explosive-rocket', position = pos, target = entity , force = 'neutral', speed = 0.5 })
				surface.create_entity({ name = 'pre-spice-mass-ore', position = pos, force = 'neutral' })
			end
		end
	end
}

return lib
