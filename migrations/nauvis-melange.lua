for _, force in pairs(game.forces) do
	local technologies = force.technologies
	local recipes = force.recipes

	if technologies['spice-processing'].researched then
		recipes['solar-component-foil'].enabled = true
	end
end
