local tiers = { 'small', 'medium', 'big', 'behemoth'}

for _,force in pairs(game.forces) do
    local technologies = force.technologies
    local recipes = force.recipes

    if technologies['nm-spice-processing'].researched then
        for tier,_ in pairs(tiers) do
            recipes['nm-'..tier..'-travel-worm'].enabled = true
            recipes['nm-'..tier..'-sandtrout'].enabled = true
        end
        recipes['nm-thumper'].enabled = true
    end
end
