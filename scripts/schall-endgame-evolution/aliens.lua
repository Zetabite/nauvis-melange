local config = require('__SchallEndgameEvolution__.config.config-1')

for type_name, _ in pairs(global.enum_aliens) do
	if type_name ~= 'worm-turret' then
		for tier = 5, config.tier_max, 1 do
			local alien = {}
			alien.name = 'Schall-category-' .. tier .. '-' .. type_name
			alien.collector = type_name == 'biter'
			table.insert(global.enum_aliens[type_name], tier, alien)
		end
	end
end
