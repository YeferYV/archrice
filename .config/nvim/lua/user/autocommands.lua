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

-- -- swap current window with the last visited window
-- _G.SwapWindow = function()
--   local thiswin = vim.fn.winnr()
--   local thisbuf = vim.fn.bufnr("%")
--   local lastwin = vim.fn.winnr("#")
--   local lastbuf = vim.fn.winbufnr(lastwin)
--
--   vim.cmd( lastwin   .. "wincmd w") -- go to lastwin
--   vim.cmd( "buffer " ..  thisbuf  ) -- view thisbuf in current window
--   vim.cmd( thiswin   .. "wincmd w") -- go to thiswin
--   vim.cmd( "buffer " ..  lastbuf  ) -- view lastbuf in current window
-- end

------------------------------------------------------------------------------------------------------------------------

-- swap current window with the last visited window
_G.SwapWindow = function()
  local thiswin = vim.fn.winnr()
  local thisbuf = vim.fn.bufnr("%")
  local lastwin = vim.fn.winnr("#")
  local lastbuf = vim.fn.winbufnr(lastwin)
  vim.cmd("buffer " .. lastbuf) -- view lastbuf in current window
  vim.cmd("wincmd p")           -- go to previous window
  vim.cmd("buffer " .. thisbuf) -- view thisbuf in current window
  vim.cmd("wincmd p")           -- go to previous window
end

------------------------------------------------------------------------------------------------------------------------

-- -- _toogle_neotree_cursor
-- local toogle_neotree_cursor = augroup("_toogle_neotree_cursor", { clear = true })
--
-- cmd({"BufEnter","Filetype"}, {
--   group = toogle_neotree_cursor,
--   callback = function()
--     if vim.bo.filetype ~= "neo-tree" then
--       vim.cmd[[setlocal guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20]]
--     end
--   end,
-- })
--
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

------------------------------------------------------------------------------------------------------------------------

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

------------------------------------------------------------------------------------------------------------------------

-- https://thevaluable.dev/vim-create-text-objects
-- select indent by the same level:
M.select_same_indent = function(skip_blank_line)
  local start_indent = vim.fn.indent(vim.fn.line('.'))

  if skip_blank_line then
    match_blank_line = function(line) return false end
  else
    match_blank_line = function(line) return string.match(vim.fn.getline(line), '^%s*$') end
  end

  local prev_line = vim.fn.line('.') - 1
  while vim.fn.indent(prev_line) == start_indent or match_blank_line(prev_line) do

    vim.cmd('-')
    prev_line = vim.fn.line('.') - 1

    -- exit loop if there's no indentation
    if skip_blank_line then
      if vim.fn.indent(prev_line) == 0 and string.match(vim.fn.getline(prev_line), '^%s*$') then
        break
      end
    else
      if vim.fn.indent(prev_line) < 0 then
        break
      end
    end

  end

  vim.cmd('normal! 0V')

  local next_line = vim.fn.line('.') + 1
  while vim.fn.indent(next_line) == start_indent or match_blank_line(next_line) do

    vim.cmd('+')
    next_line = vim.fn.line('.') + 1

    -- exit loop if there's no indentation
    if skip_blank_line then
      if vim.fn.indent(next_line) == 0 and string.match(vim.fn.getline(next_line), '^%s*$') then
        break
      end
    else
      if vim.fn.indent(prev_line) < 0 then
        break
      end
    end

  end
end

------------------------------------------------------------------------------------------------------------------------

-- goto next/prev same level indent:
M.next_same_indent = function(next)
  local start_indent = vim.fn.indent(vim.fn.line('.'))
  local next_line = next and ( vim.fn.line('.') + 1 ) or ( vim.fn.line('.') - 1 )
  local current_line = vim.fn.line('.')
  local sign = next and '+' or '-'

  -- scroll no_blanklines (indent = 0) when going down
  if string.match(vim.fn.getline(current_line), '^%s*$') == nil then
    if sign == '+' then
      while vim.fn.indent(next_line) == 0 and string.match(vim.fn.getline(next_line), '^%s*$') == nil do
        vim.cmd('+')
        next_line = vim.fn.line('.') + 1
      end
    end
  end

  -- scroll same indentation (indent != 0)
  if start_indent ~= 0 then
    while vim.fn.indent(next_line) == start_indent do
      vim.cmd(sign)
      next_line = next and ( vim.fn.line('.') + 1 ) or ( vim.fn.line('.') - 1 )
    end
  end

  -- scroll differrent indentation (supports indent = 0, skip blacklines)
  while vim.fn.indent(next_line) ~= -1 and ( vim.fn.indent(next_line) ~= start_indent or string.match(vim.fn.getline(next_line), '^%s*$') ) do
    vim.cmd(sign)
    next_line = next and ( vim.fn.line('.') + 1 ) or ( vim.fn.line('.') - 1 )
  end

  -- scroll to next indentation
  vim.cmd(sign)

  -- scroll to top of indentation noblacklines
  local start_indent = vim.fn.indent(vim.fn.line('.'))
  local next_line = next and ( vim.fn.line('.') + 1 ) or ( vim.fn.line('.') - 1 )
  if sign == '-' then

    -- next_line indent is start_indent, next_line is no_blankline
    while vim.fn.indent(next_line) == start_indent and string.match(vim.fn.getline(next_line), '^%s*$') == nil do
      vim.cmd('-')
      next_line = vim.fn.line('.') - 1
    end

  end
end

------------------------------------------------------------------------------------------------------------------------

-- goto next/prev different level indent:
M.next_different_indent = function(next)
  local start_indent = vim.fn.indent(vim.fn.line('.'))
  local current_line = vim.fn.line('.')
  local next_line = next and ( vim.fn.line('.') + 1 ) or ( vim.fn.line('.') - 1 )
  local sign = next and '+' or '-'

  -- scroll no_blanklines (indent = 0) when going down
  if string.match(vim.fn.getline(current_line), '^%s*$') == nil then
    if sign == '+' then
      while vim.fn.indent(next_line) == 0 and string.match(vim.fn.getline(next_line), '^%s*$') == nil do
        vim.cmd('+')
        next_line = vim.fn.line('.') + 1
      end
    end
  end

  -- scroll same indentation (indent != 0)
  if start_indent ~= 0 then
    while vim.fn.indent(next_line) == start_indent do
      vim.cmd(sign)
      next_line = next and ( vim.fn.line('.') + 1 ) or ( vim.fn.line('.') - 1 )
    end
  end

  -- scroll blanklines (indent = -1 is when line is 0 or line is last+1 )
  while vim.fn.indent(next_line) == 0 and string.match(vim.fn.getline(next_line), '^%s*$') do
    vim.cmd(sign)
    next_line = next and ( vim.fn.line('.') + 1 ) or ( vim.fn.line('.') - 1 )
  end

  -- scroll to next indentation
  vim.cmd(sign)

  -- scroll to top of indentation noblacklines
  local start_indent = vim.fn.indent(vim.fn.line('.'))
  local next_line = next and ( vim.fn.line('.') + 1 ) or ( vim.fn.line('.') - 1 )
  if sign == '-' then

    -- next_line indent is start_indent, next_line is no_blankline
    while vim.fn.indent(next_line) == start_indent and string.match(vim.fn.getline(next_line), '^%s*$') == nil do
      vim.cmd('-')
      next_line = vim.fn.line('.') - 1
    end

  end

end

------------------------------------------------------------------------------------------------------------------------
return M
