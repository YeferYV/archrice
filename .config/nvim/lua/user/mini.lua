local mini_status_ok, mini_ai = pcall(require, 'mini.ai')
if not mini_status_ok then return end
local spec_treesitter = mini_ai.gen_spec.treesitter
local mini_clue = require("mini.clue")

local gen_ai_spec = require('mini.extra').gen_ai_spec

mini_ai.setup({

  -- Table with textobject id as fields, textobject specification as values.
  -- Also use this to disable builtin textobjects. See |MiniAi.config|.
  custom_textobjects = {

    K = spec_treesitter({ a = "@block.outer", i = "@block.inner" }),
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

    d = gen_ai_spec.diagnostic(),
    e = gen_ai_spec.line(),

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
    -- N = { "[-+]?()%f[%d]%d+()%.?%d*" }, -- %f[%d] to make jumping to next group of number instead of next digit
    N = gen_ai_spec.number(),
    x = { "#()%x%x%x%x%x%x()" },

    -- _whitespace_textobj:
    o = { "%S()%s+()%S" },

    -- sub word textobj https://github.com/echasnovski/mini.nvim/blob/main/doc/mini-ai.txt
    S = { { '%u[%l%d]+%f[^%l%d]', '%f[%S][%l%d]+%f[^%l%d]', '%f[%P][%l%d]+%f[^%l%d]', '^[%l%d]+%f[^%l%d]', }, '^().*()$' },

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

    -- https://thevaluable.dev/vim-create-text-objects
    -- select indent by the same or mayor level delimited by blank-lines
    i = function()
      local start_indent = vim.fn.indent(vim.fn.line('.'))

      local prev_line = vim.fn.line('.') - 1
      while vim.fn.indent(prev_line) >= start_indent do
        prev_line = prev_line - 1
      end

      local next_line = vim.fn.line('.') + 1
      while vim.fn.indent(next_line) >= start_indent do
        next_line = next_line + 1
      end

      return { from = { line = prev_line + 1, col = 1 }, to = { line = next_line - 1, col = 100 }, vis_mode = 'V' }
    end,

    -- select indent by the same level delimited by comment-lines (outer: includes blank-lines)
    y = function()
      local start_indent = vim.fn.indent(vim.fn.line('.'))
      local get_comment_regex = "^%s*" .. string.gsub(vim.bo.commentstring, "%%s", ".*") .. "%s*$"
      local is_blank_line = function(line) return string.match(vim.fn.getline(line), '^%s*$') end
      local is_comment_line = function(line) return string.find(vim.fn.getline(line), get_comment_regex) end
      local is_out_of_range = function(line) return vim.fn.indent(line) == -1 end

      local prev_line = vim.fn.line('.') - 1
      while vim.fn.indent(prev_line) == start_indent or is_blank_line(prev_line) do
        if is_out_of_range(prev_line) then break end
        if is_comment_line(prev_line) then break end
        if is_blank_line(prev_line) and _G.skip_blank_line then break end
        prev_line = prev_line - 1
      end

      local next_line = vim.fn.line('.') + 1
      while vim.fn.indent(next_line) == start_indent or is_blank_line(next_line) do
        if is_out_of_range(next_line) then break end
        if is_comment_line(next_line) then break end
        if is_blank_line(next_line) and _G.skip_blank_line then break end
        next_line = next_line + 1
      end

      return { from = { line = prev_line + 1, col = 1 }, to = { line = next_line - 1, col = 100 }, vis_mode = 'V' }
    end
  },
  n_lines = 500, -- search range and required by functions less than 500 LOC
})

require('mini.surround').setup({
  mappings = {
    add = 'gza',            -- Add surrounding in Normal and Visual modes
    delete = 'gzd',         -- Delete surrounding
    find = 'gzf',           -- Find surrounding (to the right)
    find_left = 'gzF',      -- Find surrounding (to the left)
    highlight = 'gzh',      -- Highlight surrounding
    replace = 'gzr',        -- Replace surrounding
    update_n_lines = 'gzn', -- Update `n_lines`
  },
})

require('mini.align').setup()
require('mini.bracketed').setup({ undo = { suffix = '' } })
require('mini.operators').setup()
require('mini.splitjoin').setup()

