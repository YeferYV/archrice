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
    Plug 'williamboman/nvim-lsp-installer'
    " Plug 'kabouzeid/nvim-lspinstall'
    " Plug 'hrsh7th/nvim-compe'
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'

    " For vsnip users.
    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/vim-vsnip'

    " autocompletion (main one)
    " Plug 'ms-jpq/coq_nvim', {'branch': 'dev'}
    " 9000+ Snippets
    " Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
    " lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
    " Need to **configure separately**
    " Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}

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

    "" intellisense
    Plug 'github/copilot.vim'
    Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
    " Plug 'tzachar/compe-tabnine', { 'do': './install.sh' }

call plug#end()
