" set leader key
let g:mapleader = "\<Space>"

" Better nav for omnicomplete
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

" toggle NerdTree
map <C-n> :NERDTreeToggle<CR>
map <leader>n :NERDTreeToggle<CR>

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" horizontal split
nnoremap <leader>h :split<CR>
" vertical split
nnoremap <leader>v :vsplit<CR>

" Use alt + hjkl to resize windows
nnoremap <M-j> :resize -2<CR>
nnoremap <M-k> :resize +2<CR>
nnoremap <M-h> :vertical resize -2<CR>
nnoremap <M-l> :vertical resize +2<CR>

" I hate escape more than anything else
inoremap jk <Esc>
inoremap kj <Esc>

" Quick jump
nnoremap J 10j
nnoremap K 10k
nnoremap H 10h
nnoremap L 10l

" Easy CAPS
"inoremap <c-u> <ESC>viwUi
"nnoremap <c-u> viwU<Esc>

" TAB in general mode will move to text buffer
nnoremap <TAB> :bnext<CR>
" SHIFT-TAB will go back
nnoremap <S-TAB> :bprevious<CR>


" Alternate way to quit
nnoremap <C-q> :q<CR>
" Alternate way to write
nnoremap <C-w> :w<CR>
" Replace all is aliased to S.
nnoremap <C-s> :%s//g<Left><Left>


" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Better tabbing
vnoremap < <gv
vnoremap > >gv


"===== start leader keymapping =====

" ????
" nnoremap <Leader>o o<Esc>^Da
" nnoremap <Leader>O O<Esc>^Da

" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

"""""" TODO:fix :!ranger  :!lf  '/dev/tty: no such device or address' """""""
" to run ranger <C-r> is mapped to undo & <C-S-i> is the same as just <C-i>
" nnoremap <C-S-i> :!ranger<CR>
nnoremap <leader>r :!ranger<CR>

" to run lf <C-l> is mapped to clear & <C-S-o> is the same as just <C-o>
" nnoremap <C-S-o> :!lf<CR>
nnoremap <leader>l :!lf<CR>

" python run %=file
nnoremap <leader>i :!python %<CR>

" " compile latex .tex
"creating a quick command -> :map <Space>l :!pdflatex %<cr>
nnoremap <leader>x :!pdflatex %<cr>

" Compile document, be it groff/LaTeX/markdown/etc.
map <leader>c :w! \| !compiler <c-r>%<CR>

" Open corresponding .pdf/.html or preview
map <leader>o :!opout <c-r>%<CR><CR>

" Save file as sudo on files that require root permission
cnoremap w!! w !sudo tee %

"" Fix meta-key that break out of insert mode
for i in range(65,90) + range(97,122)
  let c = nr2char(i)
  exec "map \e".c." <M-".c.">"
  exec "map! \e".c." <M-".c.">"
endfor
