" checks if your terminal has 24-bit color support
if (has("termguicolors"))
    set termguicolors
    hi LineNr ctermbg=NONE guibg=NONE
endif

syntax on
" colorscheme lunar

"transparent background
highlight Normal     ctermbg=NONE guibg=NONE
highlight LineNr     ctermbg=NONE guibg=NONE
highlight SignColumn ctermbg=NONE guibg=NONE
highlight EndOfBuffer guifg=#000000 ctermfg=NONE guibg=#000000 ctermbg=NONE gui=NONE cterm=NONE

"tab colors
" highlight BufferCurrent             guibg=None guifg=#ff0000
" highlight BufferCurrentIndex        guibg=None guifg=#ff0000
" highlight BufferCurrentMod          guibg=None guifg=#ff0000
" highlight BufferCurrentSign         guibg=None guifg=#ff0000
" highlight BufferCurrentTarget       guibg=#d7ff5f

" highlight BufferVisible             guibg=None guifg=None
" highlight BufferVisibleIndex        guibg=None guifg=None
" highlight BufferVisibleMod          guibg=None guifg=None
" highlight BufferVisibleSign         guibg=None guifg=None
" highlight BufferVisibleTarget       guibg=None guifg=None

" highlight BufferInactive            guibg=None guifg=#4C566A
" highlight BufferInactiveIndex       guibg=None guifg=None
" highlight BufferInactiveMod         guibg=None guifg=None
" highlight BufferInactiveSign        guibg=None guifg=None
" highlight BufferInactiveTarget      guibg=None guifg=None

" highlight BufferTabpages            guibg=None guifg=None
" highlight BufferTabpageFill         guibg=None guifg=None

" Menu colors
hi Pmenu guifg=NONE ctermfg=NONE guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi PmenuSel guifg=#d8dee9 ctermfg=238 guibg=#3b4048 ctermbg=238 gui=NONE cterm=NONE
hi PmenuSbar guifg=NONE ctermfg=NONE guibg=#3b4048 ctermbg=238 gui=NONE cterm=NONE
hi PmenuThumb guifg=NONE ctermfg=NONE guibg=#d8dee9 ctermbg=254 gui=NONE cterm=NONE
hi WildMenu guifg=#3b4252 ctermfg=238 guibg=#5e81ac ctermbg=67 gui=NONE cterm=NONE

" Comments/LineNr colors
" hi Comment guifg=#5f5f5f ctermfg=240 guibg=NONE ctermbg=NONE gui=italic cterm=italic
" hi SpecialComment guifg=#5f5f5f ctermfg=240 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
" hi TSComment guifg=#5f5f5f ctermfg=240 guibg=NONE ctermbg=NONE gui=italic cterm=italic
" hi LineNr guifg=#6a6e7e ctermfg=243 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
" hi CursorLine guifg=NONE ctermfg=NONE guibg=#2c323c ctermbg=236 gui=NONE cterm=NONE

" Search/visual colors
hi Search guifg=NONE ctermfg=NONE guibg=#282828 ctermbg=241 gui=NONE cterm=NONE
hi IncSearch guifg=NONE ctermfg=NONE guibg=#282828 ctermbg=241 gui=NONE cterm=NONE
hi Visual guifg=NONE ctermfg=NONE guibg=#282828 ctermbg=235 gui=NONE cterm=NONE

" Matching colors
hi MatchWord guifg=#ffff00 ctermfg=NONE guibg=NONE ctermbg=NONE gui=bold,underline cterm=bold,underline
hi MatchParen guifg=#ffff00 ctermfg=NONE guibg=NONE ctermbg=NONE gui=bold,underline cterm=bold,underline
hi MatchWordCur guifg=#ffff00 ctermfg=NONE guibg=NONE ctermbg=NONE gui=bold,underline cterm=bold,underline
hi MatchParenCur guifg=#ffff00 ctermfg=NONE guibg=NONE ctermbg=NONE gui=bold,underline cterm=bold,underline

" Hide split lines
hi vertsplit guifg=#333333 ctermfg=None guibg=#000000 ctermbg=None gui=none cterm=none
hi split guifg=#333333 ctermfg=None guibg=#000000 ctermbg=None gui=none cterm=none

" Statusline colors
hi StatusLine guifg=#d8dee9 ctermfg=254 guibg=#000000 ctermbg=236 gui=NONE cterm=NONE
hi StatusLineNC guifg=#5c6370 ctermfg=241 guibg=#000000 ctermbg=NONE gui=NONE cterm=NONE
hi StatusLineTerm guifg=#ff0000 ctermfg=NONE guibg=#ffff00 ctermbg=NONE gui=NONE cterm=NONE
hi StatusLineTermNC guifg=#ff0000 ctermfg=NONE guibg=#ffff00 ctermbg=NONE gui=NONE cterm=NONE
hi NvimTreeStatusLineNC guifg=#000000 ctermfg=NONE guibg=#000000 ctermbg=NONE gui=NONE cterm=NONE
hi NvimTreeStatusLine guifg=#000000 ctermfg=NONE guibg=#000000 ctermbg=NONE gui=NONE cterm=NONE
