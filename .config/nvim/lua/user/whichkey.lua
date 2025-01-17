local M = {}

local mappings = {

  ["<space>"] = { "", "+Motion" },
  ["<space>p"] = { '"*p', "Paste after (second_clip)" },
  ["<space>P"] = { '"*P', "Paste before (second_clip)" },
  ["<space>y"] = { '"*y', "Yank (second_clip)" },
  ["<space>Y"] = { '"*yg_', "Yank forward (second_clip)" },

  -- [";"] = { "", "+Tab" },
  -- [";!"] = { "<cmd>tabmove 0<cr>", "move to #1 tab" },
  -- [";("] = { "<cmd>tabmove $<cr>", "move to last tab" },
  -- [";:"] = { "<cmd>tabmove #<cr>", "move to recent tab" },
  -- [";C"] = { "<cmd>tabonly<cr>", "Close others Tabs" },
  -- [";x"] = { "<cmd>tabclose<cr>", "Close Tab" }, --mapped to <space>X
  -- [";n"] = { "<cmd>tabnext<cr>", "Next Tab" },
  -- [";p"] = { "<cmd>tabprevious<cr>", "Previous Tab" },
  -- [";N"] = { "<cmd>+tabmove<cr>", "move tab to next tab" },
  -- [";P"] = { "<cmd>-tabmove<cr>", "move tab to previous tab" },
  -- [";t"] = { "<cmd>tabnew <cr>", "New Tab" },
  -- [";;"] = { "<cmd>tabnext #<cr>", "Recent Tab" },

  -- ["b"] = { "", "+Buffer" },
  -- ["b<TAB>"] = { ":setlocal nobuflisted | :bprevious  | :tabe # <cr>", "buffer to Tab" },
  -- ["bT"] = { ":bufdo | :setlocal nobuflisted | :b# | :tabe # <cr>", "buffers to Tab" },
  -- ["bv"] = { "<cmd>vertical ball<cr>", "Buffers to vertical windows" },
  -- ["bV"] = { "<cmd>belowright ball<cr>", "Buffers to horizontal windows" },
  -- ["bC"] = { "<cmd>%bd|e#|bd#<cr>", "Close others Buffers" },
  -- ["bt"] = { "<cmd>enew<cr>", "New buffer" },
  -- ["bx"] = { "<cmd>:bp | bd #<cr>", "Close Buffer" }, --mapped to <space>x
  -- ["b;"] = { "<cmd>buffer #<cr>", "Recent buffer" },

  ["f"] = { "", "+Find" },
  ["fb"] = { function() require("snacks").picker.buffers() end, "Buffers" },
  ["fB"] = { function() require("snacks").picker.grep_buffers() end, "Grep Open Buffers" },
  ["fc"] = { function() require("snacks").picker.colorschemes() end, "Colorschemes" },
  ["fk"] = { function() require("snacks").picker.keymaps() end, "Keymaps" },
  ["ff"] = { function() require("snacks").picker.files() end, "Find Files" },
  ["fg"] = { function() require("snacks").picker.grep() end, "Grep" },
  ["fG"] = { function() require("snacks").picker.grep_word() end, "Grep word/selection" },
  ["fh"] = { function() require("snacks").picker.highlights() end, "Highlights names" },
  ["fl"] = { function() require("snacks").picker.lines() end, "Buffer Lines" },
  ["fn"] = { "<cmd>lua MiniNotify.show_history()<cr>", "Notify history" },
  ["fp"] = { function() require("snacks").picker.projects() end, "Projects" },
  ["fq"] = { function() require("snacks").picker.qflist() end, "Quickfix List" },
  ["fr"] = { function() require("snacks").picker.recent() end, "Recent" },
  ['f"'] = { function() require("snacks").picker.registers() end, 'Registers (:help quote)' },
  ["f/"] = { function() require("snacks").picker.git_files() end, "Find Git/Hidden Files" },
  ["f;"] = { function() require("snacks").picker.jumps() end, "Jumps" },
  ["f'"] = { function() require("snacks").picker.marks() end, "Marks" },
  ["f."] = { function() require("snacks").picker.resume() end, "Resume" },


  ["m"] = { ":lua require('mini.files').open(vim.loop.cwd(), true)<cr>", "mini files (cwd)" },
  ["M"] = { ":lua require('mini.files').open(vim.api.nvim_buf_get_name(0), true)<cr>", "mini files (current file)" },
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

  ["l"] = { "", "+LSP" },
  ["lA"] = { function() WhichkeyRepeat("lua vim.lsp.buf.code_action()") end, "Code Action" },
  ["lc"] = { function() WhichkeyRepeat("lua vim.lsp.buf.incoming_calls()") end, "Incoming calls" },
  ["lC"] = { function() WhichkeyRepeat("lua vim.lsp.buf.outgoing_class()") end, "outgoing calls" },
  -- ["ld"] = { function() WhichkeyRepeat("lua vim.lsp.buf.definition()") end, "Goto Definition" },
  -- ["lD"] = { function() WhichkeyRepeat("lua vim.lsp.buf.declaration()") end, "Goto Declaration" },
  ["ld"] = { function() require("snacks").picker.lsp_definitions() end, "Pick Definition" },
  ["lD"] = { function() require("snacks").picker.lsp_declarations() end, "Pick Definition" },
  ["lF"] = { function() WhichkeyRepeat("lua vim.lsp.buf.format({ timeout_ms = 5000 })") end, "Format" },
  ["lh"] = { function() WhichkeyRepeat("lua vim.lsp.buf.signature_help()") end, "Signature" },
  ["lH"] = { function() WhichkeyRepeat("lua vim.lsp.buf.hover()") end, "Hover" },
  -- ["lI"] = { function() WhichkeyRepeat("lua vim.lsp.buf.implementation()") end, "Goto Implementation" },
  ["lI"] = { function() require("snacks").picker.lsp_implementations() end, "Pick Implementation" },
  ["ll"] = { function() WhichkeyRepeat("lua vim.lsp.codelens.refresh()") end, "CodeLens refresh" },
  ["lL"] = { function() WhichkeyRepeat("lua vim.lsp.codelens.run()") end, "CodeLens run" },
  ["ln"] = { function() WhichkeyRepeat("lua vim.diagnostic.jump({ count = 1, float = true })") end, "Next Diagnostic", },
  ["lo"] = { function() WhichkeyRepeat("lua vim.diagnostic.open_float()") end, "Open Diagnostic" },
  ["lO"] = { function() require("snacks").picker.diagnostics() end, "Pick Diagnostics" },
  ["lp"] = { function() WhichkeyRepeat("lua vim.diagnostic.jump({ count = -1, float = true })") end, "Prev Diagnostic", },
  -- ["lQ"] = { function() WhichkeyRepeat("lua vim.diagnostic.setloclist()") end, "Diagnostic List" },
  ["lq"] = { function() require("snacks").picker.loclist() end, "Pick QuickFix LocList" },
  -- ["lr"] = { function() WhichkeyRepeat("lua vim.lsp.buf.references()") end, "References" },
  ["lr"] = { function() require("snacks").picker.lsp_references() end, "Pick References" },
  ["lR"] = { function() WhichkeyRepeat("lua vim.lsp.buf.rename()") end, "Rename" },
  ["ls"] = { function() require("snacks").picker.lsp_symbols() end, "Pick Symbols" },
  -- ["lt"] = { function() WhichkeyRepeat("lua vim.lsp.buf.type_definition()") end, "Goto TypeDefinition" },
  ["lt"] = { function() require("snacks").picker.lsp_type_definitions() end, "Pick Definition" },

  ["p"] = { "", "+Packages" },
  ["pm"] = { "<cmd>Mason<cr>", "Mason" },
  ["pl"] = { "<cmd>Lazy<cr>", "Lazy" },
  ["pL"] = { "<cmd>LspInfo<cr>", "LspInfo" },
  ["pn"] = { "<cmd>NullLsInfo<cr>", "NullLsInfo" },

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
  -- ["uc"] = { "<cmd>Codi<cr>", "Codi Start"},
  -- ["uC"] = { "<cmd>Codi!<cr>", "Codi Stop" },
  -- ["um"] = { ":lua MiniMap.toggle()<cr>", "Toggle MiniMap" },
  -- ["ut"] = { ":windo if &buftype == 'terminal' | hide | endif <cr>", "Hide window terminal" },
  -- ["uT"] = { ":execute &buftype == 'terminal' ? 'hide' : 'sbuffer term'<cr>", "toggle window terminal (unfocus opens other terminal)" },
  ["u0"] = { "<cmd>set showtabline=0<cr>", "Buffer Hide" },
  ["u2"] = { "<cmd>set showtabline=2<cr>", "Buffer Show" },
  ["uc"] = { ":lua vim.opt.cmdheight = (vim.opt.cmdheight:get() == 0) and 1 or 0 <cr>", "Disable AutoNoHighlightSearch" },
  ["ud"] = { function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end, "Toggle Diagnostics" },
  ["ui"] = { ChangeIndent, "Change Indent" },
  ["ul"] = { ":set cursorline!<cr>", "Toggle Cursorline" },
  ["uL"] = { ":setlocal cursorline!<cr>", "Toggle Local Cursorline" },
  ["un"] = { ":noh<cr>", "NoHighlight" },
  ["up"] = { ":popup PopUp<cr>", "Toggle Mouse PopUp" },
  ["uP"] = { function() vim.opt.paste = not vim.opt.paste:get() end, "Toggle Paste Mode" },
  ["us"] = { ":lua vim.opt.laststatus = (vim.opt.laststatus:get() == 0) and 2 or (vim.opt.laststatus:get() == 2 and 3 or 0)<cr>", "Toggle StatusBar" },
  ["uu"] = { HideUnhideWindow, "Hide/Unhide window (useful for terminal)" },
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
  ['a'] = { '_function args' },
  ['A'] = { '@assingment' },
  ['b'] = { '_Braces )]}' },
  ["B"] = { 'greddyBrace }' },
  ["c"] = { 'word-column' },
  ["C"] = { 'WORD-column' },
  -- ["d"] = { 'greedyOuterIndentation' },
  -- ["e"] = { 'nearEndOfLine' },
  ['f'] = { '_function call' },
  ["F"] = { '@function' },
  ["g"] = { 'search inline @comment.outer' },
  ["G"] = { '@conditional' },
  ['h'] = { '_html atribute' },
  ['i'] = { 'indentation noblanks' },
  ['I'] = { 'Indentation' },
  -- ['j'] = { 'cssSelector' },
  ['k'] = { '_key' },
  ["K"] = { '@block' },
  ["l"] = { '+Last' },
  ["L"] = { '@loop' },
  -- ["m"] = { 'chainMember' },
  -- ["M"] = { 'mdFencedCodeBlock' },
  ['N'] = { '_number' },
  ['n'] = { '+Next' },
  ['o'] = { '_whitespace' },
  ['p'] = { 'paragraph' },
  ["P"] = { '@parameter' },
  ["q"] = { '@call' },
  ["Q"] = { '@class' },
  -- ["r"] = { 'restOfParagraph' },
  ["R"] = { '@return' },
  ['s'] = { 'sentence' },
  ['S'] = { 'Subword' },
  ['t'] = { '_Tag' },
  ['u'] = { '_Quotes "\'`' },
  -- ['U'] = { 'pyTripleQuotes' },
  ['v'] = { '_value' },
  ['w'] = { 'word' },
  ['W'] = { 'WORD' },
  ['x'] = { '_hex' },
  ['y'] = { 'same_indent' },
  ['z'] = { '@fold' },
  -- ['Z'] = { 'ClosedFold' },
  ["="] = { '@assignment.rhs-lhs' },
  ["#"] = { '@number' },
  ['?'] = { '_Prompt' },
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

  ["g["] = vim.tbl_extend("force", { "+Cursor to Left Around (dot to repeat)" }, ai_textobj),
  ["g]"] = vim.tbl_extend("force", { "+Cursor to Rigth Around (dot to repeat)" }, ai_textobj),
  ["g."] = { "goto last change" },
  -- ["ga"] = { "Align (operator)" },                                               -- only visual and normal mode
  -- ["gA"] = { "Preview Align (operator)" },                                       -- only visual and normal mode
  -- ["gb"] = { "Blackhole register (dot to repeat)" },                             -- only visual and normal mode
  -- ["gB"] = { "Blackhole linewise (dot to repeat)" },                             -- only visual and normal mode
  ["gc"] = { "comment textobj (dot to repeat)" },
  ["gC"] = { "BlockComment textobj (dot to repeat)" },
  ["gd"] = { "Diagnostic textobj (dot to repeat)" },
  ["ge"] = { "Prev endOf word textobj (dot to repeat)" },
  ["gE"] = { "Prev endOf WORD textobj (dot to repeat)" },
  ["gf"] = { "Next find textobj (dot to repeat)" },
  ["gF"] = { "Prev find textobj (dot to repeat)" },
  ["gg"] = { "First line textobj (dot to repeat)" },
  ["gh"] = { "Git hunk textobj (dot to repeat)" },
  -- ["gi"] = { "Goto Insert textobj" },                                            -- only visual and normal mode
  ["gj"] = { "GoDown when wrapped textobj (dot to repeat)" },
  ["gk"] = { "GoUp when wrapped textobj (dot to repeat)" },
  ["gK"] = { "ColumnDown textobj (dot to repeat)" },
  ["gl"] = { "Last modified/yank/paste textobj (no repeater key)" },
  ["gL"] = { "Url textobj (dot to repeat)" },
  -- ["gm"] = { "+Multiply (duplicate text) Operator (dot to repeat)" },            -- only visual and normal mode
  ["gn"] = { "+next (dot to repeat)" },
  ["go"] = { "VisibleWindow (dot to repeat)" },
  ["gO"] = { "RestOfWindow (dot to repeat)" },
  ["gp"] = { "+previous (dot to repeat)" },
  -- ["gq"] = { "+Format Selection/comments 80chars (dot to repeat)" },             -- only visual and normal mode (cursor_position at start)(overrided by LSP)
  -- ["gr"] = { "+Replace Operator (dot to repeat)" },                              -- only visual and normal mode
  -- ["gs"] = { "+Sort Operator (dot to repeat)" },                                 -- only visual and normal mode
  -- ["gS"] = { "SplitJoin args (dot to repeat)" },                                 -- only visual and normal mode
  ["gt"] = { "toNextQuotationMark textobj (dot to repeat)" },
  ["gT"] = { "toNextClosingBracket textobj (dot to repeat)" },
  -- ["gu"] = { "to lowercase (dot to repeat)" },                                   -- only visual and normal mode
  -- ["gU"] = { "to Uppercase (dot to repeat)" },                                   -- only visual and normal mode
  -- ["gv"] = { "last selected" },                                                  -- only visual and normal mode
  -- ["gw"] = { "SplitJoin comments/lines (limited at 80 chars)(dot to repeat)" },  -- only visual and normal mode
  -- ["gx"] = { "+Exchange Operator (dot to repeat)" },                             -- only visual and normal mode
  -- ["gy"] = { "Redo register (dot to paste forward)" },                           -- normal mode only, visual mode not supported
  -- ["gY"] = { "Redo register (dot to paste backward)" },                          -- normal mode only, visual mode not supported  -- (overwrites "replace mode")
  -- ["gz"] = { "+Surround textobj (dot to repeat)" },                              -- only visual and normal mode
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
  ["gb"] = vim.tbl_extend("force", { "+Blackhole register (dot to repeat)" }, g_textobj),
  ["gB"] = { "Blackhole linewise (dot to repeat)" },
  ["gc"] = { "+comment (dot to repeat)" },
  ["gC"] = { "BlockComment (dot to repeat)" },
  -- ["gd"] = { "goto definition" },                                                               -- normal mode only, visual mode not supported
  ["ge"] = { "goto previous endOfWord" },
  ["gE"] = { "goto previous endOfWord" },
  -- ["gf"] = { "goto file under cursor" },                                                        -- normal mode only, visual mode not supported
  ["gg"] = { "goto first line" },
  -- ["gh"] = {},
  ["gi"] = { "goto last insert" },
  ["gj"] = { "goto Down (when wrapped)" },
  ["gJ"] = { "Join below Line (dot to repeat)" },
  ["gk"] = { "goto Up (when wrapped)" },
  -- ["gl"] = {},
  ["gm"] = { "+Multiply (duplicate text) Operator (dot to repeat)" },
  ["gM"] = { "goto mid line" },
  ["gn"] = { "+next (only textobj with `@`,`_`)(;, to repeat)" },
  -- ["go"] = {},
  ["gp"] = { "+previous (only textobj with `@`,`_`)(;, to repeat)" },
  ["gq"] = vim.tbl_extend("force", { "+Format selection/comments (dot to repeat)" }, g_textobj),
  ["gr"] = { "+Replace (with register) Operator (dot to repeat)" },
  ["gs"] = { "+Sort Operator (dot to repeat)" },
  ["gS"] = { "SplitJoin args (dot to repeat)" },
  -- ["gt"] = { "goto next tab" },                                                                 -- normal mode only, visual mode not supported
  -- ["gT"] = { "goto prev tab" },                                                                 -- normal mode only, visual mode not supported
  ["gu"] = { "+toLowercase (dot to repeat)" },
  ["gU"] = { "+toUppercase (dot to repeat)" },
  ["gv"] = { "last selected" },
  ["gw"] = vim.tbl_extend("force", { "+SplitJoin coments/lines 80chars (keeps cursor position)" }, g_textobj),
  ["gx"] = { "+Exchange (text) Operator (dot to repeat)" },
  -- ["gy"] = { "Redo register (dot to paste forward)" },                                          -- normal mode only, visual mode not supported
  -- ["gY"] = { "Redo register (dot to paste backward)" },                                         -- normal mode only, visual mode not supported  -- (overwrites "replace mode")
  ["gz"] = { "+Surround (followed by a=add, d=delete, r=replace)(dot to repeat)" },
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
