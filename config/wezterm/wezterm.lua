-- Pull in the wezterm API
local wezterm = require("wezterm")
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

-- colors
local COLORSCHEME = "Catppuccin Mocha"
local colors = wezterm.color.get_builtin_schemes()[COLORSCHEME]
config.color_scheme = COLORSCHEME

local function tab_title(tab_info)
    local title = tab_info.tab_title
    -- if the tab title is explicitly set, take that
    if title and #title > 0 then
        return title
    end
    -- Otherwise, use the title from the active pane
    -- in that tab
    return tab_info.active_pane.title
end

--- Recomputes text for tab title - synchronous in GUI thread
---@param tab TabInformation The active tab
---@param tabs TabInformation[] All tabs in the window
---@param panes PaneInformation[] All panes in the active tab
---@param cfg Config Effective configuration of the window
---@param hover boolean True if the current tab is hovered
---@param max_width integer Max number of cells available to draw this tab (in retro style)
---@return string|table[string, FormatItem] Title of tab
local function format_tab(tab, tabs, panes, cfg, hover, max_width)
    local title = tab_title(tab)
    if tab.is_active then
        return {
            { Foreground = { Color = colors.tab_bar.active_tab.fg_color } },
            { Background = { Color = colors.tab_bar.active_tab.bg_color } },
            { Text = " " .. tostring(tab.tab_index) .. " " },
            { Foreground = { Color = "#FFFFFF" } },
            { Background = { Color = colors.tab_bar.background } },
            { Text = " " .. title .. " " },
        }
    else
        return {
            { Foreground = { Color = colors.tab_bar.inactive_tab.fg_color } },
            { Background = { Color = colors.tab_bar.inactive_tab_edge} },
            { Text = " " .. tostring(tab.tab_index) .. " " },
            { Foreground = { Color = "#AAAAAA" } },
            { Background = { Color = colors.tab_bar.inactive_tab.bg_color } },
            { Text = " " .. title .. " " },
        }
    end
end

-- The filled in variant of the < symbol
local SOLID_LEFT_CIRCLE = wezterm.nerdfonts.ple_left_half_circle_thin

-- The filled in variant of the > symbol
local SOLID_RIGHT_CIRCLE = wezterm.nerdfonts.ple_right_half_circle_thin

--------------------------------------------------------------------------------
-- @SECTION keys
--------------------------------------------------------------------------------
config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 1000 }
-- config.disable_default_key_bindings = true
config.keys = {
    -- Pane / Split Lifetime
    -- super-w closes the current tab (window)
    -- super-t also opens a new tab
    { key = "w", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
    { key = "/", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },

    { key = "z", mods = "LEADER", action = act.TogglePaneZoomState },

    -- Navigation
    split_nav("move", "h"),
    split_nav("move", "j"),
    split_nav("move", "k"),
    split_nav("move", "l"),

    { key = "n", mods = "LEADER|CTRL", action = act.ActivateTabRelative(1) },
    { key = "p", mods = "LEADER|CTRL", action = act.ActivateTabRelative(-1) },
    { key = "j", mods = "ALT",         action = act.ActivateTabRelative(-1) },
    { key = "k", mods = "ALT",         action = act.ActivateTabRelative(1) },

    -- clipboard
    { key = "c", mods = "CTRL|SHIFT",  action = act.CopyTo("Clipboard") },
    { key = "v", mods = "CTRL|SHIFT",  action = act.PasteFrom("Clipboard") },
    -- ctrl-shift-space launches default quick select
    { key = "f", mods = "LEADER",      action = act.QuickSelectArgs({ patterns = { [[\S+]] } }) },
    { key = "[", mods = "LEADER",      action = act.ActivateCopyMode },
}

-- wayland support isn't there quite yet so we turn that off
config.enable_wayland = false

wezterm.on("format-tab-title", format_tab)

-- and finally, return the configuration to wezterm
return config
