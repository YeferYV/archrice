local flash = require("flash")
-- local textobjs = require("various-textobjs")
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
map("i", "<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true, desc = "next completion when no lsp" })
map("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true, desc = "prev completion when no lsp" })
map({ "n", "v", "t" }, "<M-Left>", "<cmd>vertical resize -2<cr>", { desc = "vertical shrink" })
map({ "n", "v", "t" }, "<M-Right>", "<cmd>vertical resize +2<cr>", { desc = "vertical expand" })
map({ "n", "v", "t" }, "<M-Up>", "<cmd>resize -2<cr>", { desc = "horizontal shrink" })
map({ "n", "v", "t" }, "<M-Down>", "<cmd>resize +2<cr>", { desc = "horizontal shrink" })
map({ "n" }, "<esc>", "<esc><cmd>lua vim.cmd.nohlsearch()<cr>", { desc = "clear search highlight" })
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
map({ "n" }, "<leader>;", ":buffer #<cr>", { desc = "Recent buffer" })

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

-- -- https://vi.stackexchange.com/questions/22570/is-there-a-way-to-move-to-the-beginning-of-the-next-text-object
-- _G.GoStartNormal = function() vim.cmd('normal! `[') --[[ vim.cmd('normal! `<') ]] end
-- _G.GoEndNormal = function() vim.cmd('normal! `]') --[[ vim.cmd('normal! `>') ]] end
-- _G.GoStartVisual = function() vim.api.nvim_feedkeys("`[v`'", "n", true) end
-- _G.GoEndVisual = function() vim.api.nvim_feedkeys("`'v`]", "n", true) end
--
-- map(
--   { "n", "x" },
--   "g<",
--   function()
--     vim.o.operatorfunc = vim.fn.mode() == 'n' and 'v:lua.GoStartNormal' or 'v:lua.GoStartVisual'
--     return "<esc>m'g@"
--   end,
--   { expr = true, desc = "StartOf TextObj (dot to repeat)" }
-- )
-- map(
--   { "n", "x" },
--   "g>",
--   function()
--     vim.o.operatorfunc = vim.fn.mode() == 'n' and 'v:lua.GoEndNormal' or 'v:lua.GoEndVisual'
--     return "<esc>m'g@"
--   end,
--   { expr = true, desc = "EndOf TextObj (dot to repeat)" }
-- )

-- https://vi.stackexchange.com/questions/22570/is-there-a-way-to-move-to-the-beginning-of-the-next-text-object
map(
  { "n", "x" },
  "gT",
  function()
    local ok1, tobj_id1 = pcall(vim.fn.getcharstr)
    local ok2, tobj_id2 = pcall(vim.fn.getcharstr)
    if not ok1 then return end
    if not ok2 then return end
    local cmd = ":normal v" .. tobj_id1 .. tobj_id2 .. "o<cr><esc>`<"
    if vim.fn.mode() ~= "n" then
      cmd = "<esc>:normal m'v" .. tobj_id1 .. tobj_id2 .. "o<cr><esc>`<v`'"
    end
    return cmd
  end,
  { expr = true, desc = "Start of TextObj" }
)
map(
  { "n", "x" },
  "gt",
  function()
    local ok1, tobj_id1 = pcall(vim.fn.getcharstr)
    local ok2, tobj_id2 = pcall(vim.fn.getcharstr)
    if not ok1 then return end
    if not ok2 then return end
    local cmd = ":normal v" .. tobj_id1 .. tobj_id2 .. "o<cr><esc>`>"
    if vim.fn.mode() ~= "n" then
      cmd = ":<c-u>normal m'v" .. tobj_id1 .. tobj_id2 .. "o<cr><esc>`'v`>"
    end
    return cmd
  end,
  { expr = true, desc = "End of TextObj" }
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
map({ "n", "o", "x" }, "g>", "gn", { desc = "Next find textobj" })
map({ "n", "o", "x" }, "g<", "gN", { desc = "Prev find textobj" })

-- ╭───────────────────────────────────────╮
-- │ Text Objects with a/i (dot to repeat) │
-- ╰───────────────────────────────────────╯

-- -- Mini Indent Scope textobj:
-- map({ "o", "x" }, "ii", function() require("mini.ai").select_textobject("i","i") end, { silent = true, desc = "MiniIndentscope bordersless with_blankline" })
-- map({ "x" }, "ai", function() require("mini.ai").select_textobject("i","i") vim.cmd [[ normal koj ]] end, { silent = true, desc = "MiniIndentscope borders with_blankline" })
-- map({ "o" }, 'ai', ':<C-u>normal vai<cr>', { silent = true, desc = "MiniIndentscope borders with_blankline" })

map({ "o", "x" }, "ac", function() commands.ColumnWord('aw') end, { desc = "ColumnWord" })
map({ "o", "x" }, "ic", function() commands.ColumnWord('iw') end, { desc = "ColumnWord" })
map({ "o", "x" }, "ii", function() require("mini.ai").select_textobject("i", "i") end, { desc = "indent" })
map({ "o", "x" }, "ai", ":normal Viik<cr>", { desc = "indent" })
map(
  { "o", "x" },
  "iy",
  function()
    _G.skip_blank_line = true
    require("mini.ai").select_textobject("i", "y")
  end,
  { desc = "same_indent" }
)
map(
  { "o", "x" },
  "ay",
  function()
    _G.skip_blank_line = false
    require("mini.ai").select_textobject("i", "y")
  end,
  { desc = "same_indent" }
)

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

if not vim.g.vscode then
  local next_hunk_repeat, prev_hunk_repeat = ts_repeat_move.make_repeatable_move_pair(
    function() require("mini.diff").goto_hunk('next') end,
    function() require("mini.diff").goto_hunk('prev') end
  )
  map({ "n", "x", "o" }, "gnh", next_hunk_repeat, { silent = true, desc = "Next GitHunk" })
  map({ "n", "x", "o" }, "gph", prev_hunk_repeat, { silent = true, desc = "Prev GitHunk" })
end

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
repeat_mini_ai("i", "K", "@block.outer")
repeat_mini_ai("a", "K", "@block.inner")
repeat_mini_ai("i", "Q", "@call.outer")
repeat_mini_ai("a", "Q", "@call.inner")
repeat_mini_ai("i", "g", "@comment.outer")
repeat_mini_ai("a", "g", "@comment.inner")
repeat_mini_ai("i", "G", "@conditional.outer")
repeat_mini_ai("a", "G", "@conditional.inner")
repeat_mini_ai("i", "F", "@function.outer")
repeat_mini_ai("a", "F", "@function.inner")
repeat_mini_ai("i", "L", "@loop.outer")
repeat_mini_ai("a", "L", "@loop.inner")
repeat_mini_ai("i", "P", "@parameter.outer")
repeat_mini_ai("a", "P", "@parameter.inner")
repeat_mini_ai("i", "R", "@return.outer")
repeat_mini_ai("a", "R", "@return.inner")
repeat_mini_ai("i", "A", "@assignment.outer")
repeat_mini_ai("a", "A", "@assignment.inner")
repeat_mini_ai("i", "=", "@assignment.rhs")
repeat_mini_ai("a", "=", "@assignment.lhs")
repeat_mini_ai("i", "#", "@number.outer")
repeat_mini_ai("a", "#", "@number.inner")
