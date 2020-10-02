local tiers = {[1] = 'small', [2] = 'medium', [3] = 'big', [4] = 'behemoth'}

for type_name, _ in pairs(global.enum_aliens) do
	for tier, tier_name in pairs(tiers) do
		local alien = {}
		alien.name = tier_name .. '-' .. type_name
		alien.collector = type_name == 'biter'
		table.insert(global.enum_aliens[type_name], tier, alien)
	end
end
