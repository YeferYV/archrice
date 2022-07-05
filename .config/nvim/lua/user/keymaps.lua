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
keymap("n", "<leader>q", ":bdelete<CR>", opts)
keymap("n", "<leader><Tab>", ":tabnext<CR>", opts)
keymap("n", "<leader><S-Tab>", ":tabprevious<CR>", opts)
keymap("n", "<leader><x>", ":tabdelete<CR>", opts)

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

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Replace all
keymap("n", "<C-s>", ":%s//g<Left><Left>", { noremap = true, silent = false })

-- Copilot
keymap("i","<C-left>","<Plug>(copilot-previous)",opts)
keymap("i","<C-right>","<Plug>(copilot-next)",opts)

-- Alternative way to quit/write
keymap("n","<S-q>",":q<CR>",opts)
keymap("n","<S-s>",":w<CR>",opts)

-- Switch window
keymap("n","<leader>s",":call SwitchWindow2()<CR>",opts)
keymap("t","<leader>s","<C-\\><C-n>:call WinBufSwap()<CR><Esc>",opts)

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

-- Start leader mappings --
-- keymap("n","<leader>","",opts)

-- vertical split
-- keymap("n","<leader>v",":vsplit | resize 20 | term <CR>",opts)
-- keymap("t","<leader>v",":vs +te <CR>",opts)
keymap("n","<leader>s",":vsplit<bar>vertical resize 80<bar>term $SHELL<cr>",opts)
-- keymap("t","<leader>s","<C-\\><C-n>:vsplit<bar>vertical resize 80<bar>term zsh<cr>",opts)  --while typing <space>t trigger it

-- horizontal split
-- keymap("n","<leader>V",":split | resize 20 | term <CR>",opts)
-- keymap("t","<leader>V",":split +te <CR>",opts)
keymap("n","<leader>S",":split<bar>resize 20<bar>term $SHELL<cr> ",opts)
-- keymap("t","<leader>S","<C-\\><C-n>:split<bar>resize 20<bar>term zsh<cr>",opts)  --while typing <space>t trigger it

-- Zoom split
-- noremap Zz <c-w>_ \| <c-w>\|
-- noremap Zo <c-w>=
keymap("n","<leader>z","<c-w>_ | <c-w>|",opts)
keymap("n","<leader>Z","<c-w>=",opts)

-- Copy to secondary clipboard
keymap("n","<leader>y",'"*yg_',opts)
keymap("n","<leader>Y",'"*yy',opts)
keymap("v","<leader>y",'"*y',opts)
keymap("v","<leader>Y",'"*y',opts)

-- Paste from secondary clipboard
keymap("n","<leader>p",'"*p',opts)
keymap("n","<leader>P",'"*P',opts)
keymap("v","<leader>p",'"*p',opts)
keymap("v","<leader>P",'"*P',opts)

-- File Tree
keymap("n","<leader>e",":NvimTreeToggle<CR>",opts)
keymap("n","<leader>E",":NvimTreeFindFile<CR>",opts)
keymap("n","<leader>R",":NvimTreeRefresh<CR>",opts)

-- File Explorer
keymap("n","<leader>r",":lua _LF_TOGGLE()<CR>",opts)

-- Float Terminal
keymap("n","<leader>v",":ToggleTerm direction=vertical size=80<CR>",opts)
keymap("n","<leader>V",":ToggleTerm direction=horizontal size=20<CR>",opts)

-- Git
keymap("n","<leader>g",":Gitsigns preview_hunk<CR>",opts)
keymap("n","<leader><BS>",":Gitsigns reset_hunk<CR>",opts)
keymap("n","<leader>G",":lua _LAZYGIT_TOGGLE()<CR>",opts)
keymap("n","<leader>[",":Gitsigns prev_hunk<CR>",opts)
keymap("n","<leader>]",":Gitsigns next_hunk<CR>",opts)

-- Toggle HighlightSearch/HideAll
keymap("n","<leader>h",":set hlsearch!<CR>",opts)
keymap("n","<leader>H",":call ToggleHiddenAll()<CR>",opts)

-- Compile/Execute (%=file)
keymap("n","<leader>cb","!bash %<CR>",opts)
keymap("n","<leader>cp","!python %<CR>",opts)
keymap("n","<leader>cc",":w! | !compiler '<c-r>%'<CR>",opts)
keymap("n","<leader>co","!opout<CR>",opts)

-- Codi enable/disable
keymap("n","<leader>i",":Codi<CR>",opts)
keymap("n","<leader>o",":Codi!<CR>",opts)

-- cursorline/linehighlight enable/disable
keymap("n","<leader>n",":set nocursorline<CR>",opts)
keymap("n","<leader>N",":set cursorline<CR>",opts)

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

-- Telescope
keymap("n","<leader>th","<cmd>TSHighlightCapturesUnderCursor<CR>",opts)
keymap("n","<leader>tp","<cmd>lua require'telescope.builtin'.builtin{}<CR>",opts)
keymap("n","<leader>to","<cmd>lua require'telescope.builtin'.oldfiles{}<CR>",opts)
keymap("n","<leader>t;","<cmd>lua require'telescope.builtin'.buffers{}<CR>",opts)
keymap("n","<leader>t/","<cmd>lua require'telescope.builtin'.current_buffer_fuzzy_find{}<CR>",opts)
keymap("n","<leader>t'","<cmd>lua require'telescope.builtin'.marks{}<CR>",opts)
keymap("n","<leader>tg","<cmd>lua require'telescope.builtin'.git_files{}<CR>",opts)
keymap("n","<leader>tf","<cmd>lua require'telescope.builtin'.find_files{}<CR>",opts)
keymap("n","<leader>tr","cmd>lua require'telescope.builtin'.live_grep{}<CR>",opts)
keymap("n","<leader>tc","<cmd>lua require'telescope.builtin'.colorscheme{}<CR>",opts)

