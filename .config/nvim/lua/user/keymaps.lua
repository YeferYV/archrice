local flash = require("flash")
local textobjs = require("various-textobjs")
local commands = require('user.autocommands')
local map = vim.keymap.set
vim.g.mapleader = " "

-- ╭────────────╮
-- │ Navigation │
-- ╰────────────╯

map({ "i" }, "jk", "<ESC>")
map({ "i" }, "kj", "<ESC>")
map({ "n" }, "J", "10gj")
map({ "n" }, "K", "10gk")
map({ "n" }, "H", "10h")
map({ "n" }, "L", "10l")
map({ "n" }, "Y", "yg_", { desc = "Yank forward" })  -- "Y" yank forward by default
map({ "v" }, "Y", "g_y", { desc = "Yank forward" })
map({ "v" }, "P", "g_P", { desc = "Paste forward" }) -- "P" doesn't change register
map({ "v" }, "p", '"_c<c-r>+<esc>', { desc = "Paste (dot repeat)(register unchanged)" })
map({ "n" }, "Q", "<cmd>lua vim.cmd('quit')<cr>")
map({ "n" }, "R", "<cmd>lua vim.lsp.buf.format({ timeout_ms = 5000 }) vim.cmd('silent write') <cr>")
map({ "n" }, "U", "@:", { desc = "repeat last command" })
map({ "v" }, "<", "<gv", { desc = "continious indent" })
map({ "v" }, ">", ">gv", { desc = "continious indent" })
map({ "n", "v", "t" }, "<M-Left>", "<cmd>vertical resize -2<cr>", { desc = "vertical shrink" })
map({ "n", "v", "t" }, "<M-Right>", "<cmd>vertical resize +2<cr>", { desc = "vertical expand" })
map({ "n", "v", "t" }, "<M-Up>", "<cmd>resize -2<cr>", { desc = "horizontal shrink" })
map({ "n", "v", "t" }, "<M-Down>", "<cmd>resize +2<cr>", { desc = "horizontal shrink" })
map({ "t" }, "<esc><esc>", "<C-\\><C-n>", { desc = "normal mode inside terminal" })
map({ "n" }, "<C-s>", ":%s//g<Left><Left>", { desc = "Replace in Buffer" })
map({ "x" }, "<C-s>", ":s//g<Left><Left>", { desc = "Replace in Visual_selected" })
map({ "t", "n" }, "<C-h>", "<C-\\><C-n><C-w>h", { desc = "left window" })
map({ "t", "n" }, "<C-j>", "<C-\\><C-n><C-w>j", { desc = "down window" })
map({ "t", "n" }, "<C-k>", "<C-\\><C-n><C-w>k", { desc = "right window" })
map({ "t", "n" }, "<C-l>", "<C-\\><C-n><C-w>l", { desc = "right window" })
map({ "t", "n" }, "<C-\\>", ToggleTerminal, { desc = "toggle window terminal" })
map({ "t", "n" }, "<C-;>", "<C-\\><C-n><C-6>", { desc = "go to last buffer" })
map({ "n" }, "<right>", ":bnext<CR>", { desc = "next buffer" })
map({ "n" }, "<left>", ":bprevious<CR>", { desc = "prev buffer" })
map({ "n" }, "<leader>x", ":bp | bd! #<CR>", { desc = "Close Buffer" }) -- `bd!` forces closing terminal buffer
map({ "n" }, "<leader>X", ":tabclose<CR>", { desc = "Close Tab" })

-- ╭────────────────╮
-- │ leader keymaps │
-- ╰────────────────╯

map("x", "<leader><leader>p", '"*p', { desc = "Paste (second_clip)" })           -- "Paste after (second_clip)"
map("x", "<leader><leader>P", 'g_"*P', { desc = "Paste forward (second_clip)" }) -- only works in visual mode
map("x", "<leader><leader>y", '"*y', { desc = "Yank (second_clip)" })
map("x", "<leader><leader>Y", 'g_"*y', { desc = "Yank forward (second_clip)" })

-- ╭────────────────────╮
-- │ Operator / Motions │
-- ╰────────────────────╯

