local options = {
  backup = false,                          -- creates a backup file
  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  cmdheight = 0,                           -- more space in the neovim command line for displaying messages
  completeopt = {"menu","menuone","noinsert"}, -- mostly just for cmp
  conceallevel = 0,                        -- so that `` is visible in markdown files
  copyindent = true,                       -- Copy the previous indentation on autoindenting
  cursorline = true,                       -- highlight the current line
  expandtab = true,                        -- convert tabs to spaces
  fileencoding = "utf-8",                  -- the encoding written to a file
  -- fileencoding = "utf-16",                  -- the encoding written to a file
  fillchars = { eob = " " },               -- Disable `~` on nonexistent lines
  -- guicursor = a,
  guifont = "monospace:h17",               -- the font used in graphical neovim applications
  hlsearch = true,                         -- highlight all matches on previous search pattern
  ignorecase = true,                       -- ignore case in search patterns
  lazyredraw = true,                       -- lazily redraw screen
  laststatus = 3,                          -- laststatus=3 global status line (line between splits)
  mouse = "a",                             -- allow the mouse to be used in neovim
  number = true,                           -- set numbered lines
  numberwidth = 4,                         -- set number column width to 2 {default 4}
  preserveindent = true,                   -- Preserve indent structure as much as possible
  pumheight = 10,                          -- pop up menu height
  relativenumber = false,                  -- set relative numbered lines
  scrolloff = 8,                           -- vertical scrolloff
  shiftwidth = 2,                          -- the number of spaces inserted for each indentation
  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  showtabline = 1,                         -- 0) never show; 1) show tabs if more than 2; 2) always show
  sidescrolloff = 8,                       -- horizontal scrolloff
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  smartcase = true,                        -- smart case
  smartindent = true,                      -- make indenting smarter again
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  swapfile = true,                         -- creates a swapfile
  tabstop = 2,                             -- insert 2 spaces for a tab
  termguicolors = true,                    -- set term gui colors (most terminals support this)
  timeoutlen = 500,                        -- time to wait for a mapped sequence to complete (in milliseconds)
  -- undofile = true,                         -- enable persistent undo
  updatetime = 300,                        -- faster completion (4000ms default)
  virtualedit = "all",                     -- allow cursor bypass end of line
  visualbell = true,                       -- visual bell instead of beeping
  wrap = false,                            -- display lines as one long line
  writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
}

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
-- vim.cmd [[set iskeyword+="│"]]
vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work
