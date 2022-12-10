local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

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

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

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
keymap("n","<S-s>",":w<CR>",opts)

-- Quick Jump
keymap("n","J","10j",opts)
keymap("n","K","10k",opts)
keymap("n","H","10h",opts)
keymap("n","L","10l",opts)
keymap("n","fa","/\\v([^a-z]a|^a)<cr><cmd>noh<cr>",opts)
keymap("n","fb","/\\v([^a-z]b|^b)<cr><cmd>noh<cr>",opts)
keymap("n","fc","/\\v([^a-z]c|^c)<cr><cmd>noh<cr>",opts)
keymap("n","fd","/\\v([^a-z]d|^d)<cr><cmd>noh<cr>",opts)
keymap("n","fe","/\\v([^a-z]e|^e)<cr><cmd>noh<cr>",opts)
keymap("n","ff","/\\v([^a-z]f|^f)<cr><cmd>noh<cr>",opts)
keymap("n","fg","/\\v([^a-z]g|^g)<cr><cmd>noh<cr>",opts)
keymap("n","fh","/\\v([^a-z]h|^h)<cr><cmd>noh<cr>",opts)
keymap("n","fi","/\\v([^a-z]i|^i)<cr><cmd>noh<cr>",opts)
keymap("n","fj","/\\v([^a-z]j|^j)<cr><cmd>noh<cr>",opts)
keymap("n","fk","/\\v([^a-z]k|^k)<cr><cmd>noh<cr>",opts)
keymap("n","fl","/\\v([^a-z]l|^l)<cr><cmd>noh<cr>",opts)
keymap("n","fm","/\\v([^a-z]m|^m)<cr><cmd>noh<cr>",opts)
keymap("n","fn","/\\v([^a-z]n|^n)<cr><cmd>noh<cr>",opts)
keymap("n","fo","/\\v([^a-z]o|^o)<cr><cmd>noh<cr>",opts)
keymap("n","fp","/\\v([^a-z]p|^p)<cr><cmd>noh<cr>",opts)
keymap("n","fq","/\\v([^a-z]q|^q)<cr><cmd>noh<cr>",opts)
keymap("n","fr","/\\v([^a-z]r|^r)<cr><cmd>noh<cr>",opts)
keymap("n","fs","/\\v([^a-z]s|^s)<cr><cmd>noh<cr>",opts)
keymap("n","ft","/\\v([^a-z]t|^t)<cr><cmd>noh<cr>",opts)
keymap("n","fu","/\\v([^a-z]u|^u)<cr><cmd>noh<cr>",opts)
keymap("n","fv","/\\v([^a-z]v|^v)<cr><cmd>noh<cr>",opts)
keymap("n","fw","/\\v([^a-z]w|^w)<cr><cmd>noh<cr>",opts)
keymap("n","fx","/\\v([^a-z]x|^x)<cr><cmd>noh<cr>",opts)
keymap("n","fy","/\\v([^a-z]y|^y)<cr><cmd>noh<cr>",opts)
keymap("n","fz","/\\v([^a-z]z|^z)<cr><cmd>noh<cr>",opts)

-- Quick forward yank
keymap("n","Y","yg_",opts)

-- Save file as sudo
-- keymap("c","w!!","execute 'silent! write !sudo tee % >/dev/null' <bar> edit!",opts)
keymap("c","w!!","w !sudo tee %",opts)

-- ╭───────────────────────╮
-- │ Start leader mappings │
-- ╰───────────────────────╯

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
keymap("n",";;","<C-6>",opts)
keymap("n",";s","<Cmd>BufferLineCyclePrev <CR>",opts)
keymap("n",";f","<Cmd>BufferLineCycleNext <CR>",opts)
keymap("n",";S","<Cmd>BufferLineMovePrev <CR>",opts)
keymap("n",";F","<Cmd>BufferLineMoveNext <CR>",opts)

-- Explorer
keymap("n","<leader>e","<Cmd>Neotree toggle left<CR>",opts)
keymap("n","<leader>q","<Cmd>Neotree filesystem reveal float<CR>",opts)

-- Toggle Highlight
keymap("n","<leader>h","<cmd>noh<cr>",opts)

-- Terminal
keymap("n","<leader>v","<Cmd>ToggleTerm direction=vertical   size=70<CR>",opts)
keymap("n","<leader>V","<Cmd>ToggleTerm direction=horizontal size=10<CR>",opts)

-- Terminal Column Format
keymap("v","<leader>tC",":'<,'>!column -t<CR>",opts)

-- Window Swap
keymap("t","<C-x>","<C-\\><C-n>:call WinBufSwap()<cr><Esc><cmd>set number<cr>",opts)

-- Terminal Paste from secondary clipboard
keymap("n","<leader>p",'"*p',opts)
-- keymap("n","<leader>P",'"*P',opts)
-- keymap("v","<leader>p",'"*p',opts)
-- keymap("v","<leader>P",'"*P',opts)

-- Terminal Copy to secondary clipboard
keymap("n","<leader>y",'"*yg_',opts)
-- keymap("n","<leader>Y",'"*yy',opts)
-- keymap("v","<leader>y",'"*y',opts)
-- keymap("v","<leader>Y",'"*y',opts)
