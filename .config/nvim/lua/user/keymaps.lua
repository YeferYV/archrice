local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap
local map = vim.keymap.set

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- ╭────────────╮
-- │ Automation │
-- ╰────────────╯

-- position navigation (in wezterm <C-i> outputs Tab)
keymap("n", "<C-I>", "<C-i>", opts) -- <C-UpperCase> is the same as <C-LowerCase>

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
map({ 'n', 't' }, '<M-Left>', require('smart-splits').resize_left, opts)
map({ 'n', 't' }, '<M-Down>', require('smart-splits').resize_down, opts)
map({ 'n', 't' }, '<M-Up>', require('smart-splits').resize_up, opts)
map({ 'n', 't' }, '<M-Right>', require('smart-splits').resize_right, opts)

-- Navigate buffers
-- keymap("n", "]q", ":cnext<CR>", opts)
-- keymap("n", "[q", ":cprevious<CR>", opts)
-- keymap("n", "]l", ":lnext<CR>", opts)
-- keymap("n", "[l", ":lprevious<CR>", opts)
keymap("n", "<right>", ":bnext<CR>", opts)
keymap("n", "<left>", ":bprevious<CR>", opts)
keymap("n", "<Home>", ":tabprevious<CR>", opts)
keymap("n", "<End>", ":tabnext<CR>", opts)
keymap("n", "<Insert>", ":tabnext #<CR>", opts)
keymap("t", "<Home>", "<C-\\><C-n>:tabprevious<CR>", opts)
keymap("t", "<End>", "<C-\\><C-n>:tabnext<CR>", opts)
keymap("t", "<Insert>", "<C-\\><C-n>:tabnext #<CR>", opts)
keymap("n", "<Tab>", ":bnext<CR>", opts)
keymap("n", "<S-Tab>", ":bprevious<CR>", opts)
keymap("n", "<leader>x", ":bp | bd #<CR>", { silent = true, desc = "Close Buffer" })
keymap("n", "<leader><Tab>", ":tabnext<CR>", opts)
keymap("n", "<leader><S-Tab>", ":tabprevious<CR>", opts)
keymap("n", "<leader>X", ":tabclose<CR>", { silent = true, desc = "Close Tab" })

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Macros and :normal <keys> repeatable
-- keymap("n", "!", "z", opts)
-- keymap("n", "z", "Q", opts)
keymap("n", "U", "@:", opts)

-- Move text up and down autoindented
-- keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
-- keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Replace all/visual_selected
map({ "n" }, "<C-s>", ":%s//g<Left><Left>", { noremap = true, silent = false, desc = "Replace in Buffer" })
map({ "x" }, "<C-s>", ":s//g<Left><Left>", { noremap = true, silent = false, desc = "Replace in Visual_selected" })