if not vim.g.vscode then
  -- require('mini.map').setup({
  --   integrations = {
  --     require('mini.map').gen_integration.builtin_search(),
  --     require('mini.map').gen_integration.diagnostic(),
  --     require('mini.map').gen_integration.gitsigns(),
  --   },
  -- })

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
    use_cterm = true, -- required if `vi -c 'Pick files'`
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
  vim.api.nvim_set_hl(0, "MiniDiffSignAdd", { fg = "#009900" })
  vim.api.nvim_set_hl(0, "MiniDiffSignChange", { fg = "#3C3CFf" })
  vim.api.nvim_set_hl(0, "MiniDiffSignDelete", { fg = "#990000" })
  vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#db4b4b" })
  vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = "#1abc9c" })
  vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = "#0db9d7" })
  vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = "#e0af68" })
  vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = "#db4b4b" })
  vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = "#1abc9c" })
  vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg = "#0db9d7" })
  vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = "#e0af68" })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { underline = true, sp = "#db4b4b" })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { underline = true, sp = "#1abc9c" })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { underline = true, sp = "#0db9d7" })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { underline = true, sp = "#e0af68" })
  vim.api.nvim_set_hl(0, "PmenuSel", { fg = "NONE", bg = "#2c2c2c" })
  vim.api.nvim_set_hl(0, "Search", { fg = "#c0caf5", bg = "#3d59a1" })
  vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#c0caf5", bg = "#FF007C" })

  -- TODO: remove it when mini.snippets available
  local H = {}

  -- extracted from https://github.com/echasnovski/mini.nvim/blob/main/lua/mini/completion.lua
  H.table_get = function(t, id)
    if type(id) ~= 'table' then return H.table_get(t, { id }) end
    local success, res = true, t
    for _, i in ipairs(id) do
      success, res = pcall(function() return res[i] end)
      if not success or res == nil then return end
    end
    return res
  end

  -- Completion word (textEdit.newText > insertText > label)
  H.get_completion_word = function(item)
    return H.table_get(item, { 'textEdit', 'newText' }) or item.insertText or item.label or ''
  end

  -- skip snippets filter
  -- press <c-x><c-o> if snippet not showing (e.g using lua-ls when configured with `require('mini.completion').setup()` )
  require('mini.completion').setup({
    lsp_completion = {
      process_items = function(items, base)
        local res = vim.tbl_filter(function(item)
          -- Keep items which match the base
          local text = item.filterText or H.get_completion_word(item)
          return vim.startswith(text, base)
        end, items)

        table.sort(res, function(a, b) return (a.sortText or a.label) < (b.sortText or b.label) end)
        return res
      end,
    },
  })

  require('mini.cursorword').setup()
  require('mini.icons').setup()
  require('mini.indentscope').setup({ options = { indent_at_cursor = false, }, symbol = '' }) -- draw = { animation = require('mini.indentscope').gen_animation.none() }
  require('mini.misc').setup_auto_root()
  require('mini.notify').setup()
  require('mini.pairs').setup()
  -- require('mini.pick').setup()
  require('mini.statusline').setup()
  require('mini.starter').setup()
  require('mini.tabline').setup()
  MiniIcons.mock_nvim_web_devicons()
  MiniIcons.tweak_lsp_kind( --[[ "replace" ]])
  vim.notify = MiniNotify.make_notify()                                        -- `vim.print = MiniNotify.make_notify()` conflicts with `:=vim.opt.number`
  if vim.fn.has('nvim-0.11') == 1 then vim.opt.completeopt:append('fuzzy') end -- it should be after require("mini.completion").setup())
  vim.opt.laststatus = 3                                                       -- it has to be after mini.statusline
end

