"" set leader key
" let g:mapleader = ";"
let g:mapleader = "\<Space>"

"" Better nav for omnicomplete
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

"" Replace all
nnoremap <C-s> :%s//g<Left><Left>

"" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l

"" Use alt + hjkl to resize windows
nnoremap <silent> <M-down>  :resize -2<CR>
nnoremap <silent> <M-up>    :resize +2<CR>
nnoremap <silent> <M-left>  :vertical resize -2<CR>
nnoremap <silent> <M-right> :vertical resize +2<CR>
tnoremap <silent> <M-down>  <C-\><C-n>:resize -2<CR>
tnoremap <silent> <M-up>    <C-\><C-n>:resize +2<CR>
tnoremap <silent> <M-left>  <C-\><C-n>:vertical resize -2<CR>
tnoremap <silent> <M-right> <C-\><C-n>:vertical resize +2<CR>

" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

"" Better tabbing
vnoremap < <gv
vnoremap > >gv


if exists('g:vscode')
  " TAB for next/previous in VSCode
  nmap <Tab> :Tabnext<CR>
  nmap <S-Tab> :Tabprev<CR>
else
  "" TAB for next/previous buffer neovim
  nnoremap <silent> <Tab> :bnext<CR>
  nnoremap <silent> <S-Tab> :bprevious<CR>
  nnoremap <A-q> :bdelete<CR>
endif


"" Escape altenative
inoremap jk <Esc>
inoremap kj <Esc>

"" Quick jump
nnoremap J 10j
nnoremap K 10k
nnoremap H 10h
nnoremap L 10l

"" Quick forward yank
nnoremap Y yg_

"" Easy CAPS
"inoremap <c-u> <ESC>viwUi
"nnoremap <c-u> viwU<Esc>

"===== start leader keymapping ====="

"" Same as oS/OS
" nnoremap <Leader>o o<Esc>^Da
" nnoremap <Leader>O O<Esc>^Da

" Alternate way to quit
nnoremap <C-q> :q<CR>
nnoremap <S-q> :q<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>; :q<CR>

"" Alternate way to write
nnoremap <C-w> :w<CR>
nnoremap <S-w> :w<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>' :w<CR>

"" HoriZontal split
" nnoremap <leader>z :split | resize 20 | term <CR>
" nnoremap <leader>x :sp<bar>term<cr>:resize 20<cr>
" nnoremap <leader>z :split +te <CR>
nnoremap <silent><leader>z :split<bar>resize 20<bar>term zsh<cr>
tnoremap <silent><leader>z <C-\><C-n>:split<bar>resize 20<bar>term zsh<cr>

"" Vertical split
" nnoremap <leader>x :vsplit | resize 20 | term <CR>
" nnoremap <leader>z :vs<bar>term<cr><c-w>J:vertical resize80<cr>
" nnoremap <leader>z :vs<bar>term<cr>:vertical resize 80<cr>
" nnoremap <leader>x :vs +te <CR>
nnoremap <silent><leader>x :vsplit<bar>vertical resize 80<bar>term zsh<cr>
tnoremap <silent><leader>x <C-\><C-n>:vsplit<bar>vertical resize 80<bar>term zsh<cr>

"" Copy to clipboard
nnoremap  <leader>y  "*yg_
nnoremap  <leader>Y  "*yy
vnoremap  <leader>y  "*y
vnoremap  <leader>Y  "*y

"" Paste from clipboar
nnoremap <leader>p "*p
nnoremap <leader>P "*P
vnoremap <leader>p "*p
vnoremap <leader>P "*P

"" File tree
" nnoremap <silent> <leader>t :lua require'tree'.open()<CR>
" nnoremap <silent> <leader>T :lua require'tree'.close()<CR>
" nnoremap <silent> <leader>t :lua require'tree'.toggle()<CR>
nnoremap <silent> <leader>t :NvimTreeToggle<CR>
nnoremap <silent> <leader>z :NvimTreeRefresh<CR>
nnoremap <silent> <leader>Z :NvimTreeFindFile<CR>

"" File explorer
" nnoremap <C-l> :!ranger<CR> "mapped to clear
" nnoremap <C-r> :!ranger<CR> "mapped to redo
" nnoremap <C-S-r> :!ranger<CR> "the same as just <C-r>
" nnoremap <leader>r :!ranger<CR> "open /dev/tty: no such device or address
nnoremap <silent> <leader>R :FloatermNew ranger<CR>
nnoremap <silent> <leader>r :FloatermNew lf<CR>

"" To run a float terminal
nnoremap <silent> <leader>f :FloatermToggle <CR>
tnoremap <silent> <leader>f <C-\><C-n>:FloatermNew <CR>

"" To toggle highlight search
nnoremap <silent> <leader>h :set hlsearch! <CR>

"" To run a vsplit/split terminal
nnoremap <silent> <leader>v :FloatermNew --wintype=vsplit --width=60 <CR>
nnoremap <silent> <leader>V :FloatermNew --wintype=split --height=20 <CR>
tnoremap <silent> <leader>v <C-\><C-n>:FloatermNew --wintype=vsplit <CR>

"" To run lazygit
nnoremap <silent> <leader>g :FloatermNew lazygit <CR>

"" To run shell/python %=file
nnoremap <leader>b :!bash %<CR>
nnoremap <leader>B :!python %<CR>

"" To compile/open file
nnoremap <leader>c :w! \| !compiler "<c-r>%"<CR>
nnoremap <leader>C :!opout <c-r>%<CR><CR>



