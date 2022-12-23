require'nvim-treesitter.configs'.setup {
  -- ensure_installed can be "all" or a list of languages { "python", "javascript" }
  ensure_installed = {"python", "bash", "javascript", "html", "css", "c", "lua"},

  autopairs = {
    enable = true,
  },
  highlight = { -- enable highlighting for all file types
    enable = true, -- you can also use a table with list of langs here (e.g. { "python", "javascript" })
    use_languagetree = true,
    additional_vim_regex_highlighting = true,
  },
  indent = { enable = true, disable = { "yaml" } },
  context_commentstring = {
    enable = true,
    enable_autocmd = true,
  },
  incremental_selection = {
    enable = true,  -- you can also use a table with list of langs here (e.g. { "python", "javascript" })
    disable = { "yml" },
    keymaps = {                       -- mappings for incremental selection (visual mappings)
      -- init_selection = "gnn",         -- maps in normal mode to init the node/scope selection
      -- node_incremental = "grn",       -- increment to the upper named parent
      -- scope_incremental = "grc",      -- increment to the upper scope (as defined in locals.scm)
      -- node_decremental = "grm",       -- decrement to the previous node
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<c-h>', -- showkey -a <c-backspace> outputs ^H
    }
  },
  textobjects = {
    select = {
      enable = true,  -- you can also use a table with list of langs here (e.g. { "python", "javascript" })
      include_surrounding_whitespace = false,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined here:
        -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects/blob/master/queries/c/textobjects.scm
        -- ["aa"] = "@attribute.inner",  -- not supported in c/go/javascript/lua/python/rust
        -- ["ia"] = "@attribute.inner",  -- not supported in c/go/javascript/lua/python/rust
        ['ac'] = '@class.outer',         -- not supported in lua
        ['ic'] = '@class.inner',         -- not supported in lua
        ['aC'] = '@conditional.outer',   --     supported in bash
        ['iC'] = '@conditional.inner',   --     supported in bash
        ["ak"] = "@block.outer",
        ["ik"] = "@block.inner",         -- not supported in c
        ['aK'] = '@call.outer',
        ['iK'] = '@call.inner',
        -- ['aK'] = '@comment.outer',    -- not supported in c/go/javascript/lua/python/rust
        ["af"] = "@function.outer",      --     supported in bash
        ["if"] = "@function.inner",      --     supported in bash
        -- ["aF"] = "@frame.outer",      -- not supported in c/go/javascript/lua/python/rust
        -- ["iF"] = "@frame.inner",      -- not supported in c/go/javascript/lua/python/rust
        ['al'] = '@loop.outer',          --     supported in bash
        ['il'] = '@loop.inner',          --     supported in bash
        ['aP'] = '@parameter.outer',
        ['iP'] = '@parameter.inner',
        -- ["aS"] = "@statement.outer",  -- not supported in c/go/javascript/lua/python/rust
        -- ["iS"] = "@scopename.inner",  -- not supported in      javascript/lua
      },
      -- selection_modes = {
      --   ['@parameter.outer'] = 'v', -- charwise
      --   ['@function.outer'] = 'V', -- linewise
      --   ['@class.outer'] = '<c-v>', -- blockwise
      -- },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']ac'] = '@class.outer',
        [']aC'] = '@conditional.outer',
        ["]ak"] = "@block.outer",
        [']aK'] = '@call.outer',
        ["]af"] = "@function.outer",
        [']al'] = '@loop.outer',
        [']aP'] = '@parameter.outer',

        [']ic'] = '@class.inner',
        [']iC'] = '@conditional.inner',
        ["]ik"] = "@block.inner",
        [']iK'] = '@call.inner',
        ["]if"] = "@function.inner",
        [']il'] = '@loop.inner',
        [']iP'] = '@parameter.inner',
        [']]'] = '@parameter.inner',
      },
      goto_next_end = {
        [']eac'] = '@class.outer',
        [']eaC'] = '@conditional.outer',
        ["]eak"] = "@block.outer",
        [']eaK'] = '@call.outer',
        ["]eaf"] = "@function.outer",
        [']eal'] = '@loop.outer',
        [']eaP'] = '@parameter.outer',

        [']eic'] = '@class.inner',
        [']eiC'] = '@conditional.inner',
        ["]eik"] = "@block.inner",
        [']eiK'] = '@call.inner',
        ["]eif"] = "@function.inner",
        [']eil'] = '@loop.inner',
        [']eiP'] = '@parameter.inner',
      },
      goto_previous_start = {
        ['[ac'] = '@class.outer',
        ['[aC'] = '@conditional.outer',
        ["[ak"] = "@block.outer",
        ['[aK'] = '@call.outer',
        ["[af"] = "@function.outer",
        ['[al'] = '@loop.outer',
        ['[aP'] = '@parameter.outer',

        ['[ic'] = '@class.inner',
        ['[iC'] = '@conditional.inner',
        ["[ik"] = "@block.inner",
        ['[iK'] = '@call.inner',
        ["[if"] = "@function.inner",
        ['[il'] = '@loop.inner',
        ['[iP'] = '@parameter.inner',
        ['[['] = '@parameter.inner',
      },
      goto_previous_end = {
        ['[eac'] = '@class.outer',
        ['[eaC'] = '@conditional.outer',
        ["[eak"] = "@block.outer",
        ['[eaK'] = '@call.outer',
        ["[eaf"] = "@function.outer",
        ['[eal'] = '@loop.outer',
        ['[eaP'] = '@parameter.outer',

        ['[eic'] = '@class.inner',
        ['[eiC'] = '@conditional.inner',
        ["[eik"] = "@block.inner",
        ['[eiK'] = '@call.inner',
        ["[eif"] = "@function.inner",
        ['[eil'] = '@loop.inner',
        ['[eiP'] = '@parameter.inner',
      },
      },
    swap = {
      enable = true,
      swap_next = {
        ['>,'] = '@parameter.inner',
      },
      swap_previous = {
        ['<,'] = '@parameter.inner',
      },
    },
    lsp_interop = {
      enable = true,
      border = 'rounded', --'none', 'single', 'double', 'rounded', 'solid', 'shadow'.
      peek_definition_code = {
        ["<leader>lf"] = "@function.outer",
        ["<leader>lc"] = "@class.outer",
      },
    },
  },
}

-- vim.api.nvim_exec([[
--     setlocal foldmethod=expr
--     setlocal foldexpr=nvim_treesitter#foldexpr()
-- ]], true)
