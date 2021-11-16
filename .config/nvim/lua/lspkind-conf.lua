local cmp = require'cmp'
local lspkind = require('lspkind')
cmp.setup {
  -- formatting = {
  --   format = lspkind.cmp_format({with_text = true, maxwidth = 50})
  --   -- format = lspkind.cmp_format()
  -- }
  formatting = {
    format = lspkind.cmp_format({
      with_text = true,
     menu = ({
       cmp_tabnine = "[TN]",
       nvim_lsp = "[LSP]",
       ultisnips = "[Ult]",
       vsnip = "[Vsnip]",
       snippy = "[Snippy]",
       luasnip = "[LuaSnip]",
       nvim_lua = "[Lua]",
       buffer = "[Buffer]",
       path = "[Path]",
       spell = "[Spell]",
       tags = "[Tags]",
       treesitter = "[TS]",
       latex_symbols = "[Latex]",
     })
    }),
  },
}