-- map("n", "gb", "<Plug>(VM-Find-Under)", { desc = "add virtual cursor (select and find)(n to add forward)" })
-- map("n", "gB", "v<Plug>(VM-Visual-Find)", { desc = "add virtual cursor (find selected)(N to add backward)" })
-- map("n", "go", "<Plug>(VM-Add-Cursor-Down)", { desc = "add virtual cursor down (tab to visual/cursor mode)" })
-- map("n", "gO", "<Plug>(VM-Add-Cursor-Up)", { desc = "add virtual cursor up (tab to visual/cursor mode)" })
-- map("x", "gb", "<esc><Plug>(VM-Find-Under)", { desc = "add virtual cursor (select and find)(n to add forward)" })
-- map("x", "gB", "<Plug>(VM-Find-Subword-Under)", { desc = "add virtual cursor (find selected)(N to add backward)" })
-- map("x", "go", "<Plug>(VM-Visual-Add)", { desc = "visual select to virtual cursor (n to add forward)" })
-- map("x", "gO", "<Plug>(VM-Visual-Add)", { desc = "visual select to virtual cursor (N to add backward)" })
-- map("n", "mc", "<Plug>(VM-Add-Cursor-At-Pos)", { desc = "create cursor (\\\\<space> to toggle cursor keymaps)" })
-- map("x", "mc", "<Plug>(VM-Visual-Cursors)", { desc = "create cursor (\\\\<space> to toggle cursor keymaps)" })
-- map(
--   { "n", "x" },
--   "gW",
--   function()
--     require('user.autocommands').columnword()
--     vim.cmd([[ execute "normal \<Plug>(VM-Visual-Cursors)siw" ]])
--   end,
--   { silent = true, desc = "word-column multicursor (requires vim-visual-multi)" }
-- )

-- map("n", "vg<", _G.__to_start_of_textobj, { expr = true, desc = "Select from startOf TextObj" })
-- map("n", "vg>", _G.__to_end_of_textobj, { expr = true, desc = "Selcect to endOf TextObj" })
map(
  { "n", "x" },
  "g<",
  -- function() return GotoTextObj("`[", "`[v``", "`[V``", "`[\x16`'") end,
  function() return GotoTextObj("`<", "`<v`'", "`<V`'", "`<\22`'") end,
  { expr = true, silent = true, desc = "StartOf TextObj (dot to repeat)" }
)
map(
  { "n", "x" },
  "g>",
  -- function() return GotoTextObj("`]", "``v`]", "``V`]", "`'\x16`]") end,
  function() return GotoTextObj("`>", "`'v`>", "`'V`>", "`'\22`>") end,
  { expr = true, silent = true, desc = "EndOf TextObj (dot to repeat)" }
)

map({ "n", "x", "o" }, "s", function() flash.jump() end, { desc = "Flash" })
map({ "n", "x", "o" }, "S", function() flash.treesitter() end, { desc = "Flash Treesitter" })
map({ "n", "x", "o" }, "<cr>", function() flash.jump({ continue = true }) end, { desc = "Continue Flash search" })
map({ "x", "o" }, "R", function() flash.treesitter_search() end, { desc = "Treesitter Flash Search" })
map({ "c" }, "<c-s>", function() flash.toggle() end, { desc = "Toggle Flash Search" })
map({ "n", "x" }, "gb", '"_d', { desc = "Blackhole Motion/Selected (dot to repeat)" })
map({ "n", "x" }, "gB", '"_D', { desc = "Blackhole Linewise (dot to repeat)" })
map({ "n", "o", "x" }, "g.", "`.", { desc = "go to last change" })
map({ "n" }, "g,", "g,", { desc = "go forward in :changes" })  -- Formatting will lose track of changes
map({ "n" }, "g;", "g;", { desc = "go backward in :changes" }) -- Formatting will lose track of changes
map({ "n" }, "gy", '"1p', { desc = "Redo register (dot to Paste forward the rest of register)" })
map({ "n" }, "gY", '"1P', { desc = "Redo register (dot to Paste backward the rest of register)" })
map({ "n" }, "g<Up>", "<c-a>", { desc = "numbers ascending" })
map({ "n" }, "g<Down>", "<c-x>", { desc = "numbers descending" })
map({ "x" }, "g<Up>", "g<c-a>", { desc = "numbers ascending" })
map({ "x" }, "g<Down>", "g<c-x>", { desc = "numbers descending" })
map({ "n", "x" }, "g+", "<C-a>", { desc = "Increment number (dot to repeat)" })
map({ "n", "x" }, "g-", "<C-x>", { desc = "Decrement number (dot to repeat)" })

