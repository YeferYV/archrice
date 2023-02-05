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
keymap("n", "<C-t>", "<C-t>", opts)

-- Resize with arrows
keymap("n", "<M-Up>", ":resize -2<CR>", opts)
keymap("n", "<M-Down>", ":resize +2<CR>", opts)
keymap("n", "<M-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<M-Right>", ":vertical resize +2<CR>", opts)
keymap("t", "<M-Up>", "<C-\\><C-n>:resize -2<CR>", opts)
keymap("t", "<M-Down>", "<C-\\><C-n>:resize +2<CR>", opts)
keymap("t", "<M-Left>", "<C-\\><C-n>:vertical resize -2<CR>", opts)
keymap("t", "<M-Right>", "<C-\\><C-n>:vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "]q", ":cnext<CR>", opts)
keymap("n", "[q", ":cprevious<CR>", opts)
keymap("n", "]l", ":lnext<CR>", opts)
keymap("n", "[l", ":lprevious<CR>", opts)
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
keymap("n", "<leader>x", ":bp | bd #<CR>", opts)
keymap("n", "<leader><Tab>", ":tabnext<CR>", opts)
keymap("n", "<leader><S-Tab>", ":tabprevious<CR>", opts)
keymap("n", "<leader>X", ":tabclose<CR>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down autoindented
-- keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
-- keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Replace all/visual_selected
map({ "n" }, "<C-s>", ":%s//g<Left><Left>", { noremap = true, silent = false })
map({ "x" }, "<C-s>", ":s//g<Left><Left>", { noremap = true, silent = false })

-- Intellisense
-- map("i", "<C-h>", "<Plug>(copilot-dismiss)", { expr = true })
-- map("i", "<C-j>", "<Plug>(copilot-next)", { expr = true })
-- map("i", "<C-k>", "<Plug>(copilot-previous)", { expr = true })
-- map("i", "<C-l>", function() return vim.fn['copilot#Accept']() end, { expr = true })
map('i', '<c-h>', function() return vim.fn['codeium#Clear']() end, { expr = true })
map('i', '<c-j>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
map('i', '<c-k>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
map('i', '<c-l>', function() return vim.fn['codeium#Accept']() end, { expr = true })

-- Quick Escape
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)
-- keymap("v", "jk", "<ESC>", opts) --slow
-- keymap("v", "kj", "<ESC>", opts) --slow

-- Quick quit/write
keymap("n", "<S-q>", "<cmd>quit<CR>", opts)
keymap("n", "<S-r>", "<cmd>lua vim.lsp.buf.format()<cr><cmd>write<cr>", opts)

-- Quick Jump
keymap("n", "J", "10j", opts)
keymap("n", "K", "10k", opts)
keymap("n", "H", "10h", opts)
keymap("n", "L", "10l", opts)

-- Forward yank/paste
keymap("n", 'Y', 'yg_', { noremap = true, silent = true, desc = "Forward yank" })
keymap("v", 'P', 'g_P', { noremap = true, silent = true, desc = "Forward Paste" }) -- "P" seems unaltered the clipboard

-- Unaltered clipboard
keymap("v", 'p', '"_dP', { noremap = true, silent = true, desc = "Paste Unaltered" })

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
keymap("n", "gy;", ":call CycleLastBuffer()<CR>", opts)
keymap("n", "gyl", "<C-6>", { noremap = true, silent = true, desc = "go to last buffer" })
keymap("n", "gys", "<Cmd>BufferLineCyclePrev <CR>", opts)
keymap("n", "gyf", "<Cmd>BufferLineCycleNext <CR>", opts)
keymap("n", "gyS", "<Cmd>BufferLineMovePrev <CR>", opts)
keymap("n", "gyF", "<Cmd>BufferLineMoveNext <CR>", opts)

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

-- Visual increment/decrement numbers
keymap("v", "<leader>gi", "g<C-a>", { noremap = true, silent = true, desc = "Increment numbers" })
keymap("v", "<leader>gd", "g<C-x>", { noremap = true, silent = true, desc = "Decrement numbers" })

-- ╭──────────────────╮
-- │ Lspsaga mappings │
-- ╰──────────────────╯

map({ "n", "v" }, "gsa", "<cmd>Lspsaga code_action<CR>", { silent = true })
map("n", "gsb", "<cmd>Lspsaga show_buf_diagnostics<CR>", { silent = true })
map("n", "gsc", "<cmd>Lspsaga incoming_calls<CR>")
map("n", "gsC", "<cmd>Lspsaga outgoing_calls<CR>")
map("n", "gsd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
map("n", "gsD", "<cmd>Lspsaga goto_definition<CR>", { silent = true })
map("n", "gsf", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
map("n", "gsh", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
map("n", "gsn", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })
map("n", "gsN", function() require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR }) end,
  { silent = true })
map("n", "gso", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })
map("n", "gsO", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })
map("n", "gsp", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
map("n", "gsP", function() require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR }) end,
  { silent = true })
