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
  -- ["b<TAB>"] = { "<cmd>setlocal nobuflisted | :bprevious  | :tabe # <cr>", "buffer to Tab" },
  -- ["bT"] = { "<cmd>bufdo | :setlocal nobuflisted | :b# | :tabe # <cr>", "buffers to Tab" },
  -- ["bv"] = { "<cmd>vertical ball<cr>", "Buffers to vertical windows" },
  -- ["bV"] = { "<cmd>belowright ball<cr>", "Buffers to horizontal windows" },
  -- ["bC"] = { "<cmd>%bd|e#|bd#<cr>", "Close others Buffers" },
  -- ["bt"] = { "<cmd>enew<cr>", "New buffer" },
  -- ["bx"] = { "<cmd>bp | bd #<cr>", "Close Buffer" }, --mapped to <space>x
  -- ["b;"] = { "<cmd>buffer #<cr>", "Recent buffer" },

  ["f"] = { "", "+Find" },
  ["fb"] = { function() require("snacks").picker.buffers() end, "buffers" },
  ["fB"] = { function() require("snacks").picker.grep_buffers() end, "ripgrep on buffers" },
  ["fc"] = { function() require("snacks").picker.colorschemes() end, "colorschemes" },
  ["fk"] = { function() require("snacks").picker.keymaps() end, "keymaps" },
  ["ff"] = { function() require("snacks").picker.files() end, "find files" },
  ["fg"] = { function() require("snacks").picker.grep({ layout = "ivy_split", filter = { cwd = true }, }) end, "ripgrep" },
  ["fG"] = { function() require("snacks").picker.grep_word() end, "grep word/selection" },
  ["fn"] = { "<cmd>lua MiniNotify.show_history()<cr>", "Notify history" },
  ["fp"] = { function() require("snacks").picker.projects() end, "projects" },
  ["fq"] = { function() require("snacks").picker.qflist() end, "quickfix list" },
  ["fr"] = { function() require("snacks").picker.recent() end, "recent files" },
  ['f"'] = { function() require("snacks").picker.registers() end, "registers (:help quote)" },
  ["f/"] = { function() require("snacks").picker.git_files() end, "find git (sorted) files" },
  ["f;"] = { function() require("snacks").picker.jumps() end, "jumps" },
  ["f'"] = { function() require("snacks").picker.marks() end, "marks" },
  ["f."] = { function() require("snacks").picker.resume() end, "resume" },


  ["m"] = { "<cmd>lua require('mini.files').open(vim.loop.cwd(), true)<cr>", "mini files (cwd)" },
  ["M"] = { "<cmd>lua require('mini.files').open(vim.api.nvim_buf_get_name(0), true)<cr>", "mini files (current file)" },
  ["e"] = { "<cmd>lua Snacks.explorer()<cr>", "Toggle Explorer" },
  ["o"] = { "<cmd>lua Snacks.explorer.open({ auto_close = true, layout = { preset = 'default', preview = true }})<cr>", "Explorer with preview" },

  ["g"] = { "", "+Git" },
  ["gg"] = { "<cmd>term lazygit<cr><cmd>set filetype=terminal<cr>", "Tab Lazygit" },
  ["gd"] = { "<cmd>diffthis | vertical new | diffthis | read !git show HEAD^:#<cr>", "git difftool -t nvimdiff" },
  ["gp"] = {
    function()
      -- local curr_file = vim.fs.basename(vim.api.nvim_buf_get_name(0))
      local curr_file = vim.fn.expand('%')
      Snacks.picker.git_diff({
        on_show = function(picker)
          for i, item in ipairs(picker:items()) do
            if item.text:match(curr_file) then
              picker.list:view(i)
              break -- break at first match
            end
          end
          vim.cmd('stopinsert') -- starts normal mode
        end,
      })
    end,
    "Preview Hunk"
  },
  ["gP"] = { function() WhichkeyRepeat("lua Snacks.picker.git_status()") end, "Preview Diff" },
  ["gr"] = { "<cmd>lua MiniDiff.textobject() vim.cmd.normal('gH')<cr>", "Reset Hunk" },
  ["gs"] = { "<cmd>lua MiniDiff.textobject() vim.cmd.normal('gh')<cr>", "Stage Hunk" },

  ["l"] = { "", "+LSP" },
  ["lA"] = { function() WhichkeyRepeat("lua vim.lsp.buf.code_action()") end, "Code Action" },
  ["lc"] = { function() WhichkeyRepeat("lua vim.lsp.buf.incoming_calls()") end, "Incoming calls" },
  ["lC"] = { function() WhichkeyRepeat("lua vim.lsp.buf.outgoing_class()") end, "outgoing calls" },
  -- ["ld"] = { function() WhichkeyRepeat("lua vim.lsp.buf.definition()") end, "Goto Definition" },
  -- ["lD"] = { function() WhichkeyRepeat("lua vim.lsp.buf.declaration()") end, "Goto Declaration" },
  ["ld"] = { function() require("snacks").picker.lsp_definitions() end, "Pick Definition" },
  ["lD"] = { function() require("snacks").picker.lsp_declarations() end, "Pick Declaration" },
  ["lF"] = { function() WhichkeyRepeat("lua vim.lsp.buf.format({ timeout_ms = 5000 })") end, "Format" },
  ["lh"] = { function() WhichkeyRepeat("lua vim.lsp.buf.signature_help()") end, "Signature" },
  ["lH"] = { function() WhichkeyRepeat("lua vim.lsp.buf.hover()") end, "Hover" },
  -- ["lI"] = { function() WhichkeyRepeat("lua vim.lsp.buf.implementation()") end, "Goto Implementation" },
  ["lI"] = { function() require("snacks").picker.lsp_implementations() end, "Pick Implementation" },
  ["ll"] = { function() WhichkeyRepeat("lua vim.lsp.codelens.refresh()") end, "CodeLens refresh" },
  ["lL"] = { function() WhichkeyRepeat("lua vim.lsp.codelens.run()") end, "CodeLens run" },
  ["lm"] = { "<cmd>Mason<cr>", "Mason" },
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
  ["lt"] = { function() require("snacks").picker.lsp_type_definitions() end, "Pick Type Definition" },

  ["t"] = { "", "+Terminal" },
  ["t<TAB>"] = { "<cmd>wincmd T               <cr>", "Terminal to Tab" },
  ["tt"] = { "<cmd>terminal                   <cr>", "buffer terminal (same tab)" },
  ["tT"] = { "<cmd>tabnew |     terminal      <cr>", "buffer terminal (new tab)" },
  ["tY"] = { "<cmd>tabnew |     terminal yazi <cr> <cmd> set filetype=terminal  <cr>", "yazi (new tab)" },
  ["ty"] = { "<cmd>lua vim.cmd[[terminal yazi]] vim.cmd[[set filetype=terminal]]<cr>", "yazi (same tab)" },
  ["t\\"] = { ToggleTerminal, "Toggle window terminal" },

  ["v"] = { "<cmd>vsplit +te | vertical resize 80<cr>", "Vertical terminal" },
  ["V"] = { "<cmd>split +te | resize 10<cr>", "Horizontal terminal" },

  ["u"] = { "", "+UI Toggle" },
  -- ["uc"] = { "<cmd>Codi<cr>", "Codi Start"},
  -- ["uC"] = { "<cmd>Codi!<cr>", "Codi Stop" },
  -- ["um"] = { "<cmd>lua require('mini.map').toggle()<cr>", "Toggle MiniMap" },
  -- ["ut"] = { "<cmd>windo if &buftype == 'terminal' | hide | endif <cr>", "Hide window terminal" },
  -- ["uT"] = { "<cmd>execute &buftype == 'terminal' ? 'hide' : 'sbuffer term'<cr>", "toggle window terminal (unfocus opens other terminal)" },
  ["u0"] = { "<cmd>set showtabline=0<cr>", "Buffer Hide" },
  ["u2"] = { "<cmd>set showtabline=2<cr>", "Buffer Show" },
  ["uc"] = { "<cmd>lua vim.opt.cmdheight = (vim.opt.cmdheight:get() == 0) and 1 or 0 <cr>", "Disable AutoNoHighlightSearch" },
  ["ud"] = { function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end, "Toggle Diagnostics" },
  ["ui"] = { ChangeIndent, "Change Indent" },
  ["ul"] = { "<cmd>set cursorline!<cr>", "Toggle Cursorline" },
  ["uL"] = { "<cmd>setlocal cursorline!<cr>", "Toggle Local Cursorline" },
  ["un"] = { "<cmd>noh<cr>", "NoHighlight" },
  ["up"] = { "<cmd>popup PopUp<cr>", "Toggle Mouse PopUp" },
  ["uP"] = { function() vim.opt.paste = not vim.opt.paste:get() end, "Toggle Paste Mode" },
  ["us"] = { "<cmd>lua vim.opt.laststatus = (vim.opt.laststatus:get() == 0) and 2 or (vim.opt.laststatus:get() == 2 and 3 or 0)<cr>", "Toggle StatusBar" },
  ["uu"] = { HideUnhideWindow, "Hide/Unhide window (useful for terminal)" },
  ["u;"] = { "<cmd>clearjumps<cr><cmd>normal m'<cr>", "Clear and Add jump" }, -- Reset JumpList

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
  vim.keymap.set("n", "<Space>" .. key, value[1], { --[[ silent = true, ]] desc = value[2] })
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
