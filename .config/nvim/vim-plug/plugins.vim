call plug#begin('~/.config/nvim/autoload/plugged')

    "" Themes
    "Plug 'rafi/awesome-vim-colorschemes'
    "Plug 'flazz/vim-colorschemes'
    "Plug 'joshdick/onedark.vim'
    "Plug 'morhetz/gruvbox'
    "Plug 'dylanaraps/wal.vim'
    Plug 'christianchiarulli/nvcode-color-schemes.vim'
    Plug 'nvim-treesitter/nvim-treesitter'
    Plug 'nvim-treesitter/playground'
    Plug 'LunarVim/Colorschemes'

    "" Status line
    " Plug 'vim-airline/vim-airline'
    " Plug 'vim-airline/vim-airline-themes'
    Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}

    "" Better tabline
    Plug 'romgrk/barbar.nvim'

    "" Colorizer
    Plug 'norcalli/nvim-colorizer.lua'

    "" File Explorer
    "Plug 'scrooloose/NERDTree'
    Plug 'kyazdani42/nvim-tree.lua'

    "" File icons
    Plug 'kyazdani42/nvim-web-devicons'

    "" vim terminal
    Plug 'voldikss/vim-floaterm'

    "" LSP
    Plug 'neovim/nvim-lspconfig'
    Plug 'kabouzeid/nvim-lspinstall'
    Plug 'hrsh7th/nvim-compe'
    Plug 'hrsh7th/vim-vsnip'

    "" Better Syntax Support
    "Plug 'sheerun/vim-polyglot'

    "" Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'

    "" To comment block of codes
    Plug 'tpope/vim-commentary'

    "" sxhkd sixtax highlighting
    Plug 'kovetskiy/sxhkd-vim'

    "" FZF ripgrep ctags the_silver_search fd
    " Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    " Plug 'junegunn/fzf.vim'
    " Plug 'yuki-ycino/fzf-preview.vim'

    " Have the file system follow you around
    "Plug 'airblade/vim-rooter'

    "" Telescope
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'

    "" Quickhightlighting
    " Plug 'unblevable/quick-scope'

call plug#end()
