local config = require('scripts.config')
--local misc = require('__flib__.misc')
local util = require('util')

local travel_worm_tier = config.travel_worm_tier
local travel_worm_dust_scaling = config.travel_worm_dust_scaling

local frame_count = 60
local preparing_livetime = 60 * 2
local dust_livetime = preparing_livetime + 10
local offset_time = - 60 * 0.5
local main_animation_speed = frame_count / preparing_livetime
local dust_animation_speed = 0.125

built_entity = function(event)
    local entity = event.created_entity or event.destination
    local creator = event.robot or game.get_player(event.player_index)
    local creator_force = creator.force or 'neutral'

    if entity and entity.valid then
        if entity.name == 'nm-d-u-n-e' then
            script.register_on_entity_destroyed(entity)
            global.track_dune_miners[entity.unit_number] = entity
        end
        if string.match(entity.name, 'nm%-travel%-worm%-') then
            local registration_number = script.register_on_entity_destroyed(entity)
            global.track_travel_worms[registration_number] = entity
            global.forces[creator_force.index]['travel_worms'][registration_number] = entity
        end
    end
end

destroyed_entity = function(event)
    local registration_number = event.registration_number
    local unit_number = event.unit_number

    if unit_number then
        if global.track_dune_miners[unit_number] then
            global.track_dune_miners[unit_number] = nil
        end
    else
        if global.track_travel_worms[registration_number] then
            local entity = global.track_travel_worms[registration_number]
            global.forces[entity.force.index]['travel_worms'][registration_number] = nil
            global.track_travel_worms[registration_number] = nil
            global.travel_worm_data[registration_number] = nil
        end
    end
end

check_dunes = function()
    for _,dune_miner in pairs(global.track_dune_miners) do
        local entity = dune_miner

        if entity and entity.valid and entity.speed == 0 then
            local surface = game.surfaces[entity.surface.index]
            local pos = entity.position
            entity.force.print('D.U.N.E. at ' .. pos.x .. ', ' .. pos.y .. ' on surface ' .. surface.name)
        end
    end
end

call_travel_worm = function(registration_number)
    local entry = global.travel_worm_data[registration_number]
    local worm = entry.worm
    local player = entry.player
    local surface = worm.surface
    local stage = entry.stage
    local dust_scale = entry.dust_scale
    local tier = entry.tier
    local render_layer = 'higher-object-under'
    local tint = {a = 0.5}
    local source_pos = entry.source_pos

    if worm and worm.valid and player and surface.name == player.surface.name then
        if stage == 'submerge' then
            rendering.draw_animation({
                animation = 'nm-heavy-travel-worm-dust',
                render_layer = render_layer,
                animation_speed = dust_animation_speed,
                time_to_live = dust_livetime,
                surface = surface,
                target = source_pos,
                x_scale = dust_scale,
                y_scale = dust_scale,
            })
            rendering.draw_animation({
                animation = 'nm-submerge-animation-travel-worm-'..tier,
                render_layer = render_layer,
                animation_speed = main_animation_speed,
                --animation_offset = frame_count - (game.tick % frame_count),
                time_to_live = preparing_livetime,
                surface = surface,
                target = source_pos
            })
            rendering.draw_animation({
                animation = 'nm-heavy-travel-worm-dust',
                render_layer = render_layer,
                animation_speed = dust_animation_speed,
                time_to_live = dust_livetime,
                surface = surface,
                target = source_pos,
                tint = tint,
                x_scale = dust_scale,
                y_scale = dust_scale,
            })
            entry.deadline = preparing_livetime + game.tick + offset_time
            entry.stage = 'emerge'
        elseif stage == 'emerge' then
            local dest_pos = entry.dest_pos
            local search_box = {
                left_top = {dest_pos.x - 5, dest_pos.y - 5},
                right_bottom = {dest_pos.x + 5, dest_pos.y + 5}
            }
            dest_pos = surface.find_non_colliding_position_in_box(worm.name, search_box, 0.5)
            worm.teleport(dest_pos, surface)

            rendering.draw_animation({
                animation = 'nm-heavy-travel-worm-dust',
                render_layer = render_layer,
                animation_speed = dust_animation_speed,
                time_to_live = dust_livetime,
                surface = surface,
                target = dest_pos,
                x_scale = dust_scale,
                y_scale = dust_scale,
            })
            rendering.draw_animation({
                animation = 'nm-emerge-animation-travel-worm-'..tier,
                render_layer = render_layer,
                animation_speed = main_animation_speed,
                --animation_offset = frame_count - (game.tick % frame_count),
                time_to_live = preparing_livetime,
                surface = surface,
                target = dest_pos
            })
            rendering.draw_animation({
                animation = 'nm-heavy-travel-worm-dust',
                render_layer = render_layer,
                animation_speed = dust_animation_speed,
                time_to_live = dust_livetime,
                surface = surface,
                target = dest_pos,
                tint = tint,
                x_scale = dust_scale,
                y_scale = dust_scale,
            })
            entry.deadline = preparing_livetime + game.tick
            entry.stage = 'final'
        elseif stage == 'final' then
            entry = nil
        end
    else
        entry = nil
    end
    global.travel_worm_data[registration_number] = entry
end

used_capsule = function(event)
    local player_index = event.player_index
    local player = game.get_player(player_index)
    local pos = event.position
    local force_index = player.force.index

    if event.item.name == 'nm-thumper' or event.item.name == 'nm-thumper-creative'then
        local target = false
        local prev_distance = false
        local registration_number = false
        local x = 0
        local y = 0
        local distance = 0

        for reg_number, travel_worm in pairs(global.forces[force_index]['travel_worms']) do
            if travel_worm and travel_worm.valid and not global.travel_worm_data[reg_number] then
                if not travel_worm.get_driver() and not travel_worm.get_passenger() then
                    if player.surface.index == travel_worm.surface.index then
                        x = pos.x + travel_worm.position.x
                        x = x * x
                        y = pos.y + travel_worm.position.y
                        y = y * y

                        distance = x + y
                        if not prev_distance or prev_distance > distance then
                            if registration_number then
                                global.travel_worm_data[registration_number] = false
                            end
                            global.travel_worm_data[reg_number] = true
                            prev_distance = distance
                            target = travel_worm
                            registration_number = reg_number
                        end
                    end
                end
            end
        end
        if target and target.valid then
            local entry = {
                worm = target,
                player = player,
                stage = 'submerge',
                source_pos = target.position,
                dest_pos = player.position,
                tier = travel_worm_tier[target.name],
                dust_scale = travel_worm_dust_scaling[target.name]
            }
            global.travel_worm_data[registration_number] = entry
            call_travel_worm(registration_number)
        end
    end
end

check_travel_worm_animations = function()
    for registration_number, entry in pairs(global.travel_worm_data) do
        if game.tick >= entry.deadline then
            call_travel_worm(registration_number)
        end
    end
end

-- lib
local lib = {}

lib.events = {
    [defines.events.on_built_entity] = built_entity,
    [defines.events.on_robot_built_entity] = built_entity,
    [defines.events.on_entity_cloned] = built_entity,
    [defines.events.on_entity_destroyed] = destroyed_entity,
    [defines.events.on_player_used_capsule] = used_capsule,
}

lib.on_nth_tick = {
    [config.HIGH_FIDELITY_CHECK_TICK] = function()
        -- check_dunes()
        check_travel_worm_animations()
    end
}

return lib
