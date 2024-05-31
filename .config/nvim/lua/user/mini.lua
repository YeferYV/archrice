local mini_status_ok, mini_ai = pcall(require, 'mini.ai')
if not mini_status_ok then return end
local spec_treesitter = mini_ai.gen_spec.treesitter
local mini_clue = require("mini.clue")

--- local gen_ai_spec = require('mini.extra').gen_ai_spec
---   require('mini.ai').setup({
---     custom_textobjects = {
---       B = gen_ai_spec.buffer(),
---       D = gen_ai_spec.diagnostic(),
---       I = gen_ai_spec.indent(),
---       L = gen_ai_spec.line(),
---       N = gen_ai_spec.number(),
---     },
---   })

mini_ai.setup({

  -- Table with textobject id as fields, textobject specification as values.
  -- Also use this to disable builtin textobjects. See |MiniAi.config|.
  custom_textobjects = {

    B = spec_treesitter({ a = "@block.outer", i = "@block.inner" }),
    q = spec_treesitter({ a = "@call.outer", i = "@call.inner" }),
    Q = spec_treesitter({ a = "@class.outer", i = "@class.inner" }),
    g = spec_treesitter({ a = "@comment.outer", i = "@comment.inner" }),
    G = spec_treesitter({ a = "@conditional.outer", i = "@conditional.inner" }),
    F = spec_treesitter({ a = "@function.outer", i = "@function.inner" }),
    L = spec_treesitter({ a = "@loop.outer", i = "@loop.inner" }),
    P = spec_treesitter({ a = "@parameter.outer", i = "@parameter.inner" }),
    R = spec_treesitter({ a = "@return.outer", i = "@return.inner" }),
    ["A"] = spec_treesitter({ a = "@assignment.outer", i = "@assignment.inner" }),
    ["="] = spec_treesitter({ a = "@assignment.rhs", i = "@assignment.lhs" }),
    ["#"] = spec_treesitter({ a = "@number.outer", i = "@number.inner" }),

    -- pair text object
    -- ['_'] = mini.ai.gen_spec.pair('_', '_', { type = 'greedy' }),
    -- ['<'] = mini.ai.gen_spec.pair('<', '>', { type = 'balanced' }),
    -- ['>'] = mini.ai.gen_spec.pair('<', '>', { type = 'non-balanced' }),

    -- Tweak argument textobject:
    -- a = mini_ai.gen_spec.argument({ brackets = { '%b()', '%b[]', '%b{}' }, separator = '[,;]', exclude_regions = { '%b""', "%b''" } }),

    -- Disable brackets alias in favor of builtin block textobject:
    -- b = false,
    -- b = { { '%b()', '%b[]', '%b{}' }, '^.().*().$' },

    -- Tweak function call to not detect dot in function name
    -- f = mini.ai.gen_spec.function_call({ name_pattern = '[%w_]' }),

    -- html/jsx attribute (first {regex} captures tag, second {regex,regex,regex} filters)
    -- h = { '%f[%s]%s+[^%s<>=]+=[^%s<>]+', '^%s+().*()$' }, -- broked at whitespaces -- https://github.com/echasnovski/mini.nvim/issues/151
    -- h = { { '(%w+=").-(")' }, '^.().*().$' }, -- Pattern in single curly bracket makes the double curly bracket with catpuring group `(some caputure)` work
    h = { { "<(%w-)%f[^<%w][^<>]->.-</%1>" }, { "%f[%w]%w+=()%b{}()", '%f[%w]%w+=()%b""()', "%f[%w]%w+=()%b''()" } }, -- %f[%w]%w+ is equivalent to lua (%w+) since mini.ai is not greedy

    -- key-value textobj :help mini.ai (line 300)
    -- the pattern .- matches any sequence of characters (except newline characters) (including whitespaces)
    k = { { "\n.-[=:]", "^.-[=:]" }, "^%s*()().-()%s-()=?[!=<>\\+-\\*]?[=:]" }, -- .- -> don't be greedy let %s- to exist while .* is greedy
    v = { { "[=:]()%s*().-%s*()[;,]()", "[=:]=?()%s*().*()().$" } },            -- Pattern in double curly bracket equals fallback

    -- number/hexadecimalcolor textobj:
    -- the pattern %f[%d]%d+ ensures there is a %d before start matching (non %d before %d+)(useful to stop .*)
    n = { "[-+]?()%f[%d]%d+()%.?%d*" }, -- %f[%d] to make jumping to next group of number instead of next digit
    x = { "#()%x%x%x%x%x%x()" },

    -- _whitespace_textobj:
    o = { "%S()%s+()%S" },

    -- quotes/uotes:
    u = { { "%b''", '%b""', "%b``" }, "^.().*().$" }, -- Pattern in single curly bracket equals filter the double-bracket/left-side

    -- -- Whole buffer:
    -- ["+"] = function()
    --   local from = { line = 1, col = 1 }
    --   local to = {
    --     line = vim.fn.line('$'),
    --     col = math.max(vim.fn.getline('$'):len(), 1)
    --   }
    --   return { from = from, to = to }
    -- end,
  },

  user_textobject_id = true,
  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    -- Main textobject prefixes
    around = "a",
    inside = "i",

    -- Next/last variants
    around_next = "aN",
    inside_next = "iN",
    around_last = "al",
    inside_last = "il",

    -- Move cursor to corresponding edge of `a` textobject
    goto_left = "g[",
    goto_right = "g]",
  },

  -- Number of lines within which textobject is searched
  n_lines = 50,

  -- How to search for object (first inside current line, then inside
  -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
  -- 'cover_or_nearest', 'next', 'previous', 'nearest'.
  search_method = "cover_or_next",

  -- Whether to disable showing non-error feedback
  silent = false,

})

