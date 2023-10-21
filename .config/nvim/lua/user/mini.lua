local status_ok, mini_ai = pcall(require, 'mini.ai')
if not status_ok then
  return
end

local spec_treesitter = mini_ai.gen_spec.treesitter

mini_ai.setup({

  -- Table with textobject id as fields, textobject specification as values.
  -- Also use this to disable builtin textobjects. See |MiniAi.config|.
  custom_textobjects = {

    -- a = mapped to args by mini.ai
    -- A = mapped to WholeBuffer by mini.ai(custom_textobjects)
    -- b = alias to )]} by mini.ai
    -- B = alias to ]} by nvim
    -- c = mapped to word-column by textobj-word-column
    -- C = mapped to Word-Column by textobj-word-column
    -- D = mapped to doubleSquareBrackets by nvim-various-textobjs
    -- f = mapped to function.call by mini.ai
    -- i = mapped to indentation by mini.indent
    -- I = mapped to Indentation by mini.indent
    -- k = mapped to key by nvim-various-textobjs
    -- K = mapped to container by textsubjects
    -- l = mapped to last by mini.ai
    -- m = mapped to last-insert by keymaps.lua
    -- n = mapped to number by nvim-various-textobjs
    -- N = mapped to next by mini.ai
    -- p = mapped to paragraph by nvim
    -- q = alias to '"` by mini.ai
    -- r = mapped to whitespace by mini.ai
    -- R = mapped to Return by mini.ai
    -- s = mapped to sentence by nvim
    -- S = mapped to Subword by nvim-various-textobjs
    -- t = mapped to tag by mini.ai
    -- u = mapped to uotes by mini.ai(custom_textobjects)
    -- U = mapped to url by nvim-various-textobjs
    -- v = mapped to value by nvim-various-textobjs
    -- w = mapped to word by nvim
    -- W = mapped to Word by nvim
    -- x = mapped to hexadecimal by mini.ai
    -- y = mapped to Indent by vim-textobj-indent
    -- Y = mapped to Indent-same  by vim-textobj-indent
    -- z = mapped to fold by keymaps.lua
    -- Z = mapped to closefold by nvim-various-textobjs

    q = spec_treesitter({ a = '@call.outer', i = '@call.inner', }),
    Q = spec_treesitter({ a = '@class.outer', i = '@class.inner', }),
    g = spec_treesitter({ a = '@comment.outer', i = '@comment.inner', }),
    G = spec_treesitter({ a = '@conditional.outer', i = '@conditional.inner', }),
    B = spec_treesitter({ a = '@block.outer', i = '@block.inner', }),
    F = spec_treesitter({ a = '@function.outer', i = '@function.inner', }),
    L = spec_treesitter({ a = '@loop.outer', i = '@loop.inner', }),
    P = spec_treesitter({ a = '@parameter.outer', i = '@parameter.inner', }),
    R = spec_treesitter({ a = '@return.outer', i = '@return.inner', }),
    ["="] = spec_treesitter({ a = '@assignment.rhs', i = '@assignment.lhs', }),
    ["+"] = spec_treesitter({ a = '@assignment.outer', i = '@assignment.inner', }),
    ["*"] = spec_treesitter({ a = '@number.outer', i = '@number.inner', }),

    -- Tweak argument textobject:
    a = require('mini.ai').gen_spec.argument({ brackets = { '%b()' } }), -- brackets = { '%b()', '%b[]', '%b{}' },

    -- Disable brackets alias in favor of builtin block textobject:
    -- b = false,
    -- b = { { '%b()', '%b[]', '%b{}' }, '^.().*().$' },

    -- key-value textobj :help mini.ai (line 300)
    -- the pattern .- matches any sequence of characters (except newline characters) (including whitespaces)
    k = { { '\n.-[=:]', '^.-[=:]' }, '^%s*()().-()%s-()=?[!=<>\\+-\\*]?[=:]' }, -- .- -> don't be greedy let %s- to exist
    v = { { '[=:]()%s*().-%s*()[;,]()', '[=:]=?()%s*().*()().$' } }, -- Pattern in double curly bracket equals fallback

    -- quotes/uotes:
    u = { { "%b''", '%b""', '%b``' }, '^.().*().$' }, -- Pattern in single curly bracket equals filter the double-bracket/left-side

    -- number/hexadecimalcolor textobj:
    -- the pattern %f[%d]%d+ ensures there is a %d before start matching (non %d before %d+)(useful to stop .*)
    n = { '[-+]?()%f[%d]%d+()%.?%d*' }, -- %f[%d] to make jumping to next group of number instead of next digit
    x = { '#()%x%x%x%x%x%x()' },

    -- _whitespace_textobj:
    r = { '%S()%s+()%S' },

    -- Now `vax` should select `xxx` and `vix` - middle `x`:
    -- x = { 'x()x()x' },

    -- Whole buffer:
    A = function()
      local from = { line = 1, col = 1 }
      local to = {
        line = vim.fn.line('$'),
        col = math.max(vim.fn.getline('$'):len(), 1)
      }
      return { from = from, to = to }
    end,

    -- -- indent delimited by blanklines textobj:
    -- i = function()
    --   local start_indent = vim.fn.indent(vim.fn.line('.'))
    --   if string.match(vim.fn.getline('.'), '^%s*$') then return { from = nil, to = nil } end
    --
    --   local prev_line = vim.fn.line('.') - 1
    --   while vim.fn.indent(prev_line) >= start_indent do
    --       vim.cmd('-')
    --       prev_line = vim.fn.line('.') - 1
    --   end
    --
    --   from = { line = vim.fn.line('.'), col = 1 }
    --
    --   local next_line = vim.fn.line('.') + 1
    --   while vim.fn.indent(next_line) >= start_indent do
    --       vim.cmd('+')
    --       next_line = vim.fn.line('.') + 1
    --   end
    --
    --   to = { line = vim.fn.line('.'), col = vim.fn.getline(vim.fn.line('.')):len() }
    --   return { from = from, to = to }
    --
    -- end
  },

  user_textobject_id = true,
  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    -- Main textobject prefixes
    around = 'a',
    inside = 'i',

    -- Next/last variants
    around_next = 'aN',
    inside_next = 'iN',
    around_last = 'al',
    inside_last = 'il',

    -- Move cursor to corresponding edge of `a` textobject
    goto_left = 'g[',
    goto_right = 'g]',
  },

  -- Number of lines within which textobject is searched
  n_lines = 50,

  -- How to search for object (first inside current line, then inside
  -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
  -- 'cover_or_nearest', 'next', 'previous', 'nearest'.
  search_method = 'cover_or_next',

})

