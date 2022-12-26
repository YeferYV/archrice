-- vim:ft=vim:ts=2:sw=2:sts=2

vim.cmd [[
  " augroup _alpha
  "   autocmd!
  "   autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  " augroup end

  " augroup _autostart_codi
  "   autocmd!
  "   au BufEnter *.js Codi
  "   au BufEnter *.py Codi
  " augroup end

  " augroup _auto_resize
  "   autocmd!
  "   autocmd VimResized * tabdo wincmd =
  " augroup end

  " augroup _disable_neotree_status
  "   autocmd!
  "   au BufEnter,BufWinEnter,WinEnter,CmdwinEnter * if bufname('%') == "neo-tree" | set laststatus=0 | else | set laststatus=2 | endif
  " augroup end

  " augroup _enable_terminal_insert_and_hide_terminal_statusline
  "   autocmd!
  "   autocmd BufEnter term://* startinsert
  "   autocmd BufEnter        * if &filetype == 'vs-terminal' | set noruler laststatus=0 cmdheight=1 | endif
  "   autocmd BufEnter        * if &filetype != 'vs-terminal' | set noruler laststatus=3 cmdheight=0 | endif
  "   autocmd TermClose       * if &filetype != 'toggleterm'  | call feedkeys("i")                   | endif
  " augroup end

  " augroup _enable_terminal_insert_and_hide_terminal_statusline
  "   autocmd!
  "   autocmd BufEnter    term://* startinsert
  "   autocmd TermOpen,TermEnter * lua require('lualine').hide()              vim.cmd('set nocursorline nonumber statusline=%< | startinsert')
  "   autocmd TermLeave          * lua require('lualine').hide({unhide=true}) vim.cmd('set cursorline')
  "   autocmd TermClose          * if &filetype != 'toggleterm' | call feedkeys("i") | endif
  " augroup end

  augroup _filetype_vimcommentary_support
    autocmd!
    autocmd FileType sxhkd setlocal commentstring=#\ %s
  augroup end

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

  augroup _hightlight_whitespaces
    autocmd!
    autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
    highlight ExtraWhitespace ctermbg=red guibg=red
    autocmd InsertLeave * redraw!
    match ExtraWhitespace /\s\+$\| \+\ze\t/
    autocmd BufWritePre * :%s/\s\+$//e
  augroup end

  augroup _jump_to_last_position_on_reopen
    autocmd!
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  augroup end

  " augroup _lsp_autoformat
  "   autocmd!
  "   autocmd BufWritePre * lua vim.lsp.buf.formatting()
  " augroup end

  augroup _lspsaga_highlights_overwrite
    autocmd!
    au BufReadPost * hi LspSagaWinbarSep guifg=#495466
  augroup end

  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown setlocal spell
  augroup end

  " augroup _save_folding
  "   autocmd!
  "   autocmd BufWinLeave *.* mkview
  "   autocmd BufWinEnter *.* silent loadview
  " augroup end

  augroup _stop_newlines_commented
    autocmd!
  " au FileType * set fo-=c fo-=r fo-=o
    au BufEnter * set fo-=c fo-=r fo-=o
  augroup end

  " augroup _toogle_neotree_cursor
  "   autocmd!
  "   autocmd BufEnter * if &filetype == 'neo-tree' | hi Cursor guifg=none guibg=red blend=100 | setlocal guicursor=n:Cursor/lCursor | endif
  "   autocmd BufEnter * if &filetype != 'neo-tree' | setlocal guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20 | endif
  " augroup end

]]

-- Last Active Tab
vim.cmd [[
  function! LastActiveTab()
    if !exists('g:lasttab')
      let g:lasttab = 1
    endif
    au TabLeave * let g:lasttab = tabpagenr()
    exe "tabn ".g:lasttab
  endfunction
    " nnoremap <C-z> :call LastActiveTab()<CR>
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
  " nnoremap <silent> <C-z> :call ToggleStatusLIne()<CR>
]]

-- Window Buffer Swap
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

-- Window Swap
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

-- -- _toogle_neotree_cursor
-- local toogle_neotree_cursor = vim.api.nvim_create_augroup("_toogle_neotree_cursor", { clear = true })
-- vim.api.nvim_create_autocmd({"BufEnter","Filetype"}, {
--   group = toogle_neotree_cursor,
--   callback = function()
--     if vim.bo.filetype ~= "neo-tree" then
--       vim.cmd[[setlocal guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20]]
--     end
--   end,
-- })
-- vim.api.nvim_create_autocmd({"BufEnter","Filetype"}, {
--   group = toogle_neotree_cursor,
--   callback = function()
--     if vim.bo.filetype == "neo-tree" then
--       vim.cmd[[hi Cursor guibg=red blend=100 | setlocal guicursor=n:Cursor/lCursor]]
--     end
--   end,
-- })

-- _enable_terminal_insert_and_hide_terminal_statusline
local hide_terminal_statusline = vim.api.nvim_create_augroup("_enable_terminal_insert_and_hide_terminal_statusline", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter","Filetype" }, {
  group = hide_terminal_statusline,
  pattern = "term://*",
  command = "startinsert"
})
vim.api.nvim_create_autocmd( { "TermEnter","TermOpen" }, {
  group = hide_terminal_statusline,
  callback = function()
    -- require('lualine').hide()
    -- vim.cmd[[set nocursorline nonumber statusline=%< | startinsert]]
    vim.cmd[[set nocursorline nonumber | startinsert]]
    vim.cmd[[hi ExtraWhitespace guibg=none]]
  end,
})
vim.api.nvim_create_autocmd({ "TermLeave" }, {
  group = hide_terminal_statusline,
  callback = function()
    require('lualine').hide({unhide=true})
    vim.cmd[[set cursorline]]
    vim.cmd[[hi ExtraWhitespace guibg=red]]
  end,
})
vim.api.nvim_create_autocmd({ "TermClose" }, {
  group = hide_terminal_statusline,
  callback = function()
    if vim.bo.filetype ~= "toggleterm" then
      vim.cmd[[ call feedkeys("i") ]]
    end
    vim.cmd[[hi ExtraWhitespace guibg=red]]
  end,
})
