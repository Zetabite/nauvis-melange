local config = require('scripts.config')

local WATER_INJECTOR_CHECK_TICK = config.WATER_INJECTOR_CHECK_TICK

function built_entity(event)
	local entity = event.created_entity
	if(entity) then
		if entity.name == 'water-injector-proxy' then
			local surface = entity.surface
			local pos = entity.position
			entity.destroy()
			surface.create_entity({name = 'water-injector', position = pos, force = 'neutral'})
		elseif entity.name == 'spacing-guild' then enable_silos(entity)
		elseif entity.name == 'rocket-silo' then enable_silos(entity)
		end
	end
end

--[[
	We only enable silos, but dont disable them, so that once a rocket is launched, it cant be stopped,
	as they are disabled anyways before being launched.
	This might be exploitable, but everything else would only hurt honest players
--]]
function enable_silos(entity)
	local force = entity.force
	local surface = entity.surface
	local spacing_guilds = surface.find_entities_filtered({name = 'spacing-guild', force = force})
	local silos = surface.find_entities_filtered({name = 'rocket-silo', force = force})
	for _, silo in pairs(silos) do
		if #spacing_guilds >= #silos then silo.active = true end
	end
end

function rocket_launch_ordered(event)
	local silo = event.rocket_silo
	local force = silo.force
	local surface = silo.surface
	local spacing_guilds = surface.find_entities_filtered({name = 'spacing-guild', force = force})
	local silos = surface.find_entities_filtered({name = 'rocket-silo', force = force})
	if #spacing_guilds >= #silos then
		force.print({'nauvis-melange.guild-approval-message'})
	else
		force.print({'nauvis-melange.guild-intervention-message'})
	end
	silo.active = (#spacing_guilds >= #silos)
end

function check_water_injectors()
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

-- lib
local lib = {}

lib.events = {
	[defines.events.on_built_entity] = built_entity,
	[defines.events.on_robot_built_entity] = built_entity,
	[defines.events.on_rocket_launch_ordered] = rocket_launch_ordered,
}

lib.on_nth_tick = {
	[WATER_INJECTOR_CHECK_TICK] = function()
		check_water_injectors()
	end
}

return lib
