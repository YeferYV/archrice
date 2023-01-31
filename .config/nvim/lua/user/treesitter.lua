require 'nvim-treesitter.configs'.setup {
  -- ensure_installed can be "all" or a list of languages { "python", "javascript" }
  ensure_installed = { "python", "bash", "javascript", "json", "html", "css", "c", "lua" },

  autopairs = {
    enable = true,
  },
  highlight = { -- enable highlighting for all file types
    enable = true, -- you can also use a table with list of langs here (e.g. { "python", "javascript" })
    use_languagetree = true,
    additional_vim_regex_highlighting = true,
  },
  indent = { enable = true, disable = { "python", "yaml" } },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  incremental_selection = {
    enable = true, -- you can also use a table with list of langs here (e.g. { "python", "javascript" })
    disable = { "yaml" },
    keymaps = { -- mappings for incremental selection (visual mappings)
      -- init_selection = "gnn",         -- maps in normal mode to init the node/scope selection
      -- node_incremental = "grn",       -- increment to the upper named parent
      -- scope_incremental = "grc",      -- increment to the upper scope (as defined in locals.scm)
      -- node_decremental = "grm",       -- decrement to the previous node
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-i>',
      node_decremental = '<c-h>', -- showkey -a <c-backspace> outputs ^H
    }
  },
  textobjects = {
    -- select = {
    --   enable = true,  -- you can also use a table with list of langs here (e.g. { "python", "javascript" })
    --   include_surrounding_whitespace = false,
    --   lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
    --   keymaps = {
    --     -- You can use the capture groups defined here:
    --     -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects/blob/master/queries/c/textobjects.scm
    --     -- ["aa"] = "@attribute.inner",  -- not supported in c/go/javascript/lua/python/rust
    --     -- ["ia"] = "@attribute.inner",  -- not supported in c/go/javascript/lua/python/rust
    --     ['aq'] = '@call.outer',
    --     ['iq'] = '@call.inner',
    --     ['aQ'] = '@class.outer',         -- not supported in lua
    --     ['iQ'] = '@class.inner',         -- not supported in lua
    --     ['ag'] = '@comment.inner',       -- not supported in javascript
    --     ['ig'] = '@comment.outer',       -- not supported in javascript
    --     ['aG'] = '@conditional.outer',   --     supported in bash
    --     ['iG'] = '@conditional.inner',   --     supported in bash
    --     ["aB"] = "@block.outer",
    --     ["iB"] = "@block.inner",         -- not supported in c
    --     -- ["af"] = "@frame.outer",      -- not supported in c/go/javascript/lua/python/rust
    --     -- ["if"] = "@frame.inner",      -- not supported in c/go/javascript/lua/python/rust
    --     ["aF"] = "@function.outer",      --     supported in bash
    --     ["iF"] = "@function.inner",      --     supported in bash
    --     ['aL'] = '@loop.outer',          --     supported in bash
    --     ['iL'] = '@loop.inner',          --     supported in bash
    --     ['aP'] = '@parameter.outer',
    --     ['iP'] = '@parameter.inner',
    --     -- ["aS"] = "@statement.outer",  -- not supported in c/go/javascript/lua/python/rust
    --     -- ["iS"] = "@scopename.inner",  -- not supported in      javascript/lua
    --   },
    --   -- selection_modes = {
    --   --   ['@parameter.outer'] = 'v', -- charwise
    --   --   ['@function.outer'] = 'V', -- linewise
    --   --   ['@class.outer'] = '<c-v>', -- blockwise
    --   -- },
    -- },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_previous_start = {
        ['[aq'] = '@call.outer',
        ['[aQ'] = '@class.outer',
        ['[ag'] = '@comment.outer',
        ['[aG'] = '@conditional.outer',
        ['[aB'] = '@block.outer',
        ['[aF'] = '@function.outer',
        ['[aL'] = '@loop.outer',
        ['[aP'] = '@parameter.outer',

        ['[iq'] = '@call.inner',
        ['[iQ'] = '@class.inner',
        ['[ig'] = '@comment.inner',
        ['[iG'] = '@conditional.inner',
        ['[iB'] = '@block.inner',
        ['[iF'] = '@function.inner',
        ['[iL'] = '@loop.inner',
        ['[iP'] = '@parameter.inner',
        ['[['] = '@parameter.inner',
      },
      goto_next_start = {
        [']aq'] = '@call.outer',
        [']aQ'] = '@class.outer',
        [']ag'] = '@comment.outer',
        [']aG'] = '@conditional.outer',
        [']aB'] = '@block.outer',
        [']aF'] = '@function.outer',
        [']aL'] = '@loop.outer',
        [']aP'] = '@parameter.outer',

        [']iq'] = '@call.inner',
        [']iQ'] = '@class.inner',
        [']ig'] = '@comment.inner',
        [']iG'] = '@conditional.inner',
        [']iB'] = '@block.inner',
        [']iF'] = '@function.inner',
        [']iL'] = '@loop.inner',
        [']iP'] = '@parameter.inner',
        [']]'] = '@parameter.inner',
      },
      goto_previous_end = {
        ['[eaq'] = '@call.outer',
        ['[eaQ'] = '@class.outer',
        ['[eag'] = '@comment.outer',
        ['[eaG'] = '@conditional.outer',
        ['[eaB'] = '@block.outer',
        ['[eaF'] = '@function.outer',
        ['[eaL'] = '@loop.outer',
        ['[eaP'] = '@parameter.outer',

        ['[eiq'] = '@call.inner',
        ['[eiQ'] = '@class.inner',
        ['[eig'] = '@comment.inner',
        ['[eiG'] = '@conditional.inner',
        ['[eiB'] = '@block.inner',
        ['[eiF'] = '@function.inner',
        ['[eiL'] = '@loop.inner',
        ['[eiP'] = '@parameter.inner',
      },
      goto_next_end = {
        [']eaq'] = '@call.outer',
        [']eaQ'] = '@class.outer',
        [']eag'] = '@comment.outer',
        [']eaG'] = '@conditional.outer',
        [']eaB'] = '@block.outer',
        [']eaF'] = '@function.outer',
        [']eaL'] = '@loop.outer',
        [']eaP'] = '@parameter.outer',

        [']eiq'] = '@call.inner',
        [']eiQ'] = '@class.inner',
        [']eig'] = '@comment.inner',
        [']eiG'] = '@conditional.inner',
        [']eiB'] = '@block.inner',
        [']eiF'] = '@function.inner',
        [']eiL'] = '@loop.inner',
        [']eiP'] = '@parameter.inner',
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
        ['<leader>lf'] = '@function.outer',
        ['<leader>lc'] = '@class.outer',
      },
    },
  },
  textsubjects = {
    enable = true,
    prev_selection = 'Q', -- (Optional) keymap to select the previous selection
    keymaps = {
      ['K'] = 'textsubjects-smart', -- useful for block of comments
      ['aK'] = 'textsubjects-container-outer',
      ['iK'] = 'textsubjects-container-inner',
    },
  },
}

-- vim.api.nvim_exec([[
--     setlocal foldmethod=expr
--     setlocal foldexpr=nvim_treesitter#foldexpr()
-- ]], true)
