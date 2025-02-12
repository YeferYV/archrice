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
    version = "v0.15.0",
  },
  {
    "folke/flash.nvim",
    version = "v2.1.0",
    event = "VeryLazy",
    opts = { modes = { search = { enabled = true } } },
  },
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   version = "v0.9.3",
  --   event = "VeryLazy",
  --   build = ":TSUpdate", -- treesitter works with specific versions of language parsers (required if upgrading treesitter)
  --   dependencies = {
  --     { "nvim-treesitter/nvim-treesitter-textobjects", commit = "ad8f0a472148c3e0ae9851e26a722ee4e29b1595" },
  --   },
  --   config = function()
  --     require("nvim-treesitter.configs").setup({
  --       indent = { enable = true },    -- https://www.reddit.com/r/neovim/comments/14n6iiy/if_you_have_treesitter_make_sure_to_disable_smartindent
  --       highlight = { enable = true }, -- https://github.com/nvim-treesitter/nvim-treesitter/issues/5264
  --     })
  --   end
  -- },

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
      -- ignore_filetypes = { "NvimTree", "prompt", "snacks_input", "snacks_picker_input" }
    }
  },
  {
    "williamboman/mason.nvim", -- LSP/linter/formatter binary installer
    version = "v1.10.0",
    lazy = false,
    cond = not vim.g.vscode,
    opts = { ui = { border = "rounded" } },
  },

  -- UI
  -- { "metakirby5/codi.vim" },
  -- { "sphamba/smear-cursor.nvim", lazy = false, opts = {} },
  {
    "folke/snacks.nvim",
    -- version = "v2.21.0",
    commit = "f3cdd02620bd5075e453be7451a260dbbee68cab",
    lazy = false,
    cond = not vim.g.vscode,
    opts = {
      explorer = { replace_netrw = true },
      image = {},
      indent = {},
      input = {},
      picker = {
        -- previewers = { git = { native = true } },
        sources = {
          -- files = { hidden = true, ignored = true },
          -- grep = { hidden = true, ignored = true },
          explorer = { hidden = true },
        },
      },
      -- statuscolumn = {              -- fold open-sign not showing when using typescript-language-server
      --   left = { "fold", "git" },   -- priority of signs on the left (high to low)
      --   right = { "mark", "sign" }, -- priority of signs on the right (high to low)
      --   folds = { open = true, git_hl = true },
      -- },
      styles = {
        input = {
          title_pos = "left",
          relative = "cursor",
          row = 1,
          col = -1,
          width = 30,
        },
      },
    }
  },
}

lazy.setup(plugins, opts)
