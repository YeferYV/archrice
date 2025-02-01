-- vim:ft=lua:ts=2:sw=2:sts=2
local M = {}
local autocmd = vim.api.nvim_create_autocmd

------------------------------------------------------------------------------------------------------------------------

vim.cmd [[

  augroup _mouse_menu
    "aunmenu PopUp
    vnoremenu PopUp.Cut                         "+x
    vnoremenu PopUp.Copy                        "+y
    vnoremenu PopUp.Delete                      "_x
    vnoremenu PopUp.Paste                       "+P
    anoremenu PopUp.Paste                       "+gP
    anoremenu PopUp.Search\ Word                *#
    anoremenu PopUp.Undo                        <esc><esc>:silent undo<cr>
    anoremenu PopUp.Write                       :write<cr>
    anoremenu PopUp.Quit                        :quit!<cr>
    anoremenu PopUp.Explorer                    :lua Snacks.explorer()<cr>
    " anoremenu PopUp.-1-                         <Nop>
    " anoremenu PopUp.How-to\ disable\ mouse      <Cmd>help disable-mouse<CR>
    " anoremenu PopMenu.Hello                     :popup PopUp<cr>
  augroup end

]]

-- stop comment prefix on new lines
autocmd({ "BufEnter" }, { command = "set formatoptions-=cro" })

-- remember last position when re-opening a file
autocmd({ "BufReadPost" }, { command = "normal! g'\"" })

-- briefly highlight yanked text
autocmd("TextYankPost", { callback = function() vim.highlight.on_yank({ higroup = "Visual", timeout = 200 }) end })

-- Highlight trailing whitespace
vim.api.nvim_set_hl(0, "ExtraWhitespace", { ctermbg = "red", bg = "red" })

-- Ensure the highlight exists after a colorscheme change
autocmd({ "ColorScheme" }, { command = "highlight ExtraWhitespace ctermbg=red guibg=red" })

-- Refresh highlighting after leaving insert mode
autocmd("InsertLeave", { command = "redraw!", })

-- Apply the highlight to trailing spaces
vim.fn.matchadd("ExtraWhitespace", [[\s\+$\| \+\ze\t]])

