require("config.opt")
require("config.keymap")
require("config.autocommand")

-- Keep Lazy last, to make sure keybinds are set correctly.
-- It relies on leader and localleader
require("config.lazy")