-- Intellisense
-- map("i", "<A-h>", "<Plug>(copilot-dismiss)", { expr = true, silent = true })
-- map("i", "<A-j>", "<Plug>(copilot-next)", { expr = true, silent = true })
-- map("i", "<A-k>", "<Plug>(copilot-previous)", { expr = tru, silent = true })
-- map("i", "<A-l>", function() return vim.fn['copilot#Accept']() end, { expr = tru, silent = true })
-- map('i', '<A-h>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
map('i', '<A-j>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true, silent = true })
map('i', '<A-k>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true, silent = true })
map('i', '<A-l>', function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })

keymap("i", "<C-e>", "<esc><C-e>a", opts)
keymap("i", "<C-y>", "<esc><C-y>a", opts)
keymap("i", "<C-n>", "<C-e>", opts) -- completes next line
keymap("i", "<C-p>", "<C-y>", opts) -- completes previous line
-- map('i', '<C-g>', function() vim.lsp.buf.signature_help() end, opts)
-- map('i', '<C-g>', function() vim.lsp.buf.hover() end, opts)
map('i', '<C-h>', function() require('lsp_signature').toggle_float_win() end, opts)

map('i', '<C-v>', function()
  if vim.g.diagnosticsEnabled == "on" or vim.g.diagnosticsEnabled == nil then
    vim.g.diagnosticsEnabled = "off"
    vim.diagnostic.config({ virtual_text = false })
    vim.cmd [[
      augroup _toggle_virtualtext_insertmode
      autocmd InsertEnter * lua vim.diagnostic.config({ virtual_text = false })
      autocmd InsertLeave * lua vim.diagnostic.config({ virtual_text = true })
      augroup end
    ]]
  else
    vim.g.diagnosticsEnabled = "on"
    vim.diagnostic.config({ virtual_text = true })
    vim.cmd [[ autocmd! _toggle_virtualtext_insertmode ]] -- remove the autocmd, `:autocmd _toggle_virtualtext_insertmode` to view it
  end
end, { silent = true, desc = "Toggle VirtualText (InsertMode Only)" })

-- Quick Escape
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)
-- keymap("v", "jk", "<ESC>", opts) --slow
-- keymap("v", "kj", "<ESC>", opts) --slow

-- Quick quit/write
map("n", "<S-q>", function() vim.cmd("quit") end, opts)
map("n", "<S-r>", function() vim.lsp.buf.format() vim.cmd("silent write") end, opts)

-- Quick Jump
keymap("n", "J", "10gj", opts)
keymap("n", "K", "10gk", opts)
keymap("n", "H", "10h", opts)
keymap("n", "L", "10l", opts)

-- Forward yank/paste
keymap("n", 'Y', 'yg_', { noremap = true, silent = true, desc = "Forward yank" })
keymap("v", 'P', 'g_P', { noremap = true, silent = true, desc = "Forward Paste" }) -- "P" seems unaltered the clipboard

-- Unaltered clipboard
keymap("v", 'p', '"_c<c-r>+<esc>', { noremap = true, silent = true, desc = "Paste Unaltered" })

-- Save file as sudo
-- keymap("c","w!!","execute 'silent! write !sudo tee % >/dev/null' <bar> edit!",opts)
keymap("c", "w!!", "w !sudo tee %", opts)

-- ╭────────────────╮
-- │ leader keymaps │
-- ╰────────────────╯

-- Buffer keymaps
keymap("n", "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", opts)
keymap("n", "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", opts)
keymap("n", "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", opts)
keymap("n", "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", opts)
keymap("n", "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", opts)
keymap("n", "<leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", opts)
keymap("n", "<leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>", opts)
keymap("n", "<leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>", opts)
keymap("n", "<leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>", opts)
keymap("n", "g,", "g,", { noremap = true, silent = true, desc = "go forward in :changes" }) -- Formatting will lose track of changes
keymap("n", "g;", "g;", { noremap = true, silent = true, desc = "go backward in :changes" }) -- Formatting will lose track of changes
keymap("n", "gb;", "<C-6>", { noremap = true, silent = true, desc = "go to last buffer" })
keymap("n", "<C-;>", "<C-6>", { noremap = true, silent = true, desc = "go to last buffer" })
keymap("n", "gbs", "<Cmd>BufferLineCyclePrev <CR>", opts)
keymap("n", "gbf", "<Cmd>BufferLineCycleNext <CR>", opts)
keymap("n", "gbS", "<Cmd>BufferLineMovePrev <CR>", opts)
keymap("n", "gbF", "<Cmd>BufferLineMoveNext <CR>", opts)

-- Terminal
keymap("n", "<leader>v", "<Cmd>ToggleTerm direction=vertical   size=70<CR>",
  { noremap = true, silent = true, desc = "ToggleTerm vertical" })
keymap("n", "<leader>V", "<Cmd>ToggleTerm direction=horizontal size=10<CR>",
  { noremap = true, silent = true, desc = "ToggleTerm horizontal" })

-- Window Swap
keymap("t", "<C-x>", "<C-\\><C-n>:call WinBufSwap()<cr><Esc><cmd>set number<cr>", opts)

-- Visual Paste/ForwardPaste from secondary clipboard
keymap("v", "<leader>p", '"*p', { noremap = true, silent = true, desc = "Paste Unaltered (second_clip)" })
keymap("v", "<leader>P", 'g_"*P', { noremap = true, silent = true, desc = "Forward Paste (second_clip)" })

-- Visual Copy/Append to secondary clipboard
keymap("v", "<leader>y", '"*y', { noremap = true, silent = true, desc = "Copy (second_clip)" })
keymap("v", "<leader>Y", 'y:let @* .= @0<cr>', { noremap = true, silent = true, desc = "Copy Append (second_clip)" })

-- Visual Fold (Vjzf: create fold, zj/zk: next/previous fold), FormatColumn and FormatComment
keymap("v", "<leader>z", ":'<,'>fold      <CR>", { noremap = true, silent = true, desc = "Fold" })
keymap("v", "<leader>Z", ":'<,'>!column -t<CR>", { noremap = true, silent = true, desc = "Format Column" })
keymap("v", "<leader>gw", "gw", { noremap = true, silent = true, desc = "Format Comment" })
map("n", "zR", function() require("ufo").openAllFolds() end, { noremap = true, silent = true, desc = "Open All Folds" })
map("n", "zM", function() require("ufo").closeAllFolds() end, { noremap = true, silent = true, desc = "Close All Folds" })

-- Visual increment/decrement numbers
keymap("v", "<leader>gi", "g<C-a>", { noremap = true, silent = true, desc = "Increment numbers" })
keymap("v", "<leader>gd", "g<C-x>", { noremap = true, silent = true, desc = "Decrement numbers" })

-- ╭──────────────────╮
-- │ Lspsaga mappings │
-- ╰──────────────────╯

map("v", "gza", "<cmd>Lspsaga code_action<CR>", { silent = true })
map("n", "gsa", "<cmd>Lspsaga code_action<CR>", { silent = true })
map("n", "gsb", "<cmd>Lspsaga show_buf_diagnostics<CR>", { silent = true })
map("n", "gsc", "<cmd>Lspsaga incoming_calls<CR>", { silent = true })
map("n", "gsC", "<cmd>Lspsaga outgoing_calls<CR>", { silent = true })
map("n", "gsd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
map("n", "gsD", "<cmd>Lspsaga goto_definition<CR>", { silent = true })
map("n", "gsf", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
map("n", "gsh", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
map("n", "gsn", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })
map("n", "gsN", function() require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR }) end,
  { silent = true, desc = "Lspsaga Next Error" })
map("n", "gso", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })
map("n", "gsO", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })
map("n", "gsp", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
map("n", "gsP", function() require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR }) end,
  { silent = true, desc = "Lspsaga Prev Error" })
map("n", "gsr", "<cmd>Lspsaga term_toggle ranger<CR>", { silent = true })
map("n", "gsR", "<cmd>Lspsaga rename<CR>", { silent = true })
map("n", "gsz", "<cmd>LSpsaga outline<CR>", { silent = true })
map({ "n", "t" }, "<M-x>", "<cmd>Lspsaga term_toggle<CR>", { silent = true })

-- ╭──────────────╮
-- │ Text Objects │
-- ╰──────────────╯

-- _between_chars_(inline-autojump_unsupported)_(multiline-autojump_unsupported)_(next/prev_autojump_unsupported)_(like_targets.vim)
-- local chars = { '_', '.', ':', ',', ';', '|', '/', '\\', '*', '+', '%', '`', '?', '=' }
-- for _,char in ipairs(chars) do
--   for _,mode in ipairs({ 'x', 'o' }) do
--     vim.api.nvim_set_keymap(mode, "i" .. char, string.format(':<C-u>normal! T%svt%s<CR>', char, char, char), { noremap = true, silent = true })
--     vim.api.nvim_set_keymap(mode, "a" .. char, string.format(':<C-u>normal! F%svf%s<CR>', char, char, char), { noremap = true, silent = true })
--   end
-- end

