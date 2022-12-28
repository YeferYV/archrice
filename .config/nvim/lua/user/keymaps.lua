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
keymap("o", 'im', "<cmd>normal! `[v`]<Left><cr>",opts)
keymap("x", 'im', "`[o`]<Left>",opts)

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
keymap("n", "<Tab>", ":bnext<CR>", opts)
keymap("n", "<S-Tab>", ":bprevious<CR>", opts)
keymap("n", "<leader>x", ":bp | bd #<CR>", opts)
keymap("n", "<leader><Tab>", ":tabnext<CR>", opts)
keymap("n", "<leader><S-Tab>", ":tabprevious<CR>", opts)
-- keymap("n", "<leader>Q", ":tabclose<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)
-- keymap("v", "jk", "<ESC>", opts) --slow
-- keymap("v", "kj", "<ESC>", opts) --slow

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)
keymap("v", "P", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Replace all
keymap("n", "<C-s>", ":%s//g<Left><Left>", { noremap = true, silent = false })

-- Copilot
keymap("i","<C-left>","<Plug>(copilot-previous)",opts)
keymap("i","<C-right>","<Plug>(copilot-next)",opts)

-- Alternative way to quit/write
keymap("n","<S-q>",":q<CR>",opts)
keymap("n","<S-r>",":w<CR>",opts)

-- Quick Jump
keymap("n","J","10j",opts)
keymap("n","K","10k",opts)
keymap("n","H","10h",opts)
keymap("n","L","10l",opts)
-- Quick forward yank
keymap("n","Y","yg_",opts)

-- Save file as sudo
-- keymap("c","w!!","execute 'silent! write !sudo tee % >/dev/null' <bar> edit!",opts)
keymap("c","w!!","w !sudo tee %",opts)

-- ╭─────────────────╮
-- │ leader mappings │
-- ╰─────────────────╯

-- Buffer keymaps
keymap("n","<leader>1","<Cmd>BufferLineGoToBuffer 1<CR>",opts)
keymap("n","<leader>2","<Cmd>BufferLineGoToBuffer 2<CR>",opts)
keymap("n","<leader>3","<Cmd>BufferLineGoToBuffer 3<CR>",opts)
keymap("n","<leader>4","<Cmd>BufferLineGoToBuffer 4<CR>",opts)
keymap("n","<leader>5","<Cmd>BufferLineGoToBuffer 5<CR>",opts)
keymap("n","<leader>6","<Cmd>BufferLineGoToBuffer 6<CR>",opts)
keymap("n","<leader>7","<Cmd>BufferLineGoToBuffer 7<CR>",opts)
keymap("n","<leader>8","<Cmd>BufferLineGoToBuffer 8<CR>",opts)
keymap("n","<leader>9","<Cmd>BufferLineGoToBuffer 9<CR>",opts)
-- keymap("n","<leader>;",":call CycleLastBuffer()<CR>",opts)
-- keymap("n",";;","<C-6>",opts)
-- keymap("n",";s","<Cmd>BufferLineCyclePrev <CR>",opts)
-- keymap("n",";f","<Cmd>BufferLineCycleNext <CR>",opts)
-- keymap("n",";S","<Cmd>BufferLineMovePrev <CR>",opts)
-- keymap("n",";F","<Cmd>BufferLineMoveNext <CR>",opts)

-- normal mode (easymotion-like)
keymap("n", "<Leader><Leader>b", "<cmd>HopWordBC<CR>", {noremap=true})
keymap("n", "<Leader><Leader>w", "<cmd>HopWordAC<CR>", {noremap=true})
keymap("n", "<Leader><Leader>j", "<cmd>HopLineStartAC<CR>", {noremap=true})
keymap("n", "<Leader><Leader>k", "<cmd>HopLineStartBC<CR>", {noremap=true})
keymap("n", "<Leader><Leader>/", "<cmd>HopPattern<CR>", {noremap=true})

-- visual mode (easymotion-like)
keymap("v", "<Leader><Leader>w", "<cmd>HopWordAC<CR>", {noremap=true})
keymap("v", "<Leader><Leader>b", "<cmd>HopWordBC<CR>", {noremap=true})
keymap("v", "<Leader><Leader>j", "<cmd>HopLineStartAC<CR>", {noremap=true})
keymap("v", "<Leader><Leader>k", "<cmd>HopLineStartBC<CR>", {noremap=true})
keymap("v", "<Leader><Leader>/", "<cmd>HoPattern<CR>", {noremap=true})

-- normal mode (sneak-like)
keymap("n", "<Leader><Leader>s", "<cmd>HopChar2AC<CR>", {noremap=false})
keymap("n", "<Leader><Leader>S", "<cmd>HopChar2BC<CR>", {noremap=false})

-- visual mode (sneak-like)
keymap("v", "<Leader><Leader>s", "<cmd>HopChar2AC<CR>", {noremap=false})
keymap("v", "<Leader><Leader>S", "<cmd>HopChar2BC<CR>", {noremap=false})

-- Terminal
keymap("n","<leader>v","<Cmd>ToggleTerm direction=vertical   size=70<CR>",opts)
keymap("n","<leader>V","<Cmd>ToggleTerm direction=horizontal size=10<CR>",opts)

-- Window Swap
keymap("t","<C-x>","<C-\\><C-n>:call WinBufSwap()<cr><Esc><cmd>set number<cr>",opts)

-- Terminal Paste from secondary clipboard
keymap("n","<leader>yp",'"*p',opts)
-- keymap("n","<leader>P",'"*P',opts)
-- keymap("v","<leader>p",'"*p',opts)
-- keymap("v","<leader>P",'"*P',opts)

-- Terminal Copy to secondary clipboard
keymap("n","<leader>yy",'"*yg_',opts)
-- keymap("n","<leader>Y",'"*yy',opts)
-- keymap("v","<leader>y",'"*y',opts)
-- keymap("v","<leader>Y",'"*y',opts)
-- Terminal Column Format

-- Visual Fold (Vjzf: create fold, zj/zk: next/previous fold), FormatColumn and FormatComment
keymap("v","<leader>z",":'<,'>fold      <CR>",opts)
keymap("v","<leader>Z",":'<,'>!column -t<CR>",opts)
keymap("v","<leader>gw","gw",opts)

-- ╭──────────────────╮
-- │ Lspsaga mappings │
-- ╰──────────────────╯

map({"n","v"}, "gsa", "<cmd>Lspsaga code_action<CR>", { silent = true })
map("n", "gsd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
map("n", "gsf", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
map("n", "gsh", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
map("n", "gsn", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })
map("n", "gsN", function() require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR }) end, { silent = true })
map("n", "gso", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })
map("n", "gsO", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })
map("n", "gsp", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
map("n", "gsP", function() require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, { silent = true })
map("n", "gsr", "<cmd>Lspsaga open_floaterm ranger<CR>", { silent = true })
map("n", "gsR", "<cmd>Lspsaga rename<CR>", { silent = true })
map("n", "gst", "<cmd>Lspsaga open_floaterm<CR>", { silent = true })
map("n", "gsz", "<cmd>LSpsaga outline<CR>",{ silent = true })
map("t", "<C-x>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })
