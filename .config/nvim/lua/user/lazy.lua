local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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
  defaults = { lazy = true },
  performance = {
    rtp = {
      disabled_plugins = { "tohtml", "gzip", "zipPlugin", "netrwPlugin", "tarPlugin" },
    },
  },
}

local plugins = {

  -- Automation
  { 'tpope/vim-commentary', event = "VeryLazy" },
  -- {
  --   "numToStr/Comment.nvim",
  --   commit = "5f01c1a89adafc52bf34e3bf690f80d9d726715d",
  --   config = true
  -- },
  { "JoosepAlviste/nvim-ts-context-commentstring", event = "InsertEnter" },
  {
    "windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
      require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
    end,
  },
  {
    "windwp/nvim-ts-autotag", -- To autoclose and autorename tags
    event = "InsertEnter",
    config = true
  },

  -- Bufferline/ScopeBuffer
  {
    "akinsho/bufferline.nvim",
    lazy = false,
    tag = "v2.7.0", -- Icon bg color linked to selected buffer color #137
    dependencies = { { "tiagovla/scope.nvim", config = true } },
    config = function() require("user.bufferline") end
  },

  -- ColorSchemes
  { 'olivercederborg/poimandres.nvim' },
  { 'folke/tokyonight.nvim' },
  {
    "NvChad/nvim-colorizer.lua",
    config = function() require("user.colorizer") end
  },

  -- cmp-plugins
  {
    "hrsh7th/nvim-cmp", -- The completion plugin
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      { "hrsh7th/cmp-buffer" }, -- buffer completions
      { "hrsh7th/cmp-path" }, -- path completions
      { "hrsh7th/cmp-cmdline" }, -- cmdline completions
      { "saadparwaiz1/cmp_luasnip" }, -- snippet completions
      { "hrsh7th/cmp-nvim-lsp" }, -- lsp completions
      { "L3MON4D3/LuaSnip" }, --snippet engine
      { "rafamadriz/friendly-snippets" }, -- a bunch of snippets to use
    },
    config = function() require("user.cmp") end
  },

  -- DAP
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    -- config = function() require("user.dap") end
  },

  -- File-Explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    dependencies = {
      { "MunifTanjim/nui.nvim" },
      { "mrjones2014/smart-splits.nvim" },
    },
    config = function() require("user.neo-tree") end
  },

  -- Intellisense
  -- { "github/copilot.vim" },
  -- { "tzachar/cmp-tabnine", build = "./install.ps1" },
  { "Exafunction/codeium.vim", event = "InsertEnter" },
  {
    "tzachar/cmp-tabnine",
    build = "./install.sh",
    event = "InsertEnter",
    config = function() require("user.cmp-tabnine") end
  },

  -- LSP
  { "neovim/nvim-lspconfig" }, -- enable LSP
  { "jose-elias-alvarez/null-ls.nvim" }, -- for formatters and linters
  { "b0o/SchemaStore.nvim" }, -- jsonls schema completions
  { "RRethy/vim-illuminate" },
  { "williamboman/mason.nvim", config = true, },
  { "williamboman/mason-lspconfig.nvim", config = true },
  { "jay-babu/mason-null-ls.nvim" }, -- autoconfigured formatters
  { "jay-babu/mason-nvim-dap.nvim" }, -- autoconfigured debuggers
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    config = function() require("user.lspsaga") end
  },

  -- Motions
  { "tpope/vim-repeat", event = "VeryLazy" },
  { "machakann/vim-columnmove", event = "VeryLazy" },
  { "justinmk/vim-sneak", event = "VeryLazy" },
  { "phaazon/hop.nvim", event = "VeryLazy", config = true },

  -- Status-Line
  { "nvim-lualine/lualine.nvim" },
  { "nvim-tree/nvim-web-devicons" },
  { "DaikyXendo/nvim-material-icon" },

  -- Text-Objects
  -- { 'wellle/targets.vim'},
  -- { "godlygeek/tabular"},
  -- { 'nvim-treesitter/playground'},
  { "paraduxos/vim-indent-object", branch = "new_branch", event = "VeryLazy" },
  { "echasnovski/mini.nvim" },
  {
    "kana/vim-textobj-user",
    event = "VeryLazy",
    dependencies = { "saihoooooooo/vim-textobj-space" }
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects" },
      { "RRethy/nvim-treesitter-textsubjects" },
    }
  },
  { "coderifous/textobj-word-column.vim", event = "VeryLazy" },
  { "mg979/vim-visual-multi", event = "VeryLazy" },
  { "svermeulen/vim-easyclip", event = "VeryLazy" },
  {
    "chrisgrieser/nvim-various-textobjs",
    config = { useDefaultKeymaps = false, lookForwardLines = 30 },
  },
  -- _surround_code_blocks
  -- { 'tpope/vim-surround' },
  -- {
  --   "kylechui/nvim-surround",
  --   commit = "6cc6b54d3728a17e34bb5c9b9db05c7e5690813d",
  --   config = {
  --       keymaps = {
  --         insert          = '<C-g>z',
  --         insert_line     = '<C-g>Z',
  --         normal          = 'yz',
  --         normal_cur      = 'YZ',
  --         normal_line     = 'yzz',
  --         normal_cur_line = 'YZZ',
  --         visual          = 'z',
  --         visual_line     = 'Z',
  --         delete          = 'dz',
  --         change          = 'cz',
  --       }
  --   }
  -- },

  -- TUI
  { "akinsho/toggleterm.nvim" },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "nvim-telescope/telescope-file-browser.nvim" },
      { "AckslD/nvim-neoclip.lua", config = true },
    },
    config = function() require("user.telescope") end
  },

  -- UI
  -- { "metakirby5/codi.vim" },
  { "lukas-reineke/indent-blankline.nvim" },
  { "ahmedkhalf/project.nvim" },
  {
    "folke/which-key.nvim",
    dependencies = {
      { "mrjones2014/legendary.nvim" },
    },
  },
  {
    "stevearc/aerial.nvim",
    event = "LspAttach",
    config = function() require("user.aerial") end
  },
  { "goolord/alpha-nvim",
    dependencies = {
      {
        "Shatur/neovim-session-manager",
        config = { autoload_mode = "disabled" }
      },
    }
  },

  -- { "HUAHUAI23/telescope-session.nvim", config = function() require("telescope").load_extension("xray23") end },
  -- { "nvim-telescope/telescope-ui-select.nvim", config = function() require("telescope").load_extension("ui-select") end },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = function()
      require('dressing').setup {
        input = { win_options = { winblend = 0 } },
        select = { telescope = require('telescope.themes').get_dropdown { initial_mode = 'normal' } }
      }
    end
  },
  {
    "lewis6991/gitsigns.nvim",
    config = {
      signs = {
        add          = { text = "│" },
        change       = { text = "│" },
        delete       = { text = "│" },
        topdelete    = { text = "契" },
        changedelete = { text = "~" },
        untracked    = { text = '┆' },
      },
    }
  },
  {
    "kevinhwang91/nvim-ufo",
    event = "VeryLazy",
    config = {
      provider_selector = function(bufnr, filetype, buftype)
        return { "treesitter", "indent" }
      end
    },
    dependencies = {
      { "kevinhwang91/promise-async", },
      {
        "luukvbaal/statuscol.nvim",
        config = function()
          local builtin = require("statuscol.builtin")
          require("statuscol").setup(
            {
              relculright = false,
              segments = {
                { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
                { text = { "%s" }, click = "v:lua.ScSa" },
                { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" }
              }
            }
          )
        end
      }
    }
  },
  -- { "rcarriga/nvim-notify",
  --   commit = "bdd647f61a05c9b8a57c83b78341a0690e9c29d7",
  --   config = function()
  --     require("notify").setup({ stages = "fade" })
  --     require("telescope").load_extension("notify")
  --     vim.notify = require("notify")
  --   end
  -- },
  -- { "folke/noice.nvim",
  --   commit = "a83b5fb9e24ecb220fa1255a9b7957dcd7b22783",
  --   config = {
  --     messages = { view_search = false },
  --     presets = {
  --       bottom_search = true, -- use a classic bottom cmdline for search
  --       command_palette = true, -- position the cmdline and popupmenu together
  --       lsp_doc_border = true, -- add a border to hover docs and signature help
  --     },
  --   }
  -- },
}

lazy.setup(plugins, opts)
