-- Pull in the wezterm API
local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "kanagawabones"
config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 15
config.native_macos_fullscreen_mode = true
config.text_background_opacity = 1.0
config.keys = {
	{
		key = "r",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ReloadConfiguration,
	},
	{
		key = "Escape",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ToggleFullScreen,
	},
	{
		key = "t",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ShowTabNavigator,
	},
	{
		key = "q",
		mods = "CTRL|SHIFT",
		action = wezterm.action.QuitApplication,
	},
	{
		key = "l",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|TABS|WORKSPACES|COMMANDS" }),
	},
	{
		key = "w",
		mods = "CTRL|SHIFT",
		action = act.PromptInputLine({
			description = wezterm.format({
				{ Attribute = { Intensity = "Bold" } },
				{ Foreground = { AnsiColor = "Fuchsia" } },
				{ Text = "Enter name for new workspace" },
			}),
			action = wezterm.action_callback(function(window, pane, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:perform_action(
						act.SwitchToWorkspace({
							name = line,
						}),
						pane
					)
				end
			end),
		}),
	},
	{
		key = "s",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SplitPane({
			direction = "Up",
			size = { Percent = 70 },
		}),
	},
}

config.window_decorations = "RESIZE"

config.window_padding = {
	left = 10,
	right = 10,
	top = 10,
	bottom = 0,
}
config.enable_tab_bar = false

local dimmer = { brightness = 0.06 }

local function get_back(opacity)
	local backg = {
		{
			source = {
				File = "/Users/tony/Downloads/thegirl.jpeg",
			},
			width = "100%",
			repeat_x = "NoRepeat",
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

wezterm.on("window-resized", function(window)
	recompute_background(window)
end)

wezterm.on("window-config-reloaded", function(window)
	recompute_background(window)
end)

wezterm.on("user-var-changed", function(window, pane, name, value)
	local overrides = window:get_config_overrides() or {}
	if name == "ZEN_MODE" then
		local incremental = value:find("+")
		local number_value = tonumber(value)
		if incremental ~= nil then
			while number_value > 0 do
				window:perform_action(wezterm.action.IncreaseFontSize, pane)
				number_value = number_value - 1
			end
			overrides.enable_tab_bar = false
		elseif number_value < 0 then
			while number_value <= 0 do
				window:perform_action(wezterm.action.DecreaseFontSize, pane)
				number_value = number_value + 1
			end
			overrides.enable_tab_bar = false
		else
			overrides.font_size = number_value
			overrides.enable_tab_bar = false
		end
	end
	window:set_config_overrides(overrides)
end)

return config
