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
  force_reverse_video_cursor = true,
  audible_bell = "Disabled",
  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,
  tab_bar_at_bottom = true,
  adjust_window_size_when_changing_font_size = false,
  front_end = "OpenGL",
  -- animation_fps = 60,
  default_prog = { "zsh" },
  font_size = 10.0,

  -- cell_width = 1.20,
  -- line_height = 0.90,
  -- cell_width = 1.9,
  -- allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace",
  -- custom_block_glyphs = false,
  -- unicode_version=9 ,
  -- freetype_load_target = "Light",
  -- freetype_render_target = "HorizontalLcd",
  -- font_hinting = "Full",
  -- font_antialias = "Greyscale",
  -- font_antialias = "Subpixel",
  -- freetype_interpreter_version = 40,
  -- bold_brightens_ansi_colors = false, -- default true
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
  window_background_opacity = 9.0,
  -- text_background_opacity = 0.5,
  scrollback_lines = 10000,

  foreground_text_hsb = {
    hue = 1.0,
    -- saturation = 1.05, --yellow to more yellowish
    -- brightness = 1.25, --yellow to less yellowish
  },

  font_rules= {
    {
      intensity = "Bold",
      -- font = wezterm.font({family="TerminessTTF Nerd Font", scale = 1.05},{stretch="Normal", weight="ExtraBlack", foreground = "#ff8800"}), -- bright palet colors
      -- font = wezterm.font({family="Bedstead", scale = 1.05},{stretch="Normal", weight="ExtraBlack", foreground = "#ff8800"}), -- bright palet colors
      font = wezterm.font({family="Bedstead", scale = 1.00},{stretch="Normal", weight="Medium", foreground = "#ff8800"}), -- bright palet colors
    },
    {
      intensity = "Normal",
      -- font = wezterm.font("CaskaydiaCove Nerd Font", {weight="Bold", stretch="Normal", style=Normal}), -- ansi palet colors
      -- font = wezterm.font({family="IBM 3270", scale = 1.20},{stretch="Normal", weight="DemiBold"}), -- ansi palet colors
      font = wezterm.font({family="IBM 3270", scale = 1.20},{stretch="Normal", weight="Medium"}), -- ansi palet colors
      -- font = wezterm.font({family="3270Medium Nerd Font", scale = 1.20},{stretch="UltraExpanded", weight="DemiBold"}), -- ansi palet colors
    },
  },

   key_tables = {
    copy_mode = {
      {key="q", mods="NONE", action=act.Multiple{
          act.SendKey{key="u", mods="CTRL"},
          act.CopyMode("ClearPattern"),
          act.CopyMode("Close"),
      }},
      {key="i", mods="NONE", action=act.Multiple{
          act.SendKey{key="u", mods="CTRL"},
          act.CopyMode("ClearPattern"),
          act.CopyMode("Close"),
      }},
      {key="Escape", mods="NONE", action=act.Multiple{
          act.SendKey{key="u", mods="CTRL"},
          act.CopyMode("ClearPattern"),
          act.CopyMode("Close"),
      }},

      {key="h", mods="NONE", action=act.CopyMode("MoveLeft")},
      {key="j", mods="NONE", action=act.CopyMode("MoveDown")},
      {key="k", mods="NONE", action=act.CopyMode("MoveUp")},
      {key="l", mods="NONE", action=act.CopyMode("MoveRight")},

      {key="LeftArrow",  mods="NONE", action=act.CopyMode("MoveLeft")},
      {key="DownArrow",  mods="NONE", action=act.CopyMode("MoveDown")},
      {key="UpArrow",    mods="NONE", action=act.CopyMode("MoveUp")},
      {key="RightArrow", mods="NONE", action=act.CopyMode("MoveRight")},

      {key="RightArrow", mods="ALT",  action=act.CopyMode("MoveForwardWord")},
      {key="f",          mods="ALT",  action=act.CopyMode("MoveForwardWord")},
      {key="Tab",        mods="NONE", action=act.CopyMode("MoveForwardWord")},
      {key="w",          mods="NONE", action=act.CopyMode("MoveForwardWord")},
      {key="W",          mods="NONE", action=act.CopyMode("MoveForwardWord")},

      {key="LeftArrow", mods="ALT",   action=act.CopyMode("MoveBackwardWord")},
      {key="b",         mods="ALT",   action=act.CopyMode("MoveBackwardWord")},
      {key="Tab",       mods="SHIFT", action=act.CopyMode("MoveBackwardWord")},
      {key="b",         mods="NONE",  action=act.CopyMode("MoveBackwardWord")},
      {key="B",         mods="NONE",  action=act.CopyMode("MoveBackwardWord")},

      {key="0",     mods="NONE",  action=act.CopyMode("MoveToStartOfLine")},
      {key="Enter", mods="NONE",  action=act.CopyMode("MoveToStartOfNextLine")},

      {key="$",     mods="NONE",  action=act.CopyMode("MoveToEndOfLineContent")},
      {key="$",     mods="SHIFT", action=act.CopyMode("MoveToEndOfLineContent")},
      {key="^",     mods="NONE",  action=act.CopyMode("MoveToStartOfLineContent")},
      {key="^",     mods="SHIFT", action=act.CopyMode("MoveToStartOfLineContent")},
      {key="m",     mods="ALT",   action=act.CopyMode("MoveToStartOfLineContent")},

      -- {key="v", mods="NONE", action=wezterm.action{CopyMode="ToggleSelectionByCell"}},
      {key=" ", mods="NONE",  action=act.CopyMode{SetSelectionMode="Cell"}},
      {key="v", mods="NONE",  action=act.CopyMode{SetSelectionMode="Cell"}},
      {key="V", mods="NONE",  action=act.CopyMode{SetSelectionMode="Line"}},
      {key="V", mods="SHIFT", action=act.CopyMode{SetSelectionMode="Line"}},
      {key="v", mods="CTRL",  action=act.CopyMode{SetSelectionMode="Block"}},

      {key="G", mods="NONE",  action=act.CopyMode("MoveToScrollbackBottom")},
      {key="G", mods="SHIFT", action=act.CopyMode("MoveToScrollbackBottom")},
      {key="g", mods="NONE",  action=act.CopyMode("MoveToScrollbackTop")},

      {key="h", mods="ALT", action=act.CopyMode("MoveToViewportTop")},
      {key="m", mods="ALT", action=act.CopyMode("MoveToViewportMiddle")},
      {key="l", mods="ALT", action=act.CopyMode("MoveToViewportBottom")},

      {key="o", mods="NONE",  action=act.CopyMode("MoveToSelectionOtherEnd")},
      {key="O", mods="NONE",  action=act.CopyMode("MoveToSelectionOtherEndHoriz")},
      {key="O", mods="SHIFT", action=act.CopyMode("MoveToSelectionOtherEndHoriz")},

      {key="PageUp",   mods="NONE", action=act.CopyMode("PageUp")},
      {key="PageDown", mods="NONE", action=act.CopyMode("PageDown")},
      {key="u",        mods="NONE", action=act.CopyMode("PageUp")},
      {key="d",        mods="NONE", action=act.CopyMode("PageDown")},

      {key="H", mods="NONE", action=act.Multiple{
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
      {key="J", mods="NONE", action=act.Multiple{
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
      {key="K", mods="NONE", action=act.Multiple{
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
      {key="L", mods="NONE", action=act.Multiple{
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

      {key="y", mods="NONE", action=act.Multiple{
          wezterm.action{CopyTo="ClipboardAndPrimarySelection"},
          act.CopyMode("ClearPattern"),
          wezterm.action{CopyMode="Close"}
        },
      },
      {key="/", mods="NONE", action=act.Multiple{
          act.Search{CaseInSensitiveString=""},
        },
      },
      {key="N", mods="NONE", action=act.Multiple{
          act.CopyMode("PriorMatch"),
          act.CopyMode{SetSelectionMode="Cell"},
        },
      },
      {key="n", mods="NONE", action=act.Multiple{
          act.CopyMode("NextMatch"),
          act.CopyMode{SetSelectionMode="Cell"},
        },
      },
      {key="u", mods="CTRL", action=act.Multiple{
          act.ClearSelection,
          -- act.CompleteSelection 'Clipboard',
        },
      }
    },
    search_mode = {
      {key="Escape", mods="NONE", action=act.Multiple{
          act.SendKey{key="u", mods="CTRL"},
          act.CopyMode("ClearPattern"),
          act.CopyMode("Close"),
      }},

      -- {key="Enter", mods="NONE", action="ActivateCopyMode"},
      {key="Enter", mods="NONE", action=act.Multiple{
          act.ActivateCopyMode,
          act.CopyMode{SetSelectionMode="Cell"},
          -- act.ClearSelection,
          -- act.CopyMode('ClearSelectionMode'),
        }
      },

      {key="p", mods="CTRL", action=act.CopyMode("PriorMatch")},
      {key="n", mods="CTRL", action=act.CopyMode("NextMatch")},
      {key="r", mods="CTRL", action=act.CopyMode("CycleMatchType")},
      {key="u", mods="CTRL", action=act.CopyMode("ClearPattern")},
    }
  },

  -- timeout_milliseconds defaults to 1000 and can be omitted
  leader = { key="a", mods="CTRL", timeout_milliseconds=1000 },
  keys = {
   -- Turn off the default CMD-m Hide action, allowing CMD-m to
    -- be potentially recognized and handled by the tab
    -- {key="m", mods="CMD", action="DisableDefaultAssignment"} ,
    {key="v", mods="LEADER", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
    {key="v", mods="LEADER|SHIFT", action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
    {key="v", mods="CTRL|ALT", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
    {key="h", mods="CTRL|ALT", action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
    -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
    {key="a", mods="LEADER|CTRL", action=wezterm.action{SendString="\x01"}},
    {key = "[", mods = "LEADER", action = wezterm.action({ EmitEvent = "open_in_vim" }) },
    {key = "]", mods = "LEADER", action = "QuickSelect"},

    -- {key="i", mods="CTRL", action={SendKey={key="i", mods="CTRL"}}}, --default:tab
    -- {key="[", mods="CTRL", action={SendKey={key="[", mods="CTRL"}}}, --default:esc
    -- {key="phys:i", mods="CTRL", action=wezterm.action{SendString="\x09"}}, --od -c
    -- {key="phys:[", mods="CTRL", action=wezterm.action{SendString="\x1B"}}, --od -c
    -- {key="LeftArrow", mods="ALT", action=wezterm.action{SendString="\x1bo"}}, --xxd
    -- {key="RightArrow", mods="ALT", action=wezterm.action{SendString="\x1bo"}}, --xxd
    -- {key="i", mods="ALT", action=wezterm.action{SendString="\x1b[5A"}}, --showkey -a
    -- {key="u", mods="ALT", action=wezterm.action{SendString="\x1b[5B"}}, --showkey -a
    -- {key="y", mods="ALT", action=wezterm.action{SendString="\x1b[5C"}}, --showkey -a
    -- {key="o", mods="ALT", action=wezterm.action{SendString="\x1b[5D"}}, --showkey -a

    -- Copy Mode
    {key=" ", mods="ALT", action=act.Multiple{
        act.CopyMode("ClearPattern"),
        act.CopyMode("Close"),
        act.ActivateCopyMode,
      }
    },

    -- Search Case Insensitive
    {key="F", mods="SHIFT|CTRL", action=act.Multiple{
        act.Search{CaseInSensitiveString=""},
        act.SendKey{key="u", mods="CTRL"},
        act.CopyMode("ClearPattern"),
      },
    },

    -- quick select
    { key="o", mods="CTRL|SHIFT", action=wezterm.action.QuickSelect},
    { key="p", mods="CTRL|SHIFT",
      action=wezterm.action.QuickSelectArgs{
        label = "open url",
        patterns={
           "https?://\\S+"
        },
        action = wezterm.action_callback(function(window, pane)
           local url = window:get_selection_text_for_pane(pane)
           wezterm.log_info("opening: " .. url)
           wezterm.open_with(url)
        end),
      },
    },

    -- Clipboard Shortcuts
    {key="c", mods="ALT", action=wezterm.action{CopyTo="Clipboard"}},
    {key="v", mods="ALT", action=wezterm.action{PasteFrom="Clipboard"}},

    -- Window shortcuts
    {key="n", mods='SHIFT|CTRL', action = wezterm.action.SpawnWindow },

    -- Panes Shortcuts
    {key="w", mods="CTRL", action=wezterm.action{CloseCurrentPane={confirm=false}}},
    -- {key="l", mods="CTRL|SHIFT", action = 'DisableDefaultAssignment'},
    {key="r", mods="CTRL|ALT", action=act.RotatePanes("CounterClockwise")},
    {key="R", mods="CTRL|ALT", action=act.RotatePanes("Clockwise")},

    -- Tab shortcut
    {key="t", mods="CTRL|SHIFT", action=wezterm.action{SpawnCommandInNewTab={cwd=""}}},
    {key="t", mods="CTRL", action=wezterm.action{SpawnTab="CurrentPaneDomain"}},
    {key="1", mods="ALT", action=wezterm.action{ActivateTab=0}},
    {key="2", mods="ALT", action=wezterm.action{ActivateTab=1}},
    {key="3", mods="ALT", action=wezterm.action{ActivateTab=2}},
    {key="4", mods="ALT", action=wezterm.action{ActivateTab=3}},
    {key="5", mods="ALT", action=wezterm.action{ActivateTab=4}},
    {key="6", mods="ALT", action=wezterm.action{ActivateTab=5}},
    {key="7", mods="ALT", action=wezterm.action{ActivateTab=6}},
    {key="8", mods="ALT", action=wezterm.action{ActivateTab=7}},
    {key="9", mods="ALT", action=wezterm.action{ActivateTab=8}},
    {key="0", mods="ALT", action=wezterm.action{ActivateTab=-1}},

    -- Scrolling shortcuts
    {key="e", mods="ALT", action=wezterm.action{ScrollByLine=-1}},
    {key="d", mods="ALT", action=wezterm.action{ScrollByLine=1}},
    {key="r", mods="ALT", action=wezterm.action{ScrollByPage=-1}},
    {key="f", mods="ALT", action=wezterm.action{ScrollByPage=1}},
    {key="t", mods="ALT", action="ScrollToTop"},
    {key="g", mods="ALT", action="ScrollToBottom"},
    {key="LeftArrow", mods="CTRL|ALT", action=wezterm.action{AdjustPaneSize={"Left", 1}}},
    {key="RightArrow", mods="CTRL|ALT", action=wezterm.action{AdjustPaneSize={"Right", 1}}},
    {key="UpArrow", mods="CTRL|ALT", action=wezterm.action{AdjustPaneSize={"Up", 1}}},
    {key="DownArrow", mods="CTRL|ALT", action=wezterm.action{AdjustPaneSize={"Down", 1}}},
    {key="LeftArrow", mods="CTRL", action=wezterm.action{ActivatePaneDirection="Left"}},
    {key="RightArrow", mods="CTRL", action=wezterm.action{ActivatePaneDirection="Right"}},
    {key="UpArrow", mods="CTRL", action=wezterm.action{ActivatePaneDirection="Up"}},
    {key="DownArrow", mods="CTRL", action=wezterm.action{ActivatePaneDirection="Down"}},
    -- {key="Home", mods="CTRL", action=wezterm.action{ScrollToPrompt=-1}},
    -- {key="End", mods="CTRL", action=wezterm.action{ScrollToPrompt=1}},
  },

  -- color_scheme = "Retro",
  colors = {
    -- SHELL: for i in $(seq 256); do echo $(lua <<<"print('\27[${i}mReadydone${i}')"); done
    -- cursor_bg = "#0000ff",
    -- cursor_fg = "#cccccc",
    -- cursor_border = "#0000ff",
    -- ansi = {"#111111", "maroon", "green", "olive", "navy", "purple", "teal", "silver"},        -- Intensity Normal font SHELL:{30,37}
    ansi = {"#222222","#bb0000","#008800","#bbbb00","#5555cc","#8855ff","#7acaca","#ffffff"},     -- Intensity Normal font SHELL:{30,37}
    -- brights = {"#1c1c1c", "red", "lime", "yellow", "blue", "fuchsia", "aqua", "white"},        -- Intensity Bold font SHELL:{90,97}
    brights = {"#555555","#ff0000","#00ff00","#ffff00","#1c1cff","#880088","#008888","#ff4400"},  -- Intensity Bold font SHELL:{90,97}

    tab_bar = {
      -- The color of the strip that goes along the top of the window
      -- (does not apply when fancy tab bar is in use)
      -- background = "#0b0022",
      background = "#000000",

      -- The active tab is the one that has focus in the window
      active_tab = {
        -- The color of the background area for the tab
        -- bg_color = "#2b2042",
        bg_color = "#222222",
        -- The color of the text for the tab
        fg_color = "#c0c0c0",

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
        -- bg_color = "#1b1032",
        bg_color = "#111111",
        fg_color = "#808080",

        -- The same options that were listed under the `active_tab` section above
        -- can also be used for `inactive_tab`.
      },

      -- You can configure some alternate styling when the mouse pointer
      -- moves over inactive tabs
      inactive_tab_hover = {
        -- bg_color = "#3b3052",
        bg_color = "#111111",
        fg_color = "#909090",
        italic = true,

        -- The same options that were listed under the `active_tab` section above
        -- can also be used for `inactive_tab_hover`.
      },

      -- The new tab button that let you create new tabs
      new_tab = {
        -- bg_color = "#1b1032",
        bg_color = "#000000",
        -- fg_color = "#808080",
        fg_color = "#000000",

        -- The same options that were listed under the `active_tab` section above
        -- can also be used for `new_tab`.
      },

      -- You can configure some alternate styling when the mouse pointer
      -- moves over the new tab button
      new_tab_hover = {
        -- bg_color = "#3b3052",
        bg_color = "#111111",
        fg_color = "#909090",
        italic = true,

        -- The same options that were listed under the `active_tab` section above
        -- can also be used for `new_tab_hover`.
      }
    }
  }
}

