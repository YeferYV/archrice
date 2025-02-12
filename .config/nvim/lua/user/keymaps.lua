-- `:help <cmd>`
local flash = require("flash")
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
map({ "n" }, "R", "<cmd>lua vim.lsp.buf.format({ timeout_ms = 5000 }) MiniTrailspace.trim() vim.cmd('silent write') <cr>")
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
map({ "n" }, "<right>", "<cmd>bnext<CR>", { desc = "next buffer" })
map({ "n" }, "<left>", "<cmd>bprevious<CR>", { desc = "prev buffer" })
map({ "n" }, "<leader>x", "<cmd>bp | bd! #<CR>", { desc = "Close Buffer" }) -- `bd!` forces closing terminal buffer
map({ "n" }, "<leader>;", "<cmd>buffer #<cr>", { desc = "Recent buffer" })

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
-- map("o", "gm", "<cmd>normal! `[v`]<cr>", { desc = "Last change textobj" })
-- map("x", "gm", "`[o`]", { desc = "Last change textobj" })

-- _mini_comment_(not_showing_desc)_(next/prev_autojump_unsupported)
-- map({ "o" }, 'gC', '<cmd>lua require("mini.comment").textobject()<cr>', { desc = "RestOfComment textobj" })
-- map({ "x" }, 'gC', ':<c-u>normal "zygCgv<cr>', { silent = true, desc = "RestOfComment textobj" })

map({ "n" }, "vgc", "<cmd>lua require('mini.comment').textobject()<cr>", { desc = "select BlockComment" })
map({ "o", "x" }, "gC", "<cmd>lua require('mini.comment').textobject()<cr>", { desc = "BlockComment textobj" })
map({ "n", "o", "x" }, "g>", "gn", { desc = "Next find textobj" })
map({ "n", "o", "x" }, "g<", "gN", { desc = "Prev find textobj" })

-- ╭───────────────────────────────────────╮
-- │ Text Objects with a/i (dot to repeat) │
-- ╰───────────────────────────────────────╯

-- -- Mini Indent Scope textobj:
-- map({ "o", "x" }, "ii", function() require("mini.ai").select_textobject("i","i") end, { desc = "MiniIndentscope bordersless with_blankline" })
-- map({ "x" }, "ai", function() require("mini.ai").select_textobject("i","i") vim.cmd [[ normal koj ]] end, { desc = "MiniIndentscope borders with_blankline" })
-- map({ "o" }, 'ai', ':<C-u>normal vai<cr>', { silent = true, desc = "MiniIndentscope borders with_blankline" })

map({ "o", "x" }, "ac", function() commands.ColumnWord('aw') end, { desc = "ColumnWord" })
map({ "o", "x" }, "ic", function() commands.ColumnWord('iw') end, { desc = "ColumnWord" })
map({ "o", "x" }, "ii", function() require("mini.ai").select_textobject("i", "i") end, { desc = "indent" })
map({ "o", "x" }, "ai", "<cmd>normal Viik<cr>", { desc = "indent" })
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
map({ "x" }, "iz", ":<c-u>normal! [zjV]z<cr>", { silent = true, desc = "inner fold" })
map({ "o" }, "iz", ":normal Viz<CR>", { silent = true, desc = "inner fold" })
map({ "x" }, "az", ":<c-u>normal! [zV]z<cr>", { silent = true, desc = "outer fold" })
map({ "o" }, "az", ":normal Vaz<cr>", { silent = true, desc = "outer fold" })

-- ╭──────────────────────────────────────────╮
-- │ Repeatable Pair - motions using <leader> │
-- ╰──────────────────────────────────────────╯

local _, vscode = pcall(require, "vscode-neovim")
local M = {}
M.ColumnMove = require("user.autocommands").ColumnMove
M.last_move = {}

