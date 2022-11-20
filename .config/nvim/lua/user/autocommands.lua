-- vim:ft=vim:ts=2:sw=2:sts=2

vim.cmd [[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200})
    autocmd BufWinEnter * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted
  augroup end

  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell
  augroup end

  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown setlocal spell
  augroup end

  augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd =
  augroup end

  " augroup _alpha
  "   autocmd!
  "   autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  " augroup end
  "
  " augroup _lsp_autoformat
  "   autocmd!
  "   autocmd BufWritePre * lua vim.lsp.buf.formatting()
  " augroup end

  " augroup _autostart_codi
  "   autocmd!
  "   au BufEnter *.js Codi
  "   au BufEnter *.py Codi
  " augroup end

  augroup _stop_newlines_commented
    autocmd!
  " au FileType * set fo-=c fo-=r fo-=o
    au BufEnter * set fo-=c fo-=r fo-=o
  augroup end

  augroup _jump_to_last_position_on_reopen
    autocmd!
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  augroup end

  " augroup _disable_nvimtree_status
  "   autocmd!
  "   au BufEnter,BufWinEnter,WinEnter,CmdwinEnter * if bufname('%') == "NvimTree" | set laststatus=0 | else | set laststatus=2 | endif
  " augroup end

  " augroup _enable_terminal_insert_by_default
  "   autocmd!
  "   autocmd BufEnter * if &filetype == 'vs-terminal' | set noruler laststatus=0 cmdheight=3 | startinsert | endif
  "   autocmd BufEnter * if &filetype == 'sp-terminal' | set noruler laststatus=3 cmdheight=2 | startinsert | endif
  "   autocmd TermLeave * set ruler showcmd laststatus=3 cmdheight=2
  "   autocmd TermClose * set ruler showcmd laststatus=3 cmdheight=2
  " augroup end

  augroup _enable_terminal_insert_by_default
    autocmd!
    " autocmd BufEnter * if &buftype == 'terminal' | startinsert | endif
    autocmd BufEnter term://* startinsert | set nonumber statusline=%<
    autocmd TermOpen * startinsert | set nonumber statusline=%@
    autocmd TermEnter * startinsert | set nonumber statusline=%@
    autocmd TermLeave * set statusline=%{%v:lua.require'lualine'.statusline()%}
    autocmd TermClose * if &filetype != 'toggleterm' | call feedkeys("i") | endif
  augroup end

  augroup _hightlight_whitespaces
    autocmd!
    autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
    highlight ExtraWhitespace ctermbg=red guibg=red
    autocmd InsertLeave * redraw!
    match ExtraWhitespace /\s\+$\| \+\ze\t/
    autocmd BufWritePre * :%s/\s\+$//e
  augroup end

  augroup _filetype_vimcommentary_support
    autocmd!
    autocmd FileType sxhkd setlocal commentstring=#\ %s
  augroup end

]]

-- toggle status line
vim.cmd [[
  let s:hidden_all = 0
  function! ToggleStatusLIne()
    if s:hidden_all  == 0
      let s:hidden_all = 1
      set noruler
      set laststatus=0
      set cmdheight=3
      set noshowcmd
      " set nonumber
    else
      let s:hidden_all = 0
      set ruler
      set laststatus=3
      set cmdheight=2
      set showcmd
      " set number
    endif
  endfunction
  nnoremap <silent> <C-z> :call ToggleStatusLIne()<CR>
]]

-- WindowBufferSwap
vim.cmd [[
  function! WinBufSwap()
    let thiswin = winnr()
    let thisbuf = bufnr("%")
    let lastwin = winnr("#")
    let lastbuf = winbufnr(lastwin)

    exec  lastwin . " wincmd w" ."|".
        \ "buffer ". thisbuf ."|".
        \ thiswin ." wincmd w" ."|".
        \ "buffer ". lastbuf
  endfunction

  command! Wswap :call WinBufSwap()
  " map <C-v> :call WinBufSwap()<CR>
]]

-- SwitchWindow
vim.cmd [[
  function! SwitchWindow(count) abort
    let l:current_buf = winbufnr(0)
    exe "buffer" . winbufnr(a:count)
    exe a:count . "wincmd w"
    exe "buffer" . l:current_buf
    wincmd p
  endfunction
  " nnoremap <C-x> :call SwitchWindow(v:count1)<CR>
  " tnoremap <C-x> <C-\><C-n>:call SwitchWindow(v:count1)<CR><Esc>
]]

-- SwitchWindow2
vim.cmd [[
  function! SwitchWindow2()
    let thiswin = winnr()
    let thisbuf = bufnr("%")
    let lastwin = winnr("#")
    let lastbuf = winbufnr(lastwin)
    exe "buffer" . lastbuf
    wincmd p
    exe "buffer" . thisbuf
    wincmd p
  endfunction
  " nnoremap <C-x> :call SwitchWindow2()<CR>
  " tnoremap <C-x> <C-\><C-n>:call WinBufSwap()<CR><Esc>
]]

-- Cycle Last Buffer
vim.cmd [[
  let s:var = 0
  function! CycleLastBuffer()
    if s:var  == 0
      let s:var = 1
      exe "BufferLineCyclePrev"
    else
      let s:var = 0
      exe "BufferLineCycleNext"
    endif
  endfunction
]]

-- WindowSwap
vim.cmd [[
  function! MarkWindowSwap()
    let g:markedWinNum = winnr()
  endfunction

  function! DoWindowSwap()
    "Mark destination
    let curNum = winnr()
    let curBuf = bufnr( "%" )
    exe g:markedWinNum . "wincmd w"
    "Switch to source and shuffle dest->source
    let markedBuf = bufnr( "%" )
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' curBuf
    "Switch to dest and shuffle source->dest
    exe curNum . "wincmd w"
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' markedBuf
  endfunction
  " nmap <silent> <C-m> :call MarkWindowSwap()<CR>
  " nmap <silent> <C-x> :call DoWindowSwap()<CR>
]]

