-- Pull in the wezterm API
local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action

-- This will hold the configuration.
--- @type Config
local config = wezterm.config_builder()

local HJKL2DIRECTION = { h = "Left", j = "Down", k = "Up", l = "Right" }

--------------------------------------------------------------------------------
-- @SECTION functions
--------------------------------------------------------------------------------
--- Smart splits integration
---@param resize_or_move "move"|"resize" action to delegate to smart-splits.nvim
---@param key string Key to forward to neovim
---@return Key WezTerm Key mapping
local function split_nav(resize_or_move, key)
    return {
        key = key,
        mods = resize_or_move == "resize" and "META" or "CTRL",
        action = wezterm.action_callback(function(win, pane)
            if pane:get_user_vars().IS_NVIM == "true" then
                -- pass the keys through to vim/nvim
                win:perform_action({
                    SendKey = { key = key, mods = resize_or_move == "resize" and "META" or "CTRL" },
                }, pane)
            else
                if resize_or_move == "resize" then
                    win:perform_action({ AdjustPaneSize = { HJKL2DIRECTION[key], 3 } }, pane)
                else
                    win:perform_action({ ActivatePaneDirection = HJKL2DIRECTION[key] }, pane)
                end
            end
        end),
    }
end

---@param direction "Left"|"Right"|"Up"|"Down"
---@param amount integer Cells to resize
local function resize_pane(direction, amount)
    return act.Multiple({
        act.AdjustPaneSize({ direction, amount }),
        act.ActivateKeyTable({
            name = "resize_pane",
            replace_current = true,
            until_unknown = true,
            timeout_milliseconds = 750,
        }),
    })
end

--------------------------------------------------------------------------------
-- @SECTION theme
--------------------------------------------------------------------------------
-- For example, changing the color scheme:
config.color_scheme = 'Catppuccin Mocha'

-- font stuff
config.font = wezterm.font("Hack Nerd Font Mono")
config.font_size = 13

-- tab bar and window styling
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"
config.adjust_window_size_when_changing_font_size = false

config.inactive_pane_hsb = {
    saturation = 0.8,
    brightness = 0.7,
}

--------------------------------------------------------------------------------
-- @SECTION keys
--------------------------------------------------------------------------------
config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 1000 }
-- config.disable_default_key_bindings = true
config.keys = {
    -- Pane / Split Lifetime
    { key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
    { key = "/", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },

    { key = "z", mods = "LEADER", action = act.TogglePaneZoomState},

    -- Navigation
    split_nav("move", "h"),
    split_nav("move", "j"),
    split_nav("move", "k"),
    split_nav("move", "l"),
}

-- wayland support isn't there quite yet so we turn that off
config.enable_wayland = false

-- and finally, return the configuration to wezterm
return config
