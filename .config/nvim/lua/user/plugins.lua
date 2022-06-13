-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

-- Packer autocompile
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Auto pairs for '(' '[' '{'
  -- Use dependency and run lua function after load
  use {"windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter
    config = function() require('nvim-autopairs').setup() end
  }

  -- Better tabline
  use {'akinsho/bufferline.nvim', tag = "*", requires = 'kyazdani42/nvim-web-devicons'}

  -- Colors
  use 'norcalli/nvim-colorizer.lua'
  use 'lunarvim/colorschemes'
  -- use 'folke/tokyonight.nvim'

  -- Comment block of codes
  -- use {'tpope/vim-commentary'}
  use {"numToStr/Comment.nvim",
    requires = {"JoosepAlviste/nvim-ts-context-commentstring"},
    config = function() require('Comment').setup() end
  }

  -- cmp plugins
  use  {'hrsh7th/nvim-cmp'} -- The completion plugin
  -- use  {'hrsh7th/nvim-cmp',branch='border-window'} -- The completion plugin
  -- use  {'hrsh7th/nvim-cmp',commit='fae808a2bca079ea9454f33cb1e2db81c59e102b'} -- The completion plugin
  use  'hrsh7th/cmp-buffer' -- buffer completions
  use  'hrsh7th/cmp-path' -- path completions
  use  'hrsh7th/cmp-cmdline' -- cmdline completions
  use  'saadparwaiz1/cmp_luasnip' -- snippet completions
  use  'hrsh7th/cmp-nvim-lsp' -- lsp completions

  -- File Explorer
  use 'kyazdani42/nvim-tree.lua'

  -- For snippets completion
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- For ultisnips users
  -- Plugins can have dependencies on other plugins
  -- use {
  --   'SirVer/ultisnips',
  --   requires = {{'honza/vim-snippets'}, {'quangnguyen30192/cmp-nvim-ultisnips'}}
  -- }

  -- Intellisense
  -- Plugins can have post-install/update hooks
  -- use {'tzachar/cmp-tabnine', run = 'powershell ./install.ps1'}
  use {'tzachar/cmp-tabnine', run = './install.sh'}
  use {'github/copilot.vim', run = ':Copilot enable'}

  -- LSP
  use  'neovim/nvim-lspconfig' -- enable LSP
  use  'williamboman/nvim-lsp-installer' -- simple to use language server installer
  use  'tamago324/nlsp-settings.nvim' -- language server settings defined in json for
  use  'jose-elias-alvarez/null-ls.nvim' -- for formatters and linters
  use  'antoinemadec/FixCursorHold.nvim' -- This is needed to fix lsp doc highlight

  -- Status line
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- Surround block of codes
  -- Lazy loading:
  -- Load on specific commands
  -- use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}
  use {'tpope/vim-surround'}

  -- Sxhkd syntax highlighting
  -- Load on a combination of conditions: specific filetypes or commands
  use {
    'kovetskiy/sxhkd-vim',
    ft = {'sxhkd'},
  }

  -- Syntax hightlighting
  -- Post-install/update hook with neovim command
  use { 'nvim-treesitter/nvim-treesitter',
    requires = 'nvim-treesitter/nvim-treesitter-textobjects',
    run = ':TSUpdate',}


  -- Telescope
  use { 'nvim-telescope/telescope.nvim',
    requires = {{ 'nvim-lua/plenary.nvim'},{ 'nvim-lua/popup.nvim'}},
  }

  -- The interactive scratchpad (aka playground or quokka-alt)
  use  'metakirby5/codi.vim'

  -- Vim Jump to Match words
  -- Load on an autocommand event
  -- use {'andymass/vim-matchup', event = 'VimEnter'}

  -- Vim more Text Objects
  -- use {'wellle/targets.vim', event = 'VimEnter'}

  -- Vim Terminal
  -- use 'voldikss/vim-floaterm'
  use  'akinsho/toggleterm.nvim'

end)

