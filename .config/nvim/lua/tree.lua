
-- -- https://github.com/romgrk/barbar.nvim
-- local tree ={}
-- tree.open = function ()
--    -- require'bufferline.state'.set_offset(31, 'FileTree')
--    require'bufferline.state'.set_offset(31, '')
--    require'nvim-tree'.find_file(true)
-- end
-- tree.close = function ()
--    require'bufferline.state'.set_offset(0)
--    require'nvim-tree'.close()
-- end
-- return tree

-- https://github.com/romgrk/barbar.nvim/issues/177
local tree = {}
tree.toggle = function()
  require'nvim-tree'.toggle()
  if require'nvim-tree.view'.win_open() then
    -- require'bufferline.state'.set_offset(vim.g.nvim_tree_width + 1, 'File Tree')
    require'bufferline.state'.set_offset(31, '')
  else
    require'bufferline.state'.set_offset(0)
  end
end
return tree



-- -- https://github.com/LunarVim/LunarVim/blob/rolling/lua/core/nvimtree.lua -- Sun Jul 18
-- --if not package.loaded['nvim-tree.view'] then
-- --  return
-- --end
--
--local M = {}
--local status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
--if not status_ok then
--  return
--end
----
--M.setup = function()
--  local g = vim.g

--  vim.o.termguicolors = true

--  g.nvim_tree_side = "left"
--  g.nvim_tree_width = 30
--  g.nvim_tree_ignore = { ".git", "node_modules", ".cache" }
--  g.nvim_tree_auto_open = 1
--  g.nvim_tree_auto_close = 1
--  g.nvim_tree_quit_on_open = 0
--  g.nvim_tree_follow = 1
--  g.nvim_tree_indent_markers = 1
--  g.nvim_tree_hide_dotfiles = 1
--  g.nvim_tree_git_hl = 1
--  g.nvim_tree_root_folder_modifier = ":t"
--  g.nvim_tree_tab_open = 0
--  g.nvim_tree_allow_resize = 1
--  g.nvim_tree_lsp_diagnostics = 1
--  g.nvim_tree_auto_ignore_ft = { "startify", "dashboard" }

--  g.nvim_tree_show_icons = {
--    git = 1,
--    folders = 1,
--    files = 1,
--    folder_arrows = 1,
--  }

--  vim.g.nvim_tree_icons = {
--    default = "",
--    symlink = "",
--    git = {
--      unstaged = "",
--      staged = "S",
--      unmerged = "",
--      renamed = "➜",
--      deleted = "",
--      untracked = "U",
--      ignored = "◌",
--    },
--    folder = {
--      default = "",
--      open = "",
--      empty = "",
--      empty_open = "",
--      symlink = "",
--    },
--  }
--  local tree_cb = nvim_tree_config.nvim_tree_callback

--  vim.g.nvim_tree_bindings = {
--    { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
--    { key = "h", cb = tree_cb "close_node" },
--    { key = "v", cb = tree_cb "vsplit" },
--  }
--end

--local view_status_ok, view = pcall(require, "nvim-tree.view")
--if not view_status_ok then
--  return
--end
--M.toggle_tree = function()
--  if view.win_open() then
--    require("nvim-tree").close()
--    if package.loaded["bufferline.state"] then
--      require("bufferline.state").set_offset(0)
--    end
--  else
--    if package.loaded["bufferline.state"] then
--      -- require'bufferline.state'.set_offset(31, 'File Explorer')
--      require("bufferline.state").set_offset(31, "")
--    end
--    require("nvim-tree").find_file(true)
--  end
--end
----
--return M




