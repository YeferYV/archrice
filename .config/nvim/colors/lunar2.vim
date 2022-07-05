" checks if your terminal has 24-bit color support
if (has("termguicolors"))
    set termguicolors
endif

syntax on

"-- transparent background
highlight Normal     ctermbg=NONE guibg=NONE
highlight LineNr     ctermbg=NONE guibg=NONE
highlight CursorLine cterm=none guibg=#111111
highlight SignColumn ctermbg=NONE guibg=NONE
highlight EndOfBuffer guifg=#000000 ctermfg=NONE guibg=#000000 ctermbg=NONE gui=NONE cterm=NONE

" "-- Cursor Color -- https://github.com/wez/wezterm/issues/1625
" " set guicursor=n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor2/lCursor2,r-cr:hor20,o:hor20
" " hi Cursor        term=bold  cterm=bold       guifg=#ff0000  guibg=#00c918
" " hi CursorLineNr  term=bold  cterm=underline  guifg=grey     guifg=Yellow
" " hi CursorLineNrF term=none  cterm=none       guifg=#5555ff  guibg=#0000ff
" " hi CurrentLineNr term=none  cterm=none       guifg=#5555ff  guibg=#0000ff
" hi CursorLineNr  term=none  cterm=none       guifg=#cccccc  guibg=none

"-- tab colors
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

"-- Menu colors
hi Pmenu guifg=NONE ctermfg=NONE guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi PmenuSel guifg=#d8dee9 ctermfg=238 guibg=#3b4048 ctermbg=238 gui=NONE cterm=NONE
hi PmenuSbar guifg=NONE ctermfg=NONE guibg=#3b4048 ctermbg=238 gui=NONE cterm=NONE
hi PmenuThumb guifg=NONE ctermfg=NONE guibg=#d8dee9 ctermbg=254 gui=NONE cterm=NONE
hi WildMenu guifg=#3b4252 ctermfg=238 guibg=#5e81ac ctermbg=67 gui=NONE cterm=NONE

"-- Search/visual colors
hi Search guifg=NONE ctermfg=NONE guibg=#282828 ctermbg=241 gui=NONE cterm=NONE
hi IncSearch guifg=NONE ctermfg=NONE guibg=#282828 ctermbg=241 gui=NONE cterm=NONE
hi Visual guifg=NONE ctermfg=NONE guibg=#282828 ctermbg=235 gui=NONE cterm=NONE

"-- Matching colors
hi MatchWord guifg=#ffff00 ctermfg=NONE guibg=NONE ctermbg=NONE gui=bold,underline cterm=bold,underline
hi MatchParen guifg=#ffff00 ctermfg=NONE guibg=NONE ctermbg=NONE gui=bold,underline cterm=bold,underline
hi MatchWordCur guifg=#ffff00 ctermfg=NONE guibg=NONE ctermbg=NONE gui=bold,underline cterm=bold,underline
hi MatchParenCur guifg=#ffff00 ctermfg=NONE guibg=NONE ctermbg=NONE gui=bold,underline cterm=bold,underline

"-- Hide split lines
hi vertsplit guifg=#333333 ctermfg=None guibg=#000000 ctermbg=None gui=none cterm=none
hi split guifg=#333333 ctermfg=None guibg=#000000 ctermbg=None gui=none cterm=none

"-- Statusline colors
hi StatusLine guifg=#ff0000 ctermfg=254 guibg=#000000 ctermbg=236 gui=NONE cterm=NONE
hi StatusLineNC guifg=#ff0000 ctermfg=241 guibg=#000000 ctermbg=NONE gui=NONE cterm=NONE
hi StatusLineTerm guifg=#ff0000 ctermfg=NONE guibg=#ffff00 ctermbg=NONE gui=NONE cterm=NONE
hi StatusLineTermNC guifg=#ff0000 ctermfg=NONE guibg=#ffff00 ctermbg=NONE gui=NONE cterm=NONE
hi NvimTreeStatusLine guifg=#000000 ctermfg=NONE guibg=#000000 ctermbg=NONE gui=NONE cterm=NONE
hi NvimTreeStatusLineNC guifg=#000000 ctermfg=NONE guibg=#000000 ctermbg=NONE gui=NONE cterm=NONE

"--  git
hi  GitSignsAdd            term=none          cterm=none          guifg=#005500      guibg=none
hi  GitSignsChange         term=none          cterm=none          guifg=#1c1cff      guibg=none
hi  GitSignsDelete         term=none          cterm=none          guifg=#880000      guibg=none

