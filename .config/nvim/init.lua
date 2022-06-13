-- Packer Install
-- git clone --depth 1 https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"
-- git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
-- nvim +PackerSync

-- colorschemes
vim.cmd [[ colorscheme lunar2-generated ]]
vim.cmd [[ colorscheme lunar2 ]]

-- Lua
require "user.autocommands"
require "user.options"
require "user.keymaps"
require "user.plugins"
require "user.bufferline"
require "user.colorizer"
require "user.cmp"
require "user.cmp-tabnine"
require "user.lsp"
require "user.lualine"
require "user.nvim-tree"
require "user.telescope"
require "user.toggleterm"
require "user.treesitter"
