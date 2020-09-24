local handler = require('event_handler')
handler.add_lib(require('scripts.machines'))
handler.add_lib(require('scripts.resources'))
-- effects for players and vehicles driven by them
handler.add_lib(require('scripts.player-spice-effects'))
handler.add_lib(require('scripts.alien-spice-effects'))
