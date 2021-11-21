call plug#begin('~/.config/nvim/autoload/plugged')

    "" Themes
    " Plug 'flazz/vim-colorschemes'
    " Plug 'morhetz/gruvbox'
    " Plug 'joshdick/onedark.vim'
    Plug 'NLKNguyen/papercolor-theme'
    " Plug 'dylanaraps/wal.vim'
    Plug 'nvim-treesitter/playground'
    Plug 'nvim-treesitter/nvim-treesitter'
    Plug 'nvim-treesitter/nvim-treesitter-textobjects'
    Plug 'christianchiarulli/nvcode-color-schemes.vim'
    Plug 'LunarVim/Colorschemes'

    "" Sxhkd sixtax highlighting
    Plug 'kovetskiy/sxhkd-vim'

    "" Status line
    Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}

    "" Git plugins
    " Plug 'mhinz/vim-signify'

    "" Better tabline
    Plug 'romgrk/barbar.nvim'

    "" Colorizer
    Plug 'norcalli/nvim-colorizer.lua'

    "" File Explorer
    " Plug 'scrooloose/NERDTree'
    Plug 'kyazdani42/nvim-tree.lua'

    "" File Icons
    Plug 'kyazdani42/nvim-web-devicons'

    "" Vim Terminal
    Plug 'voldikss/vim-floaterm'

    "" Window swap
    Plug 'wesQ3/vim-windowswap'

    "" Intellisense
    " Plug 'tzachar/compe-tabnine', { 'do': './install.sh' }
    Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
    Plug 'github/copilot.vim'

    "" LSP
    Plug 'neovim/nvim-lspconfig'
    Plug 'tami5/lspsaga.nvim'
    Plug 'onsails/lspkind-nvim'
    Plug 'williamboman/nvim-lsp-installer'
    " Plug 'kabouzeid/nvim-lspinstall'
    " Plug 'hrsh7th/nvim-compe'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'

    " For vsnip users.
    " Plug 'hrsh7th/cmp-vsnip'
    " Plug 'hrsh7th/vim-vsnip'

    " For luasnip users.
    " Plug 'L3MON4D3/LuaSnip'
    " Plug 'saadparwaiz1/cmp_luasnip'

    " For ultisnips users.
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'quangnguyen30192/cmp-nvim-ultisnips'

    " For snippy users.
    " Plug 'dcampos/nvim-snippy'
    " Plug 'dcampos/cmp-snippy'

    "" Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'

    "" To comment block of codes
    Plug 'tpope/vim-commentary'

    "" Telescope
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'

call plug#end()
