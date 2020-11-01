-- Adjusting techs
local rocket_silo = data.raw['technology']['rocket-silo']
table.insert(rocket_silo.prerequisites, 'spacing-guild')
