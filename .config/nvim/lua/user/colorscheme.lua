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

    for _, name in ipairs(hl_groups) do
      vim.cmd(string.format("highlight %s ctermbg=none guibg=none", name))
    end

    local highlights = {
      BufferLineBackground        = { fg = "#565f89" },
      BufferLineSeparator         = { fg = "#5c5c5c" },
      BufferLineIndicatorSelected = { fg = "#ffffff" },
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

    for group, conf in pairs(highlights) do
      vim.api.nvim_set_hl(0, group, conf)
    end

    local custom_themes = {
      tokyonight = {
        ["Comment"]                = { fg = "#565f89", italic = false },
        ["Keyword"]                = { fg = "#7dcfff", italic = false },
        ["@keyword"]               = { fg = "#9d7cd8", italic = false },
        ["@field"]                 = { fg = "#7aa2f7" },
        ["@string"]                = { fg = "#73daca" },
        ["@boolean"]               = { fg = "#1cff1c" },
        ["@number"]                = { fg = "#1cff1c" },
        ["Constant"]               = { fg = "#1cff1c" },
        ["String"]                 = { fg = "#73daca" },
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
        rainbowcol2                = { fg = "#89ddff" },
        rainbowcol1                = { fg = "#2ac3de" },
        rainbowcol3                = { fg = "#7dcfff" },
        rainbowcol4                = { fg = "#1abc9c" },
        rainbowcol5                = { fg = "#7aa2f7" },
        rainbowcol6                = { fg = "#bb9af7" },
        rainbowcol7                = { fg = "#9d7cd8" }
      },
      poimandres = { -- a table of overrides/changes to the poimandres theme
        ["@comment"]               = { fg = "#3e4041" },
        ["Comment"]                = { fg = "#a6accd" },
        ["Visual"]                 = { bg = "#1c1c1c" },
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
      },
    }

    local selected_colorscheme = custom_themes[vim.g.colors_name]
    if selected_colorscheme then
      for group, conf in pairs(selected_colorscheme) do
        vim.api.nvim_set_hl(0, group, conf)
      end
    end

  end,
})

vim.opt.fillchars = "eob: "

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end
