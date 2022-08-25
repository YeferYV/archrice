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
keymap("n", "<M-Up>", ":resize +2<CR>", opts)
keymap("n", "<M-Down>", ":resize -2<CR>", opts)
keymap("n", "<M-Left>", ":vertical resize +2<CR>", opts)
keymap("n", "<M-Right>", ":vertical resize -2<CR>", opts)
keymap("t", "<M-Up>", "<C-\\><C-n>:resize -2<CR>", opts)
keymap("t", "<M-Down>", "<C-\\><C-n>:resize +2<CR>", opts)
keymap("t", "<M-Left>", "<C-\\><C-n>:vertical resize -2<CR>", opts)
keymap("t", "<M-Right>", "<C-\\><C-n>:vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<Tab>", ":bnext<CR>", opts)
keymap("n", "<S-Tab>", ":bprevious<CR>", opts)
keymap("n", "<leader>x", ":bdelete!<CR>", opts)
keymap("n", "<leader><Tab>", ":tabnext<CR>", opts)
keymap("n", "<leader><S-Tab>", ":tabprevious<CR>", opts)
keymap("n", "<leader>Q", ":tabdelete<CR>", opts)

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

-- Quick forward yank
keymap("n","Y","yg_",opts)

-- Save file as sudo
-- keymap("c","w!!","execute 'silent! write !sudo tee % >/dev/null' <bar> edit!",opts)
keymap("c","w!!","w !sudo tee %",opts)

-- Start leader mappings --
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

-- File Tree
-- keymap("n","<leader>e",":NvimTreeToggle<CR>",opts)
-- keymap("n","<leader>E",":lua vim.cmd[[NvimTreeRefresh]]; vim.cmd[[NvimTreeToggle]]<CR>",opts)

-- Git
-- keymap("n","<leader>g",":Gitsigns preview_hunk<CR>",opts)
-- keymap("n","<leader><BS>",":Gitsigns reset_hunk<CR>",opts)
-- keymap("n","<leader>G",":lua _LAZYGIT_TOGGLE()<CR>",opts)
-- keymap("n","<leader>[",":Gitsigns prev_hunk<CR>",opts)
-- keymap("n","<leader>]",":Gitsigns next_hunk<CR>",opts)

-- Telescope
-- keymap("n","<leader>tH","<cmd>TSHighlightCapturesUnderCursor<CR>",opts)
-- keymap("n","<leader>fa","<cmd>Telescope find_files follow=true no_ignore=true hidden=true <CR>",opts)
-- keymap("n","<leader>ff","<cmd>lua require'telescope.builtin'.find_files{}<CR>",opts)
-- keymap("n","<leader>fw","<cmd>lua require'telescope.builtin'.live_grep{}<CR>",opts)
-- keymap("n","<leader>fb","<cmd>lua require'telescope.builtin'.buffers{}<CR>",opts)
-- keymap("n","<leader>fh","<cmd>lua require'telescope.builtin'.help_tags{}<CR>",opts)
-- keymap("n","<leader>fo","<cmd>lua require'telescope.builtin'.oldfiles{}<CR>",opts)
-- keymap("n","<leader>fB","<cmd>lua require'telescope.builtin'.builtin{}<CR>",opts)
-- keymap("n","<leader>f/","<cmd>lua require'telescope.builtin'.current_buffer_fuzzy_find{}<CR>",opts)
-- keymap("n","<leader>f'","<cmd>lua require'telescope.builtin'.marks{}<CR>",opts)
-- keymap("n","<leader>fg","<cmd>lua require'telescope.builtin'.git_files{}<CR>",opts)
-- keymap("n","<leader>th","<cmd>lua require'telescope.builtin'.colorscheme{}<CR>",opts)

