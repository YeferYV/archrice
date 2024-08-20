-- vim.opt.completeopt = { "menuone", "noinsert" } -- mostly just for cmp
-- vim.opt.autoindenting = true                    -- indent when creating newline
-- vim.opt.conceallevel = 0                        -- so that `` is visible in markdown files
-- vim.opt.copyindent = true                       -- https://www.reddit.com/r/vim/comments/3swbps/can_i_make_vim_be_smarter_about_indentation/
-- vim.opt.cursorline = false                      -- highlight the current line
-- vim.opt.fileencoding = "utf-8"                  -- the encoding written to a file
-- vim.opt.guicursor = "a"                         -- all
-- vim.opt.guifont = "monospace:h17"               -- the font used in graphical neovim applications
-- vim.opt.mouse = "a"                             -- allow the mouse to be used in neovim
-- vim.opt.paste = true                            -- (conflictswith/overrides nvim-cmp) allow auto-indenting pasted text
-- vim.opt.preserveindent = true                   -- Preserve indent structure as much as possible
-- vim.opt.pumheight = 10                          -- pop up menu height
-- vim.opt.relativenumber = false                  -- set relative numbered lines
-- vim.opt.showtabline = 1                         -- 0) never show; 1) show tabs if more than 2; 2) always show
-- vim.opt.smartindent = true                      -- add an indent level inside braces
-- vim.opt.swapfile = true                         -- creates a swapfile
-- vim.opt.undofile = false                        -- enable persistent undo
-- vim.opt.updatetime = 300                        -- faster completion (4000ms default)
-- vim.opt.whichwrap = "bs<>[]hl"                  -- which keys are allowed to travel to prev/next line
-- vim.opt.visualbell = true                       -- visual bell instead of beeping

-- ╭──────────────────╮
-- │ Retronvim's Opts │
-- ╰──────────────────╯

vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.expandtab = true          -- convert tabs to spaces
vim.opt.hlsearch = true           -- highlight all matches on previous search pattern
vim.opt.ignorecase = true         -- ignore case in search patterns
vim.opt.shiftwidth = 2            -- the number of spaces inserted for each indentation
vim.opt.smartcase = true          -- smart case
vim.opt.splitbelow = true         -- force all horizontal splits to go below current window
vim.opt.splitright = true         -- force all vertical splits to go to the right of current window
vim.opt.tabstop = 2               -- insert 2 spaces for a tab
vim.opt.timeoutlen = 500          -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.wrap = false              -- display lines as one long line
vim.opt.shortmess:append "c"      -- don't give |ins-completion-menu| messages
vim.opt.iskeyword:append "-"      -- hyphenated words recognized by searches

if not vim.g.vscode then
  vim.opt.cmdheight = 0                               -- more space in the neovim command line for displaying messages
  vim.opt.laststatus = 3                              -- laststatus=3 global status line (line between splits)
  vim.opt.number = true                               -- set numbered lines
  vim.opt.scrolloff = 8                               -- vertical scrolloff
  vim.opt.sidescrolloff = 8                           -- horizontal scrolloff
  vim.opt.virtualedit = "all"                         -- allow cursor bypass end of line
  vim.g.mapleader = " "                               -- <leader> key
  vim.o.foldcolumn = '1'                              -- if '1' will show clickable fold signs
  vim.o.foldlevel = 99                                -- Disable folding at startup
  vim.o.foldmethod = "expr"                           -- expr = specify an expression to define folds
  vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()' -- folding using treesitter (grammar required)
  vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
  vim.o.statuscolumn =
  '%{foldlevel(v:lnum) > foldlevel(v:lnum - 1) ? (foldclosed(v:lnum) == -1 ? "" : "") : " " }%s%l '

  vim.fn.sign_define("DiagnosticSignError", { texthl = "DiagnosticSignError", text = "" })
  vim.fn.sign_define("DiagnosticSignWarn", { texthl = "DiagnosticSignWarn", text = "" })
  vim.fn.sign_define("DiagnosticSignHint", { texthl = "DiagnosticSignHint", text = "" })
  vim.fn.sign_define("DiagnosticSignInfo", { texthl = "DiagnosticSignInfo", text = "" })
end
