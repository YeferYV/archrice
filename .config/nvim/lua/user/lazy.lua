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
  defaults = { lazy = true }, -- { lazy = true, pin = true }
  performance = {
    rtp = {
      disabled_plugins = { "tohtml", "gzip", "zipPlugin", "netrwPlugin", "tarPlugin" },
    },
  },
  -- lockfile = vim.fn.stdpath("config") .. "/lazy-update.json",
}

local plugins = {

  -- Automation
  {
    "windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter
    commit = "0fd6519d44eac3a6736aafdb3fe9da916c3701d4",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
      -- require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())

      local ts_utils = require("nvim-treesitter.ts_utils")
      require("cmp").event:on("confirm_done", function(evt)
        local name = ts_utils.get_node_at_cursor()
        if name ~= nil then
          if name:type() ~= "named_imports" then
            require("nvim-autopairs.completion.cmp").on_confirm_done()(evt)
          end
        end
      end)
    end,
  },
  {
    "windwp/nvim-ts-autotag", -- To autoclose and autorename tags
    commit = "7a1c677985b8fc4cdfdb87dd55fbc16dadd86bbe",
    event = "InsertEnter",
    config = true
  },

  -- Bufferline/ScopeBuffer
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    commit = "b15c6daf5a64426c69732b31a951f4e438cb6590",
    dependencies = { { "tiagovla/scope.nvim", commit = "2db6d31de8e3a98d2b41c0f0d1f5dc299ee76875", config = true } },
    config = function() require("user.bufferline") end
  },

  -- cmp-plugins
  {
    "hrsh7th/nvim-cmp", -- The completion plugin
    commit = "777450fd0ae289463a14481673e26246b5e38bf2",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      { "hrsh7th/cmp-buffer",           commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa" }, -- buffer completions
      { "hrsh7th/cmp-path",             commit = "91ff86cd9c29299a64f968ebb45846c485725f23" }, -- path completions
      { "hrsh7th/cmp-cmdline",          commit = "8fcc934a52af96120fe26358985c10c035984b53" }, -- cmdline completions
      { "saadparwaiz1/cmp_luasnip",     commit = "18095520391186d634a0045dacaa346291096566" }, -- snippet completions
      { "hrsh7th/cmp-nvim-lsp",         commit = "0e6b2ed705ddcff9738ec4ea838141654f12eeef" }, -- lsp completions
      { "L3MON4D3/LuaSnip",             commit = "bc8ec05022743d3f08bda7a76c6bb5e9a9024581" }, --snippet engine
      { "rafamadriz/friendly-snippets", commit = "8d91ba2dc2421a54981115f61b914974f938fa77" }, -- a bunch of snippets to use
      {
        "roobert/tailwindcss-colorizer-cmp.nvim",
        commit = "bc25c56083939f274edcfe395c6ff7de23b67c50",
        config = function()
          -- require("cmp").config.formatting = { format = require("tailwindcss-colorizer-cmp").formatter }     -- from doc but not working
          -- require("cmp").setup({ formatting = { format = require("tailwindcss-colorizer-cmp").formatter } }) -- from issue #5 but not working
          require("tailwindcss-colorizer-cmp").setup({ color_square_width = 1 })
        end,
      },
    },
    config = function() require("user.cmp") end
  },
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   commit = "1fdc742af68f4725a22c05c132f971143be447fc",
  --   event = { "InsertEnter" },
  --   config = function() require "lsp_signature".on_attach({ hint_enable = false }) end
  -- },

  -- DAP
  {
    "rcarriga/nvim-dap-ui",
    commit = "56a2df0e96bfa64ebd6967e7cad877a1530633d5",
    dependencies = { { "mfussenegger/nvim-dap", commit = "debd7c2f80eaf20c5f5df25db8d8c1b9b18f4421" } },
    -- config = function() require("user.dap") end
  },

  -- File-Explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    commit = "230ff118613fa07138ba579b89d13ec2201530b9",
    cmd = "Neotree",
    dependencies = {
      { "MunifTanjim/nui.nvim",          commit = "1f43b13d133eb4b4f53a4485379d9afa58808389" },
      { "mrjones2014/smart-splits.nvim", commit = "d0111ef84fc82c9a31f4b000ff99190eaf18e790" },
    },
    config = function() require("user.neo-tree") end
  },

  -- Intellisense
  -- { "github/copilot.vim" },
  {
    "Exafunction/codeium.vim",
    commit = "1efe2a2cdf516094bdb211aa8a1d45ef01836207",
    event = "InsertEnter"
  },

  -- LSP
  { "neovim/nvim-lspconfig",             commit = "e683951a35ade60f9e1768ef770bb42ffcc1d2b7" }, -- enable LSP
  { "nvimtools/none-ls.nvim",            commit = "ef09f14eab78ca6ce3bee1ddc73db5511f5cd953" }, -- for formatters and linters
  { "b0o/SchemaStore.nvim",              commit = "a592fbe98959d13014b022ec1b1418498309019c" }, -- jsonls schema completions
  { "RRethy/vim-illuminate",             commit = "a2907275a6899c570d16e95b9db5fd921c167502" },
  { "williamboman/mason.nvim",           commit = "2311d9d883eb709ad9979a726a38c5ce1343b63c", config = true },
  { "williamboman/mason-lspconfig.nvim", commit = "a8d5db8f227b9b236d1c54a9c6234bc033825ce7", config = true },
  { "jay-babu/mason-null-ls.nvim",       commit = "a991e7697514f30126fac7c07a11c488c553e94f" }, -- autoconfigured formatters
  { "jay-babu/mason-nvim-dap.nvim",      commit = "aa7f489903460f2c2e15a6a874c8b933722fe109" }, -- autoconfigured debuggers
  {
    "glepnir/lspsaga.nvim",
    commit = "199eb00822f65b811f43736ba65ab7e16501125d",
    event = "LspAttach",
    config = function() require("user.lspsaga") end
  },

  -- Motions
  { "mg979/vim-visual-multi",            commit = "aec289a9fdabaa0ee6087d044d75b32e12084344", event = "VeryLazy" },
  {
    "folke/flash.nvim",
    commit = "48817af25f51c0590653bbc290866e4890fe1cbe",
    event = "VeryLazy",
    opts = {},
  },

  -- Status-Line
  { "nvim-lualine/lualine.nvim",         commit = "c28a7427c3fb29322db136f0564ec58807b26747" },
  { "nvim-tree/nvim-web-devicons",       commit = "f16ec8f6e5d23e4349501dae46e0a661918e086e" },
  { "Allianaab2m/nvim-material-icon-v3", commit = "89a89f7fa20330b21c93f4446bf99c20e7cea8d8" },

  -- Text-Objects
  -- { "godlygeek/tabular"},
  -- { 'nvim-treesitter/playground'},
  -- { "paraduxos/vim-indent-object", branch = "new_branch", event = "VeryLazy" }, -- incremental-repressing + respects-blanklines + vimrepeat + VisualRepeatable(e.g mini.comment is noVisualRepeable)
  { "echasnovski/mini.nvim",             commit = "e8a413b1a29f05bb556a804ebee990eb54479586" },
  {
    "coderifous/textobj-word-column.vim", -- delimited by comments or indentation
    commit = "cb40e1459817a7fa23741ff6df05e4481bde5a33",
    event = "VeryLazy",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    commit = "5a713474e38a3999b85c6cb3f5cac3248a16c7d0",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects", commit = "95933e762e28f9d38b572d65e7e4da9d2f4d90cb" },
      -- { "RRethy/nvim-treesitter-textsubjects",         commit = "b913508f503527ff540f7fe2dcf1bf1d1f259887" },
    }
  },
  {
    "chrisgrieser/nvim-various-textobjs",
    commit = "c0aa3ff33eaf9e7bc827ea918f92ac47d6037118",
    config = { useDefaultKeymaps = false, lookForwardSmall = 30, lookForwardBig = 30 },
  },

  -- TUI
  { "akinsho/toggleterm.nvim",             commit = "b86982429325112d2b20c6d0cc7a5c4b182ab705" },
  {
    "nvim-telescope/telescope.nvim",
    commit = "942fe5faef47b21241e970551eba407bc10d9547",
    dependencies = {
      { "nvim-lua/plenary.nvim",                      commit = "253d34830709d690f013daf2853a9d21ad7accab" },
      { "nvim-telescope/telescope-fzf-native.nvim",   commit = "580b6c48651cabb63455e97d7e131ed557b8c7e2", build = "make" },
      { "nvim-telescope/telescope-file-browser.nvim", commit = "e0fcb12702ad0d2873544a31730f9aaef04fd032" },
      { "AckslD/nvim-neoclip.lua",                    commit = "5b9286a40ea2020352280caeb713515badb03d99", config = true },
    },
    config = function() require("user.telescope") end
  },

  -- UI
  -- { "metakirby5/codi.vim" },
  { "lukas-reineke/indent-blankline.nvim", commit = "018bd04d80c9a73d399c1061fa0c3b14a7614399" },
  { "ahmedkhalf/project.nvim",             commit = "8c6bad7d22eef1b71144b401c9f74ed01526a4fb" },
  {
    "folke/which-key.nvim",
    commit = "4433e5ec9a507e5097571ed55c02ea9658fb268a",
    dependencies = {
      -- { "mrjones2014/legendary.nvim" },
      { "machakann/vim-columnmove", commit = "21a43d809a03ff9bf9946d983d17b3a316bf7a64" },
    },
  },
  {
    "stevearc/aerial.nvim",
    commit = "3a3baf0930444c78d19964fdb401bd3a6a23270f",
    event = "LspAttach",
    config = function() require("user.aerial") end
  },
  {
    "goolord/alpha-nvim",
    commit = "dafa11a6218c2296df044e00f88d9187222ba6b0",
    dependencies = {
      {
        "NvChad/nvim-colorizer.lua",
        commit = "dde3084106a70b9a79d48f426f6d6fec6fd203f7",
        config = function() require("user.colorizer") end
      },
      {
        'olivercederborg/poimandres.nvim'
      },
      {
        'folke/tokyonight.nvim'
      },
      -- {
      --   'sonjiku/yawnc.nvim'
      -- },
      -- {
      --   'oncomouse/lushwal.nvim',
      --   commit = "ff3598395270c7f64d4dff5b15845a531abc4bc7",
      --   cmd = { "LushwalCompile" },
      --   dependencies = {
      --     { "rktjmp/lush.nvim",       commit = "a8f0f7b9f837887f13a61d67b40ae26188fe4d62" },
      --     { "rktjmp/shipwright.nvim", commit = "ab70e80bb67b7ed3350bec89dd73473539893932" }
      --   },
      --   -- config = function() vim.g.lushwal_configuration = { compile_to_vimscript = false } end
      -- }
    }
  },

  -- { "HUAHUAI23/telescope-session.nvim", config = function() require("telescope").load_extension("xray23") end },
  -- { "nvim-telescope/telescope-ui-select.nvim", config = function() require("telescope").load_extension("ui-select") end },
  {
    "stevearc/dressing.nvim",
    commit = "91b9ba8a9474d2c4156dc2f3e858e07ae8faecf0",
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
    commit = "372d5cb485f2062ac74abc5b33054abac21d8b58",
    config = {
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
    "kevinhwang91/nvim-ufo",
    commit = "9e829d5cfa3de6a2ff561d86399772b0339ae49d",
    event = "VeryLazy",
    config = {
      provider_selector = function(bufnr, filetype, buftype)
        return { "treesitter", "indent" }
      end
    },
    dependencies = {
      { "kevinhwang91/promise-async", commit = "7fa127fa80e7d4d447e0e2c78e99af4355f4247b" },
      {
        "luukvbaal/statuscol.nvim",
        commit = "87c7b2f4c4366f83725499f2dea58f169a5d7700",
        config = function()
          local builtin = require("statuscol.builtin")
          require("statuscol").setup(
            {
              relculright = false,
              segments = {
                { text = { builtin.foldfunc },      click = "v:lua.ScFa" },
                { text = { "%s" },                  click = "v:lua.ScSa" },
                { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" }
              }
            }
          )
        end
      }
    }
  },
  -- {
  --   "rcarriga/nvim-notify",
  --   commit = "e4a2022f4fec2d5ebc79afa612f96d8b11c627b3",
  --   event = "VeryLazy",
  --   config = function()
  --     require("notify").setup({ stages = "fade" })
  --     require("telescope").load_extension("notify")
  --     vim.notify = require("notify")
  --   end
  -- },
  {
    "folke/noice.nvim",
    commit = "92433164e2f7118d4122c7674c3834d9511722ba",
    event = "VeryLazy",
    opts = {
      messages = { view_search = false },
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,   -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        lsp_doc_border = true,  -- add a border to hover docs and signature help
      },
    }
  },

}

lazy.setup(plugins, opts)
