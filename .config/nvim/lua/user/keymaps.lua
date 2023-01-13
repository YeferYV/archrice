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

-- Jump to last change
keymap("n", "gl", "`.", opts)

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-t>", "<C-t>", opts)

-- position navigation (in wezterm <C-i> outputs Tab)
keymap("n", "<C-y>", "<C-i>", opts)

-- https://www.reddit.com/r/vim/comments/xnuaxs/last_change_text_object
-- keymap("v", 'im', '<Esc>u<C-r>vgi', opts)            -- <left> unsupported
-- keymap("v", 'im', '<Esc>u<C-r>v`^<Left>', opts)      -- new-lines unsupported
keymap("o", 'im', "<cmd>normal! `[v`]<Left><cr>", opts)
keymap("x", 'im', "`[o`]<Left>", opts)

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
keymap("n", "<right>", ":bnext<CR>", opts)
keymap("n", "<left>", ":bprevious<CR>", opts)
keymap("n", "<Tab>", ":bnext<CR>", opts)
keymap("n", "<S-Tab>", ":bprevious<CR>", opts)
keymap("n", "<leader>x", ":bp | bd #<CR>", opts)
keymap("n", "<leader><Tab>", ":tabnext<CR>", opts)
keymap("n", "<leader><S-Tab>", ":tabprevious<CR>", opts)
keymap("n", "<leader>X", ":tabclose<CR>", opts)

-- Press jk fast to enter NormalMode
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)
-- keymap("v", "jk", "<ESC>", opts) --slow
-- keymap("v", "kj", "<ESC>", opts) --slow

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

-- Replace all
keymap("n", "<C-s>", ":%s//g<Left><Left>", { noremap = true, silent = false })

-- Copilot
keymap("i", "<C-left>", "<Plug>(copilot-previous)", opts)
keymap("i", "<C-right>", "<Plug>(copilot-next)", opts)

-- Alternative way to quit/write
keymap("n", "<S-q>", "<cmd>quit<CR>", opts)
keymap("n", "<S-r>", "<cmd>lua vim.lsp.buf.format()<cr><cmd>write<cr>", opts)

-- Quick Jump
keymap("n", "J", "10j", opts)
keymap("n", "K", "10k", opts)
keymap("n", "H", "10h", opts)
keymap("n", "L", "10l", opts)

-- Forward yank/paste
keymap("n", 'Y', 'yg_', opts)
keymap("v", 'P', 'g_P', opts) -- "P" seems unaltered the clipboard

-- Unaltered clipboard
keymap("v", 'p', '"_dP', opts)

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
keymap("n", "gyl", "<C-6>", opts)
keymap("n", "gys", "<Cmd>BufferLineCyclePrev <CR>", opts)
keymap("n", "gyf", "<Cmd>BufferLineCycleNext <CR>", opts)
keymap("n", "gyS", "<Cmd>BufferLineMovePrev <CR>", opts)
keymap("n", "gyF", "<Cmd>BufferLineMoveNext <CR>", opts)

-- normal mode (easymotion-like)
keymap("n", "<Leader><Leader>b", "<cmd>HopWordBC<CR>", { noremap = true })
keymap("n", "<Leader><Leader>w", "<cmd>HopWordAC<CR>", { noremap = true })
keymap("n", "<Leader><Leader>j", "<cmd>HopLineStartAC<CR>", { noremap = true })
keymap("n", "<Leader><Leader>k", "<cmd>HopLineStartBC<CR>", { noremap = true })
keymap("n", "<Leader><Leader>/", "<cmd>HopPattern<CR>", { noremap = true })

-- visual mode (easymotion-like)
keymap("v", "<Leader><Leader>w", "<cmd>HopWordAC<CR>", { noremap = true })
keymap("v", "<Leader><Leader>b", "<cmd>HopWordBC<CR>", { noremap = true })
keymap("v", "<Leader><Leader>j", "<cmd>HopLineStartAC<CR>", { noremap = true })
keymap("v", "<Leader><Leader>k", "<cmd>HopLineStartBC<CR>", { noremap = true })
keymap("v", "<Leader><Leader>/", "<cmd>HoPattern<CR>", { noremap = true })

-- normal mode (sneak-like)
keymap("n", "<Leader><Leader>s", "<cmd>HopChar2AC<CR>", { noremap = false })
keymap("n", "<Leader><Leader>S", "<cmd>HopChar2BC<CR>", { noremap = false })

-- visual mode (sneak-like)
keymap("v", "<Leader><Leader>s", "<cmd>HopChar2AC<CR>", { noremap = false })
keymap("v", "<Leader><Leader>S", "<cmd>HopChar2BC<CR>", { noremap = false })

-- Terminal
keymap("n", "<leader>v", "<Cmd>ToggleTerm direction=vertical   size=70<CR>", opts)
keymap("n", "<leader>V", "<Cmd>ToggleTerm direction=horizontal size=10<CR>", opts)