-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects/blob/master/lua/nvim-treesitter/textobjects/repeatable_move.lua
M.repeat_last_move = function(opts_extend)
  if M.last_move then
    local opts = vim.tbl_deep_extend("force", {}, M.last_move.opts, opts_extend)
    M.last_move.func(opts, unpack(M.last_move.additional_args))
  end
end

map({ "n", "x", "o" }, ";", function() M.repeat_last_move { forward = true } end, { desc = "Next TS textobj" })
map({ "n", "x", "o" }, ",", function() M.repeat_last_move { forward = false } end, { desc = "Prev TS textobj" })

M.make_repeatable_move_pair = function(forward_move_fn, backward_move_fn)
  local set_last_move = function(move_fn, opts, ...)
    M.last_move = { func = move_fn, opts = vim.deepcopy(opts), additional_args = { ... } }
  end

  local general_repeatable_move_fn = function(opts, ...)
    if opts.forward then
      forward_move_fn(...)
    else
      backward_move_fn(...)
    end
  end

  local repeatable_forward_move_fn = function(...)
    set_last_move(general_repeatable_move_fn, { forward = true }, ...)
    forward_move_fn(...)
  end

  local repeatable_backward_move_fn = function(...)
    set_last_move(general_repeatable_move_fn, { forward = false }, ...)
    backward_move_fn(...)
  end

  return repeatable_forward_move_fn, repeatable_backward_move_fn
end

local next_columnmove, prev_columnmove = M.make_repeatable_move_pair(
  function() M.ColumnMove(1) end,
  function() M.ColumnMove(-1) end
)
map({ "n", "x", "o" }, "<leader><leader>j", next_columnmove, { desc = "Next ColumnMove" })
map({ "n", "x", "o" }, "<leader><leader>k", prev_columnmove, { desc = "Prev ColumnMove" })

-- ╭──────────────────────────────────────────────────╮
-- │ Repeatable Pair - textobj navigation using gn/gp │
-- ╰──────────────────────────────────────────────────╯

if vim.g.vscode then
  local next_diagnostic, prev_diagnostic = M.make_repeatable_move_pair(
    function() vscode.call("editor.action.marker.next") end,
    function() vscode.call("editor.action.marker.prev") end
  )
  map({ "n", "x", "o" }, "gnd", next_diagnostic, { desc = "Diagnostic" })
  map({ "n", "x", "o" }, "gpd", prev_diagnostic, { desc = "Diagnostic" })

  local next_hunk_repeat, prev_hunk_repeat = M.make_repeatable_move_pair(
    function() vscode.call("workbench.action.editor.nextChange") end,
    function() vscode.call("workbench.action.editor.previousChange") end
  )
  map({ "n", "x", "o" }, "gnh", next_hunk_repeat, { desc = "GitHunk" })
  map({ "n", "x", "o" }, "gph", prev_hunk_repeat, { desc = "GitHunk" })
  map({ "n", "x", "o" }, "gnH", next_hunk_repeat, { desc = "GitHunk" })
  map({ "n", "x", "o" }, "gpH", prev_hunk_repeat, { desc = "GitHunk" })

  local next_reference, prev_reference = M.make_repeatable_move_pair(
    function() vscode.call("editor.action.wordHighlight.next") end,
    function() vscode.call("editor.action.wordHighlight.prev") end
  )
  map({ "n", "x", "o" }, "gnr", next_reference, { desc = "Reference (vscode only)" })
  map({ "n", "x", "o" }, "gpr", prev_reference, { desc = "Reference (vscode only)" })
