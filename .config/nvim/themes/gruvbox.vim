" " onedark.vim override: Don't set a background color when running in a terminal;
" if (has("autocmd") && !has("gui_running"))
"   augroup colorset
"     autocmd!
"     let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
"     " autocmd ColorScheme * call gruvbox#set_highlight("Normal", { "fg": s:white }) " `bg` will not be styled since there is no `bg` setting
"     autocmd ColorScheme * call gruvbox#hls_hide()
"   augroup END
" endif

" hi Comment cterm=italic
let g:gruvbox_transparent_bg=0
let g:gruvbox_cursor_column='orange'
let g:gruvbox_selection_bg='write'
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_termcolors=256

syntax on
colorscheme gruvbox

highlight Normal     ctermbg=NONE guibg=NONE
highlight LineNr     ctermbg=NONE guibg=NONE
highlight SignColumn ctermbg=NONE guibg=NONE

" " checks if your terminal has 24-bit color support
if (has("termguicolors"))
    set termguicolors
    hi LineNr ctermbg=NONE guibg=NONE
endif
