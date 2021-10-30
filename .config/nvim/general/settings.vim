
syntax enable                           " Enables syntax highlighing
set hidden                              " Required to keep multiple buffers open multiple buffers
set nowrap                              " Display long lines as just one line
set encoding=utf-8                      " The encoding displayed
set pumheight=10                        " Makes popup menu smaller
set fileencoding=utf-8                  " The encoding written to file
set ruler			                          " Show the cursor position all the time
set cmdheight=2                         " More space for displaying messages
set iskeyword+=-	                      " treat dash separated words as a word text object"
set mouse=a                             " Enable your mouse
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set t_Co=256                            " Support 256 colors
set conceallevel=0                      " So that I can see `` in markdown files
set tabstop=2                           " Insert 2 spaces for a tab
set shiftwidth=2                        " Change the number of space characters inserted for indentation
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set expandtab                           " Converts tabs to spaces
set smartindent                         " Makes indenting smart
set autoindent                          " Good auto indent
set number                              " Line numbers
set numberwidth=5                       " Line numbers width
" set cursorline                        " Enable highlighting of the current line
set background=dark                     " tell vim what the background color looks like
set showtabline=1                       " 0: never 1: only if there are at least two tab pages
" set showtabline=2                     " 2: Always show tabs
" set laststatus=0                      " Always display the status line
set laststatus=2                        " if is equal to 0 Always display the status line
set noshowmode                          " We don't need to see things like -- INSERT -- anymore
set nobackup                            " This is recommended by coc
set nowritebackup                       " This is recommended by coc
set updatetime=300                      " Faster completion
set timeoutlen=500                      " By default timeoutlen is 1000 ms
set formatoptions-=cro                  " Stop newline continution of comments
set clipboard=unnamedplus               " Copy paste between vim and everything else
set autochdir                           " Your working directory will always be the same as your working directory
set sidescroll=5                        " The minimal number of columns to scroll horizontally
set scrolloff=4                         " Minimal number of screen lines to keep above and below the cursor
set ignorecase		                      " Do case insensitive matching
set smartcase		                        " Do smart case matching
" set completeopt=menu,menuone,noselect   " required by nvim-cmp
set completeopt=menu,noselect   " required by nvim-cmp

" whitespaces
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
highlight ExtraWhitespace ctermbg=cyan guibg=cyan
autocmd InsertLeave * redraw!
match ExtraWhitespace /\s\+$\| \+\ze\t/
autocmd BufWritePre * :%s/\s\+$//e

" auto source when writing to init.vm alternatively you can run :source $MYVIMRC
au! BufWritePost $MYVIMRC source %

"jump to the last position when reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" You can't stop me (save file as sudo)
cmap w!! w !sudo tee %

" to autoformat eslint(javascript) on save
" autocmd BufWritePre <buffer> <cmd>EslintFixAll<CR>

" Save file as sudo on files that require root permission
" cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" disable nvimtree status
" au BufEnter,BufWinEnter,WinEnter,CmdwinEnter * if bufname('%') == "NvimTree" | set laststatus=0 | else | set laststatus=2 | endif

" enable terminal insert by default
au WinEnter * if &buftype == 'terminal' | startinsert | endif

" toggle status line
let s:hidden_all = 0
function! ToggleHiddenAll()
    if s:hidden_all  == 0
        let s:hidden_all = 1
        set noruler
        set laststatus=0
        set noshowcmd
        " set nonumber
    else
        let s:hidden_all = 0
        set ruler
        set laststatus=2
        set showcmd
        " set number
    endif
endfunction
nnoremap <silent> <F9> :call ToggleHiddenAll()<CR>

autocmd TermOpen * setlocal noruler laststatus=0 noshowcmd nonumber | startinsert
autocmd TermEnter * setlocal noruler laststatus=0 noshowcmd nonumber | startinsert
" autocmd TermLeave * set ruler laststatus=2 showcmd number
" autocmd TermClose * set ruler laststatus=2 showcmd number
" autocmd TermClose * close
" autocmd TermOpen * call feedkeys("i")
" autocmd TermOpen * startinsert
autocmd TermClose * quit


