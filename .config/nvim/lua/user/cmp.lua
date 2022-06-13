local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

--   פּ ﯟ   some other good icons
local kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}
-- see https://www.nerdfonts.com/cheat-sheet

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
    end,
  },
  mapping = {
    ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i","c"}),
    ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i","c"}),
    ["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-1),
    ['<C-f>'] = cmp.mapping.scroll_docs(1),
    ['<C-Space>'] = cmp.mapping.complete(),
    -- ["<C-y>"] = cmp.config.disable,
    -- ["<C-e>"] = cmp.mapping {
    --   i = cmp.mapping.abort(),
    --   c = cmp.mapping.close(),
    -- },
    ["<C-h>"] = cmp.mapping({
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
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping.confirm { select = true },
    -- ['<CR>'] = cmp.mapping.confirm({
    --           behavior = cmp.ConfirmBehavior.Replace,
    --           select = false,
    --           }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, {
      "i",
      "c",
      "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      "i",
      "c",
      "s",
    }),
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      vim_item.menu = ({
        cmp_tabnine = "[TN]",
        nvim_lsp = "[LSP]",
        -- ultisnips = "[Ult]",
        -- vsnip = "[Vsnip]",
        -- snippy = "[Snippy]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
        spell = "[Spell]",
        tags = "[Tags]",
        treesitter = "[TS]",
      })[entry.source.name]
      return vim_item
    end,
  },
  sources = {
    { name = 'cmp_tabnine' },
    { name = "nvim_lsp" },
    -- { name = 'ultisnips' },
    -- { name = 'vsnip' },
    -- { name = 'snippy' },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
    { name = 'spell' },
    { name = 'tags' },
    { name = 'treesitter' },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  completion = {
    completeopt = 'menu,menuone,noinsert'
  },
  -- documentation = {
  --   border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  -- },
   window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
        completion = { -- rounded border; thin-style scrollbar
          border = 'rounded',
          scrollbar = "║",
          thin_scrollbar = true,
          -- completeopt = 'menu,menuone,noinsert',
        },
        documentation = { -- rounded border; native-style scrollbar
          border = 'rounded',
          scrollbar = "║",
          thin_scrollbar = true,
          -- winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
        },
    },
  experimental = {
    ghost_text = false,
    native_menu = false,
  },
  -- view = {
  --   entries = {name = 'custom', selection_order = 'near_cursor' },
  --   -- entries = "native"
  -- },
}

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
