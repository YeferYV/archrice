-- ╭──────╮
-- │ Opts │
-- ╰──────╯

vim.opt.autoindent = true -- auto indent new lines
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.copyindent = true -- Copy the previous indentation on autoindenting
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.hlsearch = true -- highlight all matches on previous search pattern
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.number = true -- set numbered lines
vim.opt.numberwidth = 4 -- set number column width to 2 {default 4}
vim.opt.preserveindent = true -- Preserve indent structure as much as possible
vim.opt.scrolloff = 8 -- vertical scrolloff
vim.opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
vim.opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
vim.opt.sidescrolloff = 8 -- horizontal scrolloff
vim.opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
vim.opt.smartcase = true -- smart case
vim.opt.smartindent = true -- make indenting smarter again
vim.opt.tabstop = 2 -- insert 2 spaces for a tab
vim.opt.termguicolors = true -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 500 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.wrap = false -- display lines as one long line
vim.opt.shortmess:append "c" -- don't give |ins-completion-menu| messages
vim.opt.iskeyword:append "-" -- hyphenated words recognized by searches
vim.g.indent_object_ignore_blank_line = false

-- ╭─────────╮
-- │ Plugins │
-- ╰─────────╯

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  return
end

local opts = {
  ui = { border = "rounded" },
  defaults = { lazy = true },
  performance = {
    rtp = {
      disabled_plugins = { "tohtml", "gzip", "zipPlugin", "netrwPlugin", "tarPlugin" },
    },
  },
}

local plugins = {

  -- Automation
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    commit = "729d83ecb990dc2b30272833c213cc6d49ed5214",
    event = "VeryLazy"
  },

  -- Motions
  { "tpope/vim-repeat", commit = "24afe922e6a05891756ecf331f39a1f6743d3d5a", event = "VeryLazy" },
  { "justinmk/vim-sneak", commit = "93395f5b56eb203e4c8346766f258ac94ea81702", event = "VeryLazy" },
  { "machakann/vim-columnmove", commit = "21a43d809a03ff9bf9946d983d17b3a316bf7a64", event = "VeryLazy" },
  { "phaazon/hop.nvim", commit = "90db1b2c61b820e230599a04fedcd2679e64bd07", config = true, event = "VeryLazy" },

  -- Text-Objects
  -- { "paraduxos/vim-indent-object", branch = "new_branch", event = "VeryLazy" }, -- weird bug with vscode opening problem-panel -- incremental-repressing + respects-blanklines + vimrepeat + VisualRepeatable(e.g mini.comment is noVisualRepeable)
  { "echasnovski/mini.nvim", commit = "2d70ae2b0faade0b5ab8524e155f47ca829db5f2" },
  {
    "nvim-treesitter/nvim-treesitter",
    commit = "9161093fc7e13b12aa5bc86c641768c049d43a26",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects", commit = "b55fe6175f0001347a433c9df358c8cbf8a4e90f" },
      { "RRethy/nvim-treesitter-textsubjects", commit = "b913508f503527ff540f7fe2dcf1bf1d1f259887" },
    }
  },
  { "coderifous/textobj-word-column.vim", commit = "cb40e1459817a7fa23741ff6df05e4481bde5a33", event = "VeryLazy" },
  { "svermeulen/vim-easyclip", commit = "f1a3b95463402b30dd1e22dae7d0b6ea858db2df", event = "VeryLazy" },
  {
    "chrisgrieser/nvim-various-textobjs",
    commit = "eba7c5d09c97ac8a73bad5793618b7d376d91048",
    config = { useDefaultKeymaps = false, lookForwardSmall = 30, lookForwardBig = 30 },
  },

  -- UI
  { 'olivercederborg/poimandres.nvim' },

}

lazy.setup(plugins, opts)

-- ╭──────────────╮
-- │ Autocommands │
-- ╰──────────────╯

