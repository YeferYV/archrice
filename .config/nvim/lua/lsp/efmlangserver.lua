require('lspconfig')['efm'].setup{
  settings = ..., -- You must populate this according to the EFM readme
  filetypes = { 'python','cpp', 'javascript','lua' }
}

