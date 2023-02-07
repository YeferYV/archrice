-- Packer Install
-- git clone --depth 1 https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"
-- git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
-- nvim +PackerSync

-- colorschemes
-- vim.cmd [[ colorscheme lunar2-generated ]]
-- vim.cmd [[ colorscheme lunar2 ]]
-- vim.cmd [[ colorscheme leet]]

-- Lua
require "user.autocommands"
require "user.options"
require "user.plugins"
require "user.alpha"
require "user.aerial"
require "user.bufferline"
require "user.colorizer"
require "user.colorscheme"
require "user.cmp"
require "user.cmp-tabnine"
require "user.dap"
require "user.illuminate"
require "user.impatient"
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
require "user.keymaps"
