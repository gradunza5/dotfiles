require("config.opt")
require("config.keymap")

-- Keep Lazy after opt and keymap, to make sure keybinds are set correctly.
-- It relies on leader and localleader
require("config.lazy")

require("config.autocommand")
require("config.lsp")

-- Theme should be after lazy, so we can be sure that the theme has loaded
require("config.theme")