map("n", "gsr", "<cmd>Lspsaga term_toggle ranger<CR>", { silent = true })
map("n", "gsR", "<cmd>Lspsaga rename<CR>", { silent = true })
map("n", "gsz", "<cmd>LSpsaga outline<CR>", { silent = true })
map({ "n", "t" }, "<M-x>", "<cmd>Lspsaga term_toggle<CR>")

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

-- https://www.reddit.com/r/vim/comments/xnuaxs/last_change_text_object
-- keymap("v", 'im', '<Esc>u<C-r>vgi', opts)            -- <left> unsupported
-- keymap("v", 'im', '<Esc>u<C-r>v`^<Left>', opts)      -- new-lines unsupported
keymap("o", 'gm', "<cmd>normal! `[v`]<Left><cr>", { desc = "Last change textobj" })
keymap("x", 'gm', "`[o`]<Left>", { desc = "Last change textobj" })

-- _replace_textobj_(repeable_with_cgn_+_dotrepeat_supported)
map({ 'x' }, 'gs', '"zy:s/<C-r>z//g<Left><Left>', { desc = "Replace textobj" })

-- _git_hunk_(next/prev_autojump_unsupported)
map({ 'o', 'x' }, 'gh', ':<C-U>Gitsigns select_hunk<CR>', { desc = "Git hunk textobj" })

-- _jump_to_last_change
map({ "n", "o", "x" }, "gl", "`.", { desc = "Jump to last change" })

-- _mini_comment_(not_showing_desc)_(next/prev_autojump_unsupported)
map({ "x" }, 'gk', ':<C-u>normal "zygcgv<cr>', { desc = "Comment textobj" })
map({ "x" }, 'gK', '<Cmd>lua MiniComment.textobject()<cr>', { desc = "RestOfComment textobj" })

-- _nvim_various_textobjs
map({ "o", "x" }, "gd", function() require("various-textobjs").diagnostic() vim.call("repeat#set", "vgd") end,
  { desc = "Diagnostic textobj" })
map({ "o", "x" }, "gL", function() require("various-textobjs").nearEoL() vim.call("repeat#set", "vgL") end,
  { desc = "nearEoL textobj" }) -- conflicts with visual until search-next workaround: gn
map({ "o", "x" }, "g|", function() require("various-textobjs").column() vim.call("repeat#set", "vg|") end,
  { desc = "ColumnDown textobj" })
map({ "o", "x" }, "gr", function() require("various-textobjs").restOfParagraph() vim.call("repeat#set", "vgr") end,
  { desc = "RestOfParagraph textobj" })
map({ "o", "x" }, "gR", function() require("various-textobjs").restOfIndentation() vim.call("repeat#set", "vgR") end,
  { desc = "restOfIndentation textobj" })
map({ "o", "x" }, "gG", function() require("various-textobjs").entireBuffer() end,
  { desc = "EntireBuffer textobj" })
map({ "o", "x" }, "gu", function() require("various-textobjs").url() vim.call("repeat#set", "vgu") end,
  { desc = "Url textobj" })

-- _nvim_various_textobjs: inner-outer
map({ "o", "x" }, "av", function() require("various-textobjs").value(false) vim.call("repeat#set", "vav") end,
  { desc = "outer value textobj" })
map({ "o", "x" }, "iv", function() require("various-textobjs").value(true) vim.call("repeat#set", "viv") end,
  { desc = "inner value textobj" })
map({ "o", "x" }, "ak", function() require("various-textobjs").key(false) vim.call("repeat#set", "vak") end,
  { desc = "outer key textobj" })
