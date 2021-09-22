
" hide tab coded in autoload/plugged/barbar.nvim/plugin/buffeline.vim
" set showtabline=1 " 0: never 1: only if there are at least two tab pages

let bufferline = {}

" Show a shadow over the editor in buffer-pick mode
let bufferline.shadow = v:true

" Enable/disable icons
let bufferline.icons = v:true

" Enables/disable clickable tabs
"  - left-click: go to buffer
"  - middle-click: delete buffer
"
" NOTE disabled by default because this might cause E541 (too many items)
"      if you have many tabs open
let bufferline.clickable = v:true

" If set, the letters for each buffer in buffer-pick mode will be
" assigned based on their name. Otherwise or in case all letters are
" already assigned, the behavior is to assign letters in order of
" usability (see order below)
let bufferline.semantic_letters = v:true

" New buffer letters are assigned in this order. This order is
" optimal for the qwerty keyboard layout but might need adjustement
" for other layouts.
let bufferline.letters =
  \ 'asdfjkl;ghnmxcbziowerutyqpASDFJKLGHNMXCBZIOWERUTYQP'

let bg_current = get(nvim_get_hl_by_name('Normal',     1), 'background', '#ff0000')
let bg_visible = get(nvim_get_hl_by_name('TabLineSel', 1), 'background', '#ff0000')
let bg_inactive = get(nvim_get_hl_by_name('TabLine',   1), 'background', '#ff0000')

" For the current active buffer
hi default link BufferCurrent      Normal
" For the current active buffer when modified
hi default link BufferCurrentMod   Normal
" For the current active buffer icon
hi default link BufferCurrentSign  Normal
" For the current active buffer target when buffer-picking
exe 'hi default BufferCurrentTarget   guifg=red gui=bold guibg=' . bg_current

" For buffers visible but not the current one
hi default link BufferVisible      TabLineSel
hi default link BufferVisibleMod   TabLineSel
hi default link BufferVisibleSign  TabLineSel
exe 'hi default BufferVisibleTarget   guifg=red gui=bold guibg=' . bg_visible

" For buffers invisible buffers
hi default link BufferInactive     TabLine
hi default link BufferInactiveMod  TabLine
hi default link BufferInactiveSign TabLine
exe 'hi default BufferInactiveTarget   guifg=red gui=bold guibg=' . bg_inactive


" For the shadow in buffer-picking mode
hi default BufferShadow guifg=#000000 guibg=#000000



" "" https://github.com/romgrk/barbar.nvim/blob/master/autoload/bufferline/highlight.vim
" " !::exe [So]

" " Initialize highlights
" function bufferline#highlight#setup()
"    let fg_target = 'red'

"    let fg_current  = s:fg(['Normal'], '#efefef')
"    let fg_visible  = s:fg(['TabLineSel'], '#efefef')
"    let fg_inactive = s:fg(['TabLineFill'], '#888888')

"    let fg_modified = s:fg(['WarningMsg'], '#E5AB0E')
"    let fg_special  = s:fg(['Special'], '#599eff')
"    let fg_subtle   = s:fg(['NonText', 'Comment'], '#555555')

"    let bg_current  = s:bg(['Normal'], 'none')
"    let bg_visible  = s:bg(['TabLineSel', 'Normal'], 'none')
"    let bg_inactive = s:bg(['TabLineFill', 'StatusLine'], 'none')

"    "      Current: current buffer
"    "      Visible: visible but not current buffer
"    "     Inactive: invisible but not current buffer
"    "        -Icon: filetype icon
"    "       -Index: buffer index
"    "         -Mod: when modified
"    "        -Sign: the separator between buffers
"    "      -Target: letter in buffer-picking mode
"    call s:hi_all([
"    \ ['BufferCurrent',        fg_current,  bg_current],
"    \ ['BufferCurrentIndex',   fg_special,  bg_current],
"    \ ['BufferCurrentMod',     fg_modified, bg_current],
"    \ ['BufferCurrentSign',    fg_special,  bg_current],
"    \ ['BufferCurrentTarget',  fg_target,   bg_current,   'bold'],
"    \ ['BufferVisible',        fg_visible,  bg_visible],
"    \ ['BufferVisibleIndex',   fg_visible,  bg_visible],
"    \ ['BufferVisibleMod',     fg_modified, bg_visible],
"    \ ['BufferVisibleSign',    fg_visible,  bg_visible],
"    \ ['BufferVisibleTarget',  fg_target,   bg_visible,   'bold'],
"    \ ['BufferInactive',       fg_inactive, bg_inactive],
"    \ ['BufferInactiveIndex',  fg_subtle,   bg_inactive],
"    \ ['BufferInactiveMod',    fg_modified, bg_inactive],
"    \ ['BufferInactiveSign',   fg_subtle,   bg_inactive],
"    \ ['BufferInactiveTarget', fg_target,   bg_inactive,  'bold'],
"    \ ['BufferTabpages',       fg_special,  bg_inactive, 'bold'],
"    \ ['BufferTabpageFill',    fg_inactive, bg_inactive],
"    \ ])

"    call s:hi_link([
"    \ ['BufferCurrentIcon',  'BufferCurrent'],
"    \ ['BufferVisibleIcon',  'BufferVisible'],
"    \ ['BufferInactiveIcon', 'BufferInactive'],
"    \ ['BufferOffset',       'BufferTabpageFill'],
"    \ ])

"    lua require'bufferline.icons'.set_highlights()
" endfunc

" function! s:fg(groups, default)
"    for group in a:groups
"       let hl = nvim_get_hl_by_name(group,   1)
"       if has_key(hl, 'foreground')
"          return printf("#%06x", hl.foreground)
"       end
"    endfor
"    return a:default
" endfunc

" function! s:bg(groups, default)
"    for group in a:groups
"       let hl = nvim_get_hl_by_name(group,   1)
"       if has_key(hl, 'background')
"          return printf("#%06x", hl.background)
"       end
"    endfor
"    return a:default
" endfunc

" function! s:hi_all(groups)
"    for group in a:groups
"       call call(function('s:hi'), group)
"    endfor
" endfunc

" function! s:hi_link(pairs)
"    for pair in a:pairs
"       execute 'hi default link ' . join(pair)
"    endfor
" endfunc

" function! s:hi(name, ...)
"    let fg = ''
"    let bg = ''
"    let attr = ''

"    if type(a:1) == 3
"       let fg   = get(a:1, 0, '')
"       let bg   = get(a:1, 1, '')
"       let attr = get(a:1, 2, '')
"    else
"       let fg   = get(a:000, 0, '')
"       let bg   = get(a:000, 1, '')
"       let attr = get(a:000, 2, '')
"    end

"    let has_props = v:false

"    let cmd = 'hi default ' . a:name
"    if !empty(fg) && fg != 'none'
"       let cmd .= ' guifg=' . fg
"       let has_props = v:true
"    end
"    if !empty(bg) && bg != 'none'
"       let cmd .= ' guibg=' . bg
"       let has_props = v:true
"    end
"    if !empty(attr) && attr != 'none'
"       let cmd .= ' gui=' . attr
"       let has_props = v:true
"    end
"    execute 'hi default clear ' a:name
"    if has_props
"       execute cmd
"    end
" endfunc

" " call bufferline#highlight#setup()
