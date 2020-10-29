require('prototypes.categories.categories')
require('prototypes.entity.entities')
require('prototypes.autoplace-controls')
require('prototypes.item.items')
require('prototypes.fluid.fluid')
require('prototypes.technology.technology')
require('prototypes.recipe.recipes')

--[[
if not mods['Kux-Zooming'] then
	require('prototypes.shortcuts')
end
--]]

if mods['informatron'] then
	require('scripts.informatron.data')
end