map({ "o", "x" }, "ik", function() require("various-textobjs").key(true) vim.call("repeat#set", "vik") end,
  { desc = "inner key textobj" })
-- map({ "o", "x" }, "an", function() require("various-textobjs").number(false) vim.call("repeat#set", "van") end,
--   { desc = "outer number textobj" })
-- map({ "o", "x" }, "in", function() require("various-textobjs").number(true) vim.call("repeat#set", "vin") end,
--   { desc = "outer number textobj" })
-- map({ "o", "x" }, "al", function() require("various-textobjs").mdlink(false) end)
-- map({ "o", "x" }, "il", function() require("various-textobjs").mdlink(true) end)
-- map({ "o", "x" }, "aC", function() require("various-textobjs").mdFencedCodeBlock(false) end)
-- map({ "o", "x" }, "iC", function() require("various-textobjs").mdFencedCodeBlock(true) end)
-- map({ "o", "x" }, "ac", function() require("various-textobjs").cssSelector(false) end)
-- map({ "o", "x" }, "ic", function() require("various-textobjs").cssSelector(true) end)
-- map({ "o", "x" }, "a/", function() require("various-textobjs").jsRegex(false) end)
-- map({ "o", "x" }, "i/", function() require("various-textobjs").jsRegex(true) end)
-- map({ "o", "x" }, "aD", function() require("various-textobjs").doubleSquareBrackets(false) end)
-- map({ "o", "x" }, "iD", function() require("various-textobjs").doubleSquareBrackets(true) end)
map({ "o", "x" }, "aS", function() require("various-textobjs").subword(false) vim.call("repeat#set", "vaS") end,
  { desc = "outer Subword textobj" })
map({ "o", "x" }, "iS", function() require("various-textobjs").subword(true) vim.call("repeat#set", "vaS") end,
  { desc = "inner Subword textobj" })
-- map({ "o", "x" }, "aP", function() require("various-textobjs").shellPipe(false) end)
-- map({ "o", "x" }, "iP", function() require("various-textobjs").shellPipe(true) end)

-- _nvim_various_textobjs: indentation textobj requires two parameters, first for
-- exclusion of the starting border, second for the exclusion of ending border
-- map({ "o", "x" }, "ii", function() require("various-textobjs").indentation(true, true) end, { desc = "inner-inner indentation textobj" })
-- map({ "o", "x" }, "ai", function() require("various-textobjs").indentation(false, true) end, { desc = "outer-inner indentation textobj" })
-- map({ "o", "x" }, "iI", function() require("various-textobjs").indentation(true, true) end, { desc = "inner-inner indentation textobj" })
-- map({ "o", "x" }, "aI", function() require("various-textobjs").indentation(false, false) end, { desc = "outer-outer indentation textobj" })

-- _vim_indent_object_(visualrepeatable_+_vimrepeat)
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "*",
  callback = function()
    map({ "o", "x" }, "iI", "<Cmd>lua MiniIndentscope.textobject(false)<CR>", { desc = "MiniIndentscope_iI" })
    map({ "o", "x" }, "aI", "<Cmd>lua MiniIndentscope.textobject(true)<CR>", { desc = "MiniIndentscope_aI" })
  end
})

-- _vim-textobj-space
vim.g.textobj_space_no_default_key_mappings = true
map({ "o", "x" }, "ir", "<Plug>(textobj-space-i)", { desc = "Space textobj" })
map({ "o", "x" }, "ar", "<Plug>(textobj-space-a)", { desc = "Space textobj" })

-- _vim-textobj-numeral
-- vim.g.textobj_numeral_no_default_key_mappings = true
-- map({ "o", "x" }, "ix", "<Plug>(textobj-numeral-hex-i)", { desc = "Hex textobj" })
-- map({ "o", "x" }, "ax", "<Plug>(textobj-numeral-hex-a)", { desc = "Hex textobj" })

-- ╭─────────╮
-- │ Motions │
-- ╰─────────╯

-- _normal_mode_(easymotion-like)
keymap("n", "<Leader><Leader>J", "<cmd>HopWordAC<CR>", { noremap = true })
keymap("n", "<Leader><Leader>K", "<cmd>HopWordBC<CR>", { noremap = true })
keymap("n", "<Leader><Leader>j", "<cmd>HopLineStartAC<CR>", { noremap = true })
keymap("n", "<Leader><Leader>k", "<cmd>HopLineStartBC<CR>", { noremap = true })
keymap("n", "<Leader><Leader>/", "<cmd>HopPattern<CR>", { noremap = true })