require('mini.align').setup()
require('mini.bracketed').setup()
require('mini.comment').setup()
require('mini.indentscope').setup({ symbol = '' })
-- require('mini.indentscope').setup({ draw = { animation = require('mini.indentscope').gen_animation.none() }, symbol = '│' })

require('mini.operators').setup({
  evaluate = {
    prefix = '', -- 'g=',
    func = nil,
  },

  exchange = {
    prefix = 'gY',
    reindent_linewise = true,
  },
  multiply = {
    prefix = '', -- 'gm',
    func = nil,
  },
  replace = {
    prefix = 'gy',
    reindent_linewise = true,
  },
  sort = {
    prefix = 'gz',
    func = nil,
  }
})

require('mini.splitjoin').setup()

require('mini.surround').setup({
  custom_surroundings = nil,
  highlight_duration = 500,
  mappings = {
    add = 'gsa',            -- Add surrounding in Normal and Visual modes
    delete = 'gsd',         -- Delete surrounding
    find = 'gsf',           -- Find surrounding (to the right)
    find_left = 'gsF',      -- Find surrounding (to the left)
    highlight = 'gsh',      -- Highlight surrounding
    replace = 'gsr',        -- Replace surrounding
    update_n_lines = 'gsn', -- Update `n_lines`

    suffix_last = 'l',      -- Suffix to search with "prev" method
    suffix_next = 'N',      -- Suffix to search with "next" method
  },
  n_lines = 20,
  respect_selection_type = false,
  search_method = 'cover',
})

