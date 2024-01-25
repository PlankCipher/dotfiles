local wezterm = require('wezterm')

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.front_end = 'OpenGL'

config.colors = {
  foreground = '#e0def4',
  background = '#1d1b2c',

  cursor_fg = '#ffffff',
  cursor_bg = '#6e6a86',

  selection_fg = '#1d1b2c',
  selection_bg = '#e0def4',

  ansi = {
    '#1d1b2c',
    '#eb6f92',
    '#76b360',
    '#f6c177',
    '#3e8fb0',
    '#c4a7e7',
    '#9ccfd8',
    '#e0def4',
  },

  brights = {
    '#908caa',
    '#ef8faa',
    '#8bbf78',
    '#f8d19b',
    '#52a1c2',
    '#d7c3ef',
    '#b6dce2',
    '#f8f7fc',
  },

  tab_bar = {
    background = '#2a273f',
  },
}

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.show_new_tab_button_in_tab_bar = false
config.show_tab_index_in_tab_bar = false
config.tab_max_width = 30

function basename(s)
  return string.gsub(s, '/.+/(.+[^/])/?', '%1')
end

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local attribute = {}
    if tab.is_active or hover then
      background = '#908caa'
      foreground = '#1d1b2c'
      attribute = {Attribute = { Intensity = 'Bold' }}
    else
      background = '#44415a'
      foreground = '#e0def4'
      attribute = {Attribute = { Intensity = 'Normal' }}
    end

    local proc_name = basename(tab.active_pane.foreground_process_name)
    local cwd = basename(tab.active_pane.current_working_dir.file_path)
    local title = ' ' .. proc_name .. '/' .. cwd .. ' '
    title = wezterm.truncate_right(title, max_width - 1)

    return {
      { Background = { Color = background } },
      { Foreground = { Color = foreground } },
      attribute,
      { Text = title },
      'ResetAttributes',
      { Background = { Color = '#2a273f' } },
      { Foreground = { Color = '#2a273f' } },
      { Text = ' ' },
    }
  end
)

config.window_padding = {
  top = 0,
  right = 0,
  bottom = 0,
  left = 0,
}

config.enable_scroll_bar = false
config.term = 'wezterm'
config.scrollback_lines = 1000
config.check_for_updates = false
config.window_close_confirmation = 'NeverPrompt'
config.audible_bell = 'Disabled'
config.detect_password_input = false
config.alternate_buffer_wheel_scroll_speed = 3
config.default_cursor_style = 'BlinkingBar'
config.cursor_thickness = 1
config.hide_mouse_cursor_when_typing = false
config.cursor_blink_rate = 600
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'
config.canonicalize_pasted_newlines = 'LineFeed'
config.underline_position = -3

config.adjust_window_size_when_changing_font_size = false
config.allow_square_glyphs_to_overflow_width = 'Always'
config.bold_brightens_ansi_colors = 'No'
config.warn_about_missing_glyphs = false

config.line_height = 0.9
config.cell_width = 0.9
config.font_size = 14
config.font = wezterm.font_with_fallback({
  'LigaSFMono Nerd Font',
})

config.font_rules = {
  {
    intensity = 'Bold',
    italic = false,
    font = wezterm.font_with_fallback({
      {
        family = 'LigaSFMono Nerd Font',
        weight = 'ExtraBold',
        style = 'Normal',
      }
    }),
  },

  {
    intensity = 'Bold',
    italic = true,
    font = wezterm.font_with_fallback({
      {
        family = 'LigaSFMono Nerd Font',
        weight = 'ExtraBold',
        style = 'Italic',
      }
    }),
  },
}

config.keys = {
  {
    key = 'k',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivateTabRelative(-1),
  },
  {
    key = 'j',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivateTabRelative(1),
  },
  {
    key = 'Space',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivateCopyMode,
  },
  {
    key = 'g',
    mods = 'CTRL|SHIFT',
    action = wezterm.action_callback(function(window, pane)
      window:perform_action(wezterm.action.ActivateCopyMode, pane)
      window:perform_action(wezterm.action.CopyMode({ MoveBackwardZoneOfType = 'Output' }), pane)
    end),
  },
  {
    key = 'l',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.QuickSelectArgs({
      label = 'open url',
      patterns = {
        '\\((https?://\\S+)\\)',
        '\\[(https?://\\S+)\\]',
        '<(https?://\\S+)>',
        '\\b(https?://\\S+[)/a-zA-Z0-9-]+)',
      },
      action = wezterm.action_callback(function(window, pane)
        local url = window:get_selection_text_for_pane(pane)
        wezterm.open_with(url)
      end),
    }),
  },
}

copy_mode_key_table = wezterm.gui.default_key_tables().copy_mode

table.insert(
  copy_mode_key_table,
  {
    key = 'Escape',
    mods = 'NONE',
    action = wezterm.action.Multiple({
      wezterm.action.ClearSelection,
      wezterm.action.CopyMode('ClearSelectionMode')
    }),
  }
)

table.insert(
  copy_mode_key_table,
  {
    key = 'i',
    mods = 'NONE',
    action = wezterm.action.Multiple({
      wezterm.action.ClearSelection,
      wezterm.action.CopyMode('Close')
    }),
  }
)

table.insert(
  copy_mode_key_table,
  {
    key = 'e',
    mods = 'CTRL',
    action = wezterm.action.ScrollByLine(1),
  }
)

table.insert(
  copy_mode_key_table,
  {
    key = 'y',
    mods = 'CTRL',
    action = wezterm.action.ScrollByLine(-1),
  }
)

table.insert(
  copy_mode_key_table,
  {
    key = 'y',
    mods = 'NONE',
    action = wezterm.action.Multiple({
      wezterm.action.CopyTo('ClipboardAndPrimarySelection'),
      wezterm.action.ClearSelection,
      wezterm.action.CopyMode('ClearSelectionMode')
    }),
  }
)

config.key_tables = {
  copy_mode = copy_mode_key_table
}

config.mouse_bindings = {
  {
    event = { Down = { streak = 1, button = { WheelUp = 1 } } },
    mods = 'NONE',
    action = wezterm.action.ScrollByLine(-3),
    alt_screen = false,
  },
  {
    event = { Down = { streak = 1, button = { WheelDown = 1 } } },
    mods = 'NONE',
    action = wezterm.action.ScrollByLine(3),
    alt_screen = false,
  },
  {
    event = { Up = { streak = 2, button = 'Left' } },
    mods = 'NONE',
    action = wezterm.action.Nop,
  },
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'ALT',
    action = wezterm.action.Nop,
  },
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'ALT|SHIFT',
    action = wezterm.action.Nop,
  },
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = wezterm.action.OpenLinkAtMouseCursor,
  },
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'SHIFT',
    action = wezterm.action.OpenLinkAtMouseCursor,
  },
  {
    event = { Up = { streak = 3, button = 'Left' } },
    mods = 'NONE',
    action = wezterm.action.Nop,
  },
}

return config
