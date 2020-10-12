local handler = require('event_handler')

handler.add_lib(require('scripts.control.setup'))
handler.add_lib(require('scripts.control.aliens'))
handler.add_lib(require('scripts.control.machines'))
handler.add_lib(require('scripts.control.players'))
handler.add_lib(require('scripts.control.resources'))
handler.add_lib(require('scripts.control.forces'))

if script.active_mods['informatron'] then
	require('scripts.informatron.control')
end
