local handler = require('event_handler')

handler.add_lib(require('scripts.main.setup-globals'))
handler.add_lib(require('scripts.main.aliens'))
handler.add_lib(require('scripts.main.machines'))
handler.add_lib(require('scripts.main.players'))
handler.add_lib(require('scripts.main.resources'))
