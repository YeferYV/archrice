local wezterm = require 'wezterm'
local act = wezterm.action

wezterm.on("open_in_vim", function(window, pane)
  local file = io.open("/tmp/wezterm_buf", "w")
  file:write(pane:get_lines_as_text(3000))
  file:close()
  window:perform_action(
    wezterm.action({
      SpawnCommandInNewTab = { args = { "nvim", "/tmp/wezterm_buf", "-c", "call cursor(3000,0)" } },
    }),
    pane
  )
end)

return {
  -- enable_csi_u_key_encoding = true, --unmap ctrl-(j|i...) same as stty -ixon
  -- initial_rows = 50,
  -- initial_cols = 170,
  -- force_reverse_video_cursor = true,
  audible_bell = "Disabled",
  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,
  tab_bar_at_bottom = true,
  front_end = "OpenGL",
  -- animation_fps = 60,
  default_prog = { "zsh" },
  font_size = 10.0,
  adjust_window_size_when_changing_font_size = false,

  -- use_cap_height_to_scale_fallback_fonts = true,
  -- font_hinting = "Full",
  -- font_antialias = "Greyscale",
  -- font_antialias = "Subpixel",
  -- freetype_load_target = "Light",
  -- freetype_render_target = "HorizontalLcd",
  -- freetype_interpreter_version = 40,
  -- cell_width = 1.20,
  -- line_height = 0.90,
  -- allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace",
  -- custom_block_glyphs = false,
  -- unicode_version=9 ,
  bold_brightens_ansi_colors = false, -- default true -- for i in {0..255}; do; printf "\033[${i};1m color${i}"; done
  window_close_confirmation = "NeverPrompt",

  -- window_padding = {left = 8, right = 8, top = 18, bottom = 8},
  -- window_padding = {left = 8, right = 8, top = 14, bottom = 10},
  -- window_padding = {left = 8, right = 8, top = 12, bottom = 12},
  -- window_padding = {left = 8, right = 8, top = 9, bottom = 9},
  -- window_padding = {left = 8, right = 8, top = 8, bottom = 8},
  -- window_padding = {left = "8px", right = "8px", top = "8px", bottom = "8px"},
  -- window_padding = {left = "6pt", right = "6pt", top = "10pt", bottom = "10pt"},
  -- window_padding = {left = "1cell", right = "1cell", top = "1cell", bottom = "1cell"},
  -- window_padding = {left = "1%", right = "1%", top = "2%", bottom = "2%"},
  window_background_opacity = 0.7,
  -- text_background_opacity = 0.9,
  scrollback_lines = 10000,

  foreground_text_hsb = {
    hue = 1.0,
    -- saturation = 1.05, --yellow to more yellowish
    -- brightness = 1.25, --yellow to less yellowish
  },

  font_rules = {
    {
      intensity = "Bold", -- bright palet colors
      font = wezterm.font_with_fallback({
        { family = "FiraCode Nerd Font" },
        { family = "Bedstead" },
        { family = "Noto Color Emoji" },
        { family = "Symbols Nerd Font Mono" },
        { family = "TerminessTTF Nerd Font" },
        { family = "Font Awesome 6 Free Solid" },
      },
        -- { stretch = "Normal", weight = "Bold", foreground = "#452121" } -- gen: #452121 + #ff0000
        -- { stretch = "Normal", weight = "Bold", foreground = "#4e1f1f" } -- gen: #452121 + #ff0000
        -- { stretch = "Normal", weight = "Bold", foreground = "#452525" } -- var: #452121
        -- { stretch = "Normal", weight = "Bold", foreground = "#452c2c" } -- var: #452121
        -- { stretch = "Normal", weight = "Bold", foreground = "#562323" } -- gen: #2c2c2c + #ff0000
        -- { stretch = "Normal", weight = "Bold", foreground = "#612121" } -- gen: #2c2c2c + #ff0000
        -- { stretch = "Normal", weight = "Bold", foreground = "#5d2d2d" } -- gen: #5d2d2d + #ff0000
        { stretch = "Normal", weight = "Bold", foreground = "#673232" }-- gen: #5d2d2d + #ff0000
      ),
    },
    {
      intensity = "Normal", -- ansi palet colors
      font = wezterm.font_with_fallback({
        { family = "FiraCode Nerd Font", scale = 1.00, stretch = "Normal", weight = "Medium" },
        { family = "3270 Nerd Font", scale = 1.20, stretch = "Normal", weight = "Medium" },
        { family = "Noto Color Emoji", weight = "Regular", stretch = "Normal", style = "Normal" },
        { family = "Symbols Nerd Font Mono", weight = "Regular", stretch = "Normal", style = "Normal" },
        { family = "CaskaydiaCove Nerd Font", weight = "Bold", stretch = "Normal", style = "Normal" },
        { family = "Font Awesome 6 Free", weight = "Black" },
      }),
    },
  },

  key_tables = {
    copy_mode = {
      { key = "q", mods = "NONE", action = act.Multiple {
        act.SendKey { key = "u", mods = "CTRL" },
        act.CopyMode("ClearPattern"),
        act.CopyMode("Close"),
      } },
      { key = "i", mods = "NONE", action = act.Multiple {
        act.SendKey { key = "u", mods = "CTRL" },
        act.CopyMode("ClearPattern"),
        act.CopyMode("Close"),
      } },
      { key = "Escape", mods = "NONE", action = act.Multiple {
        act.SendKey { key = "u", mods = "CTRL" },
        act.CopyMode("ClearPattern"),
        act.CopyMode("Close"),
      } },

      { key = "h", mods = "NONE", action = act.CopyMode("MoveLeft") },
      { key = "j", mods = "NONE", action = act.CopyMode("MoveDown") },
      { key = "k", mods = "NONE", action = act.CopyMode("MoveUp") },
      { key = "l", mods = "NONE", action = act.CopyMode("MoveRight") },

      { key = "LeftArrow", mods = "NONE", action = act.CopyMode("MoveLeft") },
      { key = "DownArrow", mods = "NONE", action = act.CopyMode("MoveDown") },
      { key = "UpArrow", mods = "NONE", action = act.CopyMode("MoveUp") },
      { key = "RightArrow", mods = "NONE", action = act.CopyMode("MoveRight") },

      { key = "w", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
      { key = "W", mods = "NONE", action = act.CopyMode("MoveForwardWord") },

      { key = "e", mods = "NONE", action = act.CopyMode("MoveForwardWordEnd") },
      { key = "E", mods = "NONE", action = act.CopyMode("MoveForwardWordEnd") },

      { key = "b", mods = "NONE", action = act.CopyMode("MoveBackwardWord") },
      { key = "B", mods = "NONE", action = act.CopyMode("MoveBackwardWord") },

      { key = "0", mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },
      { key = "Enter", mods = "NONE", action = act.CopyMode("MoveToStartOfNextLine") },

      { key = "$", mods = "NONE", action = act.CopyMode("MoveToEndOfLineContent") },
      { key = "$", mods = "SHIFT", action = act.CopyMode("MoveToEndOfLineContent") },
      { key = "^", mods = "NONE", action = act.CopyMode("MoveToStartOfLineContent") },
      { key = "^", mods = "SHIFT", action = act.CopyMode("MoveToStartOfLineContent") },

      { key = "Tab", mods = "SHIFT", action = act.ActivateTabRelative(-1) },
      { key = "Tab", mods = "NONE", action = act.ActivateTabRelative(1) },
      { key = ";", mods = "NONE", action = act.ActivateLastTab },

      -- {key="v", mods="NONE", action=wezterm.action{CopyMode="ToggleSelectionByCell"}},
      { key = " ", mods = "NONE", action = act.CopyMode { SetSelectionMode = "Cell" } },
      { key = "v", mods = "NONE", action = act.CopyMode { SetSelectionMode = "Cell" } },
      { key = "V", mods = "NONE", action = act.CopyMode { SetSelectionMode = "Line" } },
      { key = "V", mods = "SHIFT", action = act.CopyMode { SetSelectionMode = "Line" } },
      { key = "v", mods = "CTRL", action = act.CopyMode { SetSelectionMode = "Block" } },

      { key = "G", mods = "NONE", action = act.CopyMode("MoveToScrollbackBottom") },
      { key = "G", mods = "SHIFT", action = act.CopyMode("MoveToScrollbackBottom") },
      { key = "g", mods = "NONE", action = act.CopyMode("MoveToScrollbackTop") },

      { key = "h", mods = "ALT", action = act.CopyMode("MoveToViewportTop") },
      { key = "m", mods = "ALT", action = act.CopyMode("MoveToViewportMiddle") },
      { key = "l", mods = "ALT", action = act.CopyMode("MoveToViewportBottom") },

      { key = "o", mods = "NONE", action = act.CopyMode("MoveToSelectionOtherEnd") },
      { key = "O", mods = "NONE", action = act.CopyMode("MoveToSelectionOtherEndHoriz") },
      { key = "O", mods = "SHIFT", action = act.CopyMode("MoveToSelectionOtherEndHoriz") },

      { key = "PageUp", mods = "NONE", action = act.CopyMode("PageUp") },
      { key = "PageDown", mods = "NONE", action = act.CopyMode("PageDown") },
      { key = "u", mods = "NONE", action = act.CopyMode("PageUp") },
      { key = "d", mods = "NONE", action = act.CopyMode("PageDown") },

      { key = "H", mods = "NONE", action = act.Multiple {
        act.CopyMode("MoveLeft"),
        act.CopyMode("MoveLeft"),
        act.CopyMode("MoveLeft"),
        act.CopyMode("MoveLeft"),
        act.CopyMode("MoveLeft"),
        act.CopyMode("MoveLeft"),
        act.CopyMode("MoveLeft"),
        act.CopyMode("MoveLeft"),
        act.CopyMode("MoveLeft"),
        act.CopyMode("MoveLeft"),
      },
      },
      { key = "J", mods = "NONE", action = act.Multiple {
        act.CopyMode("MoveDown"),
        act.CopyMode("MoveDown"),
        act.CopyMode("MoveDown"),
        act.CopyMode("MoveDown"),
        act.CopyMode("MoveDown"),
        act.CopyMode("MoveDown"),
        act.CopyMode("MoveDown"),
        act.CopyMode("MoveDown"),
        act.CopyMode("MoveDown"),
      },
      },
      { key = "K", mods = "NONE", action = act.Multiple {
        act.CopyMode("MoveUp"),
        act.CopyMode("MoveUp"),
        act.CopyMode("MoveUp"),
        act.CopyMode("MoveUp"),
        act.CopyMode("MoveUp"),
        act.CopyMode("MoveUp"),
        act.CopyMode("MoveUp"),
        act.CopyMode("MoveUp"),
        act.CopyMode("MoveUp"),
        act.CopyMode("MoveUp"),
      },
      },
      { key = "L", mods = "NONE", action = act.Multiple {
        act.CopyMode("MoveRight"),
        act.CopyMode("MoveRight"),
        act.CopyMode("MoveRight"),
        act.CopyMode("MoveRight"),
        act.CopyMode("MoveRight"),
        act.CopyMode("MoveRight"),
        act.CopyMode("MoveRight"),
        act.CopyMode("MoveRight"),
        act.CopyMode("MoveRight"),
        act.CopyMode("MoveRight"),
      },
      },

      { key = "y", mods = "NONE", action = act.Multiple {
        wezterm.action { CopyTo = "ClipboardAndPrimarySelection" },
        act.CopyMode("ClearPattern"),
        wezterm.action { CopyMode = "Close" }
      },
      },
      { key = "/", mods = "NONE", action = act.Multiple {
        act.Search { CaseInSensitiveString = "" },
      },
      },
      { key = "N", mods = "NONE", action = act.Multiple {
        act.CopyMode("PriorMatch"),
        act.CopyMode { SetSelectionMode = "Cell" },
      },
      },
      { key = "n", mods = "NONE", action = act.Multiple {
        act.CopyMode("NextMatch"),
        act.CopyMode { SetSelectionMode = "Cell" },
      },
      },
      { key = "u", mods = "CTRL", action = act.Multiple {
        act.ClearSelection,
        -- act.CompleteSelection 'Clipboard',
      },
      }
    },
    search_mode = {
      { key = "Escape", mods = "NONE", action = act.Multiple {
        act.SendKey { key = "u", mods = "CTRL" },
        act.CopyMode("ClearPattern"),
        act.CopyMode("Close"),
      } },

      -- {key="Enter", mods="NONE", action="ActivateCopyMode"},
      { key = "Enter", mods = "NONE", action = act.Multiple {
        act.ActivateCopyMode,
        act.CopyMode { SetSelectionMode = "Cell" },
        -- act.ClearSelection,
        -- act.CopyMode('ClearSelectionMode'),
      }
      },

      { key = "p", mods = "CTRL", action = act.CopyMode("PriorMatch") },
      { key = "n", mods = "CTRL", action = act.CopyMode("NextMatch") },
      { key = "r", mods = "CTRL", action = act.CopyMode("CycleMatchType") },
      { key = "u", mods = "CTRL", action = act.CopyMode("ClearPattern") },
    }
  },

  -- timeout_milliseconds defaults to 1000 and can be omitted
  leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 },
  keys = {
    -- Turn off the default CMD-m Hide action, allowing CMD-m to
    -- be potentially recognized and handled by the tab
    -- {key="m", mods="CMD", action="DisableDefaultAssignment"} ,
    { key = "v", mods = "LEADER", action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
    { key = "v", mods = "LEADER|SHIFT", action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } } },
    { key = "v", mods = "CTRL|ALT", action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
    { key = "h", mods = "CTRL|ALT", action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } } },
    -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
    { key = "a", mods = "LEADER|CTRL", action = wezterm.action { SendString = "\x01" } },
    { key = "[", mods = "LEADER", action = wezterm.action({ EmitEvent = "open_in_vim" }) },
    { key = "]", mods = "LEADER", action = "QuickSelect" },

    -- {key="i", mods="CTRL", action={SendKey={key="i", mods="CTRL"}}}, -- default:tab
    -- {key="[", mods="CTRL", action={SendKey={key="[", mods="CTRL"}}}, -- default:esc
    -- {key="phys:i", mods="CTRL", action=wezterm.action{SendString="\x09"}}, -- od -c
    -- {key="phys:[", mods="CTRL", action=wezterm.action{SendString="\x1B"}}, -- od -c
    -- {key="LeftArrow", mods="ALT", action=wezterm.action{SendString="\x1bo"}}, -- xxd
    -- {key="RightArrow", mods="ALT", action=wezterm.action{SendString="\x1bo"}}, -- xxd
    -- {key="i", mods="ALT", action=wezterm.action{SendString="\x1b[5A"}}, -- showkey -a
    -- {key="u", mods="ALT", action=wezterm.action{SendString="\x1b[5B"}}, -- showkey -a
    -- {key="y", mods="ALT", action=wezterm.action{SendString="\x1b[5C"}}, -- showkey -a
    -- {key="o", mods="ALT", action=wezterm.action{SendString="\x1b[5D"}}, -- showkey -a

    -- Copy Mode
    { key = " ", mods = "ALT", action = act.Multiple {
      act.CopyMode("ClearPattern"),
      act.CopyMode("Close"),
      act.ActivateCopyMode,
    }
    },

    -- Search Case Insensitive
    { key = "F", mods = "SHIFT|CTRL", action = act.Multiple {
      act.Search { CaseInSensitiveString = "" },
      act.SendKey { key = "u", mods = "CTRL" },
      act.CopyMode("ClearPattern"),
    },
    },

    -- quick select
    { key = "q", mods = "CTRL|SHIFT", action = wezterm.action.QuickSelect },
    { key = "u", mods = "CTRL|SHIFT",
      action = wezterm.action.QuickSelectArgs {
        label = "open url",
        patterns = {
          '"(https?://\\S+)"|\'(https?://\\S+)\'|(https?://\\S+)'
        },
        action = wezterm.action_callback(function(window, pane)
          local url = window:get_selection_text_for_pane(pane)
          wezterm.log_info("opening: " .. url)
          wezterm.open_with(url)
        end),
      },
    },

    -- Clipboard Shortcuts
    { key = "c", mods = "ALT", action = wezterm.action { CopyTo = "Clipboard" } },
    { key = "v", mods = "ALT", action = wezterm.action { PasteFrom = "Clipboard" } },

    -- Window shortcuts
    { key = "n", mods = 'SHIFT|CTRL', action = wezterm.action.SpawnWindow },

    -- Panes Shortcuts
    { key = "w", mods = "CTRL", action = wezterm.action { CloseCurrentPane = { confirm = false } } },
    -- {key="l", mods="CTRL|SHIFT", action = 'DisableDefaultAssignment'},
    { key = "r", mods = "CTRL|ALT", action = act.RotatePanes("CounterClockwise") },
    { key = "R", mods = "CTRL|ALT", action = act.RotatePanes("Clockwise") },

    -- Tab shortcut
    { key = "t", mods = "CTRL|SHIFT", action = wezterm.action { SpawnCommandInNewTab = { cwd = "" } } },
    { key = "t", mods = "CTRL", action = wezterm.action { SpawnTab = "CurrentPaneDomain" } },
    { key = ";", mods = "ALT", action = wezterm.action.ActivateLastTab },
    { key = "s", mods = "ALT", action = wezterm.action.ActivateTabRelative(-1) },
    { key = "f", mods = "ALT", action = wezterm.action.ActivateTabRelative(1) },
    { key = 's', mods = 'SHIFT|ALT', action = wezterm.action.MoveTabRelative(-1) },
    { key = 'f', mods = 'SHIFT|ALT', action = wezterm.action.MoveTabRelative(1) },
    { key = "1", mods = "ALT", action = wezterm.action { ActivateTab = 0 } },
    { key = "2", mods = "ALT", action = wezterm.action { ActivateTab = 1 } },
    { key = "3", mods = "ALT", action = wezterm.action { ActivateTab = 2 } },
    { key = "4", mods = "ALT", action = wezterm.action { ActivateTab = 3 } },
    { key = "5", mods = "ALT", action = wezterm.action { ActivateTab = 4 } },
    { key = "6", mods = "ALT", action = wezterm.action { ActivateTab = 5 } },
    { key = "7", mods = "ALT", action = wezterm.action { ActivateTab = 6 } },
    { key = "8", mods = "ALT", action = wezterm.action { ActivateTab = 7 } },
    { key = "9", mods = "ALT", action = wezterm.action { ActivateTab = 8 } },
    { key = "0", mods = "ALT", action = wezterm.action { ActivateTab = -1 } },

    -- Scrolling shortcuts
    { key = "e", mods = "ALT", action = wezterm.action { ScrollByLine = -1 } },
    { key = "d", mods = "ALT", action = wezterm.action { ScrollByLine = 1 } },
    { key = "q", mods = "ALT", action = wezterm.action { ScrollByPage = -1 } },
    { key = "a", mods = "ALT", action = wezterm.action { ScrollByPage = 1 } },
    { key = "t", mods = "ALT", action = "ScrollToTop" },
    { key = "g", mods = "ALT", action = "ScrollToBottom" },
    { key = "LeftArrow", mods = "CTRL|ALT", action = wezterm.action { AdjustPaneSize = { "Left", 1 } } },
    { key = "RightArrow", mods = "CTRL|ALT", action = wezterm.action { AdjustPaneSize = { "Right", 1 } } },
    { key = "UpArrow", mods = "CTRL|ALT", action = wezterm.action { AdjustPaneSize = { "Up", 1 } } },
    { key = "DownArrow", mods = "CTRL|ALT", action = wezterm.action { AdjustPaneSize = { "Down", 1 } } },
    { key = "LeftArrow", mods = "CTRL", action = wezterm.action { ActivatePaneDirection = "Left" } },
    { key = "RightArrow", mods = "CTRL", action = wezterm.action { ActivatePaneDirection = "Right" } },
    { key = "UpArrow", mods = "CTRL", action = wezterm.action { ActivatePaneDirection = "Up" } },
    { key = "DownArrow", mods = "CTRL", action = wezterm.action { ActivatePaneDirection = "Down" } },
    -- {key="Home", mods="CTRL", action=wezterm.action{ScrollToPrompt=-1}},
    -- {key="End", mods="CTRL", action=wezterm.action{ScrollToPrompt=1}},
  },

  -- color_scheme = "Retro",
  colors = {
    -- SHELL: for i in $(seq 256); do echo $(lua <<<"print('\27[${i}mReadydone${i}')"); done
    cursor_bg = "#ffffff",
    cursor_fg = "#000000",
    -- cursor_border = "#0000ff",
    -- ansi = {"#111111", "maroon", "green", "olive", "navy", "purple", "teal", "silver"},        -- Intensity Normal font SHELL:{30,37}
    ansi = { "#222222", "#bb0000", "#008800", "#bbbb00", "#5555cc", "#8855ff", "#7acaca", "#ffffff" }, -- Intensity Normal font SHELL:{30,37}
    -- brights = {"#1c1c1c", "red", "lime", "yellow", "blue", "fuchsia", "aqua", "white"},        -- Intensity Bold font SHELL:{90,97}
    brights = { "#7c7c7c", "#ff0000", "#00ff00", "#ffff00", "#1c1cff", "#8844bb", "#008888", "#673232" }, -- Intensity Bold font SHELL:{90,97}

    tab_bar = {
      -- The color of the strip that goes along the top of the window
      -- (does not apply when fancy tab bar is in use)
      background = "#000000",

      -- The active tab is the one that has focus in the window
      active_tab = {
        -- bg_color = "#0c0c0c",
        -- fg_color = "#ffffff",
        bg_color = "#1c1c1c",
        fg_color = "#888888",

        -- Specify whether you want "Half", "Normal" or "Bold" intensity for the
        -- label shown for this tab.
        -- The default is "Normal"
        intensity = "Normal",

        -- Specify whether you want "None", "Single" or "Double" underline for
        -- label shown for this tab.
        -- The default is "None"
        underline = "None",

        -- Specify whether you want the text to be italic (true) or not (false)
        -- for this tab.  The default is false.
        italic = false,

        -- Specify whether you want the text to be rendered with strikethrough (true)
        -- or not for this tab.  The default is false.
        strikethrough = false,
      },

      -- Inactive tabs are the tabs that do not have focus
      inactive_tab = {
        bg_color = "#000000",
        fg_color = "#2c2c2c",

        -- The same options that were listed under the `active_tab` section above
        -- can also be used for `inactive_tab`.
      },

      -- You can configure some alternate styling when the mouse pointer
      -- moves over inactive tabs
      inactive_tab_hover = {
        bg_color = "#111111",
        fg_color = "#909090",
        italic = true,

        -- The same options that were listed under the `active_tab` section above
        -- can also be used for `inactive_tab_hover`.
      },

      -- The new tab button that let you create new tabs
      new_tab = {
        bg_color = "#000000",
        fg_color = "#000000",

        -- The same options that were listed under the `active_tab` section above
        -- can also be used for `new_tab`.
      },

      -- You can configure some alternate styling when the mouse pointer
      -- moves over the new tab button
      new_tab_hover = {
        bg_color = "#888888",
        fg_color = "#ffffff",
        italic = true,

        -- The same options that were listed under the `active_tab` section above
        -- can also be used for `new_tab_hover`.
      }
    }
  }
}
