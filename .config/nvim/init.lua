-- Packer Install
-- git clone --depth 1 https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"
-- git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
-- nvim +PackerSync

-- colorschemes
-- vim.cmd [[ colorscheme lunar2-generated ]]
-- vim.cmd [[ colorscheme lunar2 ]]
-- vim.cmd [[ colorscheme leet]]

-- impatient at startup
local status_ok, impatient = pcall(require, "impatient")
if status_ok then
  impatient.enable_profile()
end

require "user.autocommands"
require "user.options"
require "user.plugins"
require "user.aerial"
require "user.alpha"
require "user.bufferline"
require "user.colorizer"
require "user.colorscheme"
require "user.cmp"
require "user.cmp-tabnine"
require "user.dap"
require "user.illuminate"
require "user.indentline"
require "user.lsp"
require "user.lspsaga"
require "user.lualine"
require "user.mini"
require "user.neo-tree"
require "user.neoclip"
require "user.project"
require "user.telescope"
require "user.toggleterm"
require "user.treesitter"
require "user.whichkey"

-- protected calls for ":lua require(...)<cr>"
local status_ok, _ = pcall(require, "user.keymaps")
if not status_ok then
  return
end
