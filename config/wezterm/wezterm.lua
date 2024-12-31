-- Pull in the wezterm API
local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

-- For example, changing the color scheme:
config.color_scheme = 'Catppuccin Mocha'

config.font = wezterm.font("Hack Nerd Font Mono")
config.font_size = 13

config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"
config.adjust_window_size_when_changing_font_size = false

config.inactive_pane_hsb = {
    saturation = 0.8,
    brightness = 0.7,
}

-- and finally, return the configuration to wezterm
return config