local M = {}
M.hl = {}
M.colors = {
  slate = { [50] = "f8fafc", [100] = "f1f5f9", [200] = "e2e8f0", [300] = "cbd5e1", [400] = "94a3b8", [500] = "64748b", [600] = "475569", [700] = "334155", [800] = "1e293b", [900] = "0f172a", [950] = "020617", },
  gray = { [50] = "f9fafb", [100] = "f3f4f6", [200] = "e5e7eb", [300] = "d1d5db", [400] = "9ca3af", [500] = "6b7280", [600] = "4b5563", [700] = "374151", [800] = "1f2937", [900] = "111827", [950] = "030712", },
  zinc = { [50] = "fafafa", [100] = "f4f4f5", [200] = "e4e4e7", [300] = "d4d4d8", [400] = "a1a1aa", [500] = "71717a", [600] = "52525b", [700] = "3f3f46", [800] = "27272a", [900] = "18181b", [950] = "09090B", },
  neutral = { [50] = "fafafa", [100] = "f5f5f5", [200] = "e5e5e5", [300] = "d4d4d4", [400] = "a3a3a3", [500] = "737373", [600] = "525252", [700] = "404040", [800] = "262626", [900] = "171717", [950] = "0a0a0a", },
  stone = { [50] = "fafaf9", [100] = "f5f5f4", [200] = "e7e5e4", [300] = "d6d3d1", [400] = "a8a29e", [500] = "78716c", [600] = "57534e", [700] = "44403c", [800] = "292524", [900] = "1c1917", [950] = "0a0a0a", },
  red = { [50] = "fef2f2", [100] = "fee2e2", [200] = "fecaca", [300] = "fca5a5", [400] = "f87171", [500] = "ef4444", [600] = "dc2626", [700] = "b91c1c", [800] = "991b1b", [900] = "7f1d1d", [950] = "450a0a", },
  orange = { [50] = "fff7ed", [100] = "ffedd5", [200] = "fed7aa", [300] = "fdba74", [400] = "fb923c", [500] = "f97316", [600] = "ea580c", [700] = "c2410c", [800] = "9a3412", [900] = "7c2d12", [950] = "431407", },
  amber = { [50] = "fffbeb", [100] = "fef3c7", [200] = "fde68a", [300] = "fcd34d", [400] = "fbbf24", [500] = "f59e0b", [600] = "d97706", [700] = "b45309", [800] = "92400e", [900] = "78350f", [950] = "451a03", },
  yellow = { [50] = "fefce8", [100] = "fef9c3", [200] = "fef08a", [300] = "fde047", [400] = "facc15", [500] = "eab308", [600] = "ca8a04", [700] = "a16207", [800] = "854d0e", [900] = "713f12", [950] = "422006", },
  lime = { [50] = "f7fee7", [100] = "ecfccb", [200] = "d9f99d", [300] = "bef264", [400] = "a3e635", [500] = "84cc16", [600] = "65a30d", [700] = "4d7c0f", [800] = "3f6212", [900] = "365314", [950] = "1a2e05", },
  green = { [50] = "f0fdf4", [100] = "dcfce7", [200] = "bbf7d0", [300] = "86efac", [400] = "4ade80", [500] = "22c55e", [600] = "16a34a", [700] = "15803d", [800] = "166534", [900] = "14532d", [950] = "052e16", },
  emerald = { [50] = "ecfdf5", [100] = "d1fae5", [200] = "a7f3d0", [300] = "6ee7b7", [400] = "34d399", [500] = "10b981", [600] = "059669", [700] = "047857", [800] = "065f46", [900] = "064e3b", [950] = "022c22", },
  teal = { [50] = "f0fdfa", [100] = "ccfbf1", [200] = "99f6e4", [300] = "5eead4", [400] = "2dd4bf", [500] = "14b8a6", [600] = "0d9488", [700] = "0f766e", [800] = "115e59", [900] = "134e4a", [950] = "042f2e", },
  cyan = { [50] = "ecfeff", [100] = "cffafe", [200] = "a5f3fc", [300] = "67e8f9", [400] = "22d3ee", [500] = "06b6d4", [600] = "0891b2", [700] = "0e7490", [800] = "155e75", [900] = "164e63", [950] = "083344", },
  sky = { [50] = "f0f9ff", [100] = "e0f2fe", [200] = "bae6fd", [300] = "7dd3fc", [400] = "38bdf8", [500] = "0ea5e9", [600] = "0284c7", [700] = "0369a1", [800] = "075985", [900] = "0c4a6e", [950] = "082f49", },
  blue = { [50] = "eff6ff", [100] = "dbeafe", [200] = "bfdbfe", [300] = "93c5fd", [400] = "60a5fa", [500] = "3b82f6", [600] = "2563eb", [700] = "1d4ed8", [800] = "1e40af", [900] = "1e3a8a", [950] = "172554", },
  indigo = { [50] = "eef2ff", [100] = "e0e7ff", [200] = "c7d2fe", [300] = "a5b4fc", [400] = "818cf8", [500] = "6366f1", [600] = "4f46e5", [700] = "4338ca", [800] = "3730a3", [900] = "312e81", [950] = "1e1b4b", },
  violet = { [50] = "f5f3ff", [100] = "ede9fe", [200] = "ddd6fe", [300] = "c4b5fd", [400] = "a78bfa", [500] = "8b5cf6", [600] = "7c3aed", [700] = "6d28d9", [800] = "5b21b6", [900] = "4c1d95", [950] = "2e1065", },
  purple = { [50] = "faf5ff", [100] = "f3e8ff", [200] = "e9d5ff", [300] = "d8b4fe", [400] = "c084fc", [500] = "a855f7", [600] = "9333ea", [700] = "7e22ce", [800] = "6b21a8", [900] = "581c87", [950] = "3b0764", },
  fuchsia = { [50] = "fdf4ff", [100] = "fae8ff", [200] = "f5d0fe", [300] = "f0abfc", [400] = "e879f9", [500] = "d946ef", [600] = "c026d3", [700] = "a21caf", [800] = "86198f", [900] = "701a75", [950] = "4a044e", },
  pink = { [50] = "fdf2f8", [100] = "fce7f3", [200] = "fbcfe8", [300] = "f9a8d4", [400] = "f472b6", [500] = "ec4899", [600] = "db2777", [700] = "be185d", [800] = "9d174d", [900] = "831843", [950] = "500724", },
  rose = { [50] = "fff1f2", [100] = "ffe4e6", [200] = "fecdd3", [300] = "fda4af", [400] = "fb7185", [500] = "f43f5e", [600] = "e11d48", [700] = "be123c", [800] = "9f1239", [900] = "881337", [950] = "4c0519", },
}

