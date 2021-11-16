-- https://github.com/neovim/nvim-lspconfig/issues/260
-- local util = require 'lspconfig/util'
-- lsp.tsserver.setup {on_attach = custom_attach, root_dir = util.root_pattern("package.json", "tsconfig.json", ".git") or vim.loop.cwd(); }
-- require'lspconfig'.tsserver.setup {on_attach = require'cmp'.on_attach, root_dir = vim.loop.cwd }

-- https://stackoverflow.com/questions/64868071/i-cannot-activate-nvims-built-in-lsps-for-javascript-and-html
require'lspconfig'.tsserver.setup{
  filetypes = { "javscript","typescript", "typescriptreact", "typescript.tsx" },
  settings = {rootMarkers = {".git/",".js",".ts",".tsx"}},
  root_dir = function() return vim.loop.cwd() end      -- run lsp for javascript in any directory
}
