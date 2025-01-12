local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  return
end

local opts = {
  ui = { border = "rounded" },
  defaults = { lazy = true }, -- { lazy = true, pin = true }
  performance = {
    rtp = {
      disabled_plugins = { "tohtml", "gzip", "zipPlugin", "netrwPlugin", "tarPlugin" },
    },
  },
  -- lockfile = vim.fn.stdpath("config") .. "/lazy-update.json",
  -- pkgs = { sources = { "lazy" } },
  -- rocks = { enabled = false }
}

local plugins = {

  -- Text Objects
  -- { "machakann/vim-columnmove", commit = "21a43d809a03ff9bf9946d983d17b3a316bf7a64", event = "BufReadPre" },
  -- { "romgrk/columnMove.vim",    event = "BufReadPre" },
  -- { "vim-utils/vim-vertical-move", event = "BufReadPre" },
  {
    "echasnovski/mini.nvim",
    commit = "3a3178419ce9947f55708966dabf030eca40735a",
  },
  {
    "folke/flash.nvim",
    version = "v2.1.0",
    event = "VeryLazy",
    opts = { modes = { search = { enabled = true } } },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    version = "v0.9.3",
    event = "VeryLazy",
    build = ":TSUpdate", -- treesitter works with specific versions of language parsers (required if upgrading treesitter)
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects", commit = "ad8f0a472148c3e0ae9851e26a722ee4e29b1595" },
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        indent = { enable = true },    -- https://www.reddit.com/r/neovim/comments/14n6iiy/if_you_have_treesitter_make_sure_to_disable_smartindent
        highlight = { enable = true }, -- https://github.com/nvim-treesitter/nvim-treesitter/issues/5264
      })
    end
  },

  -- Completion
  {
    "supermaven-inc/supermaven-nvim",
    commit = "07d20fce48a5629686aefb0a7cd4b25e33947d50",
    event = "InsertEnter",
    cond = not vim.g.vscode,
    opts = {
      keymaps = {
        accept_suggestion = "<A-l>",
        clear_suggestion = "<A-k>",
        accept_word = "<A-j>",
      }
    }
  },
  {
    "williamboman/mason.nvim", -- LSP/linter/formatter binary installer
    version = "v1.10.0",
    cond = not vim.g.vscode,
    dependencies = {
      { "neovim/nvim-lspconfig", version = "v1.0.0" }, -- default configurations for LSP
      -- { "williamboman/mason-lspconfig.nvim", version = "v1.31.0" },                                 -- compatibility between mason and nvim-lspconfig
      -- { "nvimtools/none-ls.nvim",            commit = "96ec99437a80a9aae1634d0a20151529a67a0977" }, -- default configurations formatters and linters
      -- { "jay-babu/mason-null-ls.nvim",       commit = "de19726de7260c68d94691afb057fa73d3cc53e7" }, -- compatibility between mason and none-ls
      -- { "b0o/SchemaStore.nvim",              commit = "218a9887085b81b3eb0ee8f1e2d20c4a7fd7b1c9" }, -- jsonls schema completions
      -- { "creativenull/efmls-configs-nvim",   version = "v1.9.0" },                                  -- preconfigured formatters and linterss for efm-language-server
    },
  },

  -- UI
  -- { "metakirby5/codi.vim" },
  -- { "sphamba/smear-cursor.nvim", lazy = false, opts = {} },
  {
    "folke/snacks.nvim",
    lazy = false,
    version = "v2.12.0",
    cond = not vim.g.vscode,
    opts = {
      -- scope = { enabled = true }
      indent = { enabled = true },
    }
  },
  {
    "lewis6991/gitsigns.nvim",
    version = "0.9.0",
    cond = not vim.g.vscode,
    opts = {
      signs = {
        add          = { text = "│" },
        change       = { text = "│" },
        delete       = { text = "│" },
        topdelete    = { text = "" },
        changedelete = { text = "~" },
        untracked    = { text = '┆' },
      },
    }
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    tag = "3.26",
    cond = not vim.g.vscode,
    cmd = "Neotree",
    dependencies = {
      { "MunifTanjim/nui.nvim",  commit = "61574ce6e60c815b0a0c4b5655b8486ba58089a1" },
      { "nvim-lua/plenary.nvim", commit = "a3e3bc82a3f95c5ed0d7201546d5d2c19b20d683" },
    },
    config = function() require("user.neo-tree") end
  },
  {
    "nvim-telescope/telescope.nvim",
    version = "v0.1.8",
    cond = not vim.g.vscode,
    cmd = "Telescope",
    opts = {
      -- defaults = {
      --   -- Telescope ignores `.gitignore` files when using `live_grep`, `grep_string` and `find_files`
      --   -- `:Telescope find_files hidden=true` searches `.git/` directory even if `file_ignore_patterns = { "!.git/"}` is configure
      --   file_ignore_patterns = { "node_modules", "!.git/", },
      -- }
    }
  },
}

lazy.setup(plugins, opts)