require('mini.align').setup({

  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    start = 'ga',
    start_with_preview = 'gA',
  },

  -- -- Modifiers changing alignment steps and/or options
  -- modifiers = {
  --   -- Main option modifiers
  --   ['s'] = --<function: enter split pattern>,
  --   ['j'] = --<function: choose justify side>,
  --   ['m'] = --<function: enter merge delimiter>,
  --
  --   -- Modifiers adding pre-steps
  --   ['f'] = --<function: filter parts by entering Lua expression>,
  --   ['i'] = --<function: ignore some split matches>,
  --   ['p'] = --<function: pair parts>,
  --   ['t'] = --<function: trim parts>,
  --
  --   -- Delete some last pre-step
  --   ['<BS>'] = --<function: delete some last pre-step>,
  --
  --   -- Special configurations for common splits
  --   ['='] = --<function: enhanced setup for '='>,
  --   [','] = --<function: enhanced setup for ','>,
  --   [' '] = --<function: enhanced setup for ' '>,
  -- },

  -- Default options controlling alignment process
  options = {
    split_pattern = '',
    justify_side = 'left',
    merge_delimiter = '',
  },

  -- Default steps performing alignment (if `nil`, default is used)
  steps = {
    pre_split = {},
    split = nil,
    pre_justify = {},
    justify = nil,
    pre_merge = {},
    merge = nil,
  },

})

