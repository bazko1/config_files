local wezterm = require 'wezterm'
local config = {}

config.color_scheme = 'OneHalfDark'
config.font = wezterm.font 'CaskaydiaCove Nerd Font Mono'
config.enable_tab_bar = false
config.default_prog = { 'wsl', '--cd', '~' }
config.keys = {
  {
    key = 'n',
    mods = 'SHIFT|CTRL',
    action = wezterm.action.ToggleFullScreen,
  },
}

return config