-- Terminal navigation
-- keymap("t", "<esc>", "<C-\\><C-N>",        term_opts)
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Terminal tabs/splits/float
keymap("n","<leader>tB","<C-w>T<CR>",opts)                                                                                                                                                              -- Move terminal to Buffer
keymap("n","<leader>tf",":ToggleTerm direction=float <CR>",opts)                                                                                                                                        -- float termininal
keymap("n","<leader>tt",":ToggleTerm <CR>",opts)                                                                                                                                                        -- toggle terminal
keymap("n","<leader>tT",":lua vim.cmd[[terminal]]                      vim.cmd[[startinsert | set ft=terminal nonumber ]]<CR>",opts)                                                                    -- Tab terminal
keymap("n","<leader>te",":lua vim.cmd[[tabnew|terminal]]               vim.cmd[[startinsert | set ft=terminal nonumber ]] require('bufferline').setup{options={always_show_bufferline=true}}<CR>",opts) -- external terminal
keymap("n","<leader>tE",":lua vim.cmd[[ToggleTerm direction=tab]]      require('bufferline').setup{options={always_show_bufferline=true}}<CR>",opts)                                                    -- External terminal
-- keymap("n","<leader>tz",":lua vim.cmd[[vs +te]]                        vim.cmd[[startinsert | set ft=vs-terminal nonumber laststatus=0 cmdheight=3 ]]<CR>",opts)
-- keymap("n","<leader>tZ",":lua vim.cmd[[sp +te]]                        vim.cmd[[startinsert | set ft=sp-terminal nonumber laststatus=3 cmdheight=2 ]]<CR>",opts)
-- keymap("n","<leader>ts",":vsplit +te | vertical resize 80              | setlocal ft=vs-terminal nonumber laststatus=0 cmdheight=3 | startinsert <CR>",opts)
-- keymap("n","<leader>tS",":split +te | resize 10                        | setlocal ft=sp-terminal nonumber laststatus=3 cmdheight=2 | startinsert <CR>",opts)
keymap("n","<leader>tv",":vsplit | vertical resize 80 | term<CR>",opts)
keymap("n","<leader>tV",":split | resize 10 | term<CR>",opts)
keymap("n","<leader>v",":ToggleTerm direction=vertical size=80<CR>",opts)
keymap("n","<leader>V",":ToggleTerm direction=horizontal size=10<CR>",opts)

-- Toggle buffer
keymap("n","<leader>tbt","<cmd>lua require('bufferline').setup{options={always_show_bufferline=true}}<CR>",opts)
keymap("n","<leader>tbf","<cmd>lua require('bufferline').setup{options={always_show_bufferline=false}} <CR>",opts)
keymap("n","<leader>tb0","<cmd>set showtabline=0<CR>",opts)

-- Toggle Codi
keymap("n","<leader>tc0",":Codi!<CR>",opts)
keymap("n","<leader>tc1",":Codi<CR>",opts)

-- Terminal Compile/Execute (%=file)
keymap("n","<leader>tcb","!bash %<CR>",opts)
keymap("n","<leader>tcp","!python %<CR>",opts)
keymap("n","<leader>tcc",":w! | !compiler '<c-r>%'<CR>",opts)
keymap("n","<leader>tco","!opout<CR>",opts)

-- Terminal Column Format
keymap("v","<leader>tC",":'<,'>!column -t<CR>",opts)

-- Terminal to left/down/up/right
keymap("n", "<leader>tH", "<C-w><S-h>", opts)
keymap("n", "<leader>tJ", "<C-w><S-j>", opts)
keymap("n", "<leader>tK", "<C-w><S-k>", opts)
keymap("n", "<leader>tL", "<C-w><S-l>", opts)

-- Toggle HighlightSearch/HideAll
keymap("n","<leader>th",":set hlsearch!<CR>",opts)

-- Toggle cursorline/linehighlight
keymap("n","<leader>tn",":set cursorline!<CR>",opts)
keymap("n","<leader>tN",":call ToggleStatusLine()<CR>",opts)

-- Toggle Maximize/Zoom
keymap("n","<leader>tm","<c-w>_ | <c-w>|",opts)
keymap("n","<leader>t=","<c-w>=",opts)

-- Terminal Rotate r=down/right R=up/left
keymap("n", "<leader>tr", "<C-w>r", opts)
keymap("n", "<leader>tR", "<C-w><S-R>", opts)

-- Toggle Swap/Switch window
keymap("n", "<leader>ts", "<C-w>x", opts)
keymap("n","<leader>tS",":call SwitchWindow2()<CR>",opts)
keymap("t","<leader>tS","<C-\\><C-n>:call WinBufSwap()<CR><Esc>",opts)

-- Terminal Paste from secondary clipboard
keymap("n","<leader>tp",'"*p',opts)
-- keymap("n","<leader>P",'"*P',opts)
-- keymap("v","<leader>p",'"*p',opts)
-- keymap("v","<leader>P",'"*P',opts)

-- Terminal Copy to secondary clipboard
keymap("n","<leader>ty",'"*yg_',opts)
-- keymap("n","<leader>Y",'"*yy',opts)
-- keymap("v","<leader>y",'"*y',opts)
-- keymap("v","<leader>Y",'"*y',opts)
