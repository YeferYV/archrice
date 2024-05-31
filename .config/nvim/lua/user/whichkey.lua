local M = {}

local mappings = {

  ["'"] = { "<Cmd>Telescope marks initial_mode=normal<CR>", "Marks" },
  ["."] = { "<cmd>Telescope resume<cr>", "Telescope resume" },

  ["<space>"] = { "", "+Motion" },
  ["<space>p"] = { '"*p', "Paste after (second_clip)" },
  ["<space>P"] = { '"*P', "Paste before (second_clip)" },
  ["<space>y"] = { '"*y', "Yank (second_clip)" },
  ["<space>Y"] = { '"*yg_', "Yank forward (second_clip)" },

  [";"] = { "", "+Tab" },
  [";C"] = { "<cmd>tabonly<cr>", "Close others Tabs" },
  [";n"] = { "<cmd>tabnext<cr>", "Next Tab" },
  [";p"] = { "<cmd>tabprevious<cr>", "Previous Tab" },
  -- [";!"] = { "<cmd>tabmove 0<cr>", "move to #1 tab" },
  -- [";("] = { "<cmd>tabmove $<cr>", "move to last tab" },
  -- [";:"] = { "<cmd>tabmove #<cr>", "move to recent tab" },
  [";N"] = { "<cmd>+tabmove<cr>", "move tab to next tab" },
  [";P"] = { "<cmd>-tabmove<cr>", "move tab to previous tab" },
  [";t"] = { "<cmd>tabnew <cr>", "New Tab" },
  [";x"] = { "<cmd>tabclose<cr>", "Close Tab" },
  -- [";1"] = { "<cmd>tabnext 1<cr>", "go to #1 tab" },
  -- [";2"] = { "<cmd>tabnext 2<cr>", "go to #2 tab" },
  -- [";3"] = { "<cmd>tabnext 3<cr>", "go to #3 tab" },
  -- [";4"] = { "<cmd>tabnext 4<cr>", "go to #4 tab" },
  -- [";5"] = { "<cmd>tabnext 5<cr>", "go to #5 tab" },
  -- [";6"] = { "<cmd>tabnext 6<cr>", "go to #6 tab" },
  -- [";7"] = { "<cmd>tabnext 7<cr>", "go to #7 tab" },
  -- [";8"] = { "<cmd>tabnext 8<cr>", "go to #8 tab" },
  -- [";9"] = { "<cmd>tabnext 9<cr>", "go to #9 tab" },
  [";;"] = { "<cmd>tabnext #<cr>", "Recent Tab" },
  [";<Tab>"] = { "<cmd>tabprevious<cr>", "Previous Tab" },
  [";<S-Tab>"] = { "<cmd>tabnext<cr>", "Next Tab" },

  ["b"] = { "", "+Buffer" },
  -- ["bB"] = { "<cmd>Telescope buffers initial_mode=normal previewer=false theme=get_dropdown <cr>", "Telescope Buffers" },
  ["bb"] = { "<cmd>Telescope buffers initial_mode=normal previewer=false theme=get_cursor <cr>", "Telescope Buffers" },
  ["bC"] = { "<cmd>%bd|e#|bd#<cr>", "Close others Buffers" },
  ["bt"] = { "<cmd>enew<cr>", "New buffer" },
  ["b<TAB>"] = { ":setlocal nobuflisted | :bprevious  | :tabe # <cr>", "buffer to Tab" },
  -- ["bT"] = { ":bufdo | :setlocal nobuflisted | :b# | :tabe # <cr>", "buffers to Tab" },
  ["bv"] = { "<cmd>vertical ball<cr>", "Buffers to vertical windows" },
  ["bV"] = { "<cmd>belowright ball<cr>", "Buffers to horizontal windows" },
  ["bx"] = { "<cmd>:bp | bd #<cr>", "Close Buffer" },
  ["b;"] = { "<cmd>buffer #<cr>", "Recent buffer" },

  -- ["c"] = { "", "Compiler" },
  -- ["cb"] = { "<cmd>!bash %<cr>", "Exec with bash" },
  -- ["cc"] = { "<cmd>!compiler '<c-r>%'<cr>", "Exec with compiler" },
  -- ["cp"] = { "<cmd>!python %<cr>", "Exec with python" },

  -- ["d"] = { "", "Debugger" },
  -- ["db"] = { function() WhichkeyRepeat("lua require'dap'.toggle_breakpoint()") end, "Toggle Breakpoint" },
  -- ["dB"] = { function() WhichkeyRepeat("lua require'dap'.clear_breakpoints()") end, "Clear Breakpoints" },
  -- ["dc"] = { function() WhichkeyRepeat("lua require'dap'.continue()") end, "Start/Continue" },
  -- ["dh"] = { function() WhichkeyRepeat("lua require'dap.ui.widgets'.hover()") end, "Debugger Hover" },
  -- ["di"] = { function() WhichkeyRepeat("lua require'dap'.step_into()") end, "Step Into" },
  -- ["dl"] = { function() WhichkeyRepeat("lua require'dap'.run_last()") end, "Run last" },
  -- ["do"] = { function() WhichkeyRepeat("lua require'dap'.step_over()") end, "Step Over" },
  -- ["dO"] = { function() WhichkeyRepeat("lua require'dap'.step_out()") end, "Step Out" },
  -- ["dq"] = { function() require 'dap'.close() end, "Close Session" },
  -- ["dQ"] = { function() require 'dap'.terminate() end, "Terminate Session" },
  -- ["dp"] = { function() WhichkeyRepeat("lua require'dap'.pause()") end, "Pause" },
  -- ["dr"] = { function() WhichkeyRepeat("lua require'dap'.restart_frame()") end, "Restart" },
  -- ["dR"] = { function() WhichkeyRepeat("lua require'dap'.repl.toggle()") end, "Toggle REPL" },
  -- ["du"] = { function() WhichkeyRepeat("lua require'dapui'.toggle()") end, "Toggle Debugger UI" },

  ["f"] = { ":Telescope find_files previewer=false theme=get_dropdown<cr>", "Find Files" },
  ["m"] = { ":lua require('mini.files').open(vim.api.nvim_buf_get_name(0), true)<cr>", "mini files (current file)" },
  ["M"] = { ":lua require('mini.files').open(vim.loop.cwd(), true)<cr>", "mini files (cwd)" },
  ["e"] = { ":lua _G.neotree_blend=false<cr><cmd>Neotree toggle last left<cr>", "Neotree Toggle" },
  ["o"] = { ":lua _G.neotree_blend=true<cr><cmd>Neotree focus last <cr>", "Neotree focus" },
  ["O"] = { ":lua _G.neotree_blend=true<cr><cmd>Neotree filesystem reveal float <cr>", "Neotree float" },

  ["g"] = { "", "+Git" },
  ["gg"] = { "<cmd>term lazygit<cr><cmd>set filetype=terminal<cr>", "Tab Lazygit" },
  ["gj"] = { function() WhichkeyRepeat("lua require 'gitsigns'.next_hunk()") end, "Next Hunk" },
  ["gk"] = { function() WhichkeyRepeat("lua require 'gitsigns'.prev_hunk()") end, "Prev Hunk" },
  ["gl"] = { function() WhichkeyRepeat("lua require 'gitsigns'.blame_line()") end, "Blame" },
  ["gp"] = { function() WhichkeyRepeat("lua require 'gitsigns'.preview_hunk()") end, "Preview Hunk" },
  ["gr"] = { function() WhichkeyRepeat("lua require 'gitsigns'.reset_hunk()") end, "Reset Hunk" },
  ["gR"] = { function() WhichkeyRepeat("lua require 'gitsigns'.reset_buffer()") end, "Reset Buffer" },
  ["gs"] = { function() WhichkeyRepeat("lua require 'gitsigns'.stage_hunk()") end, "Stage Hunk" },
  ["gS"] = { function() WhichkeyRepeat("lua require 'gitsigns'.undo_stage_hunk()") end, "Undo Stage Hunk" },
  ["go"] = { function() WhichkeyRepeat("Gitsigns diffthis HEAD") end, "Open Diff (file changes)" },
  ["gO"] = { "<cmd>Telescope git_status initial_mode=normal<cr>", "Open All Diff (file changes)" },
  ["gb"] = { "<cmd>Telescope git_branches initial_mode=normal<cr>", "Checkout Branch" },
  ["gc"] = { "<cmd>Telescope git_commits initial_mode=normal<cr>", "Checkout Commit" },

  ["l"] = { "", "+LSP" },
  ["lA"] = { function() WhichkeyRepeat("lua vim.lsp.buf.code_action()") end, "Code Action" },
  ["lc"] = { "<cmd>Telescope lsp_incoming_calls initial_mode=normal<cr>", "Telescope incoming calls" },
  ["lC"] = { "<cmd>Telescope lsp_outgoing_calls initial_mode=normal<cr>", "Telescope outgoing calls" },
  ["ld"] = { function() WhichkeyRepeat("lua vim.lsp.buf.definition()") end, "Goto Definition" },
  ["lD"] = { function() WhichkeyRepeat("lua vim.lsp.buf.declaration()") end, "Goto Declaration" },
  ["lF"] = { function() WhichkeyRepeat("lua vim.lsp.buf.format({ timeout_ms = 5000 })") end, "Format" },
  ["lh"] = { function() WhichkeyRepeat("lua vim.lsp.buf.signature_help()") end, "Signature" },
  ["lH"] = { function() WhichkeyRepeat("lua vim.lsp.buf.hover()") end, "Hover" },
  ["lI"] = { function() WhichkeyRepeat("lua vim.lsp.buf.implementation()") end, "Goto Implementation" },
  ["ll"] = { function() WhichkeyRepeat("lua vim.lsp.codelens.refresh()") end, "CodeLens refresh" },
  ["lL"] = { function() WhichkeyRepeat("lua vim.lsp.codelens.run()") end, "CodeLens run" },
  ["ln"] = { function() WhichkeyRepeat("lua vim.diagnostic.jump({ count = 1, float = true })") end, "Next Diagnostic", },
  ["lo"] = { function() WhichkeyRepeat("lua vim.diagnostic.open_float()") end, "Open Diagnostic" },
  ["lp"] = { function() WhichkeyRepeat("lua vim.diagnostic.jump({ count = -1, float = true })") end, "Prev Diagnostic", },
  ["lq"] = { function() WhichkeyRepeat("lua vim.diagnostic.setloclist()") end, "Diagnostic List" },
  ["lQ"] = { "<cmd>Telescope loclist initial_mode=normal<cr>", "Telescope QuickFix LocList" },
  ["lr"] = { function() WhichkeyRepeat("lua vim.lsp.buf.references()") end, "References" },
  ["lR"] = { function() WhichkeyRepeat("lua vim.lsp.buf.rename()") end, "Rename" },
  ["ls"] = { "<cmd>Telescope lsp_document_symbols initial_mode=normal<cr>", "Telescope Document Symbols" },
  ["lS"] = { "<cmd>Telescope lsp_dynamic_workspace_symbols initial_mode=normal<cr>", "Telescope Dynamic Workspace Symbols", },
  ["lT"] = { "<cmd>Telescope lsp_workspace_symbols initial_mode=normal<cr>", "Telescope Workspace Symbols", },
  ["lt"] = { function() WhichkeyRepeat("lua vim.lsp.buf.type_definition()") end, "Goto TypeDefinition" },
  ["lv"] = { "<cmd>Telescope lsp_references initial_mode=normal<cr>", "Telescope View References" },
  ["lV"] = { "<cmd>Telescope diagnostics initial_mode=normal theme=ivy<cr>", "Telescope View Diagnostics" },
  ["lw"] = { "<cmd>Telescope lsp_definitions initial_mode=normal show_line=false<cr>", "Telescope View Definitions" },
  ["lW"] = { "<cmd>Telescope lsp_implementations initial_mode=normal show_line=false<cr>", "Telescope View Definitions" },

  ["p"] = { "", "+Packages" },
  ["pm"] = { "<cmd>Mason<cr>", "Mason" },
  ["pl"] = { "<cmd>Lazy<cr>", "Lazy" },
  ["pL"] = { "<cmd>LspInfo<cr>", "LspInfo" },
  ["pn"] = { "<cmd>NullLsInfo<cr>", "NullLsInfo" },

  ["s"] = { "", "+Search" },
  ["sb"] = { "<cmd>Telescope buffers initial_mode=insert<cr>", "Buffers" },
  ["sB"] = { "<cmd>Telescope current_buffer_fuzzy_find theme=ivy<cr>", "Ripgrep" },
  ["sc"] = { "<cmd>Telescope colorscheme enable_preview=true initial_mode=normal<cr>", "Colorscheme" },
  ["sC"] = { "<cmd>Telescope commands<cr>", "Commands" },
  ["sk"] = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
  ["sf"] = { "<cmd>Telescope grep_string search= theme=ivy<cr>", "Grep string" },
  ["sF"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Live Grep" },
  ["sg"] = { "<cmd>Telescope git_files theme=ivy<cr>", "Git Files" },
  ["sh"] = { "<cmd>Telescope help_tags<cr>", "Find Help" },
  ["sH"] = { "<cmd>Telescope highlights<cr>", "Find Highlights" },
  ["sm"] = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
  ["sn"] = { "<cmd>lua MiniNotify.show_history()<cr>", "Notify history" },
  ["so"] = { "<cmd>Telescope oldfiles initial_mode=normal<cr>", "Open Recent File" },
  ["sq"] = { "<cmd>Telescope quickfixhistory initial_mode=normal<cr>", "Telescope QuickFix History" },
  ["sQ"] = { "<cmd>Telescope quickfix initial_mode=normal<cr>", "Telescope QuickFix" },
  ["sR"] = { "<cmd>Telescope registers initial_mode=normal<cr>", "Registers" },
  ["ss"] = { "<cmd>Telescope grep_string<cr>", "Grep string under cursor" },
  ["s+"] = { "<cmd>Telescope builtin previewer=false initial_mode=normal<cr>", "More" },
  ["s/"] = { "<cmd>Telescope find_files find_command=find,!,-ipath,*.git*,-type,f hidden=true theme=ivy <cr>", "Find files (hidden included)" },
  ["s;"] = { "<cmd>Telescope jumplist theme=ivy initial_mode=normal<cr>", "Jump List" },
  ["s'"] = { "<cmd>Telescope marks theme=ivy initial_mode=normal<cr>", "Marks" },

  ["t"] = { "", "+Terminal" },
  ["t<TAB>"] = { "<cmd>wincmd T<cr>", "Terminal to Tab" },
  ["tt"] = { "<cmd>terminal<cr>", "buffer terminal (same tab)" },
  ["tT"] = { "<cmd>tabnew | terminal<cr>", "buffer terminal (new tab)" },
  ["ty"] = { "<cmd>lua vim.cmd[[terminal yazi]] vim.cmd[[set filetype=terminal]]<cr>", "yazi (same tab)" },
  ["tY"] = { "<cmd>tabnew | terminal yazi<cr><cmd>set filetype=terminal<cr>", "yazi (new tab)" },
  ["t\\"] = { ToggleTerminal, "Toggle window terminal" },

  ["v"] = { "<cmd>vsplit +te | vertical resize 80<cr>", "Vertical terminal" },
  ["V"] = { "<cmd>split +te | resize 10<cr>", "Horizontal terminal" },

  ["u"] = { "", "+UI Toggle" },
  ["u0"] = { "<cmd>set showtabline=0<cr>", "Buffer Hide" },
  ["u2"] = { "<cmd>set showtabline=2<cr>", "Buffer Show" },
  -- ["uc"] = { "<cmd>Codi<cr>", "Codi Start"},
  -- ["uC"] = { "<cmd>Codi!<cr>", "Codi Stop" },
  ["uc"] = { ":lua vim.opt.cmdheight = (vim.opt.cmdheight:get() == 0) and 1 or 0 <cr>", "Disable AutoNoHighlightSearch" },
  ["uC"] = { "<cmd>ColorizerToggle<cr>", "Toggle Colorizer" },
  ["ud"] = { function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end, "Toggle Diagnostics" },
  ["uh"] = { EnableAutoNoHighlightSearch, "Enable AutoNoHighlightSearch" },
  ["uH"] = { DisableAutoNoHighlightSearch, "Disable AutoNoHighlightSearch" },
  ["ui"] = { ChangeIndent, "Change Indent" },
  ["uI"] = { "<cmd>IndentBlanklineToggle<cr>", "Toggle IndentBlankline" },
  ["ul"] = { "<cmd>set cursorline!<cr>", "Toggle Cursorline" },
  ["uL"] = { "<cmd>setlocal cursorline!<cr>", "Toggle Local Cursorline" },
  ["um"] = { "<cmd>lua MiniMap.toggle()<cr>", "Toggle MiniMap" },
  ["un"] = { "<cmd>noh<cr>", "NoHighlight" },
  ["up"] = { "<cmd>popup PopUp<cr>", "Toggle Mouse PopUp" },
  ["uP"] = { function() vim.opt.paste = not vim.opt.paste:get() end, "Toggle Paste Mode" },
  ["us"] = { ":lua vim.opt.laststatus = (vim.opt.laststatus:get() == 0) and 2 or (vim.opt.laststatus:get() == 2 and 3 or 0)<cr>", "Toggle StatusBar" },
  ["uu"] = { HideUnhideWindow, "Hide/Unhide window (useful for terminal)" },
  ["uU"] = { GoToParentIndent, "Go to parent indent" },
  -- ["ut"] = { ":windo if &buftype == 'terminal' | hide | endif <cr>", "Hide window terminal" },
  -- ["uT"] = { ":execute &buftype == 'terminal' ? 'hide' : 'sbuffer term'<cr>", "toggle window terminal (unfocus opens other terminal)" },
  ["u;"] = { ":clearjumps<cr>:normal m'<cr>", "Clear and Add jump" }, -- Reset JumpList

  ["w"] = { "", "+Window" },
  ["wb"] = { SwapWindow, "SwapWindow (last visited node)" },
  ["wB"] = { "<cmd>all<cr>", "Windows to buffers" },
  ["wC"] = { "<C-w>o", "Close Other windows" },
  ["wh"] = { "<C-w>H", "Move window to Leftmost" },
  ["wj"] = { "<C-w>J", "Move window to Downmost" },
  ["wk"] = { "<C-w>K", "Move window to Upmost" },
  ["wl"] = { "<C-w>L", "Move window to Rightmost" },
  ["wm"] = { "<C-w>_ | <c-w>|", "Maximize window" },
  ["wn"] = { "<C-w>w", "Switch to next window CW " },
  ["wN"] = { "<C-w>w<cmd>lua SwapWindow()<cr>", "move to next window CW" },
  ["wp"] = { "<C-w>W", "Switch to previous window CCW" },
  ["wP"] = { "<C-w>W<cmd>lua SwapWindow()<cr>", "Move to previous window CCW" },
  ["wq"] = { "<cmd>qa<cr>", "Quit all" },
  ["ws"] = { "<cmd>wincmd x<cr>", "window Swap CW (same parent node)" },
  ["wS"] = { "<cmd>-wincmd x<cr>", "window Swap CCW (same parent node)" },
  ["wr"] = { "<C-w>r", "Rotate CW (same parent node)" },
  ["wR"] = { "<C-w>R", "Rotate CCW (same parent node)" },
  ["w<TAB>"] = { "<cmd> setlocal nobuflisted | :wincmd T <cr>", "window to Tab" },
  ["wv"] = { "<cmd>vsplit<cr>", "Split vertical" },
  ["wV"] = { "<cmd>split<cr>", "Split horizontal" },
  ["ww"] = { "<cmd>new<cr>", "New horizontal window" },
  ["wW"] = { "<cmd>vnew<cr>", "New vertical window" },
  ["wx"] = { "<cmd>wincmd q<cr>", "Close window" },
  ["w;"] = { "<C-w>p", "recent window" },
  ["w:"] = { "<C-w>p<cmd>call SwitchWindow2()<cr>", "Move to recent window" },
  ["w="] = { "<C-w>=", "Reset windows sizes" },

  ["z"] = { "", "+Folding" },
  ["za"] = { "za", "Toggle fold" },
  ["zA"] = { "zA", "Toggle folds recursively" },
  ["zc"] = { "zc", "Close fold" },
  ["zC"] = { "zC", "Close fold recursively" },
  ["zj"] = { "zj", "next fold" },
  ["zk"] = { "zk", "previous fold" },
  ["zJ"] = { "]z", "go to bottom of current fold" },
  ["zK"] = { "[z", "go to top of current fold" },
  ["zd"] = { "zd", "remove fold" },
  ["zE"] = { "zE", "remove all fold" },
  ["zM"] = { "zM", "Close All Folds" },
  ["zp"] = { "zfip", "fold paragraph" },
  ["zo"] = { "zo", "open fold" },
  ["zO"] = { "zO", "open fold recursively" },
  ["zr"] = { "zr", "fold less" },
  ["zR"] = { "zR", "Open All Folds" },
  ["z}"] = { "zfa}", "fold curly-bracket block" },
  ["z]"] = { "zfa]", "fold square-bracket block" },
  ["z)"] = { "zfa)", "fold parenthesis block" },
  ["z>"] = { "zfa>", "fold greater-than block" },
}

local ai_textobj = {
  ['a'] = { 'function args' },
  ['A'] = { '@assingment' },
  ['b'] = { 'Alias )]}' },
  ["B"] = { '@block' },
  ["c"] = { 'word-column' },
  ["C"] = { 'WORD-column' },
  ["d"] = { 'greedyOuterIndentation' },
  ["e"] = { 'nearEndOfLine' },
  ['f'] = { 'function call' },
  ["F"] = { '@function' },
  ["g"] = { '@comment' },
  ["G"] = { '@conditional' },
  ['h'] = { 'html atribute' },
  ['i'] = { 'indentation noblanks' },
  ['I'] = { 'Indentation' },
  ['j'] = { 'cssSelector' },
  ['k'] = { 'key' },
  ["l"] = { '+Last' },
  ["L"] = { '@loop' },
  ["m"] = { 'chainMember' },
  ["M"] = { 'mdFencedCodeBlock' },
  ['n'] = { 'number' },
  ['N'] = { '+Next' },
  ['o'] = { 'whitespace' },
  ['p'] = { 'paragraph' },
  ["P"] = { '@parameter' },
  ["q"] = { '@call' },
  ["Q"] = { '@class' },
  ["r"] = { 'restOfIndentation' },
  ["R"] = { '@return' },
  ['s'] = { 'inside_mini_ai' },
  ['S'] = { 'Subword' },
  ['t'] = { 'tag' },
  ['u'] = { 'Alias "\'`' },
  ['U'] = { 'pyTripleQuotes' },
  ['v'] = { 'value' },
  ['w'] = { 'word' },
  ['W'] = { 'WORD' },
  ['x'] = { 'hex' },
  ['y'] = { 'same_indent' },
  ['z'] = { 'fold' },
  ['Z'] = { 'ClosedFold' },
  ["="] = { '@assignment.rhs-lhs' },
  ["#"] = { '@number' },
  ['?'] = { 'Prompt' },
  ['('] = { 'Same as )' },
  ['['] = { 'Same as ]' },
  ['{'] = { 'Same as }' },
  ['<'] = { 'Same as >' },
  ['"'] = { 'punctuations...' },
  ["'"] = { 'punctuations...' },
  ["`"] = { 'punctuations...' },
  ['.'] = { 'punctuations...' },
  [','] = { 'punctuations...' },
  [';'] = { 'punctuations...' },
  ['-'] = { 'punctuations...' },
  ['_'] = { 'punctuations...' },
  ['/'] = { 'punctuations...' },
  ['|'] = { 'punctuations...' },
  ['&'] = { 'punctuations...' },
  -- `!@#$%^&*()_+-=[]{};'\:"|,./<>?
}

local g_textobj = {
  ["="] = { "+autoindent (dot to repeat)" },
  [">"] = { "+indent right (dot to repeat)" },
  ["<"] = { "+indent left (dot to repeat)" },
  ["$"] = { "End of line (dot to repeat)" },
  ["%"] = { "Matching character: '()', '{}', '[]' (dot to repeat)" },
  [","] = { "Prev TS textobj (,; to repeat )" },
  [";"] = { "Next TS textobj (,; to repeat )" },
  ["0"] = { "Start of line (dot to repeat)" },
  ["^"] = { "Start of line (non-blank)(dot to repeat)" },
  ["("] = { "Previous sentence (dot to repeat)" },
  [")"] = { "Next sentence (dot to repeat)" },
  ["{"] = { "Previous empty line (dot to repeat)" },
  ["}"] = { "Next empty line (dot to repeat)" },
  ["[["] = { "Previous section (dot to repeat)" },
  ["]]"] = { "Next section (dot to repeat)" },
  ["<CR>"] = { "Continue Last Flash search (dot to repeat)" },
  ["b"] = { "Previous word (dot to repeat)" },
  ["e"] = { "Next end of word (dot to repeat)" },
  ["f"] = { "Move to next char (dot to repeat)" },
  ["F"] = { "Move to previous char (dot to repeat)" },
  ["G"] = { "Last line (dot to repeat)" },
  ["R"] = { "Treesitter Flash Search (dot to repeat)" },
  ["s"] = { "Flash (dot to repeat)" },
  ["S"] = { "Flash Treesitter (dot to repeat)" },
  ["t"] = { "Move before next char (dot to repeat)" },
  ["T"] = { "Move before previous char (dot to repeat)" },
  ["w"] = { "Next word (dot to repeat)" },

  -- ["i"] = ai_textobj,
  -- ["il"] = { "+Last", ai_textobj },
  -- ["iN"] = { "+Next", ai_textobj },
  -- ["a"] = ai_textobj,
  -- ["al"] = { "+Last", ai_textobj },
  -- ["aN"] = { "+Next", ai_textobj },

  ["g{"] = { "braces linewise textobj" },
  ["g}"] = { "braces linewise textobj" },
  ["g["] = vim.tbl_extend("force", { "+Cursor to Left Around (dot to repeat)" }, ai_textobj),
  ["g]"] = vim.tbl_extend("force", { "+Cursor to Rigth Around (dot to repeat)" }, ai_textobj),
  ["g."] = { "goto last change" },
  -- ["ga"] = { "Align (operator)" },                                               -- only visual and normal mode
  -- ["gA"] = { "Preview Align (operator)" },                                       -- only visual and normal mode
  -- ["gb"] = { "add virtual cursor (select and find)(dot to repeat)" },            -- only visual and normal mode
  -- ["gB"] = { "add virtual cursor (find selected)(dot to repeat)" },              -- only visual and normal mode
  ["gc"] = { "BlockComment textobj (dot to repeat)" },
  ["gC"] = { "RestOfComment textobj (dot to repeat)" },
  ["gd"] = { "Diagnostic textobj (dot to repeat)" },
  ["ge"] = { "Prev endOf word textobj (dot to repeat)" },
  ["gE"] = { "Prev endOf WORD textobj (dott to repeat)" },
  ["gf"] = { "Next find textobj (dot to repeat)" },
  ["gF"] = { "Prev find textobj (dot to repeat)" },
  ["gg"] = { "First line textobj (dot to repeat)" },
  ["gh"] = { "Git hunk textobj (dot to repeat)" },
  -- ["gi"] = { "Goto Insert textobj" },                                            -- only visual and normal mode
  ["gI"] = { "select reference (under cursor)" },
  ["gj"] = { "GoDown when wrapped textobj (dot to repeat)" },
  ["gk"] = { "GoUp when wrapped textobj (dot to repeat)" },
  ["gK"] = { "ColumnDown textobj (dot to repeat)" },
  ["gL"] = { "Url textobj (dot to repeat)" },
  ["gm"] = { "Last modified/yank/paste textobj (no repeater key)" },
  ["gn"] = { "+next (dot to repeat)" },
  -- ["go"] = { "add virtual cursor down (dot to repeat)" },                        -- only visual and normal mode
  -- ["gO"] = { "add virtual cursor up (dot to repeat)" },                          -- only visual and normal mode
  ["gp"] = { "+previous (dot to repeat)" },
  -- ["gq"] = { "SplitJoin comment/lines 80chars (dot to repeat)" },                -- only visual and normal mode (cursor_position at start)(overrided by LSP)
  ["gr"] = { "RestOfWindow textobj (dot to repeat)" },
  ["gR"] = { "VisibleWindow textobj (dot to repeat)" },
  -- ["gs"] = { "Surround textobj (dot to repeat)" },                               -- only visual and normal mode
  -- ["gS"] = { "JoinSplit textobj (dot to repeat)" },                              -- only visual and normal mode
  ["gT"] = { "toNextClosingBracket textobj (dot to repeat)" },
  ["gt"] = { "toNextQuotationMark textobj (dot to repeat)" },
  -- ["gu"] = { "to lowercase (dot to repeat)" },                                   -- only visual and normal mode
  -- ["gU"] = { "to Uppercase (dot to repeat)" },                                   -- only visual and normal mode
  -- ["gv"] = { "last selected" },                                                  -- only visual and normal mode
  -- ["gw"] = { "SplitJoin comments/lines (limited at 80 chars)(dot to repeat)" },  -- only visual and normal mode
  -- ["gW"] = { "word-column multicursor" },                                        -- only visual and normal mode
  -- ["gx"] = { "Blackhole register (dot to repeat)" },                             -- only visual and normal mode
  -- ["gX"] = { "Blackhole linewise (dot to repeat)" },                             -- only visual and normal mode
  -- ["gy"] = { "replace with register (dot to repeat)" },                          -- only visual and normal mode
  -- ["gY"] = { "exchange text (dot to repeat)" },                                  -- only visual and normal mode
  -- ["gz"] = { "sort (dot to repeat)" },                                           -- only visual and normal mode
  -- ["g+"] = { "Increment number (dot to repeat)" },                               -- only visual and normal mode
  -- ["g-"] = { "Decrement number (dot to repeat)" },                               -- only visual and normal mode
  -- ["g<Up>"] = { "Numbers ascending" },                                           -- only visual and normal mode
  -- ["g<Down>"] = { "Numbers descending" },                                        -- only visual and normal mode
}

local g_operator_motion = {
  ["g["] = vim.tbl_extend("force", { "+Cursor to Left Around (mini textobj only)" }, ai_textobj),  -- supports operator pending mode, doesn't reset cursor like "g<a"
  ["g]"] = vim.tbl_extend("force", { "+Cursor to Rigth Around (mini textobj only)" }, ai_textobj), -- supports operator pending mode, doesn't reset cursor like "g>a"
  ["g<"] = vim.tbl_extend("force", { "+goto StarOf textobj (dot to repeat)" }, g_textobj),
  ["g>"] = vim.tbl_extend("force", { "+goto EndOf textobj (dot to repeat)" }, g_textobj),
  ["g."] = { "goto last change" },
  -- ["g,"] = { "go forward in :changes" },                                                        -- normal mode only, visual mode not supported
  -- ["g;"] = { "go backward in :changes" },                                                       -- normal mode only, visual mode not supported
  ["ga"] = vim.tbl_extend("force", { "+align (dot to repeat)" }, g_textobj),
  ["gA"] = vim.tbl_extend("force", { "+preview align (dot to repeat)" }, g_textobj),
  -- ["gb"] = { "add virtual cursor (select and find) (dot to repeat)" },                          -- requires vim-visual-multi
  -- ["gB"] = { "add virtual cursor (find selected) (dot to repeat)" },                            -- requires vim-visual-multi
  ["gc"] = { "+comment (dot to repeat)" },
  -- ["gd"] = { "goto definition" },                                                               -- normal mode only, visual mode not supported
  ["ge"] = { "goto previous endOfWord" },
  ["gE"] = { "goto previous endOfWord" },
  -- ["gf"] = { "goto file under cursor" },                                                        -- normal mode only, visual mode not supported
  ["gg"] = { "goto first line" },
  -- ["gH"] = { "paste LastSearch register (dot to repeat)" },                                     -- normal mode only, visual mode not supported
  ["gi"] = { "goto insert" },
  ["gj"] = { "goto Down (when wrapped)" },
  ["gJ"] = { "Join below Line (dot to repeat)" },
  ["gk"] = { "goto Up (when wrapped)" },
  -- ["gm"] = { "goto mid window" },                                                               -- normal mode only, visual mode not supported
  ["gM"] = { "goto mid line" },
  ["gn"] = { "+next (;, to repeat)" },
  -- ["go"] = { "add virtual cursor down (tab to extend/cursor mode) (dot to repeat)" },                           -- requires vim-visual-multi
  -- ["gO"] = { "add virtual cursor up (tab to extend/cursor mode) (dot to repeat)" },                             -- requires vim-visual-multi
  ["gp"] = { "+previous (;, to repeat)" },
  ["gq"] = vim.tbl_extend("force", { "+SplitJoin comment/lines 80chars (dot to repeat)" }, g_textobj),
  -- ["gr"] = { "Redo register (dot to paste forward)" },                                          -- normal mode only, visual mode not supported
  -- ["gR"] = { "Redo register (dot to paste backward)" },                                         -- normal mode only, visual mode not supported  -- (overwrites "replace mode")
  ["gs"] = { "+Surround (followed by a=add, d=delete, r=replace)(dot to repeat)" },
  ["gS"] = { "SplitJoin args (dot to repeat)" },
  -- ["gt"] = { "goto next tab" },                                                                 -- normal mode only, visual mode not supported
  -- ["gT"] = { "goto prev tab" },                                                                 -- normal mode only, visual mode not supported
  ["gu"] = { "+toLowercase (dot to repeat)" },
  ["gU"] = { "+toUppercase (dot to repeat)" },
  ["gv"] = { "last selected" },
  ["gw"] = vim.tbl_extend("force", { "+SplitJoin coments/lines 80chars (keeps cursor position)" }, g_textobj),
  -- ["gW"] = { "word-column multicursor" },                                                       -- requires vim-visual-multi
  ["gx"] = vim.tbl_extend("force", { "+Blackhole register (dot to repeat)" }, g_textobj),
  ["gX"] = { "Blackhole linewise (dot to repeat)" },
  ["gy"] = { "+replace with register (dot to repeat)" },
  ["gY"] = { "+exchange text (dot to repeat)" },
  ["gz"] = { "+sort (dot to repeat)" },
  ["g+"] = { "Increment number (dot to repeat)" },
  ["g-"] = { "Decrement number (dot to repeat)" },
  ["g<Up>"] = { "Numbers ascending" },
  ["g<Down>"] = { "Numbers descending" },
  ["="] = vim.tbl_extend("force", { "+autoindent (dot to repeat)" }, g_textobj),
  [">"] = { "+indent right (dot to repeat)" },
  ["<"] = { "+indent left (dot to repeat)" },
}

for key, value in pairs(mappings) do
  vim.keymap.set("n", "<Space>" .. key, value[1], { desc = value[2] })
end

for key, value in pairs(ai_textobj) do
  table.insert(M, { desc = value[1], keys = "a" .. key, mode = "o" })
  table.insert(M, { desc = value[1], keys = "i" .. key, mode = "o" })
  table.insert(M, { desc = value[1], keys = "a" .. key, mode = "x" })
  table.insert(M, { desc = value[1], keys = "i" .. key, mode = "x" })
end

-- -- All g_textobj supports dot to repeat except `gm`
-- for key, value in pairs(g_textobj) do
--   table.insert(M, { desc = value[1], keys = key, mode = "o" })
-- end

-- it just adds `+` and `(dot to repeat)` to description
for key, value in pairs(g_operator_motion) do
  table.insert(M, { desc = value[1], keys = key, mode = "n" })
  table.insert(M, { desc = value[1], keys = key, mode = "x" })
end

-- vim.print(M)
return M
