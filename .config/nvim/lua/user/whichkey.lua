local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {

  ["1"] = "which_key_ignore",
  ["2"] = "which_key_ignore",
  ["3"] = "which_key_ignore",
  ["4"] = "which_key_ignore",
  ["5"] = "which_key_ignore",
  ["6"] = "which_key_ignore",
  ["7"] = "which_key_ignore",
  ["8"] = "which_key_ignore",
  ["9"] = "which_key_ignore",
  ["v"] = "which_key_ignore", -- vertical ToggleTerm
  ["V"] = "which_key_ignore", -- horizontal ToggleTerm
  ["x"] = "which_key_ignore", -- Close Current Buffer
  ["<Tab>"] = { "which_key_ignore" },
  ["<S-Tab>"] = { "which_key_ignore" },

  ["'"] = { "<Cmd>Telescope marks initial_mode=normal<CR>","Marks"},

  b = {
    name = "Buffer",
    b = { "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_cursor{previewer=false, initial_mode='insert'})<cr>", "Telescope Buffer cursor-theme" },
    B = { "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer=false, initial_mode='normal'})<cr>", "Telescope Buffer" },
    C = { "<cmd>%bd|e#|bd#<cr>","Close others Buffers" },
    s = { "<cmd>BufferLineCyclePrev<cr>","Previous Buffer" },
    f = { "<cmd>BufferLineCycleNext<cr>","Next Buffer" },
    S = { "<cmd>BufferLineMovePrev<cr>","Move to Previous Buffer" },
    F = { "<cmd>BufferLineMoveNext<cr>","Move to Next Buffer" },
    t = { "<cmd>enew<cr> <cmd>lua require('bufferline').setup{options={always_show_bufferline=true}}<cr>","New buffer" },
    T = { "<cmd>setlocal nobuflisted<cr><cmd>bprevious<cr><cmd>tabe #<cr><cmd>lua require('bufferline').setup{options={always_show_bufferline=true}}<cr>", "buffer to Tab" },
    -- T = { "<cmd>bufdo | :setlocal nobuflisted | :b# | :tabe # | :lua require('bufferline').setup{options={always_show_bufferline=true}}<cr>", "buffers to Tab" },
    v = { "<cmd>vertical ball<cr>","Buffers to vertical windows" },
    V = { "<cmd>belowright ball<cr>","Buffers to horizontal windows" },
    x = { "<cmd>:bp | bd #<cr>","Close Buffer" },
    [";"] = {"<cmd>buffer #","Recent buffer"},
  },

  [";"] = {
    name = "Tabs",
    C = { "<cmd>tabonly<cr>","Close others Tabs" },
    n = { "<cmd>tabnext<cr>","Next Tab" },
    p = { "<cmd>tabprevious<cr>","Previous Tab" },
    N = { "<cmd>+tabmove<cr>", "move tab to next tab" },
    P = { "<cmd>-tabmove<cr>", "move tab to previous tab" },
    t = { "<cmd>tabnew <cr> <cmd>lua require('bufferline').setup{options={always_show_bufferline=true}}<cr>","New Tab" },
    x = { "<cmd>tabclose<cr>","Close Tab" },
    -- ["!"] = { "<cmd>tabmove 0<cr>", "move to #1 tab" },
    -- ["("] = { "<cmd>tabmove $<cr>", "move to last tab" },
    -- [":"] = { "<cmd>tabmove #<cr>", "move to recent tab" },
    ["1"] = { "<cmd>tabnext 1<cr>", "go to #1 tab" },
    ["2"] = { "<cmd>tabnext 2<cr>", "go to #2 tab" },
    ["3"] = { "<cmd>tabnext 3<cr>", "go to #3 tab" },
    ["4"] = { "<cmd>tabnext 4<cr>", "go to #4 tab" },
    ["5"] = { "<cmd>tabnext 5<cr>", "go to #5 tab" },
    ["6"] = { "<cmd>tabnext 6<cr>", "go to #6 tab" },
    ["7"] = { "<cmd>tabnext 7<cr>", "go to #7 tab" },
    ["8"] = { "<cmd>tabnext 8<cr>", "go to #8 tab" },
    ["9"] = { "<cmd>tabnext 9<cr>", "go to #9 tab" },
    [";"] = { "<cmd>tabnext #<cr>", "Recent Tab" },
    ["<Tab>"] = { "<cmd>tabprevious<cr>","Previous Tab" },
    ["<S-Tab>"] = { "<cmd>tabnext<cr>","Next Tab" },
  },

  c = {
    name = "Compile",
    b = { "<cmd>!bash %<cr>","Exec with bash" },
    p = { "<cmd>!python %<cr>","Exec with python" },
    c = { "<cmd>w! | !compiler '<c-r>%'<cr>","Exec with compiler" },
    -- o = { "<cmd>!opout<cr>", "Output Document" },
  },

  d = {
    name = "Debugger",
    b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
    c = { "<cmd>lua require'dap'.continue()<cr>", "Continue"},
    i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into"},
    o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over"},
    O = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out"},
    l = { "<cmd>lua require'dap'.run_last()<cr>", "Run last"},
    s = { "<cmd>lua require'dapui'.toggle()<cr>", "Start/Toggle Dapui"},
    S = { "<cmd>lua require'dap'.terminate()<cr>", "Stop"},
    t = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl"},

  },

  ["f"] = {
    "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
    "Find Files",
  },

  ["h"] = { "<cmd>noh<cr>", "NoHighlight" },
  ["e"] = { "<cmd>Neotree toggle left<cr>", "Neotree Toggle" },
  ["o"] = { "<cmd>Neotree focus<cr>", "Neotree focus" },
  ["q"] = { "<cmd>Neotree filesystem reveal float<cr>", "Neotree float" },
  ["m"] = { "<cmd>Mason<cr>", "Mason" },

  g = {
    name = "Git",
    g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    o = { "<cmd>Telescope git_status initial_mode=normal<cr>", "Open Changed File" },
    b = { "<cmd>Telescope git_branches initial_mode=normal<cr>", "Checkout Branch" },
    c = { "<cmd>Telescope git_commits initial_mode=normal<cr>", "Checkout Commit" },
    d = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Diff",
    },
  },

  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Go to Definition" },
    D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Go to Declaration" },
    F = { "<cmd>lua vim.lsp.buf.format{async=true}<cr>", "Format" },
    h = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover" },
    H = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature Help" },
    -- i = { "<cmd>LspInfo<cr>", "Info" },
    -- I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
    I = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Go to Implementation" },
    L = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens in current line" },
    n = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Next Diagnostic", },
    o = { "<cmd>lua vim.diagnostic.open_float()<cr>", "Errors" },
    p = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev Diagnostic", },
    q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "QuickFix LocList" },
    Q = { "<cmd>Telescope loclist<cr>", "Telescope QuickFix LocList" },
    r = { "<cmd>lua vim.lsp.buf.references()<cr>", "Go to References" },
    R = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Telescope Document Symbols" },
    S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Telescope Dynamic Workspace Symbols", },
    T = { "<cmd>Telescope lsp_workspace_symbols<cr>", "Telescope Workspace Symbols", },
    t = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Go to Typedefinition" },
    v = { "<cmd>Telescope diagnostics<cr>", "Telescope View Diagnostics", },
    V = { "<cmd>Telescope lsp_references initial_mode=normal<cr>", "Telescope View References" },
    w = { "<cmd>Telescope lsp_implementations initial_mode=normal<cr>", "Telescope View Implementations" },
    W = { "<cmd>Telescope lsp_definitions initial_mode=normal<cr>", "Telescope View Definitions" },
    x = { "<cmd>Telescope lsp_incoming_calls initial_mode=normal<cr>", "Telescope incoming calls" },
    X = { "<cmd>Telescope lsp_outgoing_calls initial_mode=normal<cr>", "Telescope outgoing calls" },
    z = { "<cmd>AerialToggle<cr>","Symbols outline"},
    Z = { "<cmd>AerialToggle float<cr>","Symbols outline"},
  },

  p = {
    name = "Peek LspSaga",
    a = { "<cmd>Lspsaga code_action<cr>", "Code Action" },
    d = { "<cmd>Lspsaga peek_definition<cr>", "Peek Definition" },
    f = { "<cmd>Lspsaga lsp_finder<cr>", "Finder" },
    h = { "<cmd>Lspsaga hover_doc<cr>", "Hover" },
    n = { "<cmd>Lspsaga diagnostic_jump_next<cr>", "Next Diagnostics" },
    N = { function() require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR }) end, "Next Error" },
    o = { "<cmd>Lspsaga show_line_diagnostics<cr>", "Show Line Diagnostics" },
    O = { "<cmd>Lspsaga show_cursor_diagnostics<cr>", "Show Cursor Diagnostics" },
    p = { "<cmd>Lspsaga diagnostic_jump_prev<cr>", "Prev Diagnostics" },
    P = { function() require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, "Prev Error" },
    r = { "<cmd>Lspsaga open_floaterm ranger<cr>", "Ranger" },
    R = { "<cmd>Lspsaga rename<cr>", "Rename" },
    t = { "<cmd>Lspsaga open_floaterm<cr>", "Open Float Terminal" },
    x = { "<cmd>Lspsaga close_floaterm<CR>", "Close Float Terminal" },
    z = { "<cmd>Lspsaga outline<cr>", "Toggle outline" },
  },

  s = {
    name = "Search",
    b = { "<cmd>Telescope buffers initial_mode=normal<cr>", "Buffers" },
    B = { "<cmd>Telescope current_buffer_fuzzy_find theme=ivy<cr>", "Ripgrep" },
    c = { "<cmd>Telescope colorscheme initial_mode=normal<cr>", "Colorscheme" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    f = { "<cmd>Telescope grep_string search= theme=ivy<cr>", "Grep string"},
    F = { "<cmd>Telescope live_grep theme=ivy<cr>", "Live Grep" },
    g = { "<cmd>Telescope git_files theme=ivy<cr>", "Git Files (hidden included)" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    H = { "<cmd>Telescope highlights<cr>", "Find Highlights" },
    m = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    p = { "<cmd>Telescope projects<cr>", "Projects" },
    q = { "<cmd>Telescope quickfix<cr>", "Telescope QuickFix" },
    Q = { "<cmd>Telescope quickfixhistory<cr>", "Telescope QuickFix History" },
    r = { "<cmd>Telescope oldfiles initial_mode=normal<cr>", "Open Recent File" },
    R = { "<cmd>Telescope registers initial_mode=normal<cr>", "Registers" },
    s = { "<cmd>Telescope grep_string<cr>", "Grep string under cursor"},
    z = {
      function()
        local aerial_avail, _ = pcall(require, "aerial")
        if aerial_avail then
          require("telescope").extensions.aerial.aerial()
        else
          require("telescope.builtin").lsp_document_symbols()
        end
      end,
      "Search symbols",
    },
    ["+"] = { "<cmd>Telescope builtin previewer=false initial_mode=normal<cr>", "More"},
    ["/"] = { "<cmd>Telescope find_files theme=ivy hidden=true<cr>", "Find files"},
    ["'"] = { "<cmd>Telescope marks theme=ivy initial_mode=normal<cr>", "Marks" },
  },

  t = {
    name = "Terminal",
  --   n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
  --   u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
  --   t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
  --   p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
    B = { "<C-w>T<cmd>lua require('bufferline').setup{options={always_show_bufferline=true}}<cr>", "Terminal to Tab" },
    e = { ":lua vim.cmd[[tabnew|terminal]] vim.cmd[[startinsert | set ft=terminal nonumber ]] require('bufferline').setup{options={always_show_bufferline=true}}<CR>",
          "Tab Terminal" },
    E = { ":lua vim.cmd[[ToggleTerm direction=tab]] require('bufferline').setup{options={always_show_bufferline=true}}<CR>",
          "Tab ToggleTerm" },
    f = { "<cmd>ToggleTerm direction=float<cr>", "Float ToggleTerm" },
    l = { "<cmd>lua _LF_TOGGLE()<cr>", "lf" },
    t = { "<cmd>ToggleTerm <cr>", "Toggle ToggleTerm" },
    T = { ":lua vim.cmd[[terminal]] vim.cmd[[startinsert | set ft=terminal nonumber ]]<CR>",
          "Buffer terminal" },
    -- H = { "<cmd>split +te  | resize 10          | setlocal ft=sp-terminal nonumber noruler laststatus=3 cmdheight=0 | startinsert<cr>", "Horizontal terminal (status-hidden)" },
    -- V = { "<cmd>vsplit +te | vertical resize 80 | setlocal ft=vs-terminal nonumber noruler laststatus=0 cmdheight=1 | startinsert<cr>", "Vertical terminal (status-hidden)" },
    H = { "<cmd>split +te | resize 10 | setlocal ft=sp-terminal<cr>", "Horizontal terminal" },
    V = { "<cmd>vsplit +te | vertical resize 80 | setlocal ft=vs-terminal<cr>", "Vertical terminal" },
    h = { "<cmd>ToggleTerm direction=horizontal size=10<cr>", "Horizontal ToggleTerm" },
    v = { "<cmd>ToggleTerm direction=vertical   size=80<cr>", "Vertical ToggleTerm" },
    ["2h"] = { "<cmd>2ToggleTerm direction=vertical   <cr>", "Toggle second horizontal ToggleTerm" },
    ["2v"] = { "<cmd>2ToggleTerm direction=horizontal <cr>", "Toggle second vertical ToggleTerm" },
    ["3h"] = { "<cmd>3ToggleTerm direction=vertical   <cr>", "Toggle third horizontal ToggleTerm" },
    ["3v"] = { "<cmd>3ToggleTerm direction=horizontal <cr>", "Toggle third vertical ToggleTerm" },
    ["4h"] = { "<cmd>4ToggleTerm direction=vertical   <cr>", "Toggle fourth horizontal ToggleTerm" },
    ["4v"] = { "<cmd>4ToggleTerm direction=horizontal <cr>", "Toggle fourth vertical ToggleTerm" },
  },

  u = {
    name = "UI Toggle",
    ["0"] = { "<cmd>set showtabline=0<cr>", "Close Buffer Status" },
    ["1"] = { "<cmd>lua require('bufferline').setup{options={ offsets = { { filetype = 'neo-tree', padding = 1 } }}}<cr>", "Enable Buffer offset" },
    ["2"] = { "<cmd>lua require('bufferline').setup{options={ offsets = {}}}<cr>", "Disable Buffer offset" },
    b = { "<cmd>lua require('bufferline').setup{options={always_show_bufferline=true}}<cr>", "Show Buffer Status" },
    B = { "<cmd>lua require('bufferline').setup{options={always_show_bufferline=false}}<cr>", "Hide Buffer Status" },
    -- c = { "<cmd>Codi<cr>", "Codi Start"},
    -- C = { "<cmd>Codi!<cr>", "Codi Stop" },
    c = { "<cmd>set cmdheight=1<cr>", "enable cmdheight" },
    C = { "<cmd>set cmdheight=0<cr>", "disable cmdheight" },
    g = { "<cmd>hi Normal guifg=none guibg=#0b0b0b<cr>", "enable background" },
    G = { "<cmd>hi Normal guifg=none guibg=none   <cr>", "disable background" },
    h = { "<cmd>noh<cr>", "Disable Highlight" },
    i = { "<cmd>IndentBlanklineToggle<cr>", "Toggle IndentBlankline" },
    l = { "<cmd>set cursorline!<cr>", "Toggle Cursorline" },
    L = { "<cmd>setlocal cursorline!<cr>", "Toggle Local Cursorline" },
    n = { "<cmd>Neotree show<cr>", "Neotree show" },
    N = { "<cmd>Neotree close<cr>", "Neotree close" },
    s = { "<cmd>call ToggleStatusLIne()<cr>", "Toggle StatusBar" },
    u = {
      function()
        local ok, start = require("indent_blankline.utils").get_current_context(
          vim.g.indent_blankline_context_patterns,
          vim.g.indent_blankline_use_treesitter_scope
        )
        if ok then
          vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
          vim.cmd [[normal! _]]
        end
      end,
      "Jump to current_context",
    },
    w = { "<cmd>set winbar=%@<cr>", "enable winbar" },
    W = { "<cmd>set winbar=  <cr>", "disable winbar" },
  },

  w = {
    name = "Window",
    b = { "<cmd>call WinBufSwap()<cr>", "WinBufSwap (any node)"},
    B = { "<cmd>all<cr>","Windows to buffers" },
    C = { "<C-w>o", "Close Other windows"},
    h = { "<C-w>H", "Move window to Leftmost"},
    j = { "<C-w>J", "Move window to Downmost"},
    k = { "<C-w>K", "Move window to Upmost"},
    l = { "<C-w>L", "Move window to Rightmost"},
    m = { "<C-w>_ | <c-w>|", "Maximize window"},
    n = { "<C-w>w", "Switch to next window CW "},
    N = { "<C-w>w<cmd>call SwitchWindow2()<cr>", "move to next window CW"},
    p = { "<C-w>W", "Switch to previous window CCW"},
    P = { "<C-w>W<cmd>call SwitchWindow2()<cr>", "Move to previous window CCW"},
    q = { "<cmd>qa<cr>", "Quit all"},
    s = { "<cmd>wincmd x<cr>", "window Swap CW (same parent node)"},
    S = { "<cmd>-wincmd x<cr>", "window Swap CCW (same parent node)"},
    r = { "<C-w>r", "Rotate CW (same parent node)"},
    R = { "<C-w>R", "Rotate CCW (same parent node)"},
    T = { "<cmd>setlocal nobuflisted<cr><C-w>T<cmd>lua require('bufferline').setup{options={always_show_bufferline=true}}<cr>", "window to Tab" },
    v = { "<cmd>vsplit<cr>", "split vertical"},
    V = { "<cmd>split<cr>", "split horizontal"},
    w = { "<cmd>new<cr>","New horizontal window" },
    W = { "<cmd>vnew<cr>","New vertical window" },
    x = { "<cmd>wincmd q<cr>","Close window" },
    [";"] = { "<C-w>p", "recent window"},
    [":"] = { "<C-w>p<cmd>call SwitchWindow2()<cr>", "Move to recent window"},
    ["="] = { "<C-w>=", "Reset windows sizes"},
  },
  z = {
    name = "folding",
    ["j"] = { "zj","next fold" },
    ["k"] = { "zk","previous fold" },
    ["J"] = { "]z","go to bottom of current fold" },
    ["K"] = { "[z","go to top of current fold" },
    ["d"] = { "zd","remove fold" },
    ["E"] = { "zE","remove all fold" },
    ["i"] = { "<cmd>set foldlevel=0 foldlevelstart=-1 foldmethod=indent<cr>","fold all indentation" },
    ["m"] = { "<cmd>set foldlevel=99 foldlevelstart=99 foldmethod=manual<cr>","manual fold" },
    ["s"] = { "<cmd>mkview<cr>","save folds" },
    ["l"] = { "<cmd>loadview<cr>","load folds" },
    ["p"] = { "zfip","fold paragraph" },
    ["}"] = { "zfa}","fold curly-bracket block" },
    ["]"] = { "zfa]","fold square-bracket block" },
    [")"] = { "zfa)","fold parenthesis block" },
    [">"] = { "zfa>","fold greater-than block" },
  },
}

which_key.setup(setup)
which_key.register(mappings, opts)
