local ok, mini_ai = pcall(require, 'mini.ai')
if not ok then return end

local spec_treesitter = mini_ai.gen_spec.treesitter

require('mini.ai').setup({

  -- Table with textobject id as fields, textobject specification as values.
  -- Also use this to disable builtin textobjects. See |MiniAi.config|.
  custom_textobjects = {

    -- a = mapped to args by mini.ai
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
    -- n = mapped to next by mini.ai
    -- p = mapped to paragraph by nvim
    -- q = alias to '"` by mini.ai
    -- s = mapped to sentence by nvim
    -- S = mapped to Subword by nvim
    -- t = mapped to tag by mini.ai
    -- U = mapped to url by nvim-various-textobjs
    -- v = mapped to value by nvim-various-textobjs
    -- w = mapped to word by nvim
    -- W = mapped to Word by nvim

    q = spec_treesitter({
      a = '@call.outer',
      i = '@call.inner',
    }),
    Q = spec_treesitter({
      a = '@class.outer',
      i = '@class.inner',
    }),
    g = spec_treesitter({
      a = '@comment.outer',
      i = '@comment.inner',
    }),
    G = spec_treesitter({
      a = '@conditional.outer',
      i = '@conditional.inner',
    }),
    B = spec_treesitter({
      a = '@block.outer',
      i = '@block.inner',
    }),
    F = spec_treesitter({
      a = '@function.outer',
      i = '@function.inner',
    }),
    L = spec_treesitter({
      a = '@loop.outer',
      i = '@loop.inner',
    }),
    P = spec_treesitter({
      a = '@parameter.outer',
      i = '@parameter.inner',
    }),

    -- @atribute unsupported
    -- @frame unsupported
    -- @statement unsupported
    -- @scope unsupported
  },
  user_textobject_id = false,
  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    -- Main textobject prefixes
    around = 'a',
    inside = 'i',

    -- Next/last variants
    around_next = 'an',
    inside_next = 'in',
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
    object_scope = 'ii',
    object_scope_with_border = 'ai',

    -- Motions (jump to respective border line; if not present - body line)
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
    indent_at_cursor = true,

    -- Whether to first check input line to be a border of adjacent scope.
    -- Use it if you want to place cursor on function header to get scope of
    -- its body.
    try_as_border = false,
  },

  -- Which character to use for drawing scope indicator
  symbol = '',

})