require('mini.bracketed').setup({
  -- First-level elements are tables describing behavior of a target:
  --
  -- - <suffix> - single character suffix. Used after `[` / `]` in mappings.
  --   For example, with `b` creates `[B`, `[b`, `]b`, `]B` mappings.
  --   Supply empty string `''` to not create mappings.
  --
  -- - <options> - table overriding target options.
  --
  -- See `:h MiniBracketed.config` for more info.

  buffer     = { suffix = 'b', options = {} },
  comment    = { suffix = 'c', options = {} },
  conflict   = { suffix = 'x', options = {} },
  diagnostic = { suffix = 'd', options = {} },
  file       = { suffix = 'f', options = {} },
  indent     = { suffix = 'n', options = {} },
  jump       = { suffix = 'j', options = {} },
  location   = { suffix = 'l', options = {} },
  oldfile    = { suffix = 'o', options = {} },
  quickfix   = { suffix = 'q', options = {} },
  treesitter = { suffix = 't', options = {} },
  undo       = { suffix = 'u', options = {} },
  window     = { suffix = 'w', options = {} },
  yank       = { suffix = 'y', options = {} },
})

require('mini.comment').setup({

  -- Options which control module behavior
  options = {
    -- Function to compute custom 'commentstring' (optional)
    custom_commentstring = nil,

    -- Whether to ignore blank lines
    ignore_blank_line = false,

    -- Whether to recognize as comment only lines without indent
    start_of_line = false,

    -- Whether to ensure single space pad for comment parts
    pad_comment_parts = true,
  },

  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    -- Toggle comment (like `gcip` - comment inner paragraph) for both
    -- Normal and Visual modes
    comment = 'gc',

    -- Toggle comment on current line
    comment_line = 'gcc',

    -- Define 'comment' textobject (like `dgc` - delete whole comment block)
    -- Define 'comment' textobject (like `dgc` - delete whole comment block)
    textobject = 'gc', -- mapped as `gk` in keymaps.lua
  },
  -- Hook functions to be executed at certain stage of commenting
  hooks = {
    -- Before successful commenting. Does nothing by default.
    pre = function() require('ts_context_commentstring.internal').update_commentstring() end,
    -- After successful commenting. Does nothing by default.
    post = function() end,
  },

})

require('mini.indentscope').setup({

  draw = {
    -- Delay (in ms) between event and start of drawing scope indicator
    delay = 100,

    -- Animation rule for scope's first drawing. A function which, given
    -- next and total step numbers, returns wait time (in ms). See
    -- |MiniIndentscope.gen_animation| for builtin options. To disable
    -- animation, use `require('mini.indentscope').gen_animation.none()`.
    animation = nil --<function: implements constant 20ms between steps>,
  },

  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    -- Textobjects
    object_scope = '',
    object_scope_with_border = '',

    -- Motions (jump to respective border line; if not present - body line)
    -- _repressing-incremental works inside visual mode
    goto_top = '[ii',
    goto_bottom = ']ii',
  },

  -- Options which control scope computation
  options = {
    -- Type of scope's border: which line(s) with smaller indent to
    -- categorize as border. Can be one of: 'both', 'top', 'bottom', 'none'.
    border = 'both',

    -- Whether to use cursor column when computing reference indent.
    -- Useful to see incremental scopes with horizontal cursor movements.
    indent_at_cursor = false,

    -- Whether to first check input line to be a border of adjacent scope.
    -- Use it if you want to place cursor on function header to get scope of
    -- its body.
    try_as_border = false,
  },

  -- Which character to use for drawing scope indicator
  symbol = '',

})

