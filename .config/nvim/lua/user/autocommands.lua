-- vim:ft=lua:ts=2:sw=2:sts=2

local cmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local create_command = vim.api.nvim_create_user_command

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
  "   autocmd BufWritePre * silent! lua vim.lsp.buf.format()
  " augroup end

  augroup _lspsaga_highlights_overwrite
    autocmd!
    au BufReadPost * hi LspSagaWinbarSep guifg=#495466
  augroup end

  augroup _markdown
    autocmd!
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
-- local toogle_neotree_cursor = augroup("_toogle_neotree_cursor", { clear = true })
-- cmd({"BufEnter","Filetype"}, {
--   group = toogle_neotree_cursor,
--   callback = function()
--     if vim.bo.filetype ~= "neo-tree" then
--       vim.cmd[[setlocal guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20]]
--     end
--   end,
-- })
-- cmd({"BufEnter","Filetype"}, {
--   group = toogle_neotree_cursor,
--   callback = function()
--     if vim.bo.filetype == "neo-tree" then
--       vim.cmd[[hi Cursor guibg=red blend=100 | setlocal guicursor=n:Cursor/lCursor]]
--     end
--   end,
-- })

-- _enable_terminal_insert_and_hide_terminal_statusline
local hide_terminal_statusline = augroup("_enable_terminal_insert_and_hide_terminal_statusline", { clear = true })

-- cmd({ "BufEnter", "Filetype" }, {
--   group = hide_terminal_statusline,
--   pattern = "term://*",
--   command = "startinsert"
-- })

cmd({ "TermEnter", "TermOpen" }, {
  group = hide_terminal_statusline,
  callback = function()
    -- require('lualine').hide()
    -- vim.cmd[[set nocursorline nonumber statusline=%< | startinsert]]
    vim.cmd [[set nocursorline nonumber | startinsert]]
    vim.cmd [[hi ExtraWhitespace guibg=none]]
  end,
})

-- cmd({ "TermLeave" }, {
--   group = hide_terminal_statusline,
--   callback = function()
--     require('lualine').hide({ unhide = true })
--   end,
-- })

-- _autoclose_tab-terminal_if_last_window
cmd({ "TermClose" }, {
  group = hide_terminal_statusline,
  callback = function()
    local type = vim.bo.filetype

    -- if type == "sp-terminal" or type == "vs-terminal" or type == "buf-terminal" then
    --   -- vim.cmd [[ call feedkeys("i") ]]
    --   vim.cmd [[ execute 'bdelete! ' . expand('<abuf>') ]]
    -- end
    -- if type == "tab-terminal" then
    --   M.FeedKeysCorrectly("<esc><esc>:close<cr>")
    -- end

    -- if type == "sp-terminal" or type == "vs-terminal" or type == "buf-terminal" or type == "tab-terminal" then
    --   vim.cmd [[ call feedkeys(":close") ]]
    --   M.FeedKeysCorrectly("<cr>")
    -- end

    if type == "sp-terminal" or type == "vs-terminal" or type == "buf-terminal" or type == "tab-terminal" then
      -- _close_if_last_window
      vim.cmd [[
        if len(getbufinfo({'buflisted':1})) == 1
          call feedkeys(":close")
          let key = nvim_replace_termcodes("<CR>", v:true, v:false, v:true)
          call nvim_feedkeys(key, 'n', v:false)
        endif
      ]]

      -- vim.cmd [[ execute 'bdelete! ' . expand('<abuf>') ]]
      vim.cmd [[ call feedkeys("") ]]
    end
  end,
})

-- _auto_nohlsearch
local M = {}

M.EnableAutoNoHighlightSearch = function()
  vim.on_key(function(char)
    if vim.fn.mode() == "n" then
      local new_hlsearch = vim.tbl_contains({ "<CR>", "n", "N", "*", "#", "?", "/" }, vim.fn.keytrans(char))
      if vim.opt.hlsearch:get() ~= new_hlsearch then vim.cmd [[ noh ]] end
    end
  end, vim.api.nvim_create_namespace "auto_hlsearch")
end

M.DisableAutoNoHighlightSearch = function()
  vim.on_key(nil, vim.api.nvim_get_namespaces()["auto_hlsearch"])
  vim.cmd [[ set hlsearch ]]
end

M.EnableAutoNoHighlightSearch() -- autostart

-- _goto_indent_repeatable
M.GoToParentIndent = function()
  local ok, start = require("indent_blankline.utils").get_current_context(
    vim.g.indent_blankline_context_patterns,
    vim.g.indent_blankline_use_treesitter_scope
  )
  if ok then
    vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
    vim.cmd [[normal! _]]
  end
end

local My_count = 0

M.GoToParentIndent_Repeat = function()
  My_count = 0
  vim.go.operatorfunc = "v:lua.GoToParentIndent_Callback"
  return "g@l"
end

function GoToParentIndent_Callback()
  My_count = My_count + 1
  if My_count >= 2 then
    vim.cmd [[ normal 0 ]]
  end
  M.GoToParentIndent()
  -- print("Count: " .. My_count)
end

M.FeedKeysCorrectly = function(keys)
  local feedableKeys = vim.api.nvim_replace_termcodes(keys, true, false, true)
  vim.api.nvim_feedkeys(feedableKeys, "n", true)
end

function HorzIncrement()
  vim.cmd [[ normal "zyan ]]
  vim.cmd [[ execute "normal \<Plug>(textobj-numeral-N)" ]]
  vim.cmd [[ normal van"zp ]]
  M.FeedKeysCorrectly('<C-a>')
end

function HorzDecrement()
  vim.cmd [[ normal "zyan ]]
  vim.cmd [[ execute "normal \<Plug>(textobj-numeral-N)" ]]
  vim.cmd [[ normal van"zp ]]
  M.FeedKeysCorrectly('<C-x>')
end

create_command("IncrementHorz", HorzIncrement, {})
create_command("DecrementHorz", HorzDecrement, {})

-- -- _json_to_jsonc
-- cmd({ "BufEnter", "BufWinEnter", "WinEnter" }, {
--   -- pattern = "*.json",
--   -- command = "set ft=jsonc"
--   callback = function()
--     if vim.fn.expand('%:p:h:t') == "User" then
--       if vim.fn.expand('%:t') == "settings.json" or
--           vim.fn.expand('%:t') == "keybindings.json" or
--           vim.fn.expand('%:t') == "tasks.json" then
--         vim.bo.filetype = "jsonc"
--       end
--     end
--   end,
-- })