if not vim.g.vscode then
  vim.cmd [[ autocmd VimEnter * :TSEnable highlight" ]]
  require("poimandres").setup({ disable_background = true })
  vim.cmd [[ color poimandres | hi Comment guifg=#444444 | hi Visual guifg=none guibg=#1c1c1c ]]
  vim.opt.virtualedit = "all" -- allow cursor bypass end of line
end

-- Illuminate disable underline
vim.cmd [[
  hi   def IlluminatedWordText               guifg=none     guibg=#080811  gui=none
  hi   def IlluminatedWordRead               guifg=none     guibg=#080811  gui=none
  hi   def IlluminatedWordWrite              guifg=none     guibg=#080811  gui=none
]]

------------------------------------------------------------------------------------------------------------------------

vim.cmd [[

  augroup _general_settings
    autocmd!
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200})
    autocmd BufEnter * :set formatoptions-=cro
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  augroup end

  augroup _hightlight_whitespaces
    autocmd!
    autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
    highlight ExtraWhitespace ctermbg=red guibg=red
    autocmd InsertLeave * redraw!
    match ExtraWhitespace /\s\+$\| \+\ze\t/
    autocmd BufWritePre * :%s/\s\+$//e
  augroup end

]]

------------------------------------------------------------------------------------------------------------------------

local M = {}

M.EnableAutoNoHighlightSearch = function()
  vim.on_key(function(char)
    if vim.fn.mode() == "n" then
      local new_hlsearch = vim.tbl_contains({ "<Up>", "<Down>", "<CR>", "n", "N", "*", "#", "?", "/" },
        vim.fn.keytrans(char))
      if vim.opt.hlsearch:get() ~= new_hlsearch then vim.cmd [[ noh ]] end
    end
  end, vim.api.nvim_create_namespace "auto_hlsearch")
end

M.DisableAutoNoHighlightSearch = function()
  vim.on_key(nil, vim.api.nvim_get_namespaces()["auto_hlsearch"])
  vim.cmd [[ set hlsearch ]]
end

M.EnableAutoNoHighlightSearch() -- autostart

------------------------------------------------------------------------------------------------------------------------

_G.FeedKeysCorrectly = function(keys)
  local feedableKeys = vim.api.nvim_replace_termcodes(keys, true, false, true)
  vim.api.nvim_feedkeys(feedableKeys, "n", true)
end

------------------------------------------------------------------------------------------------------------------------

function GotoTextObj_Callback()
  FeedKeysCorrectly(vim.g.dotargs)
end

_G.GotoTextObj = function(action)
  vim.g.dotargs = action
  vim.o.operatorfunc = 'v:lua.GotoTextObj_Callback'
  return "g@"
end

------------------------------------------------------------------------------------------------------------------------

-- https://thevaluable.dev/vim-create-text-objects
-- select indent by the same level:
M.select_indent = function(check_blank_line)
  local start_indent = vim.fn.indent(vim.fn.line('.'))

  if check_blank_line then
    match_blank_line = function(line) return string.match(vim.fn.getline(line), '^%s*$') end
  else
    match_blank_line = function(line) return false end
  end

  local prev_line = vim.fn.line('.') - 1
  while vim.fn.indent(prev_line) == start_indent or match_blank_line(prev_line) do
    vim.cmd('-')
    prev_line = vim.fn.line('.') - 1
  end

  vim.cmd('normal! 0V')

  local next_line = vim.fn.line('.') + 1
  while vim.fn.indent(next_line) == start_indent or match_blank_line(next_line) do
    vim.cmd('+')
    next_line = vim.fn.line('.') + 1
  end
end

------------------------------------------------------------------------------------------------------------------------

-- next/prev same level indent:
M.next_indent = function(next)
  local start_indent = vim.fn.indent(vim.fn.line('.'))
  local next_line = next and ( vim.fn.line('.') + 1 ) or ( vim.fn.line('.') - 1 )
  local sign = next and '+' or '-'

  while vim.fn.indent(next_line) == start_indent do
    vim.cmd(sign)
    next_line = next and ( vim.fn.line('.') + 1 ) or ( vim.fn.line('.') - 1 )
  end

  while vim.fn.indent(next_line) > start_indent or string.match(vim.fn.getline(next_line), '^%s*$')  do
    vim.cmd(sign)
    next_line = next and ( vim.fn.line('.') + 1 ) or ( vim.fn.line('.') - 1 )
  end

  vim.cmd(sign)
end

------------------------------------------------------------------------------------------------------------------------

-- ╭──────╮
-- │ Mini │
-- ╰──────╯

local mini_status_ok, mini_ai = pcall(require, 'mini.ai')
if not mini_status_ok then return end
local spec_treesitter = mini_ai.gen_spec.treesitter

require("mini.ai").setup({
  custom_textobjects = {
    q = spec_treesitter({ a = '@call.outer', i = '@call.inner', }),
    Q = spec_treesitter({ a = '@class.outer', i = '@class.inner', }),
    g = spec_treesitter({ a = '@comment.outer', i = '@comment.inner', }),
    G = spec_treesitter({ a = '@conditional.outer', i = '@conditional.inner', }),
    B = spec_treesitter({ a = '@block.outer', i = '@block.inner', }),
    F = spec_treesitter({ a = '@function.outer', i = '@function.inner', }),
    L = spec_treesitter({ a = '@loop.outer', i = '@loop.inner', }),
    P = spec_treesitter({ a = '@parameter.outer', i = '@parameter.inner', }),
    R = spec_treesitter({ a = '@return.outer', i = '@return.inner', }),
    ["="] = spec_treesitter({ a = '@assignment.rhs', i = '@assignment.lhs', }),
    ["+"] = spec_treesitter({ a = '@assignment.outer', i = '@assignment.inner', }),
    ["*"] = spec_treesitter({ a = '@number.outer', i = '@number.inner', }),
    a = require('mini.ai').gen_spec.argument({ brackets = { '%b()' } }),
    k = { { '\n.-[=:]', '^.-[=:]' }, '^%s*()().-()%s-()=?[!=<>\\+-\\*]?[=:]' },
    v = { { '[=:]()%s*().-%s*()[;,]()', '[=:]=?()%s*().*()().$' } },
    u = { { "%b''", '%b""', '%b``' }, '^.().*().$' },
    n = { '[-+]?()%f[%d]%d+()%.?%d*' },
    x = { '#()%x%x%x%x%x%x()' },
    r = { '%S()%s+()%S' },
    A = function()
      local from = { line = 1, col = 1 }
      local to = {
        line = vim.fn.line('$'),
        col = math.max(vim.fn.getline('$'):len(), 1)
      }
      return { from = from, to = to }
    end,
    i = function()
      local start_indent = vim.fn.indent(vim.fn.line('.'))
      if string.match(vim.fn.getline('.'), '^%s*$') then return { from = nil, to = nil } end

      local prev_line = vim.fn.line('.') - 1
      while vim.fn.indent(prev_line) >= start_indent do
          vim.cmd('-')
          prev_line = vim.fn.line('.') - 1
      end

      from = { line = vim.fn.line('.'), col = 1 }

      local next_line = vim.fn.line('.') + 1
      while vim.fn.indent(next_line) >= start_indent do
          vim.cmd('+')
          next_line = vim.fn.line('.') + 1
      end

      to = { line = vim.fn.line('.'), col = vim.fn.getline(vim.fn.line('.')):len() }
      return { from = from, to = to }
    end
  },
  user_textobject_id = true,
  mappings = {
    around = 'a',
    inside = 'i',
    around_next = 'aN',
    inside_next = 'iN',
    around_last = 'al',
    inside_last = 'il',
    goto_left = 'g[',
    goto_right = 'g]',
  },
  n_lines = 50,
  search_method = 'cover_or_next',
})

require('mini.align').setup({
  mappings = {
    start = 'ga',
    start_with_preview = 'gA',
  },
  options = {
    split_pattern = '',
    justify_side = 'left',
    merge_delimiter = '',
  },
  steps = {
    pre_split = {},
    split = nil,
    pre_justify = {},
    justify = nil,
    pre_merge = {},
    merge = nil,
  },
})

require('mini.bracketed').setup({
  buffer     = { suffix = 'b', options = {} },
  comment    = { suffix = 'c', options = {} },
  conflict   = { suffix = 'x', options = {} },
  diagnostic = { suffix = 'd', options = {} },
  file       = { suffix = 'f', options = {} },
  indent     = { suffix = 'n', options = {} },
  jump       = { suffix = 'j', options = {} },
  location   = { suffix = 'l', options = {} },
  oldfile    = { suffix = 'o', options = {} },
  quickfix   = { suffix = 'q', options = {} },
  treesitter = { suffix = 't', options = {} },
  undo       = { suffix = 'u', options = {} },
  window     = { suffix = 'w', options = {} },
  yank       = { suffix = 'y', options = {} },
})

require('mini.comment').setup({
  options = {
    custom_commentstring = nil,
    ignore_blank_line = false,
    start_of_line = false,
    pad_comment_parts = true,
  },
  mappings = {
    comment = 'gc',
    comment_line = 'gcc',
    textobject = 'gc',
  },
  hooks = {
    pre = function() require('ts_context_commentstring.internal').update_commentstring() end,
    post = function() end,
  },
})

require('mini.indentscope').setup({
  draw = {
    delay = 10,
    animation = nil --<function: implements constant 20ms between steps>,
  },
  mappings = {
    object_scope = '',
    object_scope_with_border = '',
    goto_top = '[ii',
    goto_bottom = ']ii',
  },
  options = {
    border = 'both',
    indent_at_cursor = false,
    try_as_border = false,
  },
  symbol = '',
})

require('mini.splitjoin').setup({
  mappings = {
    toggle = 'gS',
    split = '',
    join = '',
  },
  detect = {
    brackets = nil,
    separator = ',',
    exclude_regions = nil,
  },
  split = {
    hooks_pre = {},
    hooks_post = {},
  },
  join = {
    hooks_pre = {},
    hooks_post = {},
  },
})

require('mini.surround').setup({
  custom_surroundings = nil,
  highlight_duration = 500,
  mappings = {
    add = 'ys', -- Add surrounding in Normal and Visual modes
    delete = 'ds', -- Delete surrounding
    find = 'zf', -- Find surrounding (to the right)
    find_left = 'zF', -- Find surrounding (to the left)
    highlight = 'zh', -- Highlight surrounding
    replace = 'cs', -- Replace surrounding
    update_n_lines = 'zn', -- Update `n_lines`
    suffix_last = 'l', -- Suffix to search with "prev" method
    suffix_next = 'N', -- Suffix to search with "next" method
  },
  n_lines = 20,
  search_method = 'cover',
})

-- ╭────────────╮
-- │ Treesitter │
-- ╰────────────╯

local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then return end

configs.setup {
  ensure_installed = { "python", "bash", "javascript", "json", "html", "css", "c", "lua" },
  autopairs = {
    enable = true,
  },
  highlight = { -- enable highlighting for all file types
    enable = false, -- you can also use a table with list of langs here (e.g. { "python", "javascript" })
    use_languagetree = false,
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true, disable = { "python", "yaml" } },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  incremental_selection = {
    enable = true, -- you can also use a table with list of langs here (e.g. { "python", "javascript" })
    disable = { "yaml" },
    keymaps = { -- mappings for incremental selection (visual mappings)
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-]>',
      node_decremental = '<c-[>', -- showkey -a <c-backspace> outputs ^H
    }
  },
  textobjects = {
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_previous_start = {
        ['[aq'] = '@call.outer',
        ['[aQ'] = '@class.outer',
        ['[ag'] = '@comment.outer',
        ['[aG'] = '@conditional.outer',
        ['[aB'] = '@block.outer',
        ['[aF'] = '@function.outer',
        ['[aL'] = '@loop.outer',
        ['[aP'] = '@parameter.outer',
        ['[aR'] = '@return.outer',
        ['[a='] = '@assignment.outer',
        ['[a+'] = '@assignment.lhs',
        ["[aX"] = { query = "@scope", query_group = "locals", desc = "Prev scope" },
        ["[["] = { query = "@fold", query_group = "folds", desc = "Previous Start Fold" },

        ['[iq'] = '@call.inner',
        ['[iQ'] = '@class.inner',
        ['[ig'] = '@comment.inner',
        ['[iG'] = '@conditional.inner',
        ['[iB'] = '@block.inner',
        ['[iF'] = '@function.inner',
        ['[iL'] = '@loop.inner',
        ['[iP'] = '@parameter.inner',
        ['[iR'] = '@return.inner',
        ['[i='] = '@assignment.inner',
        ['[i+'] = '@assignment.rhs',
      },
      goto_next_start = {
        [']aq'] = '@call.outer',
        [']aQ'] = '@class.outer',
        [']ag'] = '@comment.outer',
        [']aG'] = '@conditional.outer',
        [']aB'] = '@block.outer',
        [']aF'] = '@function.outer',
        [']aL'] = '@loop.outer',
        [']aP'] = '@parameter.outer',
        [']aR'] = '@return.outer',
        [']a='] = '@assignment.outer',
        [']a+'] = '@assignment.lhs',
        ["]aX"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
        ["]]"] = { query = "@fold", query_group = "folds", desc = "Next Start Fold" },

        [']iq'] = '@call.inner',
        [']iQ'] = '@class.inner',
        [']ig'] = '@comment.inner',
        [']iG'] = '@conditional.inner',
        [']iB'] = '@block.inner',
        [']iF'] = '@function.inner',
        [']iL'] = '@loop.inner',
        [']iP'] = '@parameter.inner',
        [']iR'] = '@return.inner',
        [']i='] = '@assignment.inner',
        [']i+'] = '@assignment.rhs',
      },
      goto_previous_end = {
        ['[eaq'] = '@call.outer',
        ['[eaQ'] = '@class.outer',
        ['[eag'] = '@comment.outer',
        ['[eaG'] = '@conditional.outer',
        ['[eaB'] = '@block.outer',
        ['[eaF'] = '@function.outer',
        ['[eaL'] = '@loop.outer',
        ['[eaP'] = '@parameter.outer',
        ['[eaR'] = '@return.outer',
        ['[ea='] = '@assignment.outer',
        ['[ea+'] = '@assignment.lhs',
        ["[eX"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
        ["[e["] = { query = "@fold", query_group = "folds", desc = "Previous End Fold" },

        ['[eiq'] = '@call.inner',
        ['[eiQ'] = '@class.inner',
        ['[eig'] = '@comment.inner',
        ['[eiG'] = '@conditional.inner',
        ['[eiB'] = '@block.inner',
        ['[eiF'] = '@function.inner',
        ['[eiL'] = '@loop.inner',
        ['[eiP'] = '@parameter.inner',
        ['[eiR'] = '@return.inner',
        ['[ei='] = '@assignment.inner',
        ['[ei+'] = '@assignment.rhs',
      },
      goto_next_end = {
        [']eaq'] = '@call.outer',
        [']eaQ'] = '@class.outer',
        [']eag'] = '@comment.outer',
        [']eaG'] = '@conditional.outer',
        [']eaB'] = '@block.outer',
        [']eaF'] = '@function.outer',
        [']eaL'] = '@loop.outer',
        [']eaP'] = '@parameter.outer',
        [']eaR'] = '@return.outer',
        [']ea='] = '@assignment.outer',
        [']ea+'] = '@assignment.lhs',
        ["]eX"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
        ["]e]"] = { query = "@fold", query_group = "folds", desc = "Next End Fold" },

        [']eiq'] = '@call.inner',
        [']eiQ'] = '@class.inner',
        [']eig'] = '@comment.inner',
        [']eiG'] = '@conditional.inner',
        [']eiB'] = '@block.inner',
        [']eiF'] = '@function.inner',
        [']eiL'] = '@loop.inner',
        [']eiP'] = '@parameter.inner',
        [']eiR'] = '@return.inner',
        [']ei='] = '@assignment.inner',
        [']ei+'] = '@assignment.rhs',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['>,'] = '@parameter.inner',
      },
      swap_previous = {
        ['<,'] = '@parameter.inner',
      },
    },
  },
  textsubjects = {
    enable = true,
    prev_selection = 'Q', -- (Optional) keymap to select the previous selection
    keymaps = {
      ['K'] = 'textsubjects-smart', -- useful for block of comments
      ['aK'] = 'textsubjects-container-outer',
      ['iK'] = 'textsubjects-container-inner',
    },
  },
}

-- ╭────────────╮
-- │ Automation │
-- ╰────────────╯

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
local map = vim.keymap.set

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Macros and :normal <keys> repeatable
keymap("n", "U", "@:", opts)

-- Quick commands
if not vim.g.vscode then

  -- Replace all/visual_selected
  map({ "n" }, "<C-s>", ":%s//g<Left><Left>", { noremap = true, silent = false })
  map({ "x" }, "<C-s>", ":s//g<Left><Left>", { noremap = true, silent = false })

  keymap("n", "<S-q>", "<cmd>quit<CR>", opts)
  keymap("n", "<S-r>", "<cmd>write<cr>", opts)

end
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)
keymap("n", "J", "10gj", opts)
keymap("n", "K", "10gk", opts)
keymap("n", "H", "10h", opts)
keymap("n", "L", "10l", opts)

-- Forward yank/paste
keymap("n", 'Y', 'yg_', { noremap = true, silent = true, desc = "Forward yank" })
keymap("v", 'P', 'g_P', { noremap = true, silent = true, desc = "Forward Paste" })

-- Unaltered clipboard (visualrepeatable)
keymap("v", 'p', '"_c<c-r>+<esc>', { noremap = true, silent = true, desc = "Paste Unaltered" })

-- ╭────────────────╮
-- │ leader keymaps │
-- ╰────────────────╯

-- setting leaderkey
keymap("", "<space>", "<Nop>", opts)
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- Buffer keymaps
keymap("n", "g,", "g,", { noremap = true, silent = true, desc = "go forward in :changes" }) -- Formatting will lose track of changes
keymap("n", "g;", "g;", { noremap = true, silent = true, desc = "go backward in :changes" }) -- Formatting will lose track of changes
keymap("n", "gb;", "<C-6>", { noremap = true, silent = true, desc = "go to last buffer" })
keymap("n", "<C-;>", "<C-6>", { noremap = true, silent = true, desc = "go to last buffer" })

-- Explorer
if not vim.g.vscode then
  keymap("n", "<C-h>", ":wincmd h<cr>", { noremap = true, silent = true, desc = "Window Left" })
  keymap("n", "<C-j>", ":wincmd j<cr>", { noremap = true, silent = true, desc = "Window Down" })
  keymap("n", "<C-k>", ":wincmd k<cr>", { noremap = true, silent = true, desc = "Window Up" })
  keymap("n", "<C-l>", ":wincmd l<cr>", { noremap = true, silent = true, desc = "Window Right" })
  keymap("n", "<A-Left>", ":vertical resize +2<cr>", { noremap = true, silent = true, desc = "Resize Left" })
  keymap("n", "<A-Down>", ":resize +2<cr>", { noremap = true, silent = true, desc = "Resize Down" })
  keymap("n", "<A-Up>", ":resize -2<cr>", { noremap = true, silent = true, desc = "Resize Up" })
  keymap("n", "<A-Right>", ":vertical resize -2<cr>", { noremap = true, silent = true, desc = "Resize Right" })
  keymap("n", "<Left>", ":bprevious<cr>", { noremap = true, silent = true, desc = "Buffer prev" })
  keymap("n", "<Right>", ":bnext<cr>", { noremap = true, silent = true, desc = "Buffer next" })
  keymap("n", "<leader>x", ":bdelete<cr>", { noremap = true, silent = true, desc = "Buffer delete" })
  keymap("n", "<leader>o", ":Lexplore<cr>", { noremap = true, silent = true, desc = "Toggle Explorer" })
  keymap("n", "<leader>u0", ":set showtabline=0<cr>", { noremap = true, silent = true, desc = "Buffer Hide" })
  keymap("n", "<leader>u1", ":set showtabline=1<cr>", { noremap = true, silent = true, desc = "Tab Hide if < 1" })
  keymap("n", "<leader>u2", ":lua require('mini.tabline').setup()<cr>",
    { noremap = true, silent = true, desc = "Buffer Show" })
end

-- Visual Fold (Vjzf: create fold, zj/zk: next/previous fold), FormatColumn and FormatComment
keymap("v", "<leader>z", ":'<,'>fold      <CR>", { noremap = true, silent = true, desc = "Fold" })
keymap("v", "<leader>Z", ":'<,'>!column -t<CR>", { noremap = true, silent = true, desc = "Format Column" })
keymap("v", "<leader>gw", "gw", { noremap = true, silent = true, desc = "Format Comment" })

-- Visual increment/decrement numbers
keymap("v", "<leader>gi", "g<C-a>", { noremap = true, silent = true, desc = "Increment numbers" })
keymap("v", "<leader>gd", "g<C-x>", { noremap = true, silent = true, desc = "Decrement numbers" })

-- _highlight_search
map("n", "<leader>h", "<cmd>noh<cr>", { desc = "NoHighlight" })
map("n", "<leader>uh", function() M.EnableAutoNoHighlightSearch() end, { desc = "Enable AutoNoHighlightSearch" })
map("n", "<leader>uH", function() M.DisableAutoNoHighlightSearch() end, { desc = "Disable AutoNoHighlightSearch" })
map("n", "<leader>uu", function() vim.fn.VSCodeNotify("editor.gotoParentFold") vim.call("repeat#set", "\\uu") end,
  { desc = "Disable AutoNoHighlightSearch" })

-- ╭──────────────╮
-- │ Text Objects │
-- ╰──────────────╯

-- _goto_textobj_(dotrepeat)
map('n', "g.", function() return GotoTextObj("") end, { expr = true, desc = "StartOf TextObj" })
map('n', "g:", function() return GotoTextObj(":normal `[v`]<cr><esc>") end, { expr = true, desc = "EndOf TextObj" })

-- _last_change_text_object
map("o", 'gm', "<cmd>normal! `[v`]<cr>", { desc = "Last change textobj" })
map("x", 'gm', "`[o`]", { desc = "Last change textobj" })

-- _jump_to_last_change
map({ "n", "o", "x" }, "gl", "`.", { silent = true, desc = "Jump to last change" })

-- _mini_comment_(not_showing_desc)_(next/prev_autojump_unsupported)_(gC and gk visual support for gc and gk textobj)
map({ "o" }, 'gk', '<Cmd>lua MiniComment.textobject()<CR>', { silent = true, desc = "BlockComment textobj" })
map({ "x" }, 'gk', ':<C-u>normal "zygkgv<cr>', { silent = true, desc = "BlockComment textobj" })
map({ "x" }, 'gK', '<Cmd>lua MiniComment.textobject()<cr>', { silent = true, desc = "RestOfComment textobj" })
map({ "x" }, 'gC', ':<C-u>normal "zygcgv<cr>', { silent = true, desc = "WholeComment textobj" })

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
keymap("x", 'iz', ":<C-U>silent!normal![zjV]zk<CR>", { silent = true, desc = "inner fold textobj" })
keymap("o", 'iz', ":normal Vif<CR>", { silent = true, desc = "inner fold textobj" })
keymap("x", 'az', ":<C-U>silent!normal![zV]z<CR>", { silent = true, desc = "outer fold textobj" })
keymap("o", 'az', ":normal Vaf<CR>", { silent = true, desc = "outer fold textobj" })

-- Mini Indent Scope textobj:
map({ "o", "x" }, "ii", function() require("mini.ai").select_textobject("i","i") end, { silent = true, desc = "MiniIndentscope bordersless blankline_wise" })
map({ "x" }, "ai", function() require("mini.ai").select_textobject("i","i") vim.cmd [[ normal koj ]] end, { silent = true, desc = "MiniIndentscope borders blankline_wise" })
map({ "o" }, 'ai', ':<C-u>normal vai<cr>', { silent = true, desc = "MiniIndentscope borders blankline_wise" })
map({ "o", "x" }, "iI", "<Cmd>lua MiniIndentscope.textobject(false)<CR>", { silent = true, desc = "MiniIndentscope bordersless blankline_skip" })
map({ "o", "x" }, "aI", "<Cmd>lua MiniIndentscope.textobject(true)<CR>", { silent = true, desc = "MiniIndentscope borders blankline_skip" })

-- indent same level textobj:
map({"x","o"}, "iy", function() M.select_indent(false) end, { silent = true, desc = "indent_samelevel_noblankline textobj" })
map({"x","o"}, "ay", function() M.select_indent(true) end, { silent = true, desc = "indent_samelevel_blankline textobj" })

-- _clipboard_textobj
vim.g.EasyClipAutoFormat = 1
vim.g.EasyClipUseCutDefaults = false
vim.g.EasyClipEnableBlackHoleRedirect = false
map({ "n", "x" }, "gx", '"_d', { silent = true, desc = "Blackhole Motion/Selected" })
map({ "n" }, "gxx", '"_dd', { silent = true, desc = "Blackhole line" })
map({ "n" }, "gX", '"/p', { silent = true, desc = "Search register" })

vim.g.EasyClipUseYankDefaults = false
map({ "n" }, "gy", "<plug>SubstituteOverMotionMap", { silent = true, desc = "Substitute Motion" })
map({ "n" }, "gyy", "<plug>SubstituteLine", { silent = true, desc = "Substitute Line" })
map({ "x" }, "gy", "<plug>XEasyClipPaste ", { silent = true, desc = "Substitute Selected" })

vim.g.EasyClipUsePasteDefaults = false
map({ "n" }, "gY", "<plug>G_EasyClipPasteBefore", { silent = true, desc = "Paste Preserving cursor position" })
map({ "x" }, "gY", "<plug>XG_EasyClipPaste ", { silent = true, desc = "Paste Preserving cursor position" })

vim.g.EasyClipUsePasteToggleDefaults = false
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
  function() vim.fn.VSCodeNotify("editor.action.marker.next") end,
  function() vim.fn.VSCodeNotify("editor.action.marker.prev") end
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
local next_hunk_repeat, prev_hunk_repeat = ts_repeat_move.make_repeatable_move_pair(
  function() vim.fn.VSCodeNotify("workbench.action.editor.nextChange") end,
  function() vim.fn.VSCodeNotify("workbench.action.editor.previousChange") end
)
map({ "n", "x", "o" }, "gnh", next_hunk_repeat, { desc = "Next GitHunk" })
map({ "n", "x", "o" }, "gph", prev_hunk_repeat, { desc = "Prev GitHunk" })

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
  function() vim.cmd [[ normal ) ]] end,
  function() vim.cmd [[ normal ( ]] end
)
map({ "n", "x", "o" }, "<leader><leader>)", next_paragraph, { silent = true, desc = "Next Paragraph" })
map({ "n", "x", "o" }, "<leader><leader>(", prev_paragraph, { silent = true, desc = "Prev Paragraph" })

-- _jump_edgeindent_repeatable
local next_indent, prev_indent = ts_repeat_move.make_repeatable_move_pair(
  function() vim.cmd [[ normal g]i ]] vim.cmd [[ call feedkeys("") ]] end,
  function() vim.cmd [[ normal g[i ]] vim.cmd [[ call feedkeys("") ]] end
)
map({ "n", "x", "o" }, "<leader><leader>i", next_indent, { silent = true, desc = "End Indent" })
map({ "n", "x", "o" }, "<leader><leader>i", prev_indent, { silent = true, desc = "Start Indent" })

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

-- ╭─────────────╮
-- │ Lsp keymaps │
-- ╰─────────────╯

map("n", "ga", function() vim.fn.VSCodeNotify("editor.action.autoFix") end, opts)
map("n", "gA", function() vim.fn.VSCodeNotify("editor.action.refactor") end, opts)
map("n", "gc", function() vim.fn.VSCodeNotify("references-view.showCallHierarchy") end, opts)
map("n", "gd", function() vim.fn.VSCodeNotify("editor.action.revealDefinition") end, opts)
map("n", "gD", function() vim.fn.VSCodeNotify("editor.action.revealDeclaration") end, opts)
map("n", "gF", function() vim.fn.VSCodeNotify("editor.action.format") end, opts)
map("n", "gh", function() vim.fn.VSCodeNotify("editor.action.showHover") vim.call("repeat#set", "gh") end, opts)
map("n", "gH", function() vim.fn.VSCodeNotify("editor.action.triggerParameterHints") vim.call("repeat#set", "gH") end,
  opts)
map("n", "gI", function() vim.fn.VSCodeNotify("editor.action.goToImplementation") end, opts)
-- map("n", "gl",function() vim.fn.VSCodeNotify("workbench.action.navigateToLastEditLocation") end,opts)
map("n", "gnm", function() vim.fn.VSCodeNotify("editor.action.marker.next") vim.call("repeat#set", "gnm") end, opts)
map("n", "gnM", function() vim.fn.VSCodeNotify("editor.action.marker.nextInFiles") vim.call("repeat#set", "gnM") end,
  opts)
map("n", "go", function() vim.fn.VSCodeNotify("editor.action.marker.next") vim.call("repeat#set", "go") end, opts)
map("n", "gpm", function() vim.fn.VSCodeNotify("editor.action.marker.prev") vim.call("repeat#set", "gpm") end, opts)
map("n", "gpM", function() vim.fn.VSCodeNotify("editor.action.marker.prevInFiles") vim.call("repeat#set", "gpM") end,
  opts)
map("n", "gq", function() vim.fn.VSCodeNotify("workbench.actions.view.problems") end, opts)
map("n", "gQ", function() vim.fn.VSCodeNotify("editor.action.quickFix") end, opts)
map("n", "gr", function() vim.fn.VSCodeNotify("editor.action.goToReferences") end, opts)
map("n", "gR", function() vim.fn.VSCodeNotify("editor.action.rename") end, opts)
map("n", "gs", function() vim.fn.VSCodeNotify("workbench.action.gotoSymbol") end, opts)
map("n", "gS", function() vim.fn.VSCodeNotify("workbench.action.showAllSymbols") end, opts)
map("n", "gt", function() vim.fn.VSCodeNotify("editor.action.goToTypeDefinition") end, opts)
map("n", "gv", function() vim.fn.VSCodeNotify("workbench.actions.view.problems") end, opts)
map("n", "gV", function() vim.fn.VSCodeNotify("references-view.find") end, opts)
map("n", "gw", function() vim.fn.VSCodeNotify("references-view.findImplementations") end, opts)
map("n", "gW", function() vim.fn.VSCodeNotify("editor.action.revealDefinitionAside") end, opts)
map("n", "gz", function() vim.fn.VSCodeNotify("outline.focus") vim.call("repeat#set", "gO") end, opts)
map("n", "g\\", function() vim.fn.VSCodeNotify("editor.action.formatDocument") end, opts)
