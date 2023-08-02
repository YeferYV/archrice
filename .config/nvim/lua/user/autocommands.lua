-- vim:ft=lua:ts=2:sw=2:sts=2

local M = {}
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local create_command = vim.api.nvim_create_user_command

------------------------------------------------------------------------------------------------------------------------

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

  augroup _mouse_menu
    aunmenu PopUp
    vnoremenu PopUp.Cut                         "+x
    vnoremenu PopUp.Copy                        "+y
    anoremenu PopUp.Paste                       "+gP
    vnoremenu PopUp.Paste                       "+P
    vnoremenu PopUp.Delete                      "_x
    anoremenu PopUp.Search\ Word                *#
    anoremenu PopUp.Undo                        <esc><esc>:silent undo<cr>
    anoremenu PopUp.Write                       :write<cr>
    anoremenu PopUp.Quit                        :quit!<cr>
    anoremenu PopUp.Definition                  :Telescope lsp_definitions<cr>
    anoremenu PopUp.Peek\ Definition            :Lspsaga peek_definition<cr>
    anoremenu PopUp.Explorer                    :Neotree<cr>
    anoremenu PopUp.Toggle\ Scroller            :lua MiniMap.toggle()<cr>
    " anoremenu PopUp.-1-                         <Nop>
    " anoremenu PopUp.How-to\ disable\ mouse      <Cmd>help disable-mouse<CR>
    " anoremenu PopMenu.Hello                     :popup PopUp<cr>
  augroup end

]]

------------------------------------------------------------------------------------------------------------------------

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

------------------------------------------------------------------------------------------------------------------------

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

------------------------------------------------------------------------------------------------------------------------

-- _enable_terminal_insert_and_hide_terminal_statusline
local hide_terminal_statusline = augroup("_enable_terminal_insert_and_hide_terminal_statusline", { clear = true })

-- cmd({ "BufEnter", "Filetype" }, {
--   group = hide_terminal_statusline,
--   pattern = "term://*",
--   command = "startinsert"
-- })

autocmd({ "TermEnter", "TermOpen" }, {
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
autocmd({ "TermClose" }, {
  group = hide_terminal_statusline,
  callback = function()

    local type = vim.bo.filetype
    if type == "sp-terminal" or type == "vs-terminal" or type == "buf-terminal" or type == "tab-terminal" then

      -- if number of tabs is equal to 1 (last tab)
      if #vim.api.nvim_list_tabpages() == 1 then
        vim.cmd [[ Alpha ]]
        vim.cmd [[ bd # ]]
      else
        -- if number of buffers of the current tab is equal to 1 (last window)
        if #vim.fn.getbufinfo({ buflisted = 1 }) == 1 then
          -- FeedKeysCorrectly("<esc><esc>:close<cr>")
          vim.cmd [[ call feedkeys("\<Esc>\<Esc>:close\<CR>") ]]
        end
      end

      -- confirm terminal-exit-code by pressing <esc>
      vim.cmd [[ call feedkeys("") ]]

      -- alternatively close the buffer instead of confirming
      -- vim.cmd [[ execute 'bdelete! ' . expand('<abuf>') ]]

    end
  end,
})

------------------------------------------------------------------------------------------------------------------------

M.EnableAutoNoHighlightSearch = function()
  vim.on_key(function(char)
    if vim.fn.mode() == "n" then
      local new_hlsearch = vim.tbl_contains({ "<Up>", "<Down>", "<CR>", "n", "N", "*", "#", "?", "/" },
        vim.fn.keytrans(char))
      if vim.opt.hlsearch:get() ~= new_hlsearch then vim.cmd [[ noh ]] end
    end
  end, vim.api.nvim_create_namespace "auto_hlsearch")
end

M.DisableAutoNoHighlightSearch = function()
  vim.on_key(nil, vim.api.nvim_get_namespaces()["auto_hlsearch"])
  vim.cmd [[ set hlsearch ]]
end

M.EnableAutoNoHighlightSearch() -- autostart

------------------------------------------------------------------------------------------------------------------------

_G.FeedKeysCorrectly = function(keys)
  local feedableKeys = vim.api.nvim_replace_termcodes(keys, true, false, true)
  vim.api.nvim_feedkeys(feedableKeys, "n", true)
end

------------------------------------------------------------------------------------------------------------------------

_G.GoToParentIndent = function()
  local ok, start = require("indent_blankline.utils").get_current_context(
    vim.g.indent_blankline_context_patterns,
    vim.g.indent_blankline_use_treesitter_scope
  )
  if ok then
    vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
    vim.cmd [[normal! _]]
  end
end

------------------------------------------------------------------------------------------------------------------------

function GotoTextObj_Callback()
  FeedKeysCorrectly(vim.g.dotargs)
end

_G.GotoTextObj = function(action)
  vim.g.dotargs = action
  vim.o.operatorfunc = 'v:lua.GotoTextObj_Callback'
  return "g@"
end

------------------------------------------------------------------------------------------------------------------------

function WhichKeyRepeat_Callback()
  if vim.g.dotfirstcmd ~= nil then vim.cmd(vim.g.dotfirstcmd) end
  if vim.g.dotsecondcmd ~= nil then vim.cmd(vim.g.dotsecondcmd) end
  if vim.g.dotthirdcmd ~= nil then vim.cmd(vim.g.dotthirdcmd) end
end

_G.WhichkeyRepeat = function(firstcmd, secondcmd, thirdcmd)
  vim.g.dotfirstcmd = firstcmd
  vim.g.dotsecondcmd = secondcmd
  vim.g.dotthirdcmd = thirdcmd
  vim.o.operatorfunc = 'v:lua.WhichKeyRepeat_Callback'
  vim.cmd.normal { "g@l", bang = true }
end

------------------------------------------------------------------------------------------------------------------------

function ShowBufferline()
  require('bufferline').setup {
    options = {
      offsets = { { filetype = 'neo-tree', padding = 1 } },
      show_close_icon = false
    }
  }
end

create_command("BufferlineShow", ShowBufferline, {})

------------------------------------------------------------------------------------------------------------------------

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

return M