require('mini.splitjoin').setup({
  -- Module mappings. Use `''` (empty string) to disable one.
  -- Created for both Normal and Visual modes.
  mappings = {
    toggle = 'gS',
    split = '',
    join = '',
  },

  -- Detection options: where split/join should be done
  detect = {
    -- Array of Lua patterns to detect region with arguments.
    -- Default: { '%b()', '%b[]', '%b{}' }
    brackets = nil,

    -- String Lua pattern defining argument separator
    separator = ',',

    -- Array of Lua patterns for sub-regions to exclude separators from.
    -- Enables correct detection in presence of nested brackets and quotes.
    -- Default: { '%b()', '%b[]', '%b{}', '%b""', "%b''" }
    exclude_regions = nil,
  },

  -- Split options
  split = {
    hooks_pre = {},
    hooks_post = {},
  },

  -- Join options
  join = {
    hooks_pre = {},
    hooks_post = {},
  },
})

require('mini.surround').setup({
  -- Add custom surroundings to be used on top of builtin ones. For more
  -- information with examples, see `:h MiniSurround.config`.
  custom_surroundings = nil,

  -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
  highlight_duration = 500,

  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    add = 'ys', -- Add surrounding in Normal and Visual modes
    delete = 'ds', -- Delete surrounding
    find = 'zf', -- Find surrounding (to the right)
    find_left = 'zF', -- Find surrounding (to the left)
    highlight = 'zh', -- Highlight surrounding
    replace = 'cs', -- Replace surrounding
    update_n_lines = 'zn', -- Update `n_lines`

    suffix_last = 'l', -- Suffix to search with "prev" method
    suffix_next = 'N', -- Suffix to search with "next" method
  },

  -- Number of lines within which surrounding is searched
  n_lines = 20,

  -- How to search for surrounding (first inside current line, then inside
  -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
  -- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
  -- see `:h MiniSurround.config`.
  search_method = 'cover',
})

require('mini.map').setup({
  -- Highlight integrations (none by default)
  integrations = {
    require('mini.map').gen_integration.builtin_search(),
    require('mini.map').gen_integration.diagnostic(),
    require('mini.map').gen_integration.gitsigns(),
  },

  -- Symbols used to display data
  symbols = {
    -- Encode symbols. See `:h MiniMap.config` for specification and
    -- `:h MiniMap.gen_encode_symbols` for pre-built ones.
    -- Default: solid blocks with 3x2 resolution.
    encode = nil,

    -- Scrollbar parts for view and line. Use empty string to disable any.
    scroll_line = '█',
    scroll_view = '┃',
  },

  -- Window options
  window = {
    -- Whether window is focusable in normal way (with `wincmd` or mouse)
    focusable = true,

    -- Side to stick ('left' or 'right')
    side = 'right',

    -- Whether to show count of multiple integration highlights
    show_integration_count = false,

    -- Total width
    width = 10,

    -- Value of 'winblend' option
    winblend = 25,
  },
})

-- require('mini.pairs').setup({
--   -- In which modes mappings from this `config` should be created
--   modes = { insert = true, command = false, terminal = false },
--
--   -- Global mappings. Each right hand side should be a pair information, a
--   -- table with at least these fields (see more in |MiniPairs.map|):
--   -- - <action> - one of "open", "close", "closeopen".
--   -- - <pair> - two character string for pair to be used.
--   -- By default pair is not inserted after `\`, quotes are not recognized by
--   -- `<CR>`, `'` does not insert pair after a letter.
--   -- Only parts of tables can be tweaked (others will use these defaults).
--   mappings = {
--     ['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\].' },
--     ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\].' },
--     ['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\].' },
--
--     [')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].' },
--     [']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].' },
--     ['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },
--
--     ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^\\].', register = { cr = false } },
--     ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '[^%a\\].', register = { cr = false } },
--     ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^\\].', register = { cr = false } },
--   },
-- })
