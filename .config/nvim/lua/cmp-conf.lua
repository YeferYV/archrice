-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    -- ['<C-y>'] = cmp.config.disable, -- If you want to remove the default `<C-y>` mapping, You can specify `cmp.config.disable` value.
    -- ['<C-y>'] = cmp.mapping({
    --   i = cmp.mapping.complete(),
    --   c = cmp.mapping.abort(),
    --   -- c = cmp.mapping.complete(),
    -- }),
    -- ['<C-e>'] = cmp.mapping({
    --   -- i = cmp.mapping.close(),
    --   i = cmp.mapping.abort(),
    --   c = cmp.mapping.close(),
    -- }),
      ["<C-k>"] = cmp.mapping({
        i = function()
          if cmp.visible() then
            -- require("notify")("visible")
            cmp.abort()
          else
            -- require("notify")("not visible")
            cmp.complete()
          end
        end,
        c = function()
          if cmp.visible() then
            -- require("notify")("visible")
            cmp.close()
          else
            -- require("notify")("not visible")
            cmp.complete()
          end
        end,
      }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = 'cmp_tabnine' }, -- For tabnine users.
    { name = 'nvim_lsp' }, -- For lsp users.
    { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'snippy' }, -- For snippy users.
    -- { name = 'luasnip' }, -- For luasnip users.
  }, {
    { name = 'buffer' },
    { name = 'path' },
    { name = 'spell' },
    { name = 'tags' },
    { name = 'treesitter' },
  }),
  -- preselect = cmp.PreselectMode.Item,
  -- completion = {
  --   completeopt = 'menu,menuone,noinsert'
  -- },
  -- documentation = {
  --   border = "rounded",
  --   winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
  --   max_width = 50,
  --   min_width = 50,
  --   max_height = math.floor(vim.o.lines * 0.4),
  --   min_height = 3,
  -- },
	completion = { -- rounded border; thin-style scrollbar
		border = 'rounded',
		thin_scrollbar = true,
    completeopt = 'menu,menuone,noinsert',
	},
	documentation = { -- no border; native-style scrollbar
		border = 'rounded',
		thin_scrollbar = true,
    -- winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
	},
})

-- Use buffer source for `/`.
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['tsserver'].setup {
    capabilities = capabilities
}

-- cmp.PreselectMode.Item(){
--   preselect = true
-- }
