function scale_worm(tier)
    local scale = {
        small = 0.65,
        medium = 0.83,
        big = 1.0,
        behemoth = 1.2
    }
    return scale[tier]
end

function tint_worm(tier)
    local tint = {
        small = {r = 0.7, g = 1, b = 0.3, a = 0.5},
        medium = {r = 0.9, g = 0.15, b = 0.3, a = 1},
        big = {r = 0.34, g = 0.68, b = 0.90, a = 0.8},
        behemoth = {r = 0.3, g = 1, b = 0, a = 0.8}
    }
    return tint[tier]
end

function health_worm(tier)
    local health = {
        small = 200,
        medium = 400,
        big = 750,
        behemoth = 750
    }
    return health[tier]
end

function resistances_worm(tier)
    local resistances = {
        small = {},
        medium = {
        {
            type = "physical",
            decrease = 5
        },
        {
            type = "explosion",
            decrease = 5,
            percent = 15
        },
        {
            type = "fire",
            decrease = 2,
            percent = 50
        }
        },
        big = {
        {
            type = "physical",
            decrease = 10
        },
        {
            type = "explosion",
            decrease = 10,
            percent = 30
        },
        {
            type = "fire",
            decrease = 3,
            percent = 70
        }
        },
        behemoth = {
            {
            type = "physical",
            decrease = 10
            },
            {
            type = "explosion",
            decrease = 10,
            percent = 30
            },
            {
            type = "fire",
            decrease = 3,
            percent = 70
            }
        }
    }
    return resistances[tier]
end

function collision_box_worm(tier)
    local collision_box = {
        small = {{-0.9, -0.8 }, {0.9, 0.8}},
        medium = {{-1.1, -1.0}, {1.1, 1.0}},
        big = {{-1.4, -1.2}, {1.4, 1.2}},
        behemoth = {{-1.4, -1.2}, {1.4, 1.2}}
    }
    return collision_box[tier]
end