-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/util/mini-hipatterns.lua
require("mini.hipatterns").setup({
  highlighters = {
    hex_color = require("mini.hipatterns").gen_highlighter.hex_color({ priority = 2000 }),
    tailwind = {
      pattern = "%f[%w:-]()[%w:-]+%-[a-z%-]+%-%d+()%f[^%w:-]",
      group = function(_, _, m)
        local match = m.full_match
        local color, shade = match:match("[%w-]+%-([a-z%-]+)%-(%d+)")
        shade = tonumber(shade)
        local bg = vim.tbl_get(M.colors, color, shade)
        if bg then
          local hl = "MiniHipatternsTailwind" .. color .. shade
          if not M.hl[hl] then
            M.hl[hl] = true
            local bg_shade = shade == 500 and 950 or shade < 500 and 900 or 100
            local fg = vim.tbl_get(M.colors, color, bg_shade)
            vim.api.nvim_set_hl(0, hl, { bg = "#" .. bg, fg = "#" .. fg })
          end
          return hl
        end
      end,
    }
  }
})

-- local out = vim.api.nvim_exec2(
--   string.format("! rg --files '%s'/.vscode/extensions | rg '.code-snippets' ", vim.env.HOME),
--   { output = true }
-- )
--
-- local words = {}
--
-- local extract_paths = function()
--   local out_nofirstline = out.output:gsub(".*\r\n\n", "")
--   local out_array = out_nofirstline:gsub("\n", ";")
--
--   -- https://stackoverflow.com/questions/19907916/split-a-string-using-string-gmatch-in-lua
--   for w in out_array:gmatch("([^;]*);") do
--     table.insert(words, w)
--   end
-- end
-- extract_paths()

-- local gens = {}
local gen_loader = require('mini.snippets').gen_loader
--
-- for _, value in pairs(files) do
--   local gen = gen_loader.from_file(value)
--   table.insert(gens, gen)
-- end

-- local runtime_path = vim.opt.rtp:get()
-- table.insert(runtime_path, files)
-- vim.notify(vim.inspect(runtime_path))
-- vim.opt.rtp = runtime_path

local function add_vscode_snippets_to_rtp()
  local extensions_dir = vim.fs.joinpath(vim.env.HOME, '.vscode', 'extensions')

  -- Get all snippet directories using glob
  local snippet_dirs = vim.fn.globpath(
    extensions_dir,
    '*/snippets', -- Matches any extension/snippets directory
    true,         -- recursive
    true          -- return as list
  )

  -- Add to runtimepath (with nil checks)
  for _, dir in ipairs(snippet_dirs) do
    if vim.fn.isdirectory(dir) == 1 then
      -- Normalize the path to handle OS-specific separators
      local normalized_dir = vim.fs.normalize(dir)

      local parent_dir = normalized_dir:gsub("/snippets$", "")
      -- ~/.vscode/extensions/emranweb.daisyui-snippet-1.0.3/snippets/snippetshtml.code-snippets no contains a valid JSON object
      -- ~/.vscode/extensions/imgildev.vscode-nextjs-generator-2.6.0/snippets/trpc.code-snippets no contains a valid JSON object
      vim.opt.rtp:append(parent_dir)
    end
  end
end


add_vscode_snippets_to_rtp()

-- vim.opt.rtp:prepend("~/.vscode/extensions/emranweb.daisyui-snippet-1.0.3")
-- vim.opt.rtp:prepend("~/.vscode/extensions/*/snippets")
require('mini.snippets').setup({
  -- snippets = { gen_loader.from_file('~/.vscode/extensions/emranweb.daisyui-snippet-1.0.3/snippets/snippets.code-snippets'), },
  -- snippets = gens,
  snippets = { gen_loader.from_runtime("*") },
  mappings = {
    expand = '<a-;>',
    jump_next = '<a-;>',
    jump_prev = '<a-,>',
  }
})

require('mini.diff').setup({
  view = {
    style = 'sign',
    signs = {
      add = '│',
      change = '│',
      delete = '│'
    }
  },
  mappings = {
    textobject = 'gH',
  },
  options = {
    wrap_goto = true
  }
})
