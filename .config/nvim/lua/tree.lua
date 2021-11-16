-- https://github.com/romgrk/barbar.nvim
-- local tree ={}
-- tree.open = function ()
--    require'bufferline.state'.set_offset(31, 'FileTree')
--    require'nvim-tree'.find_file(true)
-- end
-- tree.close = function ()
--    require'bufferline.state'.set_offset(0)
--    require'nvim-tree'.close()
-- end
-- return tree



-- https://github.com/romgrk/barbar.nvim/issues/81
vim.cmd [[
  let bufferline = get(g:, 'bufferline', {})
]]

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



-- https://github.com/LunarVim/LunarVim/issues/1182
--local M = {}
----
--M.config = function()
--  lvim.builtin.nvimtree = {
--    -- ...
--    width = 40,
--    -- ...
--  }
--end
---- ...
--M.toggle_tree = function()
--  local view_status_ok, view = pcall(require, "nvim-tree.view")
--  if not view_status_ok then
--    return
--  end
--  if view.win_open() then
--    require("nvim-tree").close()
--    if package.loaded["bufferline.state"] then
--      require("bufferline.state").set_offset(0)
--    end
--  else
--    if package.loaded["bufferline.state"] and lvim.builtin.nvimtree.side == "left" then
--      -- require'bufferline.state'.set_offset(31, 'File Explorer')
--      require("bufferline.state").set_offset(lvim.builtin.nvimtree.width + 1, "")
--    end
--    require("nvim-tree").toggle()
--  end
--end
----
--return M