else
  local next_diagnostic, prev_diagnostic = M.make_repeatable_move_pair(
    function() vim.diagnostic.jump({ count = 1, float = true }) end,
    function() vim.diagnostic.jump({ count = -1, float = true }) end
  )
  map({ "n", "x", "o" }, "gnd", next_diagnostic, { desc = "Diagnostic" })
  map({ "n", "x", "o" }, "gpd", prev_diagnostic, { desc = "Diagnostic" })

  local next_hunk_repeat, prev_hunk_repeat = M.make_repeatable_move_pair(
    function() require("mini.diff").goto_hunk('next') end,
    function() require("mini.diff").goto_hunk('prev') end
  )
  map({ "n", "x", "o" }, "gnh", next_hunk_repeat, { desc = "GitHunk" })
  map({ "n", "x", "o" }, "gph", prev_hunk_repeat, { desc = "GitHunk" })
end

local next_comment, prev_comment = M.make_repeatable_move_pair(
  function() require("mini.bracketed").comment("forward") end,
  function() require("mini.bracketed").comment("backward") end
)
map({ "n", "x", "o" }, "gnc", next_comment, { desc = "Comment" })
map({ "n", "x", "o" }, "gpc", prev_comment, { desc = "Comment" })

local next_fold, prev_fold = M.make_repeatable_move_pair(
  function() vim.cmd([[ normal ]z ]]) end,
  function() vim.cmd([[ normal [z ]]) end
)
map({ "n", "x", "o" }, "gnf", next_fold, { desc = "Fold ending" })
map({ "n", "x", "o" }, "gpf", prev_fold, { desc = "Fold beginning" })

local next_different_indent, prev_different_indent = M.make_repeatable_move_pair(
  function() commands.next_indent(true, "different_level") end,
  function() commands.next_indent(false, "different_level") end
)
map({ "n", "x", "o" }, "gnI", next_different_indent, { desc = "next different_indent" })
map({ "n", "x", "o" }, "gpI", prev_different_indent, { desc = "prev different_indent" })

local next_same_indent, prev_same_indent = M.make_repeatable_move_pair(
  function() commands.next_indent(true, "same_level") end,
  function() commands.next_indent(false, "same_level") end
)
map({ "n", "x", "o" }, "gny", next_same_indent, { desc = "next same_indent" })
map({ "n", "x", "o" }, "gpy", prev_same_indent, { desc = "prev same_indent" })

local repeat_mini_ai = function(inner_or_around, key, desc)
  local next, prev = M.make_repeatable_move_pair(
    function() require("mini.ai").move_cursor("left", inner_or_around, key, { search_method = "next" }) end,
    function() require("mini.ai").move_cursor("left", inner_or_around, key, { search_method = "prev" }) end
  )
  map({ "n", "x", "o" }, "gn" .. inner_or_around .. key, next, { desc = desc })
  map({ "n", "x", "o" }, "gp" .. inner_or_around .. key, prev, { desc = desc })
end

repeat_mini_ai("i", "a", "argument")
repeat_mini_ai("a", "a", "argument")
repeat_mini_ai("i", "b", "brace")
repeat_mini_ai("a", "b", "brace")
repeat_mini_ai("i", "f", "func_call")
repeat_mini_ai("a", "f", "func_call")
repeat_mini_ai("i", "h", "html_atrib")
repeat_mini_ai("a", "h", "html_atrib")
repeat_mini_ai("i", "k", "key")
repeat_mini_ai("a", "k", "key")
repeat_mini_ai("i", "m", "number")
repeat_mini_ai("a", "m", "number")
repeat_mini_ai("i", "o", "whitespace")
repeat_mini_ai("a", "o", "whitespace")
repeat_mini_ai("i", "q", "quote")
repeat_mini_ai("a", "q", "quote")
repeat_mini_ai("i", "t", "tag")
repeat_mini_ai("a", "t", "tag")
repeat_mini_ai("i", "u", "subword")
repeat_mini_ai("a", "u", "subword")
repeat_mini_ai("i", "v", "value")
repeat_mini_ai("a", "v", "value")
repeat_mini_ai("i", "x", "hexadecimal")
repeat_mini_ai("a", "x", "hexadecimal")
repeat_mini_ai("i", "?", "user_prompt")
repeat_mini_ai("a", "?", "user_prompt")