-- ╭───────────────────────────────────────╮
-- │ Text Objects with "g" (dot to repeat) │
-- ╰───────────────────────────────────────╯

-- https://www.reddit.com/r/vim/comments/xnuaxs/last_change_text_object
-- map("v", 'gm', '<Esc>u<C-r>vgi', opts)            -- <left> unsupported
-- map("v", 'gm', '<Esc>u<C-r>v`^<Left>', opts)      -- new-lines unsupported
-- map("o", "gm", "<cmd>normal! `[v`]<cr>", { silent = true, desc = "Last change textobj" })
-- map("x", "gm", "`[o`]", { silent = true, desc = "Last change textobj" })

-- _mini_comment_(not_showing_desc)_(next/prev_autojump_unsupported)
-- map({ "o" }, 'gC', '<cmd>lua require("mini.comment").textobject()<cr>', { silent = true, desc = "RestOfComment textobj" })
-- map({ "x" }, 'gC', ':<c-u>normal "zygCgv<cr>', { silent = true, desc = "RestOfComment textobj" })

map({ "n" }, "vgc", "<cmd>lua require('mini.comment').textobject()<cr>", { desc = "select BlockComment" })
map({ "o", "x" }, "gC", ":<c-u>lua require('mini.comment').textobject()<cr>", { desc = "BlockComment textobj" })
map({ "o", "x" }, "gf", "gn", { desc = "Next find textobj" })
map({ "o", "x" }, "gF", "gN", { desc = "Prev find textobj" })
map({ "o", "x" }, "gh", ":<c-u>Gitsigns select_hunk<cr>", { desc = "Git hunk textobj" })
map({ "o", "x" }, "gd", function() textobjs.diagnostic() end, { desc = "Diagnostic textobj" })
map({ "o", "x" }, "gK", function() textobjs.column() end, { desc = "ColumnDown textobj" })
map({ "o", "x" }, "gl", function() textobjs.lastChange() end, { desc = "last modified/yank/paste (noRepeaterKey)" }) -- `vgm` and `dgm` works. `cgm` and `ygm` doesn't work but it notifies
map({ "o", "x" }, "gL", function() textobjs.url() end, { desc = "Url textobj" })
map({ "o", "x" }, "go", function() textobjs.restOfWindow() end, { desc = "RestOfWindow textobj" })
map({ "o", "x" }, "gO", function() textobjs.visibleInWindow() end, { desc = "VisibleWindow textobj" })
map({ "o", "x" }, "gt", function() textobjs.toNextQuotationMark() end, { desc = "toNextQuotationMark textobj" })
map({ "o", "x" }, "gT", function() textobjs.toNextClosingBracket() end, { desc = "toNextClosingBracket textobj" })

-- ╭───────────────────────────────────────╮
-- │ Text Objects with a/i (dot to repeat) │
-- ╰───────────────────────────────────────╯

-- -- Mini Indent Scope textobj:
-- map({ "o", "x" }, "ii", function() require("mini.ai").select_textobject("i","i") end, { silent = true, desc = "MiniIndentscope bordersless with_blankline" })
-- map({ "x" }, "ai", function() require("mini.ai").select_textobject("i","i") vim.cmd [[ normal koj ]] end, { silent = true, desc = "MiniIndentscope borders with_blankline" })
-- map({ "o" }, 'ai', ':<C-u>normal vai<cr>', { silent = true, desc = "MiniIndentscope borders with_blankline" })
-- map({ "o", "x" }, "iI", "<Cmd>lua MiniIndentscope.textobject(false)<CR>", { silent = true, desc = "MiniIndentscope bordersless skip_blankline" })
-- map({ "o", "x" }, "aI", "<Cmd>lua MiniIndentscope.textobject(true)<CR>", { silent = true, desc = "MiniIndentscope borders skip_blankline" })

