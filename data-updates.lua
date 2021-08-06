local migration = require('__flib__.migration')

-- Adjusting recipes
local satellite = data.raw['recipe']['satellite']
table.insert(satellite.ingredients, {'nm-biter-navigator', 1})

if mods['base'] and migration.is_newer_version('0.18', mods['base']) then
    local spidertron = data.raw['recipe']['spidertron']
    spidertron.ingredients = {
        {'exoskeleton-equipment', 4},
        {'fusion-reactor-equipment', 2},
        {'rocket-launcher', 4},
        {'rocket-control-unit', 16},
        {'low-density-structure', 150},
        {'radar', 2},
        {'effectivity-module-3', 2},
        {'nm-fish-navigator', 1},
    }
end

if mods['space-exploration'] then
    require('scripts.space-exploration.data-updates')
end
