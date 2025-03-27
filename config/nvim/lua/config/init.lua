require("config.opt")
require("config.lsp")
require("config.keymap")

-- Keep Lazy after opt and keymap, to make sure keybinds are set correctly.
-- It relies on leader and localleader
require("config.lazy")

require("config.autocommand")

-- Theme should be after lazy, so we can be sure that the theme has loaded
require("config.theme")

require("config.wiki")

-- Local functions
_G.F = require("config.fn")
