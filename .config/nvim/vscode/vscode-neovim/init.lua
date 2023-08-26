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
  { "JoosepAlviste/nvim-ts-context-commentstring", event = "VeryLazy" },

  -- Motions
  { "machakann/vim-columnmove", event = "VeryLazy" },
  { "tpope/vim-repeat", event = "VeryLazy" },
  { "justinmk/vim-sneak", event = "VeryLazy" },
  { "phaazon/hop.nvim", config = true, event = "VeryLazy" },

  -- Text-Objects
  { "paraduxos/vim-indent-object", branch = "new_branch", event = "VeryLazy" },
  { "echasnovski/mini.nvim", event = "VeryLazy" },
  {
    "kana/vim-textobj-user",
    event = "VeryLazy",
    dependencies = { "saihoooooooo/vim-textobj-space" }
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects" },
      { "RRethy/nvim-treesitter-textsubjects" },
    }
  },
  { "coderifous/textobj-word-column.vim", event = "VeryLazy" },
  { "svermeulen/vim-easyclip", event = "VeryLazy" },
  {
    "chrisgrieser/nvim-various-textobjs",
    event = "VeryLazy",
    config = { useDefaultKeymaps = false, lookForwardSmall = 30, lookForwardBig = 30 }
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
    n = { '[-+]?()%f[%d]%d+()%.?%d*' },
    u = { { "%b''", '%b""', '%b``' }, '^.().*().$' },
    x = { '#()%x%x%x%x%x%x()' },
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
  mappings = {
    comment = 'gc',
    comment_line = 'gcc',
    textobject = '',
  },
  hooks = {
    pre = function() require('ts_context_commentstring.internal').update_commentstring() end,
    post = function() end,
  },
})

