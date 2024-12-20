local wezterm = require('wezterm')
local mux = wezterm.mux
local act = wezterm.action

wezterm.on('gui-startup', function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
	window:gui_window():toggle_fullscreen()
end)

return {
	leader = { key = 'b', mods = 'CTRL', timeout_milliseconds = 2001 },
	window_decorations = 'RESIZE',
  font = wezterm.font('MesloLGS NF'),
	-- font = wezterm.font('Iosevka Nerd Font'),

	font_size = 13.5,
	-- line_height = 1.2,
	hide_tab_bar_if_only_one_tab = true,
	keys = {
    {
      key = '|',
      mods = 'LEADER',
      action = wezterm.action.SplitPane {
        direction = 'Right',
        size = { Percent = 50 },
      },
    },
    { key = 'q', action = wezterm.action.DisableDefaultAssignment },
		{
			mods = 'LEADER',
			key = '[',
			action = wezterm.action.ToggleAlwaysOnTop,
		},
		{
			mods = 'LEADER',
			key = ']',
			action = wezterm.action.ToggleAlwaysOnBottom,
		},
		{
			mods = 'LEADER',
			key = 'z',
			action = wezterm.action.TogglePaneZoomState,
		},
		{
			mods = 'LEADER',
			key = 'c',
			action = wezterm.action.SpawnTab('CurrentPaneDomain'),
		},
		{
			mods = 'LEADER',
			key = 'x',
			action = wezterm.action.CloseCurrentPane({ confirm = true }),
		},
		{
			mods = 'LEADER',
			key = 'b',
			action = wezterm.action.ActivateTabRelative(-1),
		},
		{
			mods = 'LEADER',
			key = 'n',
			action = wezterm.action.ActivateTabRelative(1),
		},
		{
			mods = 'LEADER',
			key = '|',
			action = wezterm.action.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
		},
		{
			mods = 'LEADER',
			key = '-',
			action = wezterm.action.SplitVertical({ domain = 'CurrentPaneDomain' }),
		},
		{
			mods = 'LEADER',
			key = 'h',
			action = wezterm.action.ActivatePaneDirection('Left'),
		},
		{
			mods = 'LEADER',
			key = 'j',
			action = wezterm.action.ActivatePaneDirection('Down'),
		},
		{
			mods = 'LEADER',
			key = 'k',
			action = wezterm.action.ActivatePaneDirection('Up'),
		},
		{
			mods = 'LEADER',
			key = 'l',
			action = wezterm.action.ActivatePaneDirection('Right'),
		},
		{
			mods = 'LEADER',
			key = 'LeftArrow',
			action = wezterm.action.AdjustPaneSize({ 'Left', 5 }),
		},
		{
			mods = 'LEADER',
			key = 'RightArrow',
			action = wezterm.action.AdjustPaneSize({ 'Right', 5 }),
		},
		{
			mods = 'LEADER',
			key = 'DownArrow',
			action = wezterm.action.AdjustPaneSize({ 'Down', 5 }),
		},
		{
			mods = 'LEADER',
			key = 'UpArrow',
			action = wezterm.action.AdjustPaneSize({ 'Up', 5 }),
		},
		{
			key = 'r',
			mods = 'CMD|SHIFT',
			action = wezterm.action.ReloadConfiguration,
		},
		{
			key = 'n',
			mods = 'CMD|SHIFT',
			action = wezterm.action.ToggleFullScreen,
		},
		-- { key = 'l', mods = 'CMD|SHIFT', action = act.ActivateTabRelative(1) },
		-- {
		--   key = 'R',
		--   mods = 'CMD|SHIFT',
		--   action = act.PromptInputLine {
		--     description = 'Enter new name for tab',
		--     action = wezterm.action_callback(function(window, _, line)
		--       -- line will be `nil` if they hit escape without entering anything
		--       -- An empty string if they just hit enter
		--       -- Or the actual line of text they wrote
		--       if line then
		--         window:active_tab():set_title(line)
		--       end
		--     end),
		--   },
		-- },
		-- {
		--   key = ',',
		--   mods = 'CMD',
		--   action = act.SpawnCommandInNewTab {
		--     cwd = os.getenv('WEZTERM_CONFIG_DIR'),
		--     set_environment_variables = {
		--       TERM = 'screen-256color',
		--     },
		--     args = {
		--       'nvim',
		--       os.getenv('WEZTERM_CONFIG_FILE'),
		--     },
		--   },
		-- },
		{
			key = 't',
			mods = 'CMD|SHIFT',
			action = act.ShowTabNavigator,
		},
		{
			key = 'K',
			mods = 'CMD',
			action = wezterm.action.SendString('\x0c'),
		},
		{
			key = 'I',
			mods = 'CTRL',
			action = wezterm.action.SendString('\x1b[105;5u'),
		},
		{
			key = '.',
			mods = 'CTRL',
			action = wezterm.action.SendString('\x1b[46;5u'),
		},
		{
			key = ',',
			mods = 'CTRL',
			action = wezterm.action.SendString('\x1b[44;5u'),
		},
		{
			key = ';',
			mods = 'CTRL',
			action = wezterm.action.SendString('\x1b[59;5u'),
		},
		{
			key = 'Enter',
			mods = 'SHIFT',
			action = wezterm.action.SendString('\x1b[13;2u'),
		},
		{
			key = 'Enter',
			mods = 'CTRL',
			action = wezterm.action.SendString('\x1b[13;5u'),
		},
		{
			key = 'Backspace',
			mods = 'CTRL',
			action = wezterm.action.SendString('\x7f'),
		},
	},
	window_frame = {
		font = wezterm.font({ family = 'Noto Sans', weight = 'Regular' }),
	},
	window_padding = {
		-- left = 0,
		-- right = 0,
		-- top = 0,
		-- bottom = 0,
	},
	-- window_background_opacity = 0.8,
	scrollback_lines = 100000,
  max_fps = 120,
}
