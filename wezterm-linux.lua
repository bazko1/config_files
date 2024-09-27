local wezterm = require 'wezterm'
local config = {}

config.color_scheme = 'OneHalfDark'
config.font = wezterm.font 'CaskaydiaCove Nerd Font Mono'
config.enable_tab_bar = false
config.keys = {
  {
    key = 'n',
    mods = 'SHIFT|CTRL',
    action = wezterm.action.ToggleFullScreen,
  },
}

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

return config
