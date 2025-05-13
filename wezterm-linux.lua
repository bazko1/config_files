local wezterm = require 'wezterm'
local config = {}

config.color_scheme = 'OneHalfDark'
config.font = wezterm.font 'CaskaydiaCove Nerd Font'
config.font_size = 20
config.enable_tab_bar = false
config.keys = {
  {
    key = 'n',
    mods = 'SHIFT|CTRL',
    action = wezterm.action.ToggleFullScreen,
  },
  {
    key = 'f',
    mods = 'SHIFT|CTRL',
    action = wezterm.action.DisableDefaultAssignment,
  },
  {
    key = 't',
    mods = 'CMD',
    action = wezterm.action.DisableDefaultAssignment,
  },
  {
    key = '*',
    mods = 'CMD',
    action = wezterm.action.DisableDefaultAssignment,
  },
  {
    key = 'Enter',
    mods = 'ALT',
    action = wezterm.action.DisableDefaultAssignment,
  },
  {
    key = 'o',
    mods = 'ALT',
    action = wezterm.action.DisableDefaultAssignment,
  },
  {
    key = 'f',
    mods = 'CTRL',
    action = wezterm.action.DisableDefaultAssignment,
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

config.window_background_opacity = .97

return config
