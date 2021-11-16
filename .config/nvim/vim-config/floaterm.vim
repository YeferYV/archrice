let g:floaterm_keymap_toggle = '<F1>'
let g:floaterm_keymap_prev   = '<F2>'
let g:floaterm_keymap_next   = '<F3>'
let g:floaterm_keymap_new    = '<F4>'
" nnoremap   <silent>   <F1>    :FloatermNew<CR>
" tnoremap   <silent>   <F1>    <C-\><C-n>:FloatermNew<CR>
" nnoremap   <silent>   <F2>    :FloatermPrev<CR>
" tnoremap   <silent>   <F2>    <C-\><C-n>:FloatermPrev<CR>
" nnoremap   <silent>   <F3>    :FloatermNext<CR>
" tnoremap   <silent>   <F3>    <C-\><C-n>:FloatermNext<CR>
" nnoremap   <silent>   <F4>   :FloatermToggle<CR>
" tnoremap   <silent>   <F4>   <C-\><C-n>:FloatermToggle<CR>
tnoremap <F5> <C-\><C-n>

"" Floaterm env
let g:floaterm_gitcommit='floaterm'
let g:floaterm_opener='vsplit'
let g:floaterm_shell='zsh'
let g:floaterm_autoinsert=1
let g:floaterm_width=0.65
let g:floaterm_height=0.8
"let g:floaterm_title=0
let g:floaterm_title='$1|$2'
let g:floaterm_autoclose=1
"let g:floaterm_borderchars='─│─│┌┐┘└'
" let g:floaterm_borderchars='=#=#┌┐┘└'

"" Floaterm highlights
hi FloatermBorder guibg=black guifg=gray


"" Terminal mode keymapping
" noremap  <silent> <expr><F12>     &buftype =='terminal' ?
"                                   \ "\<C-\><C-n>:call util#toggleWindows('terminal')\<CR>" :
"                                   \ "\<Esc>:call util#toggleWindows('terminal')\<CR>i<C-u>"
" noremap! <silent> <F12>           <Esc>:call util#toggleWindows('terminal')<CR>i
" tnoremap <silent> <F12>           <C-\><C-n>:call util#toggleWindows('terminal')<CR>
" noremap <silent> <F12>            <Esc>:ToggleTerminal<CR>i
" tnoremap <silent> <F12>           <C-\><C-n>:ToggleTerminal<CR>