map({ "o", "x" }, "ac", function() commands.ColumnWord('aw') end, { desc = "ColumnWord" })
map({ "o", "x" }, "ic", function() commands.ColumnWord('iw') end, { desc = "ColumnWord" })
map({ "o", "x" }, "ad", function() textobjs.greedyOuterIndentation('outer') end, { desc = "greddyOuterIndent" })
map({ "o", "x" }, "id", function() textobjs.greedyOuterIndentation('inner') end, { desc = "greddyOuterIndent" })
map({ "o", "x" }, "ie", function() textobjs.nearEoL() end, { desc = "nearEndOfLine textobj" })
map({ "o", "x" }, "ae", function() textobjs.lineCharacterwise('inner') end, { desc = "lineCharacterwise" })
map({ "o", "x" }, "ii", function() textobjs.indentation("inner", "inner", "noBlanks") end, { desc = "indent" })
map({ "o", "x" }, "ai", function() textobjs.indentation("outer", "outer", "noBlanks") end, { desc = "indent" })
map({ "o", "x" }, "iI", function() textobjs.indentation("inner", "inner") end, { desc = "Indent blanklines" })
map({ "o", "x" }, "aI", function() textobjs.indentation("outer", "outer") end, { desc = "Indent blanklines" })
map({ "o", "x" }, "aj", function() textobjs.cssSelector('outer') end, { desc = "cssSelector" })
map({ "o", "x" }, "ij", function() textobjs.cssSelector('inner') end, { desc = "cssSelector" })
map({ "o", "x" }, "am", function() textobjs.chainMember('outer') end, { desc = "chainMember" })
map({ "o", "x" }, "im", function() textobjs.chainMember('inner') end, { desc = "chainMember" })
map({ "o", "x" }, "aM", function() textobjs.mdFencedCodeBlock('outer') end, { desc = "mdFencedCodeBlock" })
map({ "o", "x" }, "iM", function() textobjs.mdFencedCodeBlock('inner') end, { desc = "mdFencedCodeBlock" })
map({ "o", "x" }, "ir", function() textobjs.restOfParagraph() end, { desc = "RestOfParagraph" })
map({ "o", "x" }, "ar", function() textobjs.restOfIndentation() end, { desc = "restOfIndentation" })
map({ "o", "x" }, "aS", function() textobjs.subword('outer') end, { desc = "Subword" })
map({ "o", "x" }, "iS", function() textobjs.subword('inner') end, { desc = "Subword" })
map({ "o", "x" }, "aU", function() textobjs.pyTripleQuotes('outer') end, { desc = "pyTrippleQuotes" })
map({ "o", "x" }, "iU", function() textobjs.pyTripleQuotes('inner') end, { desc = "pyTrippleQuotes" })
map({ "x", "o" }, "iy", function() commands.select_same_indent(true, true) end, { desc = "same_indent" })
map({ "x", "o" }, "ay", function() commands.select_same_indent(false, false) end, { desc = "same_indent blank" })
map({ "o", "x" }, "aZ", function() textobjs.closedFold('outer') end, { desc = "ClosedFold" })
map({ "o", "x" }, "iZ", function() textobjs.closedFold('inner') end, { desc = "ClosedFold" })

-- https://superuser.com/questions/578432/can-vim-treat-a-folded-section-as-a-motion
map({ "x" }, "iz", ":<c-u>normal! [zjV]zk<cr>", { desc = "inner fold" })
map({ "o" }, "iz", ":normal Viz<CR>", { desc = "inner fold" })
map({ "x" }, "az", ":<c-u>normal! [zV]z<cr>", { desc = "outer fold" })
map({ "o" }, "az", ":normal Vaz<cr>", { desc = "outer fold" })

-- ╭──────────────────────────────────────────╮
-- │ Repeatable Pair - motions using <leader> │
-- ╰──────────────────────────────────────────╯

