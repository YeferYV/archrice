-- local colorscheme = "leet"
-- local colorscheme = "poimandres"
local colorscheme = "tokyonight-night"

-- Transparency
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()

    local hl_groups = {
      "EndOfBuffer",
      "FloatBorder",
      "MsgArea",
      "NeoTreeNormal",
      "NeoTreeNormalNC",
      "Normal",
      "NormalNC",
      "NormalFloat",
      "Pmenu",
      "SignColumn",
      "TelescopeBorder",
      "TelescopeNormal",
      "WhichKeyBorder",
      "WhichKeyFloat",
    }

    -- setting hl_groups
    for _, name in ipairs(hl_groups) do
      vim.cmd(string.format("highlight %s ctermbg=none guibg=none", name))
    end

    local highlights = {
      BufferLineBufferSelected    = { fg = "#ffffff", bold = true },
      BufferLineBackground        = { fg = "#565f89" },
      BufferLineIndicatorSelected = { fg = "#ffffff" },
      BufferLineModified          = { fg = "#616161" },
      BufferLineModifiedSelected  = { fg = "#ffffff" },
      BufferLineModifiedVisible   = { fg = "#a1a1ad" },
      BufferLineSeparator         = { fg = "#5c5c5c" },
      CursorLine                  = { bg = "#0c0c0c" },
      NeoTreeCursorLine           = { bg = "#16161e" },
      NeoTreeGitAdded             = { fg = "#495466" },
      NeoTreeGitConflict          = { fg = "#495466" },
      NeoTreeGitDeleted           = { fg = "#495466" },
      NeoTreeGitIgnored           = { fg = "#495466" },
      NeoTreeGitModified          = { fg = "#495466" },
      NeoTreeGitUnstaged          = { fg = "#495466" },
      NeoTreeGitUntracked         = { fg = "#495466" },
      NeoTreeGitStaged            = { fg = "#495466" },
      NeoTreeRootName             = { fg = "#7aa2f7" },
      NeoTreeTabActive            = { fg = "#c0caf5" },
      Winbar                      = { fg = "#495466" },
      WinbarNC                    = { fg = "#495466" },
    }

    -- setting highlights
    for group, conf in pairs(highlights) do
      vim.api.nvim_set_hl(0, group, conf)
    end

    local custom_themes = {
      tokyonight = {
        custom_colorscheme = {
          ["Comment"]                = { fg = "#565f89", italic = false },
          ["Keyword"]                = { fg = "#7dcfff", italic = false },
          ["@keyword"]               = { fg = "#9d7cd8", italic = false },
          ["@keyword.function"]      = { fg = "#6e51a2" },
          ["@field"]                 = { fg = "#7aa2f7" },
          ["@string"]                = { fg = "#73daca" },
          ["@boolean"]               = { fg = "#1cff1c" },
          ["@number"]                = { fg = "#1cff1c" },
          ["@punctuation"]           = { fg = "#e8e8e8" },
          ["@punctuation.bracket"]   = { fg = "#515171" },
          ["@punctuation.delimiter"] = { fg = "#e8e8e8" },
          ["@punctuation.special"]   = { fg = "#515171" },
          ["@tag"]                   = { fg = "#515171" },
          ["@tag.attribute"]         = { fg = "#91b4d5" },
          ["@tag.delimiter"]         = { fg = "#515171" },
          ["@constructor"]           = { fg = "#6e51a2" },
          ["Constant"]               = { fg = "#1cff1c" },
          ["String"]                 = { fg = "#73daca" },
          GitSignsAdd                = { fg = "#1abc9c" },
          GitSignsChange             = { fg = "#3c3cff" },
          GitSignsDelete             = { fg = "#880000" },
          IndentBlanklineChar        = { fg = "#3b4261" },
          IndentBlanklineContextChar = { fg = "#7aa2f7" },
          IlluminatedWordText        = { bg = "#080811" },
          IlluminatedWordRead        = { bg = "#080811" },
          IlluminatedWordWrite       = { bg = "#080811" },
          LspReferenceRead           = { bg = "#080811" },
          LspReferenceText           = { bg = "#080811" },
          LspReferenceWrite          = { bg = "#080811" },
          TelescopeSelection         = { bg = "#080811" },
          TelescopeSelectionCaret    = { bg = "#080811" },
          WinSeparator               = { fg = "#565f89" },
          rainbowcol2                = { fg = "#89ddff" },
          rainbowcol1                = { fg = "#2ac3de" },
          rainbowcol3                = { fg = "#7dcfff" },
          rainbowcol4                = { fg = "#1abc9c" },
          rainbowcol5                = { fg = "#7aa2f7" },
          rainbowcol6                = { fg = "#bb9af7" },
          rainbowcol7                = { fg = "#9d7cd8" }
        },
        custom_terminal_colors = {
          terminal_color_0  = '#15161e',
          terminal_color_1  = '#db4b4b',
          terminal_color_2  = '#1abc9c',
          terminal_color_3  = '#e0af68',
          terminal_color_4  = '#7aa2f7',
          terminal_color_5  = '#bb9af7',
          terminal_color_6  = '#7dcfff',
          terminal_color_7  = '#a9b1d6',
          terminal_color_8  = '#414868',
          terminal_color_9  = '#ff0000',
          terminal_color_10 = '#00ff00',
          terminal_color_11 = '#ffff00',
          terminal_color_12 = '#1c1cff',
          terminal_color_13 = '#8844bb',
          terminal_color_14 = '#008888',
          terminal_color_15 = '#ff4400',
        }
      },
      poimandres = {
        custom_colorscheme = { -- a table of overrides/changes to the poimandres theme
          ["@punctuation"]           = { fg = "#e8e8e8" },
          ["@punctuation.bracket"]   = { fg = "#515171" },
          ["@punctuation.delimiter"] = { fg = "#e8e8e8" },
          ["@punctuation.special"]   = { fg = "#515171" },
          ["@tag"]                   = { fg = "#515171" },
          ["@tag.attribute"]         = { fg = "#91b4d5" },
          ["@tag.delimiter"]         = { fg = "#515171" },
          ["@constructor"]           = { fg = "#5de4c7" },
          ["@comment"]               = { fg = "#3e4041" },
          ["Comment"]                = { fg = "#a6accd" },
          ["Visual"]                 = { bg = "#1c1c1c" },
          GitSignsAdd                = { fg = "#1abc9c" },
          GitSignsChange             = { fg = "#3c3cff" },
          GitSignsDelete             = { fg = "#880000" },
          IndentBlanklineChar        = { fg = "#3b4261" },
          IndentBlanklineContextChar = { fg = "#7aa2f7" },
          IlluminatedWordText        = { bg = "#080811" },
          IlluminatedWordRead        = { bg = "#080811" },
          IlluminatedWordWrite       = { bg = "#080811" },
          LspReferenceRead           = { bg = "#080811" },
          LspReferenceText           = { bg = "#080811" },
          LspReferenceWrite          = { bg = "#080811" },
          TelescopeSelection         = { bg = "#080811" },
          TelescopeSelectionCaret    = { bg = "#080811" },
          WinSeparator               = { fg = "#565f89" },
        },
        custom_terminal_colors = {
          terminal_color_0  = '#171922',
          terminal_color_1  = '#d0679d',
          terminal_color_2  = '#5de4c7',
          terminal_color_3  = '#fffac2',
          terminal_color_4  = '#add7ff',
          terminal_color_5  = '#fcc5e9',
          terminal_color_6  = '#89ddff',
          terminal_color_7  = '#ffffff',
          terminal_color_8  = '#506477',
          terminal_color_9  = '#ff0000',
          terminal_color_10 = '#00ff00',
          terminal_color_11 = '#ffff00',
          terminal_color_12 = '#1c1cff',
          terminal_color_13 = '#8844bb',
          terminal_color_14 = '#008888',
          terminal_color_15 = '#ff4400',
        }
      },
    }

    local selected_colorscheme = custom_themes[vim.g.colors_name]
    if selected_colorscheme then

      -- setting custom_colorscheme
      for group, conf in pairs(selected_colorscheme.custom_colorscheme) do
        vim.api.nvim_set_hl(0, group, conf)
      end

      -- setting custom_terminal_colors
      for group, conf in pairs(selected_colorscheme.custom_terminal_colors) do
        vim.g[group] = conf
      end

    end
  end,
})

vim.opt.fillchars = "eob: "

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end
