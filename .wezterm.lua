-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'kanagawabones'
config.font = wezterm.font 'FiraCode Nerd Font'
config.font_size = 15
config.native_macos_fullscreen_mode = true
config.text_background_opacity = 1.0
config.keys = {
  {
    key = 'r',
    mods = 'CMD|SHIFT',
    action = wezterm.action.ReloadConfiguration,
  },
  {
    key = 'Escape',
    mods = 'CTRL',
    action = wezterm.action.ToggleFullScreen,
  },
  {
    key = 't',
    mods = 'CMD|SHIFT',
    action = wezterm.action.ShowTabNavigator
  },{ key = 'l', mods = 'ALT', action = wezterm.action.ShowLauncher },
}

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.enable_tab_bar = false


local dimmer = { brightness = 0.06 }

local function get_back(opacity)
  local backg = {
    {
      source = {
        File = '/Users/tony/Downloads/thegirl.jpeg',
      },
      width = '100%',
      repeat_x = 'NoRepeat',
      hsb = dimmer,
      opacity = opacity,
    },
  }
  return backg
end

local function recompute_background(window)
  local window_dims = window:get_dimensions()
  local overrides = window:get_config_overrides() or {}
  if window_dims.is_full_screen then
    overrides.background = get_back(1.0)
  else
    overrides.background = get_back(0.6)
    overrides.macos_window_background_blur = 20
  end
  window:set_config_overrides(overrides)
end

wezterm.on('window-resized', function(window)
  recompute_background(window)
end)

wezterm.on('window-config-reloaded', function(window)
  recompute_background(window)
end)

-- and finally, return the configuration to wezterm
return config
