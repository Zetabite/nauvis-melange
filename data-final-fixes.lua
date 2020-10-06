-- Adjusting recipes
local satellite = data.raw['recipe']['satellite']
table.insert(satellite.ingredients, {'biter-navigator', 1})
local spidertron = data.raw['recipe']['spidertron']
spidertron.normal.ingredients = {
	{'exoskeleton-equipment', 4},
	{'fusion-reactor-equipment', 2},
	{'rocket-launcher', 4},
	{'rocket-control-unit', 16},
	{'low-density-structure', 150},
	{'radar', 2},
	{'effectivity-module-3', 2},
	{'fish-navigator', 1},
}

-- Adjusting techs
local rocket_silo = data.raw['technology']['rocket-silo']
table.insert(rocket_silo.prerequisites, 'spacing-guild')