-- _goto_textobj_(dotrepeat)
map('n', "g.", function() return GotoTextObj("") end, { expr = true, silent = true, desc = "StartOf TextObj" })
map('n', "g:", function() return GotoTextObj(":normal `[v`]<cr><esc>") end,
  { expr = true, silent = true, desc = "EndOf TextObj" })

-- https://www.reddit.com/r/vim/comments/xnuaxs/last_change_text_object
-- keymap("v", 'im', '<Esc>u<C-r>vgi', opts)            -- <left> unsupported
-- keymap("v", 'im', '<Esc>u<C-r>v`^<Left>', opts)      -- new-lines unsupported
keymap("o", 'gm', "<cmd>normal! `[v`]<cr>", { silent = true, desc = "Last change textobj" })
keymap("x", 'gm', "`[o`]", { silent = true, desc = "Last change textobj" })

-- _git_hunk_(next/prev_autojump_unsupported)
map({ 'o', 'x' }, 'gh', ':<C-U>Gitsigns select_hunk<CR>', { silent = true, desc = "Git hunk textobj" })

-- _jump_to_last_change
map({ "n", "o", "x" }, "gl", "`.", { silent = true, desc = "Jump to last change" })

-- _mini_comment_(not_showing_desc)_(next/prev_autojump_unsupported)
-- map({ "o" }, 'gk', '<cmd>lua MiniComment.textobject()<cr>', { silent = true, desc = "BlockComment textobj" })
-- map({ "x" }, 'gk', ':<c-u>normal "zygkgv<cr>', { silent = true, desc = "BlockComment textobj" })
map({ "o", "x" }, "gc", "<cmd>lua require('various-textobjs').multiCommentedLines()<cr>", { silent = true, desc = "BlockComment textobj" })
map({ "n" }, "vgc", "<cmd>lua require('various-textobjs').multiCommentedLines()<cr>", { silent = true, desc = "BlockComment textobj" })
map({ "x" }, 'gK', '<cmd>lua MiniComment.textobject()<cr>', { silent = true, desc = "RestOfComment textobj" })
map({ "o" }, 'gK', ':<c-u>normal vgK<cr>', { silent = true, desc = "RestOfComment textobj" })

-- _search_textobj_(dot-repeat_supported)
map({ "o", "x" }, "gs", "gn", { noremap = true, silent = true, desc = "Next search textobj" })
map({ "o", "x" }, "gS", "gN", { noremap = true, silent = true, desc = "Prev search textobj" })

-- _replace_textobj_(repeable_with_cgs_+_dotrepeat_supported)
map({ 'x' }, 'g/', '"zy:s/<C-r>z//g<Left><Left>', { silent = true, desc = "Replace textobj" })

-- _nvim_various_textobjs
map({ "o", "x" }, "gd", "<cmd>lua require('various-textobjs').diagnostic()<cr>",
  { silent = true, desc = "Diagnostic textobj" })
map({ "o", "x" }, "gL", "<cmd>lua require('various-textobjs').nearEoL()<cr>",
  { silent = true, desc = "nearEoL textobj" })
map({ "o", "x" }, "g_", "<cmd>lua require('various-textobjs').lineCharacterwise()<CR>",
  { silent = true, desc = "lineCharacterwise textobj" })
map({ "o", "x" }, "g|", "<cmd>lua require('various-textobjs').column()<cr>",
  { silent = true, desc = "ColumnDown textobj" })
map({ "o", "x" }, "gr", "<cmd>lua require('various-textobjs').restOfParagraph()<cr>",
  { silent = true, desc = "RestOfParagraph textobj" })
map({ "o", "x" }, "gR", "<cmd>lua require('various-textobjs').restOfIndentation()<cr>",
  { silent = true, desc = "restOfIndentation textobj" })
map({ "o", "x" }, "gG", "<cmd>lua require('various-textobjs').entireBuffer()<cr>",
  { silent = true, desc = "EntireBuffer textobj" })
map({ "o", "x" }, "gu", "<cmd>lua require('various-textobjs').url()<cr>",
  { silent = true, desc = "Url textobj" })

-- _nvim_various_textobjs: inner-outer
-- map({ "o", "x" }, "av", "<cmd>lua require('various-textobjs').value(false)<cr>")
-- map({ "o", "x" }, "iv", "<cmd>lua require('various-textobjs').value(true)<cr>")
-- map({ "o", "x" }, "ak", "<cmd>lua require('various-textobjs').key(false)<cr>")
-- map({ "o", "x" }, "ik", "<cmd>lua require('various-textobjs').key(true)<cr>")
-- map({ "o", "x" }, "an", "<cmd>lua require('various-textobjs').number(false)<cr>")
-- map({ "o", "x" }, "in", "<cmd>lua require('various-textobjs').number(true)<cr>")
-- map({ "o", "x" }, "al", "<cmd>lua require('various-textobjs').mdlink(false)<cr>")
-- map({ "o", "x" }, "il", "<cmd>lua require('various-textobjs').mdlink(true)<cr>")
-- map({ "o", "x" }, "aC", "<cmd>lua require('various-textobjs').mdFencedCodeBlock(false)<cr>")
-- map({ "o", "x" }, "iC", "<cmd>lua require('various-textobjs').mdFencedCodeBlock(true)<cr>")
-- map({ "o", "x" }, "ac", "<cmd>lua require('various-textobjs').cssSelector(false)<cr>")
-- map({ "o", "x" }, "ic", "<cmd>lua require('various-textobjs').cssSelector(true)<cr>")
-- map({ "o", "x" }, "a/", "<cmd>lua require('various-textobjs').jsRegex(false)<cr>")
-- map({ "o", "x" }, "i/", "<cmd>lua require('various-textobjs').jsRegex(true)<cr>")
-- map({ "o", "x" }, "aD", "<cmd>lua require('various-textobjs').doubleSquareBrackets(false)<cr>")
-- map({ "o", "x" }, "iD", "<cmd>lua require('various-textobjs').doubleSquareBrackets(true)<cr>")

