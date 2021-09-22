" configure treesitter
" lua << EOF
" require'nvim-treesitter.configs'.setup {
"   ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
"   highlight = {
"     enable = true,              -- false will disable the whole extension
"     disable = { "c", "rust" },  -- list of language that will be disabled
"   },
" }
" EOF

" configure nvcode-color-schemes
let g:nvcode_termcolors=256

syntax on
"colorscheme nvcode " Or whatever colorscheme you make
colorscheme lunar2
"colorscheme aurora

"transparent background
highlight Normal     ctermbg=NONE guibg=NONE
highlight LineNr     ctermbg=NONE guibg=NONE
highlight SignColumn ctermbg=NONE guibg=NONE

"hide split lines
highlight statusline   ctermfg=None ctermbg=None cterm=bold,underline
highlight statuslinenc ctermfg=None ctermbg=None cterm=underline
highlight vertsplit    ctermfg=None ctermbg=None cterm=NONE

"tab colors
set termguicolors
highlight BufferCurrent             guibg=None guifg=#ff0000
highlight BufferCurrentIndex        guibg=None guifg=#ff0000
highlight BufferCurrentMod          guibg=None guifg=#ff0000
highlight BufferCurrentSign         guibg=None guifg=#ff0000
highlight BufferCurrentTarget       guibg=#d7ff5f

highlight BufferVisible             guibg=None guifg=None
highlight BufferVisibleIndex        guibg=None guifg=None
highlight BufferVisibleMod          guibg=None guifg=None
highlight BufferVisibleSign         guibg=None guifg=None
highlight BufferVisibleTarget       guibg=None guifg=None

highlight BufferInactive            guibg=None guifg=#4C566A
highlight BufferInactiveIndex       guibg=None guifg=None
highlight BufferInactiveMod         guibg=None guifg=None
highlight BufferInactiveSign        guibg=None guifg=None
highlight BufferInactiveTarget      guibg=None guifg=None

highlight BufferTabpages            guibg=None guifg=None
highlight BufferTabpageFill         guibg=None guifg=None

" hide tab coded in autoload/plugged/barbar.nvim/plugin/buffeline.vim
" set showtabline=1 " 0: never 1: only if there are at least two tab pages

" checks if your terminal has 24-bit color support
if (has("termguicolors"))
    set termguicolors
    hi LineNr ctermbg=NONE guibg=NONE
endif