-- Window Swap
keymap("t", "<C-x>", "<C-\\><C-n>:call WinBufSwap()<cr><Esc><cmd>set number<cr>", opts)

-- Visual Paste/ForwardPaste from secondary clipboard
keymap("v", "<leader>p", '"*p', opts)
keymap("v", "<leader>P", 'g_"*P', opts)

-- Visual Copy/Append to secondary clipboard
keymap("v", "<leader>y", '"*y', opts)
keymap("v", "<leader>Y", 'y:let @* .= @0<cr>', opts)

-- Visual Fold (Vjzf: create fold, zj/zk: next/previous fold), FormatColumn and FormatComment
keymap("v", "<leader>z", ":'<,'>fold      <CR>", opts)
keymap("v", "<leader>Z", ":'<,'>!column -t<CR>", opts)
keymap("v", "<leader>gw", "gw", opts)

-- ╭──────────────────╮
-- │ Lspsaga mappings │
-- ╰──────────────────╯

map({ "n", "v" }, "gsa", "<cmd>Lspsaga code_action<CR>", { silent = true })
map("n", "gsd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
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
map("n", "gsr", "<cmd>Lspsaga open_floaterm ranger<CR>", { silent = true })
map("n", "gsR", "<cmd>Lspsaga rename<CR>", { silent = true })
map("n", "gst", "<cmd>Lspsaga open_floaterm<CR>", { silent = true })
map("n", "gsz", "<cmd>LSpsaga outline<CR>", { silent = true })
map("t", "<C-x>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })

-- ╭──────────────╮
-- │ Text Objects │
-- ╰──────────────╯

-- -- Between chars (inline-autojump unsupported) (multiline-autojump unsupported) (next/prev autojump unsupported) (like targets.vim)
-- local chars = { '_', '.', ':', ',', ';', '|', '/', '\\', '*', '+', '%', '`', '?', '=' }
-- for _,char in ipairs(chars) do
--   for _,mode in ipairs({ 'x', 'o' }) do
--     vim.api.nvim_set_keymap(mode, "i" .. char, string.format(':<C-u>normal! T%svt%s<CR>', char, char, char), { noremap = true, silent = true })
--     vim.api.nvim_set_keymap(mode, "a" .. char, string.format(':<C-u>normal! F%svf%s<CR>', char, char, char), { noremap = true, silent = true })
--   end
-- end

-- example: `?` for diagnostic textobj
map({ "o", "x" }, "!", function() require("various-textobjs").diagnostic() vim.call("repeat#set", "v!") end)
map({ "o", "x" }, "n", function() require("various-textobjs").nearEoL() vim.call("repeat#set", "vn") end)
map({ "o", "x" }, "|", function() require("various-textobjs").column() vim.call("repeat#set", "v|") end)
map({ "o", "x" }, "r", function() require("various-textobjs").restOfParagraph() vim.call("repeat#set", "vr") end)
map({ "o", "x" }, "gG", function() require("various-textobjs").entireBuffer() vim.call("repeat#set", "vU") end)
map({ "o", "x" }, "U", function() require("various-textobjs").url() vim.call("repeat#set", "vU") end)

-- example: `an` for outer number, `in` for inner number
map({ "o", "x" }, "av", function() require("various-textobjs").value(false) vim.call("repeat#set", "vav") end)
map({ "o", "x" }, "iv", function() require("various-textobjs").value(true) vim.call("repeat#set", "viv") end)
map({ "o", "x" }, "ak", function() require("various-textobjs").key(false) vim.call("repeat#set", "vak") end)
map({ "o", "x" }, "ik", function() require("various-textobjs").key(true) vim.call("repeat#set", "vik") end)
map({ "o", "x" }, "an", function() require("various-textobjs").number(false) vim.call("repeat#set", "van") end)
map({ "o", "x" }, "in", function() require("various-textobjs").number(true) vim.call("repeat#set", "vin") end)
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
map({ "o", "x" }, "aS", function() require("various-textobjs").subword(false) vim.call("repeat#set", "vaS") end)
map({ "o", "x" }, "iS", function() require("various-textobjs").subword(true) vim.call("repeat#set", "vaS") end)
-- map({ "o", "x" }, "aP", function() require("various-textobjs").shellPipe(false) end)
-- map({ "o", "x" }, "iP", function() require("various-textobjs").shellPipe(true) end)

-- FIXME: Repeat not working
-- exception: indentation textobj requires two parameters, first for exclusion of the
-- starting border, second for the exclusion of ending border
map({ "o", "x" }, "ii",
  function() require("various-textobjs").indentation(true, true) vim.call("repeat#set", "vii") end)
map({ "o", "x" }, "ai",
  function() require("various-textobjs").indentation(false, true) vim.call("repeat#set", "vai") end)
map({ "o", "x" }, "iI",
  function() require("various-textobjs").indentation(true, true) vim.call("repeat#set", "viI") end)
map({ "o", "x" }, "aI",
  function() require("various-textobjs").indentation(false, false) vim.call("repeat#set", "vaI") end)