if not vim.g.vscode then
  require('mini.map').setup({
    integrations = {
      require('mini.map').gen_integration.builtin_search(),
      require('mini.map').gen_integration.diagnostic(),
      require('mini.map').gen_integration.gitsigns(),
    },
  })

  require('mini.clue').setup({
    triggers = {
      -- Leader triggers
      { mode = 'n', keys = '<Leader>' },
      { mode = 'x', keys = '<Leader>' },

      -- Built-in completion
      { mode = 'i', keys = '<C-x>' },

      -- textobj
      { mode = 'o', keys = 'a' },
      { mode = 'o', keys = 'i' },
      { mode = 'x', keys = 'a' },
      { mode = 'x', keys = 'i' },

      -- `g` key
      { mode = 'o', keys = 'g' },
      { mode = 'n', keys = 'g' },
      { mode = 'x', keys = 'g' },

      -- `v` key
      -- { mode = 'n', keys = 'v' }, -- overwrites ``vg` menu`

      -- Marks
      { mode = 'n', keys = "'" },
      { mode = 'n', keys = '`' },
      { mode = 'x', keys = "'" },
      { mode = 'x', keys = '`' },

      -- Registers
      { mode = 'n', keys = '"' },
      { mode = 'x', keys = '"' },
      { mode = 'i', keys = '<C-r>' },
      { mode = 'c', keys = '<C-r>' },

      -- Window commands
      { mode = 'n', keys = '<C-w>' },

      -- `z` key
      { mode = 'n', keys = 'z' },
      { mode = 'x', keys = 'z' },
    },
    clues = {
      -- Enhance this by adding descriptions for <Leader> mapping groups
      mini_clue.gen_clues.builtin_completion(),
      mini_clue.gen_clues.g(),
      mini_clue.gen_clues.marks(),
      mini_clue.gen_clues.registers(),
      mini_clue.gen_clues.windows(),
      mini_clue.gen_clues.z(),
      require("user.whichkey"),
    },
  })

  require("mini.files").setup({
    windows = {
      max_number = math.huge,
      preview = true,
      width_focus = 30,
      width_nofocus = 15,
      width_preview = 60,
    },
  })

  require('mini.completion').setup({ delay = { completion = 10 ^ 7, info = 100, signature = 50 } })
  require('mini.cursorword').setup()
  require('mini.icons').setup()
  require('mini.misc').setup_auto_root()
  require('mini.notify').setup()
  require('mini.pairs').setup()
  require('mini.statusline').setup()
  require('mini.starter').setup()
  require('mini.tabline').setup()
  MiniIcons.mock_nvim_web_devicons()
  vim.notify = MiniNotify.make_notify() -- `vim.print = MiniNotify.make_notify()` conflicts with `:=vim.opt.number`
  vim.opt.laststatus = 3                -- it has to be after mini.statusline

  require('mini.base16').setup({
    -- `:Inspect` and `:hi <@treesitter>` to reverse engineering a colorscheme
    -- https://github.com/NvChad/base46/tree/v2.5/lua/base46/themes for popular colorscheme palettes
    palette = {
      -- xigoi mini.nvim share your setups discution #36
      -- base00 = "#000000", -- default bg
      -- base01 = "#111111", -- line number bg
      -- base02 = "#333333", -- statusline bg, selection bg
      -- base03 = "#bbbbbb", -- line number fg, comments
      -- base04 = "#dddddd", -- statusline fg
      -- base05 = "#ffffff", -- default fg
      -- base06 = "#ffffff", -- light fg (not often used)
      -- base07 = "#ffffff", -- light bg (not often used)
      -- base09 = "#ff2222", -- statements, identifiers
      -- base08 = "#ff9922", -- integers, booleans, constants
      -- base0A = "#ff22ff", -- classes, search highlights
      -- base0B = "#22ff22", -- strings
      -- base0C = "#4444ff", -- builtins
      -- base0D = "#22ffff", -- functions
      -- base0E = "#ffff22", -- keywords
      -- base0F = "#999999", -- punctuation, regex, indentscope

      -- nvchad mountain
      -- base00 = "#0f0f0f", -- default bg
      -- base01 = "#151515", -- line number bg
      -- -- base02 = "#191919", -- statusline bg, selection bg
      -- -- base03 = "#222222", -- line number fg, comments
      -- base02 = '#444444', -- statusline bg, selection bg
      -- base03 = '#767676', -- line number fg, comments
      -- base04 = "#535353", -- statusline fg
      -- base05 = "#d8d8d8", -- default fg
      -- base06 = "#e6e6e6", -- light fg (not often used)
      -- base07 = "#f0f0f0", -- light bg (not often used)
      -- base08 = "#b18f91", -- statements, identifiers
      -- base09 = "#d8bb92", -- integers, booleans, constants
      -- base0A = "#b1ae8f", -- classes, search highlights
      -- base0B = "#8aac8b", -- strings
      -- base0C = "#91b2b3", -- builtins
      -- base0D = "#a5a0c2", -- functions
      -- base0E = "#ac8aac", -- keywords
      -- base0F = "#b39193", -- punctuation, regex, indentscope

      -- arcxio mini.nvim share your setups discution #36
      -- base00 = '#080808', -- default bg
      -- base01 = '#121212', -- line number bg
      -- base02 = '#444444', -- statusline bg, selection bg
      -- base03 = '#767676', -- line number fg, comments
      -- base04 = '#eeeeee', -- statusline fg
      -- base05 = '#eeeeee', -- default fg
      -- base06 = '#eeeeee', -- light fg (not often used)
      -- base07 = '#eeeeee', -- light bg (not often used)
      -- base08 = '#ffd7ff', -- statements, identifiers
      -- base09 = '#d7afff', -- integers, booleans, constants
      -- base0A = '#ffffd7', -- classes, search highlights
      -- base0B = '#afd787', -- strings
      -- base0C = '#afd7ff', -- builtins
      -- base0D = '#d7ffff', -- functions
      -- base0E = '#afffaf', -- keywords
      -- base0F = '#8a8a8a', -- punctuation, regex, indentscope

      -- -- nvchad poimandres
      -- base00 = "#1b1e28", -- default bg
      -- base01 = "#2b3040", -- line number bg
      -- base02 = "#32384a", -- statusline bg, selection bg
      -- base03 = "#3b4258", -- line number fg, comments
      -- base04 = "#48506a", -- statusline fg
      -- base05 = "#A6ACCD", -- default fg
      -- base06 = "#b6d7f4", -- light fg (not often used)
      -- base07 = "#ffffff", -- light bg (not often used)
      -- base08 = "#A6ACCD", -- statements, identifiers
      -- base09 = "#5DE4C7", -- integers, booleans, constants, search
      -- base0A = "#5DE4C7", -- classes
      -- base0B = "#5DE4C7", -- strings
      -- base0C = "#89DDFF", -- builtins
      -- base0D = "#ADD7FF", -- functions
      -- base0E = "#91B4D5", -- keywords
      -- base0F = "#E4F0FB", -- punctuation, regex, indentscope

      -- nvchad tokyonight
      base00 = "#1a1b26", -- default bg
      base01 = "#16161e", -- line number bg
      base02 = "#2f3549", -- statusline bg, selection bg
      base03 = "#444b6a", -- line number fg, comments
      base04 = "#787c99", -- statusline fg
      base05 = "#a9b1d6", -- default fg, delimiters
      base06 = "#cbccd1", -- light fg (not often used)
      base07 = "#d5d6db", -- light bg (not often used)
      base08 = "#7aa2f7", -- variables, tags, Diff delete
      base09 = "#ff9e64", -- integers, booleans, constants, search fg
      base0A = "#0db9d7", -- classes, search bg
      base0B = "#73daca", -- strings, Diff insert
      -- base0C = "#b4f9f8", -- builtins, regex
      base0C = "#2ac3de", -- builtins, regex
      -- base0D = "#2ac3de", -- functions
      base0D = "#7aa2f7", -- functions
      base0E = "#bb9af7", -- keywords, Diff changed
      base0F = "#7aa2f7", -- punctuation, indentscope

      -- -- nvchad tokyonight
      -- base00 = "#1a1b26", -- default bg
      -- base01 = "#16161e", -- line number bg
      -- base02 = "#2f3549", -- statusline bg, selection bg
      -- base03 = "#444b6a", -- line number fg, comments
      -- base04 = "#787c99", -- statusline fg
      -- base05 = "#a9b1d6", -- default fg, delimiters
      -- base06 = "#cbccd1", -- light fg (not often used)
      -- base07 = "#d5d6db", -- light bg (not often used)
      -- base08 = "#73daca", -- variables, tags, Diff delete
      -- base09 = "#ff9e64", -- integers, booleans, constants, search fg
      -- base0A = "#0db9d7", -- classes, search bg
      -- base0B = "#9ece6a", -- strings, Diff insert
      -- base0C = "#b4f9f8", -- builtins, regex
      -- base0D = "#2ac3de", -- functions
      -- base0E = "#bb9af7", -- keywords, Diff changed
      -- base0F = "#f7768e", -- punctuation, indentscope, tag signs

    },
  })

  -- poimandres custom treesitter colors
  -- vim.api.nvim_set_hl(0, "Identifier", { fg = "#2ac3de" })
  -- vim.api.nvim_set_hl(0, "Search", { fg = "#c0caf5", bg = "#3d59a1" })
  -- vim.api.nvim_set_hl(0, "IncSearch", { fg = "#15161e", bg = "#ff9e64" })
  vim.api.nvim_set_hl(0, "@property", { fg = "#7aa2f7" })
  vim.api.nvim_set_hl(0, "@field", { fg = "#7aa2f7" })
  -- vim.api.nvim_set_hl(0, "@function.call", { fg = "#7aa2f7" })
  vim.api.nvim_set_hl(0, "@keyword", { fg = "#9d7cd8" })
  vim.api.nvim_set_hl(0, "@keyword.function", { fg = "#6e51a2" })

  -- adding tokyonight transparency
  vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "FoldColumn", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "MiniStatuslineFilename", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { underline = false, bg = "#1c1c2c" })
  vim.api.nvim_set_hl(0, "MiniCursorword", { bg = "#1c1c2c" })
  vim.api.nvim_set_hl(0, "LineNr", { fg = "#506477", bg = "NONE" })
  vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "Statusline", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "StatuslineNC", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#1abc9c" })
  vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#3c3cff" })
  vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#880000" })
  vim.api.nvim_set_hl(0, "PmenuSel", { fg = "NONE", bg = "#2c2c2c" })
end