-- _visual_mode_(easymotion-like)
keymap("v", "<Leader><Leader>J", "<cmd>HopWordAC<CR>", { noremap = true })
keymap("v", "<Leader><Leader>K", "<cmd>HopWordBC<CR>", { noremap = true })
keymap("v", "<Leader><Leader>j", "<cmd>HopLineStartAC<CR>", { noremap = true })
keymap("v", "<Leader><Leader>k", "<cmd>HopLineStartBC<CR>", { noremap = true })
keymap("v", "<Leader><Leader>/", "<cmd>HoPattern<CR>", { noremap = true })

-- _normal_mode_(sneak-like)
keymap("n", "<Leader><Leader>z", "<cmd>HopChar2AC<CR>", { noremap = false })
keymap("n", "<Leader><Leader>Z", "<cmd>HopChar2BC<CR>", { noremap = false })

-- _visual_mode_(sneak-like)
keymap("v", "<Leader><Leader>z", "<cmd>HopChar2AC<CR>", { noremap = false })
keymap("v", "<Leader><Leader>Z", "<cmd>HopChar2BC<CR>", { noremap = false })

vim.cmd [[
  let g:sneak#prompt = ''
  " let g:sneak#target_labels = ";sftunq/SFGHLTUNRMQZ?0"
  " let g:sneak#use_ic_scs = 1
  " let g:sneak#label = 1
  " let g:sneak#label_esc = "\<Space>"
  " nnoremap s <Plug>Sneak_s
  " nnoremap S <Plug>Sneak_S
  " onoremap s <Plug>Sneak_s
  " onoremap Z <Plug>Sneak_S
  " vnoremap s <Plug>Sneak_s
  " vnoremap Z <Plug>Sneak_S
  " xnoremap s <Plug>Sneak_s
  " xnoremap Z <Plug>Sneak_S
  " map ; <Plug>Sneak_;
  " map , <Plug>Sneak_,
  map f <Plug>Sneak_f
  map F <Plug>Sneak_F
  map t <Plug>Sneak_t
  map T <Plug>Sneak_T
  map <space><space>s <Plug>SneakLabel_s
  map <space><space>S <Plug>SneakLabel_S
  nmap <silent><expr> <Tab> sneak#is_sneaking() ? '<Plug>SneakLabel_s<cr>' : ':bnext<cr>'
  nmap <silent><expr> <S-Tab> sneak#is_sneaking() ? '<Plug>SneakLabel_S<cr>' : ':bprevious<cr>'
  omap <Tab> <Plug>SneakLabel_s<cr>
  omap <S-Tab> <Plug>SneakLabel_S<cr>
  vmap <Tab> <Plug>SneakLabel_s<cr>
  vmap <S-Tab> <Plug>SneakLabel_S<cr>
  xmap <Tab> <Plug>SneakLabel_s<cr>
  xmap <S-Tab> <Plug>SneakLabel_S<cr>
]]

-- ╭────────────╮
-- │ Repeatable │
-- ╰────────────╯