map({ "o", "x" }, "am", "<cmd>lua require('various-textobjs').chainMember(false)<CR>",
  { silent = true, desc = "inner chainMember textobj" })
map({ "o", "x" }, "im", "<cmd>lua require('various-textobjs').chainMember(true)<CR>",
  { silent = true, desc = "inner chainMember textobj" })
map({ "o", "x" }, "aS", "<cmd>lua require('various-textobjs').subword(false)<cr>",
  { silent = true, desc = "outer Subword textobj" })
map({ "o", "x" }, "iS", "<cmd>lua require('various-textobjs').subword(true)<cr>",
  { silent = true, desc = "inner Subword textobj" })
map({ "o", "x" }, "aZ", "<cmd>lua require('various-textobjs').closedFold(false)<CR>",
  { silent = true, desc = "outer ClosedFold textobj" })
map({ "o", "x" }, "iZ", "<cmd>lua require('various-textobjs').closedFold(true)<CR>",
  { silent = true, desc = "inner ClosedFold textobj" })

-- _fold_textobj
-- https://superuser.com/questions/578432/can-vim-treat-a-folded-section-as-a-motion
keymap("x", 'iz', ":<C-U>silent!normal![zjV]zk<CR>", { silent = true, desc = "inner fold textobj" })
keymap("o", 'iz', ":normal Vif<CR>", { silent = true, desc = "inner fold textobj" })
keymap("x", 'az', ":<C-U>silent!normal![zV]z<CR>", { silent = true, desc = "outer fold textobj" })
keymap("o", 'az', ":normal Vaf<CR>", { silent = true, desc = "outer fold textobj" })

-- _nvim_various_textobjs: indentation textobj requires two parameters, first for
-- exclusion of the starting border, second for the exclusion of ending border
-- _vim_indent_object_(incrementalrepressing_+_visualrepeatable_+_vimrepeat_+_respectingblanklines_+_norespectslastblanklines(selectblanklines is vip))
map({ "o", "x" }, "ii", '<cmd>lua require("various-textobjs").indentation("inner", "inner", "noBlanks")<cr>', { desc = "inner noblanks indentation textobj" })
map({ "o", "x" }, "ai", '<cmd>lua require("various-textobjs").indentation("outer", "outer", "noBlanks")<cr>', { desc = "outer noblanks indentation textobj" })
map({ "o", "x" }, "iI", '<cmd>lua require("various-textobjs").indentation("inner", "inner")<cr>', { desc = "inner indentation textobj" })
map({ "o", "x" }, "aI", '<cmd>lua require("various-textobjs").indentation("outer", "outer")<cr>', { desc = "outer indentation textobj" })

-- -- _vim_indent_object_(incrementalrepressing_+_visualrepeatable_+_vimrepeat_+_notrespectingblanklines_+_respectslastblanklines(selectblanklines is vip))
-- -- _as_autocommand_since_vim-indent-object_overwrites_it
-- vim.api.nvim_create_autocmd({ "FileType" }, {
--   pattern = "*",
--   callback = function()
--     map({ "o", "x" }, "iI", "<Cmd>lua MiniIndentscope.textobject(false)<CR>",
--       { silent = true, desc = "MiniIndentscope_noborders" })
--     map({ "o", "x" }, "aI", "<Cmd>lua MiniIndentscope.textobject(true)<CR>",
--       { silent = true, desc = "MiniIndentscope_withborders" })
--   end
-- })

-- Indented Paragraph textobj:
-- map({ "o", "x" }, 'ii', '<Plug>(textobj-indentedparagraph-i)', { silent = true, desc = "MiniIndentscope bordersless blankline_wise" })
-- map({ "x" }, 'ai', '<Plug>(textobj-indentedparagraph-i)jok', { silent = true, desc = "MiniIndentscope borders blankline_wise" })
-- map({ "o" }, 'ai', ':<C-u>normal vai<cr>', { silent = true, desc = "MiniIndentscope borders blankline_wise" })
-- map({ "o", "x" }, "iI", "<Cmd>lua MiniIndentscope.textobject(false)<CR>", { silent = true, desc = "MiniIndentscope bordersless blankline_skip" })
-- map({ "o", "x" }, "aI", "<Cmd>lua MiniIndentscope.textobject(true)<CR>", { silent = true, desc = "MiniIndentscope borders blankline_skip" })

-- Mini Indent Scope textobj:
-- map({ "o", "x" }, "ii", function() require("mini.ai").select_textobject("i","i") end, { silent = true, desc = "MiniIndentscope bordersless blankline_wise" })
-- map({ "x" }, "ai", function() require("mini.ai").select_textobject("i","i") vim.cmd [[ normal koj ]] end, { silent = true, desc = "MiniIndentscope borders blankline_wise" })
-- map({ "o" }, 'ai', ':<C-u>normal vai<cr>', { silent = true, desc = "MiniIndentscope borders blankline_wise" })
-- map({ "o", "x" }, "iI", "<Cmd>lua MiniIndentscope.textobject(false)<CR>", { silent = true, desc = "MiniIndentscope bordersless blankline_skip" })
-- map({ "o", "x" }, "aI", "<Cmd>lua MiniIndentscope.textobject(true)<CR>", { silent = true, desc = "MiniIndentscope borders blankline_skip" })

-- braces linewise textobj:
-- vim.cmd [[
--   xnoremap iy aB$o0
--   onoremap iy :normal! vaB$o0<cr>
-- ]]
-- keymap("x", 'iy', "aB$o0", { silent = true, desc = "" })
-- keymap("o", 'iy', "<cmd>normal vaB$o0<cr>", { silent = true, desc = "" })

