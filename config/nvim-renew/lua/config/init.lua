require("config.opt")
require("config.keymap")
require("config.autocommand")
require("config.theme")
require("config.lsp")

-- Keep Lazy last, to make sure keybinds are set correctly.
-- It relies on leader and localleader
require("config.lazy")
