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

  -- Automation
  -- {
  --   "xiyaowong/fast-cursor-move.nvim",
  --   commit = "9ab80d0184861be18833647e983086725b9905f9",
  --   event = "BufReadPre"
  -- },
  {
    "windwp/nvim-ts-autotag", -- To autoclose and autorename tags
    commit = "dc5e1687ab76ee02e0f11c5ce137f530b36e98b3",
    event = "BufReadPre",
    opts = {}
  },

  -- Completion
  -- {
  --   "Exafunction/codeium.vim", -- run `:Codeium Auth` then `:Codeium Enable` see: https://github.com/Exafunction/codeium.vim/issues/376
  --   version = "v1.12.0",
  --   event = "InsertEnter",
  --   config = function() vim.g.codeium_log_file = "~/.codeium/codeium.log" end,
  --   keys = {
  --     {
  --       "<A-j>",
  --       function()
  --         return vim.fn["codeium#CycleCompletions"](1)
  --       end,
  --       expr = true,
  --       silent = true,
  --       mode = "i"
  --     },
  --     {
  --       "<A-k>",
  --       function()
  --         return vim.fn["codeium#CycleCompletions"](-1)
  --       end,
  --       expr = true,
  --       silent = true,
  --       mode = "i"
  --     },
  --     {
  --       "<A-l>",
  --       function()
  --         return vim.fn["codeium#Accept"]()
  --       end,
  --       expr = true,
  --       silent = true,
  --       mode = "i"
  --     },
  --   },
  -- },
  {
    "supermaven-inc/supermaven-nvim",
    event = "InsertEnter",
    opts = {
      keymaps = {
        accept_suggestion = "<A-l>",
        clear_suggestion = "<A-k>",
        accept_word = "<A-j>",
      }
    }
  },
  -- {
  --   "hrsh7th/nvim-cmp", -- completion engine
  --   commit = "29fb4854573355792df9e156cb779f0d31308796",
  --   event = { "InsertEnter", "CmdlineEnter" },
  --   dependencies = {
  --     { "hrsh7th/cmp-buffer",   commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa" }, -- buffer completions
  --     { "hrsh7th/cmp-path",     commit = "91ff86cd9c29299a64f968ebb45846c485725f23" }, -- path completions
  --     { "hrsh7th/cmp-cmdline",  commit = "d250c63aa13ead745e3a40f61fdd3470efde3923" }, -- cmdline completions
  --     { "hrsh7th/cmp-nvim-lsp", commit = "39e2eda76828d88b773cc27a3f61d2ad782c922d" }, -- lsp completions
  --     -- { "saadparwaiz1/cmp_luasnip",     commit = "05a9ab28b53f71d1aece421ef32fee2cb857a843" }, -- snippet source
  --     -- { "L3MON4D3/LuaSnip",             tag = "v2.0.0" },                                      --snippet engine
  --     -- {
  --     --   "roobert/tailwindcss-colorizer-cmp.nvim",
  --     --   commit = "3d3cd95e4a4135c250faf83dd5ed61b8e5502b86",
  --     --   config = function()
  --     --     require("tailwindcss-colorizer-cmp").setup({ color_square_width = 3 })
  --     --   end,
  --     -- },
  --   },
  --   config = function() require("user.cmp") end
  -- },

  -- Snippets
  {
    "L3MON4D3/LuaSnip", --snippet engine
    tag = "v2.0.0",
    event = { "InsertEnter" },
    dependencies = {
      { "rafamadriz/friendly-snippets", commit = "00ebcaa159e817150bd83bfe2d51fa3b3377d5c4" }, -- a bunch of snippets to use
    },
    config = function() require("luasnip.loaders.from_vscode").lazy_load() end
  },

  -- {
  --   "garymjr/nvim-snippets",
  --   commit = "56b4052f71220144689caaa2e5b66222ba5661eb",
  --   event = { "InsertEnter", "CmdlineEnter" },
  --   dependencies = {
  --     { "rafamadriz/friendly-snippets", commit = "00ebcaa159e817150bd83bfe2d51fa3b3377d5c4" }, -- a bunch of snippets to use
  --   },
  --   opts = { friendly_snippets = true, },
  --   keys = {
  --     {
  --       "<Tab>",
  --       function()
  --         if vim.snippet.active({ direction = 1 }) then
  --           vim.schedule(function()
  --             vim.snippet.jump(1)
  --           end)
  --           return
  --         end
  --         return "<Tab>"
  --       end,
  --       expr = true,
  --       silent = true,
  --       mode = "i",
  --     },
  --     {
  --       "<Tab>",
  --       function()
  --         vim.schedule(function()
  --           vim.snippet.jump(1)
  --         end)
  --       end,
  --       expr = true,
  --       silent = true,
  --       mode = "s",
  --     },
  --     {
  --       "<S-Tab>",
  --       function()
  --         if vim.snippet.active({ direction = -1 }) then
  --           vim.schedule(function()
  --             vim.snippet.jump(-1)
  --           end)
  --           return
  --         end
  --         return "<S-Tab>"
  --       end,
  --       expr = true,
  --       silent = true,
  --       mode = { "i", "s" },
  --     },
  --   },
  -- },

  -- LSP
  {
    "williamboman/mason.nvim", -- LSP/linter/formatter binary installer
    commit = "e2f7f9044ec30067bc11800a9e266664b88cda22",
    dependencies = {
      { "neovim/nvim-lspconfig",             commit = "6c505d4220b521f3b0e7b645f6ce45fa914d0eed" }, -- default configurations for LSP
      { "nvimtools/none-ls.nvim",            commit = "96ec99437a80a9aae1634d0a20151529a67a0977" }, -- default configurations formatters and linters
      { "williamboman/mason-lspconfig.nvim", commit = "62360f061d45177dda8afc1b0fd1327328540301" }, -- compatibility between mason and nvim-lspconfig
      { "jay-babu/mason-null-ls.nvim",       commit = "de19726de7260c68d94691afb057fa73d3cc53e7" }, -- compatibility between mason and none-ls
      { "nvim-lua/plenary.nvim",             commit = "a3e3bc82a3f95c5ed0d7201546d5d2c19b20d683" }, -- lua modules required by none-ls
      -- { "b0o/SchemaStore.nvim",              commit = "218a9887085b81b3eb0ee8f1e2d20c4a7fd7b1c9" }, -- jsonls schema completions
    },
  },

  -- Motions
  -- { "mg979/vim-visual-multi",   commit = "38b0e8d94a5499ccc17d6159763d32c79f53417b", event = "VeryLazy" },
  -- { "machakann/vim-columnmove", commit = "21a43d809a03ff9bf9946d983d17b3a316bf7a64", event = "BufReadPre" },
  -- { "romgrk/columnMove.vim",    event = "BufReadPre" },
  -- { "vim-utils/vim-vertical-move", event = "BufReadPre" },
  -- { "coderifous/textobj-word-column.vim", event = "BufReadPre" },
  {
    "folke/flash.nvim",
    version = "v2.1.0",
    event = "VeryLazy",
    opts = { modes = { search = { enabled = true } } },
  },

  -- Text-Objects
  { "echasnovski/mini.nvim", commit = "c6eede272cfdb9b804e40dc43bb9bff53f38ed8a" },
  {
    "nvim-treesitter/nvim-treesitter",
    commit = "69170c93149ddb71a22bd954514806395c430c02",
    event = "VeryLazy",
    build = ":TSUpdate", -- treesitter works with specific versions of language parsers (required if upgrading treesitter)
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects", commit = "ad8f0a472148c3e0ae9851e26a722ee4e29b1595" },
    },
    config = function() require("user.treesitter") end
  },
  {
    "chrisgrieser/nvim-various-textobjs",
    commit = "52343c70e2487095cafd4a5000d0465a2b992b03",
    opts = { useDefaultKeymaps = false, lookForwardSmall = 30, lookForwardBig = 30 },
  },

  -- TUI
  {
    "nvim-telescope/telescope.nvim",
    version = "v0.1.8",
    cmd = "Telescope",
    opts = {
      -- defaults = {
      --   -- -- Telescope ignores `.gitignore` files when using `live_grep`, `grep_string` and `find_files`
      --   -- -- `:Telescope find_files hidden=true` searches `.git/` directory even if `file_ignore_patterns = { "!.git/"}` is configure
      --   file_ignore_patterns = { "node_modules", "!.git/", },
      --
      --   -- -- It's slow
      --   vimgrep_arguments = { "grep", "-b", "-I", "-n", "-R", "-E", "-i", "-s", },
      -- }
    }
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    tag = "3.26",
    cmd = "Neotree",
    dependencies = {
      { "MunifTanjim/nui.nvim", commit = "61574ce6e60c815b0a0c4b5655b8486ba58089a1" },
      -- {
      --   "3rd/image.nvim",
      --   commit = "61c76515cfc3cdac8123ece9e9761b20c3dc1315",
      --   opts = {
      --     backend = "kitty",
      --   },
      --   init = function()
      --     -- pacman -S luarocks imagemagick
      --     -- luarocks --local --lua-version=5.1 install magick
      --     package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua"
      --     package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua"
      --   end,
      -- },
    },
    config = function() require("user.neo-tree") end
  },

  -- UI
  -- { "metakirby5/codi.vim" },
  -- { 'folke/tokyonight.nvim' },
  -- { 'olivercederborg/poimandres.nvim' },
  {
    "lukas-reineke/indent-blankline.nvim",
    tag = "v2.20.0",
    event = "VeryLazy",
    -- main = "ibl",                          -- for version 3 (same as require("ibl"))
    opts = {
      -- indent = { char = "│" },             -- for version 3
      -- scope = { enabled = false },         -- for version 3 (it doesn't highlight the indent scope so use mini.indentscope instead)
      show_trailing_blankline_indent = false, -- not supported on version 3
      show_first_indent_level = false,        -- not supported on version 3
      show_current_context = true,            -- not supported on version 3
    }
  },
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   commit = "194ec600488f7c7229668d0e80bd197f3a2b84ff",
  --   event = "BufReadPre",
  --   opts = {
  --     user_default_options = {
  --       RRGGBBAA = true,     -- #RRGGBBAA hex codes
  --       css = true,          -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
  --       css_fn = true,       -- Enable all CSS *functions*: rgb_fn, hsl_fn
  --       tailwind = true,     -- Enable tailwind colors
  --       always_update = true -- for cmp_menu and cmp_docs (replaces tailwindcss-colorizer-cmp.nvim)
  --     },
  --   }
  -- },
  {
    "lewis6991/gitsigns.nvim",
    version = "0.9.0",
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
}

lazy.setup(plugins, opts)