require('mini.indentscope').setup({
  draw = {
    delay = 100,
    animation = nil --<function: implements constant 20ms between steps>,
  },
  mappings = {
    object_scope = 'iI',
    object_scope_with_border = 'aI',
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

        ['[iq'] = '@call.inner',
        ['[iQ'] = '@class.inner',
        ['[ig'] = '@comment.inner',
        ['[iG'] = '@conditional.inner',
        ['[iB'] = '@block.inner',
        ['[iF'] = '@function.inner',
        ['[iL'] = '@loop.inner',
        ['[iP'] = '@parameter.inner',
        ['[iR'] = '@return.inner',
        ['[['] = '@parameter.inner',
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

        [']iq'] = '@call.inner',
        [']iQ'] = '@class.inner',
        [']ig'] = '@comment.inner',
        [']iG'] = '@conditional.inner',
        [']iB'] = '@block.inner',
        [']iF'] = '@function.inner',
        [']iL'] = '@loop.inner',
        [']iP'] = '@parameter.inner',
        [']iR'] = '@return.inner',
        [']]'] = '@parameter.inner',
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
keymap("n", "!", "z", opts)
keymap("n", "z", "Q", opts)
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
map("o", 'gm', "<cmd>normal! `[v`]<Left><cr>", { desc = "Last change textobj" })
map("x", 'gm', "`[o`]<Left>", { desc = "Last change textobj" })

-- _jump_to_last_change
map({ "n", "o", "x" }, "gl", "`.", { desc = "Jump to last change" })

-- _mini_comment_(not_showing_desc)_(next/prev_autojump_unsupported)
map({ "o" }, 'gk', '<Cmd>lua MiniComment.textobject()<CR>', { desc = "BlockComment textobj" })
map({ "x" }, 'gk', ':<C-u>normal "zygkgv<cr>', { desc = "BlockComment textobj" })
map({ "x" }, 'gK', '<Cmd>lua MiniComment.textobject()<cr>', { desc = "RestOfComment textobj" })
map({ "x" }, 'gC', ':<C-u>normal "zygcgv<cr>', { desc = "WholeComment textobj" })

-- _search_textobj_(dot-repeat_supported)
map({ "o", "x" }, "gs", "gn", { noremap = true, desc = "Next search textobj" })
map({ "o", "x" }, "gS", "gN", { noremap = true, desc = "Prev search textobj" })

-- _replace_textobj_(repeable_with_cgs_+_dotrepeat_supported)
map({ 'x' }, 'g/', '"zy:s/<C-r>z//g<Left><Left>', { desc = "Replace textobj" })

-- _nvim_various_textobjs
map({ "o", "x" }, "gd", function() require("various-textobjs").diagnostic() vim.call("repeat#set", "vgd") end,
  { desc = "Diagnostic textobj" })
map({ "o", "x" }, "gL", function() require("various-textobjs").nearEoL() vim.call("repeat#set", "vgL") end,
  { desc = "nearEoL textobj" }) -- conflicts with visual until search-next workaround: gn
map({ "o", "x" }, "g_", "<cmd>lua require('various-textobjs').lineCharacterwise()<CR>",
  { silent = true, desc = "lineCharacterwise textobj" })
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
map({ "o", "x" }, "am", "<cmd>lua require('various-textobjs').chainMember(false)<CR>",
  { silent = true, desc = "inner chainMember textobj" })
map({ "o", "x" }, "im", "<cmd>lua require('various-textobjs').chainMember(true)<CR>",
  { silent = true, desc = "inner chainMember textobj" })
map({ "o", "x" }, "aS", function() require("various-textobjs").subword(false) vim.call("repeat#set", "vaS") end,
  { desc = "outer Subword textobj" })
map({ "o", "x" }, "iS", function() require("various-textobjs").subword(true) vim.call("repeat#set", "vaS") end,
  { desc = "inner Subword textobj" })
map({ "o", "x" }, "az", "<cmd>lua require('various-textobjs').closedFold(false)<CR>",
  { silent = true, desc = "outer ClosedFold textobj" })
map({ "o", "x" }, "iz", "<cmd>lua require('various-textobjs').closedFold(true)<CR>",
  { silent = true, desc = "inner ClosedFold textobj" })

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

-- _clipboard_textobj
vim.g.EasyClipUseCutDefaults = false
vim.g.EasyClipEnableBlackHoleRedirect = false
map({ "n", "x" }, "gx", "_d", { silent = true, desc = "Blackhole Delete" })
map({ "n" }, "gxx", "_dd", { silent = true, desc = "Blackhole _dd" })

vim.g.EasyClipUseYankDefaults = false
map({ "n" }, "gy", "<plug>SubstituteOverMotionMap", { silent = true, desc = "SubstituteOverMotionMap" })
map({ "n" }, "gyy", "<plug>SubstituteLine", { silent = true, desc = "SubstituteLine" })
map({ "x" }, "gy", "<plug>XEasyClipPaste ", { silent = true, desc = "XEasyClipPaste" })

vim.g.EasyClipUsePasteDefaults = false
map({ "n" }, "gY", "<plug>G_EasyClipPasteBefore", { silent = true, desc = "EasyClip PasteBefore" })
map({ "x" }, "gY", "<plug>XG_EasyClipPaste ", { silent = true, desc = "EasyClip Paste" })

vim.g.EasyClipUsePasteToggleDefaults = false
map({ "n" }, "gz", "<plug>EasyClipSwapPasteForward", { silent = true, desc = "EasyClip SwapPasteForward" })
map({ "n" }, "gZ", "<plug>EasyClipSwapPasteBackwards ", { silent = true, desc = "EasyClip SwapPasteBackwards" })

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

-- _goto_diagnostic_repeatable
local next_diagnostic, prev_diagnostic = ts_repeat_move.make_repeatable_move_pair(
  function() vim.fn.VSCodeNotify("editor.action.marker.next") end,
  function() vim.fn.VSCodeNotify("editor.action.marker.prev") end
)
map({ "n", "x", "o" }, "gnd", next_diagnostic, { desc = "Next Diagnostic" })
map({ "n", "x", "o" }, "gpd", prev_diagnostic, { desc = "Prev Diagnostic" })

-- _goto_function_definition_repeatable
local next_funcdefinition, prev_funcdefinition = ts_repeat_move.make_repeatable_move_pair(
  function() vim.cmd [[ normal vaNf ]] vim.cmd [[ call feedkeys("") ]] end,
  function() vim.cmd [[ normal valf ]] vim.cmd [[ call feedkeys("") ]] end
)
map({ "n", "x", "o" }, "gnf", next_funcdefinition, { desc = "Next FuncDefinition" })
map({ "n", "x", "o" }, "gpf", prev_funcdefinition, { desc = "Prev FuncDefinition" })

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

-- _jump_startofline_repeatable
local next_startline, prev_startline = ts_repeat_move.make_repeatable_move_pair(
  function() vim.cmd [[ normal + ]] end,
  function() vim.cmd [[ normal - ]] end
)
map({ "n", "x", "o" }, "<leader><leader>+", next_startline, { desc = "Next StartLine" })
map({ "n", "x", "o" }, "<leader><leader>-", prev_startline, { desc = "Prev StartLine" })

-- _number_textobj_(goto_repeatable)
local next_inner_hex, prev_inner_hex = ts_repeat_move.make_repeatable_move_pair(
  function() require("mini.ai").move_cursor('left', 'i', 'x', { search_method = 'next' }) end,
  function() require("mini.ai").move_cursor('left', 'i', 'x', { search_method = 'prev' }) end
)
map({ "n", "x", "o" }, "gnx", next_inner_hex, { desc = "Next Inner Hex" })
map({ "n", "x", "o" }, "gpx", prev_inner_hex, { desc = "Prev Inner Hex" })

local next_around_hex, prev_around_hex = ts_repeat_move.make_repeatable_move_pair(
  function() require("mini.ai").move_cursor('left', 'a', 'x', { search_method = 'next' }) end,
  function() require("mini.ai").move_cursor('left', 'a', 'x', { search_method = 'prev' }) end
)
map({ "n", "x", "o" }, "gNx", next_around_hex, { desc = "Next Around Hex" })
map({ "n", "x", "o" }, "gPx", prev_around_hex, { desc = "Prev Around Hex" })

-- hexadecimalcolor_textobj_(goto_repeatable)
local next_inner_numeral, prev_inner_numeral = ts_repeat_move.make_repeatable_move_pair(
  function() require("mini.ai").move_cursor('left', 'i', 'n', { search_method = 'next' }) end,
  function() require("mini.ai").move_cursor('left', 'i', 'n', { search_method = 'prev' }) end
)
map({ "n", "x", "o" }, "gnn", next_inner_numeral, { desc = "Next Inner Number" })
map({ "n", "x", "o" }, "gpn", prev_inner_numeral, { desc = "Prev Inner Number" })

local next_around_numeral, prev_around_numeral = ts_repeat_move.make_repeatable_move_pair(
  function() require("mini.ai").move_cursor('left', 'a', 'n', { search_method = 'next' }) end,
  function() require("mini.ai").move_cursor('left', 'a', 'n', { search_method = 'prev' }) end
)
map({ "n", "x", "o" }, "gNn", next_around_numeral, { desc = "Next Around Number" })
map({ "n", "x", "o" }, "gPn", prev_around_numeral, { desc = "Prev Around Number" })

-- _vert_horz_incremental_(goto_repeatable)
local vert_increment, vert_decrement = ts_repeat_move.make_repeatable_move_pair(
  function() vim.cmd [[ normal "zyanjvan"zp ]] FeedKeysCorrectly('<C-a>') end,
  function() vim.cmd [[ normal "zyanjvan"zp ]] FeedKeysCorrectly('<C-x>') end
)
map({ "n" }, "g+", vert_increment, { desc = "Vert Increment" })
map({ "n" }, "g-", vert_decrement, { desc = "Vert Decrement" })

local horz_increment, horz_decrement = ts_repeat_move.make_repeatable_move_pair(
  function() vim.cmd [[ normal "zyanvaNn"zp ]] FeedKeysCorrectly('<C-a>') end,
  function() vim.cmd [[ normal "zyanvaNn"zp ]] FeedKeysCorrectly('<C-x>') end
)
map({ "n" }, "gn+", horz_increment, { desc = "Horz increment" })
map({ "n" }, "gn-", horz_decrement, { desc = "Horz Decrement" })

-- _key_textobj_(goto_repeatable)
local next_inner_key, prev_inner_key = ts_repeat_move.make_repeatable_move_pair(
  function() require("mini.ai").move_cursor('left', 'i', 'k', { search_method = 'next' }) end,
  function() require("mini.ai").move_cursor('left', 'i', 'k', { search_method = 'prev' }) end
)
map({ "n", "x", "o" }, "gnk", next_inner_key, { desc = "Next Inner Key" })
map({ "n", "x", "o" }, "gpk", prev_inner_key, { desc = "Prev Inner Key" })

local next_around_key, prev_around_key = ts_repeat_move.make_repeatable_move_pair(
  function() require("mini.ai").move_cursor('left', 'a', 'k', { search_method = 'next' }) end,
  function() require("mini.ai").move_cursor('left', 'a', 'k', { search_method = 'prev' }) end
)
map({ "n", "x", "o" }, "gNk", next_around_key, { desc = "Next Around Key" })
map({ "n", "x", "o" }, "gNk", prev_around_key, { desc = "Prev Around Key" })

-- _value_textobj_(goto_repeatable)
local next_inner_value, prev_inner_value = ts_repeat_move.make_repeatable_move_pair(
  function() require("mini.ai").move_cursor('left', 'i', 'v', { search_method = 'next' }) end,
  function() require("mini.ai").move_cursor('left', 'i', 'v', { search_method = 'prev' }) end
)
map({ "n", "x", "o" }, "gnv", next_inner_value, { desc = "Next Inner Value" })
map({ "n", "x", "o" }, "gpv", prev_inner_value, { desc = "Prev Inner Value" })

local next_around_value, prev_around_value = ts_repeat_move.make_repeatable_move_pair(
  function() require("mini.ai").move_cursor('left', 'a', 'v', { search_method = 'next' }) end,
  function() require("mini.ai").move_cursor('left', 'a', 'v', { search_method = 'prev' }) end
)
map({ "n", "x", "o" }, "gNv", next_around_value, { desc = "Next Around Value" })
map({ "n", "x", "o" }, "gNv", prev_around_value, { desc = "Prev Around Value" })

-- _comment_(goto_repeatable)
local next_comment, prev_comment = ts_repeat_move.make_repeatable_move_pair(
  function() require('mini.bracketed').comment('forward') end,
  function() require('mini.bracketed').comment('backward') end
)
map({ "n", "x", "o" }, "gnc", next_comment, { desc = "Next Comment" })
map({ "n", "x", "o" }, "gpc", prev_comment, { desc = "Prev Comment" })

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