-- -- _vim-textobj-indent_(noincrementalrepressing_+_visualrepeatable_+_vimrepeat_+_respectingblanklines_+_norespectslastblanklines(selectblanklines is vip))
-- map({ "o", "x" }, "iy", "<Plug>(textobj-indent-i)", { silent = true, desc = "indent nosamelevel noblankline textobj" })
-- map({ "o", "x" }, "ay", "<Plug>(textobj-indent-a)", { silent = true, desc = "indent nosamelevel blankline textobj" })
-- map({ "o", "x" }, "iY", "<Plug>(textobj-indent-same-i)", { silent = true, desc = "indent samelevel noblankline textobj" })
-- map({ "o", "x" }, "aY", "<Plug>(textobj-indent-same-a)", { silent = true, desc = "indent samelevel blankline textobj" })

-- indent same level textobj:
map({"x","o"}, "iy", ":<c-u> lua require('user.autocommands').select_indent(false)<cr>", { silent = true, desc = "indent_samelevel_noblankline textobj" })
map({"x","o"}, "ay", ":<c-u> lua require('user.autocommands').select_indent(true)<cr>", { silent = true, desc = "indent_samelevel_blankline textobj" })

-- _clipboard_textobj_(vim.g defined in options.lua)
-- vim.g.EasyClipEnableBlackHoleRedirect = false
map({ "n", "x" }, "gx", '"_d', { silent = true, desc = "Blackhole Motion/Selected" })
map({ "n" }, "gxx", '"_dd', { silent = true, desc = "Blackhole line" })

-- vim.g.EasyClipUseCutDefaults = false
-- map({ "n" }, "gX", "<plug>MoveMotionPlug", { silent = true, desc = "noBlackhole Motion" }) -- same as "Delete + motion" if EasyClipEnableBlackHoleRedirect is disabled
-- map({ "n" }, "gXX", "<plug>MoveMotionLinePlug", { silent = true, desc = "noBlackhole Line" }) -- same as "dd" if EasyClipEnableBlackHoleRedirect is disabled
-- map({ "x" }, "gX", "<plug>MoveMotionXPlug", { silent = true, desc = "noBlackhole Selected" }) -- same as "d" if EasyClipEnableBlackHoleRedirect is disabled

-- Search Register:
map({ "n" }, "gX", '"/p', { silent = true, desc = "Search register" })

-- vim.g.EasyClipUseYankDefaults = false
map({ "n" }, "gy", "<plug>SubstituteOverMotionMap", { silent = true, desc = "Substitute Motion" })
map({ "n" }, "gyy", "<plug>SubstituteLine", { silent = true, desc = "Substitute Line" })
map({ "x" }, "gy", "<plug>XEasyClipPaste ", { silent = true, desc = "Substitute Selected" })

-- vim.g.EasyClipUsePasteDefaults = false
map({ "n" }, "gY", "<plug>G_EasyClipPasteBefore", { silent = true, desc = "Paste Preserving cursor position" })
map({ "x" }, "gY", "<plug>XG_EasyClipPaste ", { silent = true, desc = "Paste Preserving cursor position" })

-- vim.g.EasyClipUsePasteToggleDefaults = false
-- map({ "n" }, "gz", "<plug>EasyClipSwapPasteForward", { silent = true, desc = "Paste Swapping register Forward" }) -- replaced by neoclip since has a tui
-- map({ "n" }, "gZ", "<plug>EasyClipSwapPasteBackwards ", { silent = true, desc = "Paste Swapping register Backwards" }) -- replaced by neoclip since has a tui

-- Redo Register:
map({ "n" }, "gz", '"1p', { silent = true, desc = "Redo register (dot to Paste forward the rest of register)" })
map({ "n" }, "gZ", '"1P', { silent = true, desc = "Redo register (dot to Paste backward the rest of register)" })

-- ╭─────────╮
-- │ Motions │
-- ╰─────────╯

-- _normal_mode_(easymotion-like)
keymap("n", "<Leader><Leader>J", "<cmd>HopWordAC<CR>", opts)
keymap("n", "<Leader><Leader>K", "<cmd>HopWordBC<CR>", opts)
keymap("n", "<Leader><Leader>j", "<cmd>HopLineStartAC<CR>", opts)
keymap("n", "<Leader><Leader>k", "<cmd>HopLineStartBC<CR>", opts)
keymap("n", "<Leader><Leader>/", "<cmd>HopPattern<CR>", opts)

-- _visual_mode_(easymotion-like)
keymap("v", "<Leader><Leader>J", "<cmd>HopWordAC<CR>", opts)
keymap("v", "<Leader><Leader>K", "<cmd>HopWordBC<CR>", opts)
keymap("v", "<Leader><Leader>j", "<cmd>HopLineStartAC<CR>", opts)
keymap("v", "<Leader><Leader>k", "<cmd>HopLineStartBC<CR>", opts)
keymap("v", "<Leader><Leader>/", "<cmd>HoPattern<CR>", opts)

-- _normal_mode_(sneak-like)
keymap("n", "<Leader><Leader>z", "<cmd>HopChar2AC<CR>", opts)
keymap("n", "<Leader><Leader>Z", "<cmd>HopChar2BC<CR>", opts)

-- _visual_mode_(sneak-like)
keymap("v", "<Leader><Leader>z", "<cmd>HopChar2AC<CR>", opts)
keymap("v", "<Leader><Leader>Z", "<cmd>HopChar2BC<CR>", opts)

-- _sneak_keymaps
map("n", "f", "<Plug>Sneak_f", opts)
map("n", "F", "<Plug>Sneak_F", opts)
map("n", "t", "<Plug>Sneak_t", opts)
map("n", "T", "<Plug>Sneak_T", opts)
map("n", "<Tab>", "sneak#is_sneaking() ? '<Plug>SneakLabel_s<cr>' : ':bnext<cr>' ", { expr = true, silent = true })
map("n", "<S-Tab>", "sneak#is_sneaking() ? '<Plug>SneakLabel_S<cr>' : ':bprevious<cr>' ", { expr = true, silent = true })
map({ "x", "o" }, "<Tab>", "<Plug>SneakLabel_s<cr>", opts)
map({ "x", "o" }, "<S-Tab>", "<Plug>SneakLabel_S<cr>", opts)

