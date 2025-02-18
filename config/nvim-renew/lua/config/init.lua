print "loaded config"

require("config.opt")
require("config.keymap")

-- Keep Lazy last, to make sure keybinds are set correctly.
-- It relies on leader and localleader
require("config.lazy")
