local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup {
  -- ensure_installed can be "all" or a list of languages { "python", "javascript" }
  ensure_installed = { "python", "bash", "javascript", "json", "html", "css", "c", "lua" },

  autopairs = {
    enable = true,
  },
  highlight = {    -- enable highlighting for all file types
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
    keymaps = {    -- mappings for incremental selection (visual mappings)
      -- init_selection = "gnn",         -- maps in normal mode to init the node/scope selection
      -- node_incremental = "grn",       -- increment to the upper named parent
      -- scope_incremental = "grc",      -- increment to the upper scope (as defined in locals.scm)
      -- node_decremental = "grm",       -- decrement to the previous node
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-]>',
      node_decremental = '<c-[>', -- showkey -a <c-backspace> outputs ^H
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
    --     -- ["aX"] = "@statement.outer",  -- not supported in c/go/javascript/lua/python/rust
    --     -- ["iX"] = "@scopename.inner",  -- not supported in      javascript/lua
    --     ['a='] = '@assignment.lhs',
    --     ['i='] = '@assignment.rhs',
    --     ['a+'] = '@assignment.outer',
    --     ['i+'] = '@assignment.inner',
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
        ['[aR'] = '@return.outer',
        ['[a='] = '@assignment.outer',
        ['[a+'] = '@assignment.lhs',
        ["[aX"] = { query = "@scope", query_group = "locals", desc = "Prev scope" },
        ["[["] = { query = "@fold", query_group = "folds", desc = "Previous Start Fold" },

        ['[iq'] = '@call.inner',
        ['[iQ'] = '@class.inner',
        ['[ig'] = '@comment.inner',
        ['[iG'] = '@conditional.inner',
        ['[iB'] = '@block.inner',
        ['[iF'] = '@function.inner',
        ['[iL'] = '@loop.inner',
        ['[iP'] = '@parameter.inner',
        ['[iR'] = '@return.inner',
        ['[i='] = '@assignment.inner',
        ['[i+'] = '@assignment.rhs',
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
        [']aR'] = '@return.outer',
        [']a='] = '@assignment.outer',
        [']a+'] = '@assignment.lhs',
        ["]aX"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
        ["]]"] = { query = "@fold", query_group = "folds", desc = "Next Start Fold" },

        [']iq'] = '@call.inner',
        [']iQ'] = '@class.inner',
        [']ig'] = '@comment.inner',
        [']iG'] = '@conditional.inner',
        [']iB'] = '@block.inner',
        [']iF'] = '@function.inner',
        [']iL'] = '@loop.inner',
        [']iP'] = '@parameter.inner',
        [']iR'] = '@return.inner',
        [']i='] = '@assignment.inner',
        [']i+'] = '@assignment.rhs',
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
        ['[eaR'] = '@return.outer',
        ['[ea='] = '@assignment.outer',
        ['[ea+'] = '@assignment.lhs',
        ["[eX"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
        ["[e["] = { query = "@fold", query_group = "folds", desc = "Previous End Fold" },

        ['[eiq'] = '@call.inner',
        ['[eiQ'] = '@class.inner',
        ['[eig'] = '@comment.inner',
        ['[eiG'] = '@conditional.inner',
        ['[eiB'] = '@block.inner',
        ['[eiF'] = '@function.inner',
        ['[eiL'] = '@loop.inner',
        ['[eiP'] = '@parameter.inner',
        ['[eiR'] = '@return.inner',
        ['[ei='] = '@assignment.inner',
        ['[ei+'] = '@assignment.rhs',
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
        [']eaR'] = '@return.outer',
        [']ea='] = '@assignment.outer',
        [']ea+'] = '@assignment.lhs',
        ["]eX"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
        ["]e]"] = { query = "@fold", query_group = "folds", desc = "Next End Fold" },

        [']eiq'] = '@call.inner',
        [']eiQ'] = '@class.inner',
        [']eig'] = '@comment.inner',
        [']eiG'] = '@conditional.inner',
        [']eiB'] = '@block.inner',
        [']eiF'] = '@function.inner',
        [']eiL'] = '@loop.inner',
        [']eiP'] = '@parameter.inner',
        [']eiR'] = '@return.inner',
        [']ei='] = '@assignment.inner',
        [']ei+'] = '@assignment.rhs',
      },
    },
    -- selection_modes = {
    --   ['@parameter.outer'] = 'v', -- charwise
    --   ['@function.outer'] = 'V', -- linewise
    --   ['@class.outer'] = '<c-v>', -- blockwise
    -- },
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
    prev_selection = 'Q',           -- (Optional) keymap to select the previous selection
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