" "-- leet2
" hi  Normal               term=none          cterm=none          guifg=none         guibg=none
" hi  NonText              term=none          cterm=none          guifg=black        guibg=none
" hi  Function             term=none          cterm=none          guifg=green        guibg=none
" hi  Statement            term=bold          cterm=bold          guifg=#5555ff      guibg=none
" hi  Special              term=none          cterm=none          guifg=red          guibg=none
" hi  SpecialChar          term=none          cterm=none          guifg=#bb0000      guibg=none
" hi  String               term=none          cterm=none          guifg=darkyellow   guibg=none
" hi  Constant             term=none          cterm=none          guifg=darkyellow   guibg=none
" hi  Comment              term=none          cterm=none          guifg=#555555      guibg=none
" hi  Preproc              term=none          cterm=none          guifg=#1c1cff      guibg=none
" hi  Type                 term=none          cterm=none          guifg=darkmagenta  guibg=none
" hi  Identifier           term=none          cterm=none          guifg=#8855ff      guibg=none
" hi  Visual               term=bold          cterm=bold          guifg=none         guibg=#1c1c1c
" hi  Search               term=none          cterm=none          guibg=yellow       guifg=#5555cc
" hi  Directory            term=bold          cterm=bold          guifg=#555555      guibg=none
" hi  WarningMsg           term=none          cterm=none          guifg=red          guibg=none
" hi  Error                term=none          cterm=none          guifg=red          guibg=none
" hi  Cursor               term=none          cterm=none          guifg=blue         guibg=blue     "??
" hi  LineNr               term=none          cterm=none          guifg=#555555      guibg=none
" hi  StatusLine           term=none          cterm=none          guifg=blue         guibg=#000000
" hi  StatusLineNC         term=none          cterm=none          guifg=blue         guibg=#000000
" hi  VertSplit            term=none          cterm=none          guifg=black        guibg=#555555
" hi  CursorLine           term=none          cterm=none          guifg=none         guibg=#111111
" hi  ColorColumn          term=none          cterm=none          guifg=darkcyan     guibg=magenta  "??
" hi  Pmenu                term=none          cterm=none          guifg=grey         guibg=none
" hi  PmenuSel             term=none          cterm=none          guifg=none         guibg=#1c1c1c
" hi  PmenuSbar            term=none          cterm=none          guifg=darkcyan     guibg=magenta  "??
" hi  SignColumn           term=none          cterm=none          guifg=none         guibg=none
" hi  Folded               term=none          cterm=none          guifg=none         guibg=#0000ff
" hi  FoldColumn           term=none          cterm=none          guifg=none         guibg=#000000
" hi  MatchParen           term=underline     cterm=underline     guifg=red          guibg=yellow
" hi  SpecialComment       term=underline     cterm=underline     guifg=yellow       guibg=red
"
" "-- Diagnostics
" hi  DiagnosticError      term=none          cterm=none          guifg=#ff0000      guibg=none
" hi  DiagnosticWarn       term=none          cterm=none          guifg=#ff4400      guibg=none
" hi  DiagnosticHint       term=none          cterm=none          guifg=#ff8800      guibg=none
" hi  DiagnosticInfo       term=none          cterm=none          guifg=#bbbb00      guibg=none
" hi  DiagnosticSignError  term=none          cterm=none          guifg=#ff0000      guibg=none
" hi  DiagnosticSignWarn   term=none          cterm=none          guifg=#ff4400      guibg=none
" hi  DiagnosticSignHint   term=none          cterm=none          guifg=#ff8800      guibg=none
" hi  DiagnosticSignInfo   term=none          cterm=none          guifg=#bbbb00      guibg=none
"
" "-- Diff
" hi  DiffAdd              term=none          cterm=none          guifg=#555555      guibg=#44ff44
" hi  DiffChange           term=underline     cterm=underline     guifg=#ffff44      guibg=none
" hi  DiffDelete           term=none          cterm=none          guifg=#555555      guibg=#ff4444
" hi  DiffText             term=none          cterm=none          guifg=#555555      guibg=#ffff44
" hi  diffAdded            term=none          cterm=none          guifg=#000000      guibg=#00ff00
" hi  diffChanged          term=none          cterm=none          guifg=#000000      guibg=#5555ff
" hi  diffRemoved          term=none          cterm=none          guifg=#000000      guibg=#880000
" hi  diffFileId           term=bold,reverse  cterm=bold,reverse  guifg=#000000      guibg=#ff4400
" hi  diffFile             term=none          cterm=none          guifg=#000000      guibg=#ff8800
" hi  diffNewFile          term=none          cterm=none          guifg=#000000      guibg=#8855ff
" hi  diffOldFile          term=none          cterm=none          guifg=#000000      guibg=#880088
"
" "-- Cmp
" hi  link CmpItemAbbr Pmenu
" hi  link CmpItemAbbrMatch WildMenu
" hi  link CmpItemAbbrMatchFuzzyDefault PmenuSbar
" hi  link CmpItemMenu Comment
