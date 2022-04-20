local config = require('scripts.config')
local misc = require('__flib__.misc')
local util = require('util')
-- correct animation
local travel_worm_tier = config.travel_worm_tier

local main_frame_count = 60
local preparing_livetime = config.travel_worm_digging_time
local main_animation_speed = main_frame_count / preparing_livetime
local main_frame_count_scaled = main_frame_count / main_animation_speed

local dust_frame_count = 60
local dust_fade_in = config.travel_worm_dust.fade_in
local dust_fade_out = config.travel_worm_dust.fade_out
local dust_full = config.travel_worm_dust.full
local dust_animation_speed = 1
local dust_frame_count_scaled = dust_frame_count / dust_animation_speed
local dust_offset = - 1

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
            global.travel_worm_data[registration_number] = util.copy(config.default.travel_worm_data)
            global.forces[creator_force.index]['travel_worms'][registration_number] = entity
        end
    end
end

destroyed_entity = function(event)
    local registration_number = event.registration_number
    local unit_number = event.unit_number

    if unit_number then
        if global.track_dune_miners[unit_number] then
            table.remove(global.track_dune_miners, unit_number)
        end
    else
        if global.track_travel_worms[registration_number] then
            local entity = global.track_travel_worms[registration_number]
            table.remove(global.forces[entity.force.index]['travel_worms'], registration_number)
            table.remove(global.track_travel_worms, registration_number)
            table.remove(global.travel_worm_data, registration_number)
            if global.render_table.travel_worms[registration_number] then
                table.remove(global.render_table.travel_worms, registration_number)
            end
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
    local tier = entry.tier
    local dest_pos = entry.dest_pos
    local source_pos = entry.source_pos
    local scale = entry.scale

    if worm and worm.valid and surface.name == player.surface.name then
        if stage == '0' then
            -- If player exists, we will continue, else we break up here
            if player then
                rendering.draw_animation({
                    animation = 'nm-heavy-travel-worm-dust-fade-in-bottom',
                    animation_speed = dust_animation_speed,
                    animation_offset = - ((game.tick % dust_frame_count_scaled) * dust_animation_speed),
                    time_to_live = dust_fade_in,
                    x_scale = scale,
                    y_scale = scale,
                    surface = surface,
                    target = source_pos,
                    render_layer = 130,
                })
                rendering.draw_animation({
                    animation = 'nm-heavy-travel-worm-dust-fade-in-top',
                    animation_speed = dust_animation_speed,
                    animation_offset = - ((game.tick % dust_frame_count_scaled) * dust_animation_speed),
                    time_to_live = dust_fade_in,
                    x_scale = scale,
                    y_scale = scale,
                    surface = surface,
                    target = source_pos,
                    render_layer = 132,
                })

                entry.deadline = game.tick + dust_fade_in + dust_offset
                entry.stage = '1'
            else
                entry.stage = 'final'
                entry.deadline = game.tick
            end
        elseif stage == '1' then
            rendering.draw_animation({
                animation = 'nm-heavy-travel-worm-dust-full-bottom',
                animation_speed = dust_animation_speed,
                time_to_live = dust_full,
                x_scale = scale,
                y_scale = scale,
                surface = surface,
                target = source_pos,
                render_layer = 130,
            })
            rendering.draw_animation({
                animation = 'nm-heavy-travel-worm-dust-full-top',
                animation_speed = dust_animation_speed,
                time_to_live = dust_full,
                x_scale = scale,
                y_scale = scale,
                surface = surface,
                target = source_pos,
                render_layer = 132,
            })
            rendering.draw_animation({
                animation = 'nm-submerge-animation-travel-worm-'..tier,
                animation_speed = main_animation_speed,
                animation_offset = - ((game.tick % main_frame_count_scaled) * main_animation_speed),
                time_to_live = preparing_livetime,
                surface = surface,
                target = source_pos,
                render_layer = 131,
            })

            entry.deadline = game.tick + dust_full - dust_fade_in
            entry.stage = '2'
        elseif stage == '2' then
            rendering.draw_animation({
                animation = 'nm-heavy-travel-worm-dust-fade-in-bottom',
                animation_speed = dust_animation_speed,
                animation_offset = - ((game.tick % dust_frame_count_scaled) * dust_animation_speed),
                time_to_live = dust_fade_in,
                x_scale = scale,
                y_scale = scale,
                surface = surface,
                target = dest_pos,
                render_layer = 130,
            })
            rendering.draw_animation({
                animation = 'nm-heavy-travel-worm-dust-fade-in-top',
                animation_speed = dust_animation_speed,
                animation_offset = - ((game.tick % dust_frame_count_scaled) * dust_animation_speed),
                time_to_live = dust_fade_in,
                x_scale = scale,
                y_scale = scale,
                surface = surface,
                target = dest_pos,
                render_layer = 132,
            })

            entry.deadline = game.tick + dust_fade_in + dust_offset
            entry.stage = '3'
        elseif stage == '3' then
            worm.teleport(dest_pos, surface)

            rendering.draw_animation({
                animation = 'nm-heavy-travel-worm-dust-fade-out-bottom',
                animation_speed = dust_animation_speed,
                animation_offset = - ((game.tick % dust_frame_count_scaled) * dust_animation_speed),
                time_to_live = dust_fade_out,
                x_scale = scale,
                y_scale = scale,
                surface = surface,
                target = source_pos,
                render_layer = 130,
            })
            rendering.draw_animation({
                animation = 'nm-heavy-travel-worm-dust-fade-out-top',
                animation_speed = dust_animation_speed,
                animation_offset = - ((game.tick % dust_frame_count_scaled) * dust_animation_speed),
                time_to_live = dust_fade_out,
                x_scale = scale,
                y_scale = scale,
                surface = surface,
                target = source_pos,
                render_layer = 132,
            })
            rendering.draw_animation({
                animation = 'nm-heavy-travel-worm-dust-full-bottom',
                animation_speed = dust_animation_speed,
                time_to_live = dust_full,
                x_scale = scale,
                y_scale = scale,
                surface = surface,
                target = dest_pos,
                render_layer = 130,
            })
            rendering.draw_animation({
                animation = 'nm-heavy-travel-worm-dust-full-top',
                animation_speed = dust_animation_speed,
                time_to_live = dust_full,
                x_scale = scale,
                y_scale = scale,
                surface = surface,
                target = dest_pos,
                render_layer = 132,
            })
            rendering.draw_animation({
                animation = 'nm-emerge-animation-travel-worm-'..tier,
                animation_speed = main_animation_speed,
                animation_offset = - ((game.tick % main_frame_count_scaled) * main_animation_speed),
                time_to_live = preparing_livetime,
                surface = surface,
                target = dest_pos,
                render_layer = 131,
            })

            entry.deadline = game.tick + dust_full + dust_offset
            entry.stage = 'final'
        elseif stage == 'final' then
            rendering.draw_animation({
                animation = 'nm-heavy-travel-worm-dust-fade-out-bottom',
                animation_speed = dust_animation_speed,
                animation_offset = - ((game.tick % dust_frame_count_scaled) * dust_animation_speed),
                time_to_live = dust_fade_out,
                x_scale = scale,
                y_scale = scale,
                surface = surface,
                target = dest_pos,
                render_layer = 130,
            })
            rendering.draw_animation({
                animation = 'nm-heavy-travel-worm-dust-fade-out-top',
                animation_speed = dust_animation_speed,
                animation_offset = - ((game.tick % dust_frame_count_scaled) * dust_animation_speed),
                time_to_live = dust_fade_out,
                x_scale = scale,
                y_scale = scale,
                surface = surface,
                target = dest_pos,
                render_layer = 132,
            })

            entry = util.copy(config.default.travel_worm_data)
        end
    else
        entry = worm.valid
    end
    global.travel_worm_data[registration_number] = entry