-- ╭────────────╮
-- │ Repeatable │
-- ╰────────────╯

-- _nvim-treesitter-textobjs_repeatable
-- ensure ; goes forward and , goes backward regardless of the last direction
local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"
map({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next, { silent = true, desc = "Next TS textobj" })
map({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous, { silent = true, desc = "Prev TS textobj" })

-- _sneak_repeatable
vim.cmd [[ command SneakForward execute "normal \<Plug>Sneak_;" ]]
vim.cmd [[ command SneakBackward execute "normal \<Plug>Sneak_," ]]
local next_sneak, prev_sneak = ts_repeat_move.make_repeatable_move_pair(
  function() vim.cmd [[ SneakForward ]] end,
  function() vim.cmd [[ SneakBackward ]] end
)
map({ "n", "x", "o" }, "<BS>", next_sneak, { silent = true, desc = "Next SneakForward" })
map({ "n", "x", "o" }, "<S-BS>", prev_sneak, { silent = true, desc = "Prev SneakForward" })

-- _goto_next_indent_repeatable
vim.cmd [[ command NextIndentedParagraph execute "normal \<Plug>(textobj-indentedparagraph-n)" ]]
vim.cmd [[ command PrevIndentedParagraph execute "normal \<Plug>(textobj-indentedparagraph-p)" ]]
local next_indentedparagraph, prev_indentedparagraph = ts_repeat_move.make_repeatable_move_pair(
  function() vim.cmd [[ NextIndentedParagraph ]] end,
  function() vim.cmd [[ PrevIndentedParagraph ]] end
)
map({ "n", "x", "o" }, "gni", next_indentedparagraph, { silent = true, desc = "Next IndentedParagraph" })
map({ "n", "x", "o" }, "gpi", prev_indentedparagraph, { silent = true, desc = "Prev IndentedParagraph" })

-- _goto_indent_samelevel_blankline_repeatable
local next_indent, prev_indent = ts_repeat_move.make_repeatable_move_pair(
  function() require("user.autocommands").next_indent(true) end,
  function() require("user.autocommands").next_indent(false) end
)
map({ "n", "x", "o" }, "gny", next_indent, { silent = true, desc = "next indent_samelevel_blankline" })
map({ "n", "x", "o" }, "gpy", prev_indent, { silent = true, desc = "prev indent_samelevel_blankline" })

-- _goto_diagnostic_repeatable
local next_diagnostic, prev_diagnostic = ts_repeat_move.make_repeatable_move_pair(
  function() vim.diagnostic.goto_next({ border = "rounded" }) end,
  function() vim.diagnostic.goto_prev({ border = "rounded" }) end
)
map({ "n", "x", "o" }, "gnd", next_diagnostic, { silent = true, desc = "Next Diagnostic" })
map({ "n", "x", "o" }, "gpd", prev_diagnostic, { silent = true, desc = "Prev Diagnostic" })

-- _goto_function_definition_repeatable
local next_funcdefinition, prev_funcdefinition = ts_repeat_move.make_repeatable_move_pair(
  function() vim.cmd [[ normal vaNf ]] vim.cmd [[ call feedkeys("") ]] end,
  function() vim.cmd [[ normal valf ]] vim.cmd [[ call feedkeys("") ]] end
)
map({ "n", "x", "o" }, "gnf", next_funcdefinition, { silent = true, desc = "Next FuncDefinition" })
map({ "n", "x", "o" }, "gpf", prev_funcdefinition, { silent = true, desc = "Prev FuncDefinition" })

-- _gitsigns_chunck_repeatable
-- make sure forward function comes first
-- Or, use `make_repeatable_move` or `set_last_move` functions for more control. See the code for instructions.
local gs = require("gitsigns")
local next_hunk_repeat, prev_hunk_repeat = ts_repeat_move.make_repeatable_move_pair(gs.next_hunk, gs.prev_hunk)
map({ "n", "x", "o" }, "gnh", next_hunk_repeat, { silent = true, desc = "Next GitHunk" })
map({ "n", "x", "o" }, "gph", prev_hunk_repeat, { silent = true, desc = "Prev GitHunk" })

-- _goto_quotes_repeatable
local next_quote, prev_quote = ts_repeat_move.make_repeatable_move_pair(
  function() vim.cmd [[ normal viNu ]] vim.cmd [[ call feedkeys("") ]] end,
  function() vim.cmd [[ normal vilu ]] vim.cmd [[ call feedkeys("") ]] end
)
map({ "n", "x", "o" }, "gnu", next_quote, { silent = true, desc = "Next Quote" })
map({ "n", "x", "o" }, "gpu", prev_quote, { silent = true, desc = "Prev Quote" })

-- _columnmove_repeatable
vim.g.columnmove_strict_wbege = 0 -- skips inner-paragraph whitespaces for wbege
vim.g.columnmove_no_default_key_mappings = true
map({ "n", "o", "x" }, "<leader><leader>f", "<Plug>(columnmove-f)", { silent = true })
map({ "n", "o", "x" }, "<leader><leader>t", "<Plug>(columnmove-t)", { silent = true })
map({ "n", "o", "x" }, "<leader><leader>F", "<Plug>(columnmove-F)", { silent = true })
map({ "n", "o", "x" }, "<leader><leader>T", "<Plug>(columnmove-T)", { silent = true })

local next_columnmove, prev_columnmove = ts_repeat_move.make_repeatable_move_pair(
  function() vim.cmd [[ execute "normal \<Plug>(columnmove-;)" ]] end,
  function() vim.cmd [[ execute "normal \<Plug>(columnmove-,)" ]] end
)
map({ "n", "x", "o" }, "<leader><leader>;", next_columnmove, { silent = true, desc = "Next ColumnMove_;" })
map({ "n", "x", "o" }, "<leader><leader>,", prev_columnmove, { silent = true, desc = "Prev ColumnMove_," })

local next_columnmove_w, prev_columnmove_b = ts_repeat_move.make_repeatable_move_pair(
  function() vim.cmd [[ execute "normal \<Plug>(columnmove-w)" ]] end,
  function() vim.cmd [[ execute "normal \<Plug>(columnmove-b)" ]] end
)
map({ "n", "x", "o" }, "<leader><leader>w", next_columnmove_w, { silent = true, desc = "Next ColumnMove_w" })
map({ "n", "x", "o" }, "<leader><leader>b", prev_columnmove_b, { silent = true, desc = "Prev ColumnMove_b" })

local next_columnmove_e, prev_columnmove_ge = ts_repeat_move.make_repeatable_move_pair(
  function() vim.cmd [[ execute "normal \<Plug>(columnmove-e)" ]] end,
  function() vim.cmd [[ execute "normal \<Plug>(columnmove-ge)" ]] end
)
map({ "n", "x", "o" }, "<leader><leader>e", next_columnmove_e, { silent = true, desc = "Next ColumnMove_e" })
map({ "n", "x", "o" }, "<leader><leader>ge", prev_columnmove_ge, { silent = true, desc = "Prev ColumnMove_ge" })

local next_columnmove_W, prev_columnmove_B = ts_repeat_move.make_repeatable_move_pair(
  function() vim.cmd [[ execute "normal \<Plug>(columnmove-W)" ]] end,
  function() vim.cmd [[ execute "normal \<Plug>(columnmove-B)" ]] end
)
map({ "n", "x", "o" }, "<leader><leader>W", next_columnmove_W, { silent = true, desc = "Next ColumnMove_W" })
map({ "n", "x", "o" }, "<leader><leader>B", prev_columnmove_B, { silent = true, desc = "Prev ColumnMove_B" })

local next_columnmove_E, prev_columnmove_gE = ts_repeat_move.make_repeatable_move_pair(
  function() vim.cmd [[ execute "normal \<Plug>(columnmove-E)" ]] end,
  function() vim.cmd [[ execute "normal \<Plug>(columnmove-gE)" ]] end
)
map({ "n", "x", "o" }, "<leader><leader>E", next_columnmove_E, { silent = true, desc = "Next ColumnMove_E" })
map({ "n", "x", "o" }, "<leader><leader>gE", prev_columnmove_gE, { silent = true, desc = "Prev ColumnMove_gE" })

-- _jump_blankline_repeatable
local next_blankline, prev_blankline = ts_repeat_move.make_repeatable_move_pair(
  function() vim.cmd [[ normal } ]] end,
  function() vim.cmd [[ normal { ]] end
)
map({ "n", "x", "o" }, "<leader><leader>}", next_blankline, { silent = true, desc = "Next Blankline" })
map({ "n", "x", "o" }, "<leader><leader>{", prev_blankline, { silent = true, desc = "Prev Blankline" })

-- _jump_paragraph_repeatable
local next_paragraph, prev_paragraph = ts_repeat_move.make_repeatable_move_pair(
  function() vim.cmd [[ normal )) ]] end,
  function() vim.cmd [[ normal (( ]] end
)
map({ "n", "x", "o" }, "<leader><leader>)", next_paragraph, { silent = true, desc = "Next Paragraph" })
map({ "n", "x", "o" }, "<leader><leader>(", prev_paragraph, { silent = true, desc = "Prev Paragraph" })

-- _jump_edgeindent_repeatable_blankline
local next_indent, prev_indent = ts_repeat_move.make_repeatable_move_pair(
  function() vim.cmd [[ normal viiV$ ]] end,
  function() vim.cmd [[ normal viio ]] FeedKeysCorrectly('<esc>_') end
)
map({ "n", "x", "o" }, "<leader><leader>a", next_indent, { silent = true, desc = "End Indent" })
map({ "n", "x", "o" }, "<leader><leader>i", prev_indent, { silent = true, desc = "Start Indent" })

-- _jump_edgeindent_repeatable_noblankline
local next_indent, prev_indent = ts_repeat_move.make_repeatable_move_pair(
  function() vim.cmd [[ normal viIV$ ]] end,
  function() vim.cmd [[ normal viIo ]] FeedKeysCorrectly('<esc>_') end
)
map({ "n", "x", "o" }, "<leader><leader>A", next_indent, { silent = true, desc = "End Indent" })
map({ "n", "x", "o" }, "<leader><leader>I", prev_indent, { silent = true, desc = "Start Indent" })

-- _jump_edgefold_repeatable
local next_fold, prev_fold = ts_repeat_move.make_repeatable_move_pair(
  function() vim.cmd [[ normal ]z ]] end,
  function() vim.cmd [[ normal [z ]] end
)
map({ "n", "x", "o" }, "<leader><leader>]", next_fold, { silent = true, desc = "End Fold" })
map({ "n", "x", "o" }, "<leader><leader>[", prev_fold, { silent = true, desc = "Start Fold" })

-- _jump_startofline_repeatable
local next_startline, prev_startline = ts_repeat_move.make_repeatable_move_pair(
  function() vim.cmd [[ normal + ]] end,
  function() vim.cmd [[ normal - ]] end
)
map({ "n", "x", "o" }, "<leader><leader>+", next_startline, { silent = true, desc = "Next StartLine" })
map({ "n", "x", "o" }, "<leader><leader>-", prev_startline, { silent = true, desc = "Prev StartLine" })

-- _number_textobj_(goto_repeatable)
local next_inner_hex, prev_inner_hex = ts_repeat_move.make_repeatable_move_pair(
  function() require("mini.ai").move_cursor('left', 'i', 'x', { search_method = 'next' }) end,
  function() require("mini.ai").move_cursor('left', 'i', 'x', { search_method = 'prev' }) end
)
map({ "n", "x", "o" }, "gnx", next_inner_hex, { silent = true, desc = "Next Inner Hex" })
map({ "n", "x", "o" }, "gpx", prev_inner_hex, { silent = true, desc = "Prev Inner Hex" })

local next_around_hex, prev_around_hex = ts_repeat_move.make_repeatable_move_pair(
  function() require("mini.ai").move_cursor('left', 'a', 'x', { search_method = 'next' }) end,
  function() require("mini.ai").move_cursor('left', 'a', 'x', { search_method = 'prev' }) end
)
map({ "n", "x", "o" }, "gNx", next_around_hex, { silent = true, desc = "Next Around Hex" })
map({ "n", "x", "o" }, "gPx", prev_around_hex, { silent = true, desc = "Prev Around Hex" })

-- hexadecimalcolor_textobj_(goto_repeatable)
local next_inner_numeral, prev_inner_numeral = ts_repeat_move.make_repeatable_move_pair(
  function() require("mini.ai").move_cursor('left', 'i', 'n', { search_method = 'next' }) end,
  function() require("mini.ai").move_cursor('left', 'i', 'n', { search_method = 'prev' }) end
)
map({ "n", "x", "o" }, "gnn", next_inner_numeral, { silent = true, desc = "Next Inner Number" })
map({ "n", "x", "o" }, "gpn", prev_inner_numeral, { silent = true, desc = "Prev Inner Number" })

local next_around_numeral, prev_around_numeral = ts_repeat_move.make_repeatable_move_pair(
  function() require("mini.ai").move_cursor('left', 'a', 'n', { search_method = 'next' }) end,
  function() require("mini.ai").move_cursor('left', 'a', 'n', { search_method = 'prev' }) end
)
map({ "n", "x", "o" }, "gNn", next_around_numeral, { silent = true, desc = "Next Around Number" })
map({ "n", "x", "o" }, "gPn", prev_around_numeral, { silent = true, desc = "Prev Around Number" })

-- _vert_horz_incremental_(goto_repeatable)
local vert_increment, vert_decrement = ts_repeat_move.make_repeatable_move_pair(
  function() vim.cmd [[ normal "zyanjvan"zp ]] FeedKeysCorrectly('<C-a>') end,
  function() vim.cmd [[ normal "zyanjvan"zp ]] FeedKeysCorrectly('<C-x>') end
)
map({ "n" }, "g+", vert_increment, { silent = true, desc = "Vert Increment" })
map({ "n" }, "g-", vert_decrement, { silent = true, desc = "Vert Decrement" })

local horz_increment, horz_decrement = ts_repeat_move.make_repeatable_move_pair(
  function() vim.cmd [[ normal "zyanvaNn"zp ]] FeedKeysCorrectly('<C-a>') end,
  function() vim.cmd [[ normal "zyanvaNn"zp ]] FeedKeysCorrectly('<C-x>') end
)
map({ "n" }, "gn+", horz_increment, { silent = true, desc = "Horz increment" })
map({ "n" }, "gn-", horz_decrement, { silent = true, desc = "Horz Decrement" })

-- _key_textobj_(goto_repeatable)
local next_inner_key, prev_inner_key = ts_repeat_move.make_repeatable_move_pair(
  function() require("mini.ai").move_cursor('left', 'i', 'k', { search_method = 'next' }) end,
  function() require("mini.ai").move_cursor('left', 'i', 'k', { search_method = 'prev' }) end
)
map({ "n", "x", "o" }, "gnk", next_inner_key, { silent = true, desc = "Next Inner Key" })
map({ "n", "x", "o" }, "gpk", prev_inner_key, { silent = true, desc = "Prev Inner Key" })

local next_around_key, prev_around_key = ts_repeat_move.make_repeatable_move_pair(
  function() require("mini.ai").move_cursor('left', 'a', 'k', { search_method = 'next' }) end,
  function() require("mini.ai").move_cursor('left', 'a', 'k', { search_method = 'prev' }) end
)
map({ "n", "x", "o" }, "gNk", next_around_key, { silent = true, desc = "Next Around Key" })
map({ "n", "x", "o" }, "gNk", prev_around_key, { silent = true, desc = "Prev Around Key" })

-- _value_textobj_(goto_repeatable)
local next_inner_value, prev_inner_value = ts_repeat_move.make_repeatable_move_pair(
  function() require("mini.ai").move_cursor('left', 'i', 'v', { search_method = 'next' }) end,
  function() require("mini.ai").move_cursor('left', 'i', 'v', { search_method = 'prev' }) end
)
map({ "n", "x", "o" }, "gnv", next_inner_value, { silent = true, desc = "Next Inner Value" })
map({ "n", "x", "o" }, "gpv", prev_inner_value, { silent = true, desc = "Prev Inner Value" })

local next_around_value, prev_around_value = ts_repeat_move.make_repeatable_move_pair(
  function() require("mini.ai").move_cursor('left', 'a', 'v', { search_method = 'next' }) end,
  function() require("mini.ai").move_cursor('left', 'a', 'v', { search_method = 'prev' }) end
)
map({ "n", "x", "o" }, "gNv", next_around_value, { silent = true, desc = "Next Around Value" })
map({ "n", "x", "o" }, "gNv", prev_around_value, { silent = true, desc = "Prev Around Value" })

-- _comment_(goto_repeatable)
local next_comment, prev_comment = ts_repeat_move.make_repeatable_move_pair(
  function() require('mini.bracketed').comment('forward') end,
  function() require('mini.bracketed').comment('backward') end
)
map({ "n", "x", "o" }, "gnc", next_comment, { silent = true, desc = "Next Comment" })
map({ "n", "x", "o" }, "gpc", prev_comment, { silent = true, desc = "Prev Comment" })