-- Remove trailing spaces on save
autocmd("BufWritePre", { command = [[%s/\s\+$//e]], })


-- Disable mini.completion for a certain filetype (extracted from `:help mini.nvim`)
local f = function(args) vim.b[args.buf].minicompletion_disable = true end
vim.api.nvim_create_autocmd('Filetype', { pattern = 'snacks_picker_input', callback = f })
vim.api.nvim_create_autocmd('Filetype', { pattern = 'snacks_input', callback = f })

------------------------------------------------------------------------------------------------------------------------


-- autocmd({ "BufEnter", "Filetype" }, {
--   group = hide_terminal_statusline,
--   pattern = "term://*",
--   command = "startinsert"
-- })

autocmd({ "TermEnter", "TermOpen" }, {
  callback = function()
    vim.cmd [[ setlocal nocursorline ]]
    vim.cmd [[ setlocal nonumber ]]
    vim.cmd [[ setlocal signcolumn=no ]]
    vim.cmd.startinsert()
    vim.cmd.highlight("ExtraWhitespace guibg=none")

    -- hide bufferline if `nvim -cterm`
    if #vim.fn.getbufinfo({ buflisted = 1 }) == 1 then
      vim.cmd("set showtabline=0")
    else
      vim.cmd("set showtabline=2")
    end
  end,
})

------------------------------------------------------------------------------------------------------------------------

-- https://github.com/neovim/neovim/issues/14986
-- used by neotree open_image_with_sixel
autocmd({ "TermClose", --[[ "BufWipeout" ]] }, {
  callback = function()
    vim.schedule(function()
      -- if vim.bo.buftype == 'terminal' and vim.v.shell_error == 0 then
      if vim.bo.filetype == 'terminal' then
        vim.cmd [[ bp | bd! # ]]
      end

      -- required when exiting `nvim -cterm`
      if vim.fn.bufname() == "" then
        vim.cmd [[ quit ]]
      end
    end)
  end,
})

--------------------------------------------------------------------------------------------------------------------

-- https://www.reddit.com/r/neovim/comments/ww2oyu/toggle_terminal
function ToggleTerminal()
  local buf_exists = vim.fn.bufexists(te_buf) == 1
  local win_exists = vim.fn.win_gotoid(te_win_id) == 1

  if not buf_exists then
    -- Terminal buffer doesn't exist, create it
    vim.cmd("vsplit +term")
    te_win_id = vim.fn.win_getid()
    te_buf = vim.fn.bufnr()
  elseif not win_exists then
    -- Terminal buffer exists but not visible, show it
    vim.cmd('vs | buffer' .. te_buf)
    te_win_id = vim.fn.win_getid()
  else
    -- Terminal buffer exists and is visible, hide it
    vim.cmd("hide")
  end
end

function HideUnhideWindow()
  if not Hidden then
    Bufnr = vim.fn.bufnr()
    vim.cmd('hide')
    Hidden = true
  else
    vim.cmd('vs | buffer' .. Bufnr)
    Hidden = false
  end
end

------------------------------------------------------------------------------------------------------------------------

-- swap current window with the last visited window
function SwapWindow()
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

function ChangeIndent()
  local input_avail, input = pcall(vim.fn.input, "Set indent value (>0 expandtab, <=0 noexpandtab): ")
  if input_avail then
    local indent = tonumber(input)
    if not indent or indent == 0 then return end
    vim.bo.expandtab = (indent > 0)
    indent = math.abs(indent)
    vim.bo.tabstop = indent
    vim.bo.softtabstop = indent
    vim.bo.shiftwidth = indent
  end
end

------------------------------------------------------------------------------------------------------------------------

function WhichKeyRepeat_Callback()
  if vim.g.dotfirstcmd ~= nil then vim.cmd(vim.g.dotfirstcmd) end
  if vim.g.dotsecondcmd ~= nil then vim.cmd(vim.g.dotsecondcmd) end
  if vim.g.dotthirdcmd ~= nil then vim.cmd(vim.g.dotthirdcmd) end
end

-- https://www.vikasraj.dev/blog/vim-dot-repeat
_G.WhichkeyRepeat = function(firstcmd, secondcmd, thirdcmd)
  vim.g.dotfirstcmd = firstcmd
  vim.g.dotsecondcmd = secondcmd
  vim.g.dotthirdcmd = thirdcmd
  vim.o.operatorfunc = 'v:lua.WhichKeyRepeat_Callback'
  vim.cmd.normal { "g@l", bang = true }
end

------------------------------------------------------------------------------------------------------------------------

-- goto next/prev same/different level indent:
M.next_indent = function(next, level)
  local start_indent = vim.fn.indent(vim.fn.line('.'))
  local sign = next and '+' or '-'
  local next_line = function() return next and (vim.fn.line('.') + 1) or (vim.fn.line('.') - 1) end
  local is_blank_line = function(line) return string.match(vim.fn.getline(line), '^%s*$') end

  while vim.fn.indent(next_line()) == start_indent do
    vim.cmd(sign)
    -- vim.notify("scrolling the start_indent")
  end

  if level == "same_level" then
    while vim.fn.indent(next_line()) ~= start_indent and vim.fn.indent(next_line()) ~= -1 do
      vim.cmd(sign)
      -- vim.notify("finding next start_indent")
    end
  else
    while is_blank_line(next_line()) and vim.fn.indent(next_line()) ~= -1 do
      vim.cmd(sign)
      -- vim.notify("avoiding blanklines stops")
    end
  end

  -- scroll to next indentation
  vim.cmd(sign)
end

------------------------------------------------------------------------------------------------------------------------

----> https://github.com/coderifous/textobj-word-column.vim
local function find_boundary_col(start_line, stop_line, cursor_col, word_textobj)
  local col_bounds = { 100, 0 }
  local index = start_line

  while index <= stop_line do
    local select_word = "norm! " .. tostring(index) .. "gg" .. tostring(cursor_col) .. "|v" .. word_textobj .. "\\<esc>"
    vim.cmd('exec "' .. select_word .. '"')

    local start_col = vim.fn.col("'<")
    local stop_col = vim.fn.col("'>")

    if col_bounds[1] >= start_col then
      col_bounds[1] = start_col
    end

    if col_bounds[2] <= stop_col then
      col_bounds[2] = stop_col
    end

    index = index + 1
  end

  return col_bounds
end

local function find_boundary_row()
  local start_indent = vim.fn.indent(vim.fn.line('.'))
  local get_comment_regex = "^%s*" .. string.gsub(vim.bo.commentstring, "%%s", ".*") .. "%s*$"
  local is_blank_line = function(line) return string.match(vim.fn.getline(line), '^%s*$') end
  local is_comment_line = function(line) return string.find(vim.fn.getline(line), get_comment_regex) end

  local prev_line = vim.fn.line('.') - 1
  while vim.fn.indent(prev_line) == start_indent do
    if is_comment_line(prev_line) or is_blank_line(prev_line) then break end
    prev_line = prev_line - 1
  end

  local next_line = vim.fn.line('.') + 1
  while vim.fn.indent(next_line) == start_indent do
    if is_comment_line(next_line) or is_blank_line(next_line) then break end
    next_line = next_line + 1
  end

  return { prev_line + 1, next_line - 1 }
end

M.ColumnWord = function(word_textobj)
  vim.cmd [[ execute "normal \<esc>" ]] -- to exit visual mode
  local cursor_col = vim.fn.col(".")
  local row_bounds = find_boundary_row()
  local col_bounds = find_boundary_col(row_bounds[1], row_bounds[2], cursor_col, word_textobj)
  vim.cmd.normal {
    tostring(row_bounds[1]) .. "gg" ..
    tostring(col_bounds[1]) .. "|" ..
    tostring(row_bounds[2]) .. "gg" ..
    tostring(col_bounds[2]) .. "|",
    bang = true
  }
  -- vim.print(row_bounds)
  -- vim.print(col_bounds)
end

--------------------------------------------------------------------------------------------------------------------

-- https://github.com/romgrk/columnMove.vim
M.ColumnMove = function(direction)
  local lnum = vim.fn.line('.')
  local colnum = vim.fn.virtcol('.')
  local remove_extraline = false
  local pattern1, pattern2
  local match_char = function(lnum, pattern) return vim.fn.getline(lnum):sub(colnum, colnum):match(pattern) end

  if match_char(lnum, '%S') then
    pattern1 = '^$'         -- pattern to stop at empty char
    pattern2 = '%s'         -- pattern to stop at blankspace
    lnum = lnum + direction -- continue (to the blankspace and emptychar conditional) when at end of line
    remove_extraline = true
    -- vim.notify("no_blankspace")
  end

  if match_char(lnum, '%s') then
    pattern1 = '%S'
    pattern2 = nil
    remove_extraline = false
    -- vim.notify("blankspace")
  end

  if match_char(lnum, '^$') then
    pattern1 = '%S'
    pattern2 = nil
    remove_extraline = false
    -- vim.notify("emptychar")
  end

  while lnum >= 0 and lnum <= vim.fn.line('$') do
    if match_char(lnum, pattern1) then
      break
    end

    if pattern2 then
      if match_char(lnum, pattern2) then
        break
      end
    end

    lnum = lnum + direction
  end

  -- If the match was at the end of the line, return the previous line number and the current column number
  if remove_extraline then
    vim.cmd.normal(lnum - direction .. "gg" .. colnum .. "|")
  else
    vim.cmd.normal(lnum .. "gg" .. colnum .. "|")
  end
end

--------------------------------------------------------------------------------------------------------------------

-- https://www.reddit.com/r/neovim/comments/10bmy9w/lets_see_your_status_columns
function ToggleFold()
  local line = vim.fn.getmousepos().line

  if vim.fn.foldlevel(line) > vim.fn.foldlevel(line - 1) then -- Only lines with the marks should be clickable
    if vim.fn.foldclosed(line) == -1 then
      vim.cmd(line .. 'foldclose')
    else
      vim.cmd(line .. 'foldopen')
    end
  end
end

-- https://www.reddit.com/r/neovim/comments/13u9brg/remove_the_fold_level_numbers_using_the_statusline_config
local fcs = vim.opt.fillchars:get()
local function get_fold(lnum)
  if vim.fn.foldlevel(lnum) <= vim.fn.foldlevel(lnum - 1) then return ' ' end
  return vim.fn.foldclosed(lnum) == -1 and fcs.foldopen or fcs.foldclose
end

-- clickable fold markers
_G.get_statuscol = function()
  local lnum = vim.v.lnum
  return '%@v:lua.ToggleFold@' .. get_fold(lnum) .. '%X%s%l '
end

-- https://github.com/neovim/neovim/pull/17446
-- vim.o.statuscolumn = '%{foldlevel(v:lnum) > foldlevel(v:lnum - 1) ? (foldclosed(v:lnum) == -1 ? "▼" : "⏵") : " " }%s%l '
vim.o.statuscolumn = '%!v:lua.get_statuscol()'

--------------------------------------------------------------------------------------------------------------------

-- https://www.reddit.com/r/neovim/comments/1d7j0c1/a_small_gist_to_use_the_new_builtin_completion/
-- https://www.reddit.com/r/neovim/comments/rddugs/snipcomplua_luasnip_companion_plugin_for_omni/
-- local _, luasnip = pcall(require, "luasnip")
local map = vim.keymap.set

---For replacing certain <C-x>... keymaps.
---@param keys string
local function feedkeys(keys)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), 'n', true)
end

---Is the completion menu open?
local function pumvisible()
  return tonumber(vim.fn.pumvisible()) ~= 0
end

vim.api.nvim_create_autocmd('LspAttach', {

  callback = function(args)
    -- vim.cmd [[ LspStart ]] -- the `vi` zsh alias doesn't autostart lsp
    vim.lsp.completion.enable(true, args.data.client_id, args.buf, { autotrigger = true })

    -- Use enter to expand snippet or accept completions.
    map('i', '<cr>', function()
      -- if luasnip.expandable() then luasnip.expand()
      if pumvisible() then
        feedkeys '<C-y>'
      else
        feedkeys '<cr>'
      end
    end)

    -- complete placeholder (if selecting snippet expand it with <cr>)
    map('i', '<down>', function()
      if pumvisible() then
        feedkeys '<C-n>'
      else
        feedkeys '<down>'
      end
    end)
    map('i', '<up>', function()
      if pumvisible() then
        feedkeys '<C-p>'
      else
        feedkeys '<up>'
      end
    end)

    -- to navigate between completion list or snippet tabstops,
    map({ 'i', 's' }, '<Tab>', function()
      if pumvisible() then
        feedkeys '<C-n>'
        --  elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
      elseif vim.snippet.active { direction = 1 } then
        vim.snippet.jump(1)
      else
        feedkeys '<Tab>'
      end
    end)
    map({ 'i', 's' }, '<S-Tab>', function()
      if pumvisible() then
        feedkeys '<C-p>'
        -- elseif luasnip.jumpable(-1) then luasnip.jump(-1)
      elseif vim.snippet.active { direction = -1 } then
        vim.snippet.jump(-1)
      else
        feedkeys '<S-Tab>'
      end
    end)
  end
})

------------------------------------------------------------------------------------------------------------------------

return M