end

used_capsule = function(event)
    local player_index = event.player_index
    local player = game.get_player(player_index)
    local pos = event.position
    local force_index = player.force.index

    if event.item.name == 'nm-thumper' or event.item.name == 'nm-thumper-creative'then
        local worm = false
        local prev_distance = false
        local registration_number = false
        local distance = 0

        for reg_number, travel_worm in pairs(global.forces[force_index]['travel_worms']) do
            if travel_worm and travel_worm.valid and global.travel_worm_data[reg_number].lock == 'free' then
                if not travel_worm.get_driver() and not travel_worm.get_passenger() then
                    if player.surface.index == travel_worm.surface.index then
                        distance = misc.get_distance(pos, travel_worm.position)
                        if not prev_distance or prev_distance > distance then
                            if registration_number then
                                global.travel_worm_data[registration_number].lock = 'free'
                            end
                            global.travel_worm_data[reg_number].lock = 'locked'
                            prev_distance = distance
                            worm = travel_worm
                            registration_number = reg_number
                        end
                    end
                end
            end
        end
        if worm and worm.valid then
            local dest_pos = player.position
            local search_box = {
                left_top = {dest_pos.x - 5, dest_pos.y - 5},
                right_bottom = {dest_pos.x + 5, dest_pos.y + 5}
            }
            dest_pos = worm.surface.find_non_colliding_position_in_box(worm.name, search_box, 0.5)
            local entry = {
                worm = worm,
                player = player,
                stage = '0',
                source_pos = worm.position,
                dest_pos = dest_pos,
                scale = config.travel_worm_dust.scaling[travel_worm_tier[worm.name]],
                tier = travel_worm_tier[worm.name],
                deadline = false
            }
            global.travel_worm_data[registration_number] = entry
            call_travel_worm(registration_number)
        end
    end
end

check_travel_worm_animations = function()
    for registration_number, entry in pairs(global.travel_worm_data) do
        if entry.deadline and entry and game.tick >= entry.deadline then
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
    end,
    [config.HIGHEST_FIDELITY_CHECK_TICK] = function()
        check_travel_worm_animations()
    end
}

return lib
