local wezterm = require 'wezterm'
local config = {}

config.color_scheme = 'OneHalfDark'
config.font = wezterm.font 'CaskaydiaCove Nerd Font Mono'
config.font_size = 22
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

-- custom Catppuccin-Macchiato like color scheme
config.colors = {
  -- The default text color
  foreground = '#CAD3F5',
  -- The default background color
  background = '#24273A',

  cursor_bg = '#F4DBD6',
  cursor_fg = '#24273A',
  ansi = {
    '#494D64', -- surface1
    '#ED8796', -- red
    '#A6DA95', -- green
    '#EED49F', -- yellow
    '#8AADF4', -- blue
    '#F5BDE6', -- pink
    '#8BD5CA', -- teal
    '#B8C0E0', -- subtext1
  },
  brights = {
    '#5B6078', -- surface2
    '#ED8796', -- red
    '#A6DA95', -- green
    '#EED49F', -- yellow
    '#8AADF4', -- blue
    '#F5BDE6', -- pink
    '#8BD5CA', -- teal
    '#A5ADCB', -- subtext0
  },
  indexed = { [16] = '#F5A97F', [17] = '#F4DBD6' }
}

return config
