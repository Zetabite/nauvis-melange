local config = require('scripts.config')

remote.add_interface('nauvis_melange_zoom', {
	onZoomFactorChanged = function(event)
		global.players[event.playerIndex].zoom_factor = event.zoomFactor
	end,
})

on_zoom_factor_changed = function(event)
	local player_index = event.player_index
	local zoom_factor = global.players[player_index].zoom_factor
	zoom_factor = zoom_factor + config[event.input_name]
	if zoom_factor > config.MAX then zoom_factor = config.MAX
	elseif zoom_factor < config.MIN then zoom_factor = config.MIN
	end
	global.players[player_index].zoom_factor = zoom_factor
	game.get_player(player_index).print(tostring(zoom_factor))
end

check_and_call_kux_zooming = function()
	if script.active_mods['Kux-Zooming'] then
		if remote.interfaces['Kux-Zooming'] and remote.interfaces['Kux-Zooming']['onZoomFactorChanged'] then
			remote.call('Kux-Zooming', 'onZoomFactorChanged_add', 'nauvis_melange_zoom', 'onZoomFactorChanged')
		end
	else
		script.on_event('nauvis-melange-zoom-in', function(event) on_zoom_factor_changed(event) end)
		script.on_event('nauvis-melange-zoom-out', function(event) on_zoom_factor_changed(event) end)
	end
end

-- lib
local lib = {}

lib.on_init = function()
	check_and_call_kux_zooming()
end

lib.on_configuration_changed = function()
	check_and_call_kux_zooming()
end

lib.on_load = function ()
	check_and_call_kux_zooming()
end

return lib
