local wezterm = require("wezterm")
local act = wezterm.action

-- This is the module table that we will export
local module = {}

-- define a function in the module table.
-- Only functions defined in `module` will be exported to
-- code that imports this module.
-- The suggested convention for making modules that update
-- the config is for them to export an `apply_to_config`
-- function that accepts the config object, like this:
---@class config Config The wezterm confguration to modify
function module.apply_to_config(config)

    -- wayland support isn't there quite yet so we turn that off
    config.enable_wayland = false

    config.font_size = 10

	wezterm.on("gui-startup", function(_)
		-- https://wezterm.org/config/lua/pane/split.html
		-- https://wezterm.org/config/lua/mux-window/spawn_tab.html
        --
        local mux = wezterm.mux

		-- spawn main window with wiki and btop
		local first_tab, pane, window = mux.spawn_window({
			workspace = "main",
			cwd = wezterm.home_dir,
		})

		first_tab:set_title("main")

		pane:split({
			direction = "Right",
		}):send_text("nvim\n")

		-- spawn tab with dotfiles open
		local dots_tab, dots_pane, _ = window:spawn_tab({
			cwd = wezterm.home_dir .. "/.config",
		})
		dots_tab:set_title("dots")

		dots_pane
			:split({
				direction = "Right",
			})
			:send_text("nvim\n")

		mux.set_active_workspace("main")

        first_tab:activate()
        pane:activate()
	end)
end

-- return our module table
return module
