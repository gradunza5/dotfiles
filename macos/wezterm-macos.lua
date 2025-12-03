-- I am helpers.lua and I should live in ~/.config/wezterm/helpers.lua

local wezterm = require("wezterm")

-- This is the module table that we will export
local module = {}

-- define a function in the module table.
-- Only functions defined in `module` will be exported to
-- code that imports this module.
-- The suggested convention for making modules that update
-- the config is for them to export an `apply_to_config`
-- function that accepts the config object, like this:
---@param config Config The wezterm confguration to modify
function module.apply_to_config(config)
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
			cwd = wezterm.home_dir .. "/Documents/wiki/",
		}):send_text("nvim\n")

		pane:split({
			direction = "Top",
		}):send_text("btop\n")

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

		-- spawn tab for manager
		local mgr_tab, mgr_pane, _ = window:spawn_tab({
			cwd = wezterm.home_dir .. "/work/code/gdma/manager/",
		})
		mgr_tab:set_title("manager")
		mgr_pane:send_text("git status\n")

		mgr_pane
			:split({
				direction = "Right",
			})
			:send_text("nvim\n")

		-- spawn tab for monitor
		local mon_tab, mon_pane, _ = window:spawn_tab({
			cwd = wezterm.home_dir .. "/work/code/gdma/monitor/",
		})
		mon_tab:set_title("monitor")
		mon_pane:send_text("git status\n")

		mon_pane
			:split({
				direction = "Right",
			})
			:send_text("nvim\n")

		mux.set_active_workspace("main")
        first_tab:activate()
	end)
end

-- return our module table
return module
