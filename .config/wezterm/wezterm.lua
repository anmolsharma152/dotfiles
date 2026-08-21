local wezterm = require("wezterm")

local function get_random_theme()
	local schemes = {}
	-- In recent versions, use wezterm.color.get_builtin_schemes()
	-- For older versions, use wezterm.get_builtin_color_schemes()
	for name, scheme in pairs(wezterm.color.get_builtin_schemes()) do
		table.insert(schemes, name)
	end
	return schemes[math.random(#schemes)]
end

local config = wezterm.config_builder()

-- Shell
config.default_prog = { "/usr/bin/fish" }

-- Font
config.font = wezterm.font("MesloLGS Nerd Font")
config.font_size = 14.0
config.line_height = 1.1

-- Theme Configuration (Synchronized with GNOME / Hyprland)
local has_theme, current_theme = pcall(require, "theme")
config.color_scheme = has_theme and current_theme or "Catppuccin Mocha"
config.front_end = "OpenGL"

-- Padding (similar to Alacritty)
config.window_padding = {
	left = 4,
	right = 4,
	top = 4,
	bottom = 4,
}
-- Copy on select
config.mouse_bindings = {
	-- Left-click drag to select text and automatically copy to clipboard
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "NONE",
		action = wezterm.action_callback(function(window, pane)
			local has_selection = pane:get_selection_text()
			if has_selection and #has_selection > 0 then
				window:perform_action(wezterm.action.CopyTo("Clipboard"), pane)
			end
		end),
	},
}

config.enable_kitty_keyboard = true

-- Key bindings for tabs, panes, navigation, zoom, and resizing
config.keys = {
	-- Copy & Paste
	{ key = "C", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo("Clipboard") },
	{ key = "V", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("Clipboard") },

	-- Tabs
	{ key = "T", mods = "CTRL|SHIFT", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
	{ key = "W", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentPane({ confirm = false }) },
	{ key = "PageDown", mods = "CTRL", action = wezterm.action.ActivateTabRelative(1) },
	{ key = "PageUp", mods = "CTRL", action = wezterm.action.ActivateTabRelative(-1) },

	-- Splits (Panes)
	{ key = "O", mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "E", mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },

	-- Split Navigation (Ctrl + Arrow Keys)
	{ key = "LeftArrow", mods = "CTRL", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "RightArrow", mods = "CTRL", action = wezterm.action.ActivatePaneDirection("Right") },
	{ key = "UpArrow", mods = "CTRL", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "DownArrow", mods = "CTRL", action = wezterm.action.ActivatePaneDirection("Down") },

	-- Toggle Zoom / Fullscreen Pane
	{ key = "Enter", mods = "CTRL|SHIFT", action = wezterm.action.TogglePaneZoomState },

	-- Resizing Splits (Ctrl + Shift + Arrow Keys)
	{ key = "LeftArrow", mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ "Left", 5 }) },
	{ key = "RightArrow", mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ "Right", 5 }) },
	{ key = "UpArrow", mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ "Up", 5 }) },
	{ key = "DownArrow", mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ "Down", 5 }) },
}

-- Cursor
config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 800

-- Appearance
config.window_background_opacity = 1.0
--config.window_decorations = "NONE"
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

-- Terminal behavior
config.initial_cols = 90
config.initial_rows = 26
config.scrollback_lines = 5000
config.set_environment_variables = {
	TERM = "xterm-256color",
}

-- Compatibility
config.enable_wayland = false
config.prefer_egl = true
config.check_for_updates = false

return config