local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
map({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next, { silent = true, desc = "Next TS textobj" })
map({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous, { silent = true, desc = "Prev TS textobj" })

local next_columnmove, prev_columnmove = ts_repeat_move.make_repeatable_move_pair(
  function() commands.ColumnMove(1) end,
  function() commands.ColumnMove(-1) end
)
map({ "n", "x", "o" }, "<leader><leader>j", next_columnmove, { silent = true, desc = "Next ColumnMove" })
map({ "n", "x", "o" }, "<leader><leader>k", prev_columnmove, { silent = true, desc = "Prev ColumnMove" })

-- ╭──────────────────────────────────────────────────╮
-- │ Repeatable Pair - textobj navigation using gn/gp │
-- ╰──────────────────────────────────────────────────╯

local next_comment, prev_comment = ts_repeat_move.make_repeatable_move_pair(
  function() require("mini.bracketed").comment("forward") end,
  function() require("mini.bracketed").comment("backward") end
)
map({ "n", "x", "o" }, "gnc", next_comment, { silent = true, desc = "Next Comment" })
map({ "n", "x", "o" }, "gpc", prev_comment, { silent = true, desc = "Prev Comment" })

local next_diagnostic, prev_diagnostic = ts_repeat_move.make_repeatable_move_pair(
  function() vim.diagnostic.jump({ count = 1, float = true }) end,
  function() vim.diagnostic.jump({ count = -1, float = true }) end
)
map({ "n", "x", "o" }, "gnd", next_diagnostic, { silent = true, desc = "Next Diagnostic" })
map({ "n", "x", "o" }, "gpd", prev_diagnostic, { silent = true, desc = "Prev Diagnostic" })

local next_fold, prev_fold = ts_repeat_move.make_repeatable_move_pair(
  function() vim.cmd([[ normal ]z ]]) end,
  function() vim.cmd([[ normal [z ]]) end
)
map({ "n", "x", "o" }, "gnf", next_fold, { silent = true, desc = "Fold ending" })
map({ "n", "x", "o" }, "gpf", prev_fold, { silent = true, desc = "Fold beginning" })

local gs = require("gitsigns")
local next_hunk_repeat, prev_hunk_repeat = ts_repeat_move.make_repeatable_move_pair(gs.next_hunk, gs.prev_hunk)
map({ "n", "x", "o" }, "gnh", next_hunk_repeat, { silent = true, desc = "Next GitHunk" })
map({ "n", "x", "o" }, "gph", prev_hunk_repeat, { silent = true, desc = "Prev GitHunk" })

local next_different_indent, prev_different_indent = ts_repeat_move.make_repeatable_move_pair(
  function() commands.next_indent(true, "different_level") end,
  function() commands.next_indent(false, "different_level") end
)
map({ "n", "x", "o" }, "gnI", next_different_indent, { silent = true, desc = "next different_indent" })
map({ "n", "x", "o" }, "gpI", prev_different_indent, { silent = true, desc = "prev different_indent" })

local next_same_indent, prev_same_indent = ts_repeat_move.make_repeatable_move_pair(
  function() commands.next_indent(true, "same_level") end,
  function() commands.next_indent(false, "same_level") end
)
map({ "n", "x", "o" }, "gny", next_same_indent, { silent = true, desc = "next same_indent" })
map({ "n", "x", "o" }, "gpy", prev_same_indent, { silent = true, desc = "prev same_indent" })

local repeat_mini_ai = function(inner_or_around, key, desc)
  local next, prev = ts_repeat_move.make_repeatable_move_pair(
    function() require("mini.ai").move_cursor("left", inner_or_around, key, { search_method = "next" }) end,
    function() require("mini.ai").move_cursor("left", inner_or_around, key, { search_method = "prev" }) end
  )
  map({ "n", "x", "o" }, "gn" .. inner_or_around .. key, next, { desc = desc })
  map({ "n", "x", "o" }, "gp" .. inner_or_around .. key, prev, { desc = desc })
end

repeat_mini_ai("i", "f", "function call")
repeat_mini_ai("a", "f", "function call")
repeat_mini_ai("i", "h", "html atrib")
repeat_mini_ai("a", "h", "html atrib")
repeat_mini_ai("i", "k", "key")
repeat_mini_ai("a", "k", "key")
repeat_mini_ai("i", "n", "number")
repeat_mini_ai("a", "n", "number")
repeat_mini_ai("i", "u", "quote")
repeat_mini_ai("a", "u", "quote")
repeat_mini_ai("i", "v", "value")
repeat_mini_ai("a", "v", "value")
repeat_mini_ai("i", "x", "hexadecimal")
repeat_mini_ai("a", "x", "hexadecimal")
