local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

return {
  window_decorations = "RESIZE",
  -- font = wezterm.font('Space Mono for Powerline'),
  -- font_size = 10.5,
  -- line_height = 1.2,
  hide_tab_bar_if_only_one_tab = true,
  keys = {
    -- { key = 'l', mods = 'CMD|SHIFT', action = act.ActivateTabRelative(1) },
    {
      key = 'R',
      mods = 'CMD|SHIFT',
      action = act.PromptInputLine {
        description = 'Enter new name for tab',
        action = wezterm.action_callback(function(window, _, line)
          -- line will be `nil` if they hit escape without entering anything
          -- An empty string if they just hit enter
          -- Or the actual line of text they wrote
          if line then
            window:active_tab():set_title(line)
          end
        end),
      },
    },
    {
      key = ',',
      mods = 'CMD',
      action = act.SpawnCommandInNewTab {
        cwd = os.getenv('WEZTERM_CONFIG_DIR'),
        set_environment_variables = {
          TERM = 'screen-256color',
        },
        args = {
          'nvim',
          os.getenv('WEZTERM_CONFIG_FILE'),
        },
      },
    },
    {
      key = 't',
      mods = 'CMD|SHIFT',
      action = act.ShowTabNavigator,
    },
    {
      key = 'K',
      mods = 'CMD',
      action = wezterm.action.SendString '\x0c',
    },
    {
      key = 'I',
      mods = 'CTRL',
      action = wezterm.action.SendString '\x1b[105;5u',
    },
    {
      key = '.',
      mods = 'CTRL',
      action = wezterm.action.SendString '\x1b[46;5u',
    },
    {
      key = ',',
      mods = 'CTRL',
      action = wezterm.action.SendString '\x1b[44;5u',
    },
    {
      key = ';',
      mods = 'CTRL',
      action = wezterm.action.SendString '\x1b[59;5u',
    },
    {
      key = 'Enter',
      mods = 'SHIFT',
      action = wezterm.action.SendString '\x1b[13;2u',
    },
    {
      key = 'Enter',
      mods = 'CTRL',
      action = wezterm.action.SendString '\x1b[13;5u',
    },
  },
  window_frame = {
    font = wezterm.font { family = 'Noto Sans', weight = 'Regular' },
  },
  window_background_opacity = 0.8,
}