-- _nvim-treesitter-textobjs_repeatable
-- ensure ; goes forward and , goes backward regardless of the last direction
local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"
map({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next, { desc = "Next TS textobj" })
map({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous, { desc = "Prev TS textobj" })

-- _sneak_repeatable
vim.cmd [[ command SneakForward execute "normal \<Plug>Sneak_;" ]]
vim.cmd [[ command SneakBackward execute "normal \<Plug>Sneak_," ]]
local next_sneak, prev_sneak = ts_repeat_move.make_repeatable_move_pair(
  function() vim.cmd [[ SneakForward ]] end,
  function() vim.cmd [[ SneakBackward ]] end
)
map({ "n", "x", "o" }, "<BS>", next_sneak, { desc = "Next SneakForward" })
map({ "n", "x", "o" }, "<S-BS>", prev_sneak, { desc = "Prev SneakForward" })

-- _gitsigns_chunck_repeatable
-- make sure forward function comes first
-- Or, use `make_repeatable_move` or `set_last_move` functions for more control. See the code for instructions.
local gs = require("gitsigns")
local next_hunk_repeat, prev_hunk_repeat = ts_repeat_move.make_repeatable_move_pair(gs.next_hunk, gs.prev_hunk)
map({ "n", "x", "o" }, "gnh", next_hunk_repeat, { desc = "Next GitHunk" })
map({ "n", "x", "o" }, "gph", prev_hunk_repeat, { desc = "Prev GitHunk" })

-- _goto_quotes_repeatable
local next_quote, prev_quote = ts_repeat_move.make_repeatable_move_pair(
  function() vim.cmd [[ normal viNu ]] vim.cmd [[ call feedkeys("") ]] end,
  function() vim.cmd [[ normal vilu ]] vim.cmd [[ call feedkeys("") ]] end
)
map({ "n", "x", "o" }, "gnu", next_quote, { desc = "Next Quote" })
map({ "n", "x", "o" }, "gpu", prev_quote, { desc = "Prev Quote" })

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
map({ "n", "x", "o" }, "<leader><leader>;", next_columnmove, { desc = "Next ColumnMove_;" })
map({ "n", "x", "o" }, "<leader><leader>,", prev_columnmove, { desc = "Prev ColumnMove_," })

local next_columnmove_w, prev_columnmove_b = ts_repeat_move.make_repeatable_move_pair(
  function() vim.cmd [[ execute "normal \<Plug>(columnmove-w)" ]] end,
  function() vim.cmd [[ execute "normal \<Plug>(columnmove-b)" ]] end
)
map({ "n", "x", "o" }, "<leader><leader>w", next_columnmove_w, { desc = "Next ColumnMove_w" })
map({ "n", "x", "o" }, "<leader><leader>b", prev_columnmove_b, { desc = "Prev ColumnMove_b" })

local next_columnmove_e, prev_columnmove_ge = ts_repeat_move.make_repeatable_move_pair(
  function() vim.cmd [[ execute "normal \<Plug>(columnmove-e)" ]] end,
  function() vim.cmd [[ execute "normal \<Plug>(columnmove-ge)" ]] end
)
map({ "n", "x", "o" }, "<leader><leader>e", next_columnmove_e, { desc = "Next ColumnMove_e" })
map({ "n", "x", "o" }, "<leader><leader>ge", prev_columnmove_ge, { desc = "Prev ColumnMove_ge" })

local next_columnmove_W, prev_columnmove_B = ts_repeat_move.make_repeatable_move_pair(
  function() vim.cmd [[ execute "normal \<Plug>(columnmove-W)" ]] end,
  function() vim.cmd [[ execute "normal \<Plug>(columnmove-B)" ]] end
)
map({ "n", "x", "o" }, "<leader><leader>W", next_columnmove_W, { desc = "Next ColumnMove_W" })
map({ "n", "x", "o" }, "<leader><leader>B", prev_columnmove_B, { desc = "Prev ColumnMove_B" })

local next_columnmove_E, prev_columnmove_gE = ts_repeat_move.make_repeatable_move_pair(
  function() vim.cmd [[ execute "normal \<Plug>(columnmove-E)" ]] end,
  function() vim.cmd [[ execute "normal \<Plug>(columnmove-gE)" ]] end
)
map({ "n", "x", "o" }, "<leader><leader>E", next_columnmove_E, { desc = "Next ColumnMove_E" })
map({ "n", "x", "o" }, "<leader><leader>gE", prev_columnmove_gE, { desc = "Prev ColumnMove_gE" })

-- _jump_blankline_repeatable
local next_blankline, prev_blankline = ts_repeat_move.make_repeatable_move_pair(
  function() vim.cmd [[ normal } ]] end,
  function() vim.cmd [[ normal { ]] end
)
map({ "n", "x", "o" }, "<leader><leader>}", next_blankline, { desc = "Next Blankline" })
map({ "n", "x", "o" }, "<leader><leader>{", prev_blankline, { desc = "Prev Blankline" })

-- _jump_indent_repeatable
local next_indent, prev_indent = ts_repeat_move.make_repeatable_move_pair(
  function() vim.cmd [[ normal vii_ ]] vim.cmd [[ call feedkeys("") ]] end,
  function() vim.cmd [[ normal viio_ ]] vim.cmd [[ call feedkeys("") ]] end
)
map({ "n", "x", "o" }, "<leader><leader>]", next_indent, { desc = "Next Indent" })
map({ "n", "x", "o" }, "<leader><leader>[", prev_indent, { desc = "Prev Indent" })

-- _jump_paragraph_repeatable
local next_paragraph, prev_paragraph = ts_repeat_move.make_repeatable_move_pair(
  function() vim.cmd [[ normal ) ]] end,
  function() vim.cmd [[ normal ( ]] end
)
map({ "n", "x", "o" }, "<leader><leader>)", next_paragraph, { desc = "Next Paragraph" })
map({ "n", "x", "o" }, "<leader><leader>(", prev_paragraph, { desc = "Prev Paragraph" })

-- _jump_paragraph_repeatable
local next_startline, prev_startline = ts_repeat_move.make_repeatable_move_pair(
  function() vim.cmd [[ normal + ]] end,
  function() vim.cmd [[ normal - ]] end
)
map({ "n", "x", "o" }, "<leader><leader>+", next_startline, { desc = "Next StartLine" })
map({ "n", "x", "o" }, "<leader><leader>-", prev_startline, { desc = "Prev StartLine" })

-- _vim-textobj-numeral_(goto_repeatable)
local next_inner_hex, prev_inner_hex = ts_repeat_move.make_repeatable_move_pair(
  function() vim.cmd [[ execute "normal \<Plug>(textobj-numeral-hex-n)" ]] end,
  function() vim.cmd [[ execute "normal \<Plug>(textobj-numeral-hex-p)" ]] end
)
map({ "n", "x", "o" }, "gnx", next_inner_hex, { desc = "Next Inner Hex" })
map({ "n", "x", "o" }, "gpx", prev_inner_hex, { desc = "Prev Inner Hex" })

local next_inner_numeral, prev_inner_numeral = ts_repeat_move.make_repeatable_move_pair(
  function() vim.cmd [[ execute "normal \<Plug>(textobj-numeral-n)" ]] end,
  function() vim.cmd [[ execute "normal \<Plug>(textobj-numeral-p)" ]] end
)
map({ "n", "x", "o" }, "gnn", next_inner_numeral, { desc = "Next Inner Number" })
map({ "n", "x", "o" }, "gpn", prev_inner_numeral, { desc = "Prev Inner Number" })

local next_around_hex, prev_around_hex = ts_repeat_move.make_repeatable_move_pair(
  function() vim.cmd [[ execute "normal \<Plug>(textobj-numeral-hex-N)" ]] end,
  function() vim.cmd [[ execute "normal \<Plug>(textobj-numeral-hex-P)" ]] end
)
map({ "n", "x", "o" }, "gNx", next_around_hex, { desc = "Next Around Hex" })
map({ "n", "x", "o" }, "gPx", prev_around_hex, { desc = "Prev Around Hex" })

local next_around_numeral, prev_around_numeral = ts_repeat_move.make_repeatable_move_pair(
  function() vim.cmd [[ execute "normal \<Plug>(textobj-numeral-N)" ]] end,
  function() vim.cmd [[ execute "normal \<Plug>(textobj-numeral-P)" ]] end
)
map({ "n", "x", "o" }, "gNn", next_around_numeral, { desc = "Next Around Number" })
map({ "n", "x", "o" }, "gPn", prev_around_numeral, { desc = "Prev Around Number" })

local vert_increment, vert_decrement = ts_repeat_move.make_repeatable_move_pair(
  function() vim.cmd [[ normal "zyanjvan"zp ]] require("user.autocommands").FeedKeysCorrectly('<C-a>') end,
  function() vim.cmd [[ normal "zyanjvan"zp ]] require("user.autocommands").FeedKeysCorrectly('<C-x>') end
)
map({ "n" }, "g+", vert_increment, { desc = "Vert Increment" })
map({ "n" }, "g-", vert_decrement, { desc = "Vert Decrement" })

local horz_increment, horz_decrement = ts_repeat_move.make_repeatable_move_pair(
  require("user.autocommands").HorzIncrement,
  require("user.autocommands").HorzDecrement
)
map({ "n" }, "gn+", horz_increment, { desc = "Horz increment" })
map({ "n" }, "gn-", horz_decrement, { desc = "Horz Decrement" })
