local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local M = {}

-- https://github.com/LazyVim/LazyVim/commit/97862f425997bf89f581e6aeceed9aac85d90432
-- https://github.com/LazyVim/LazyVim/commit/1b86d7b2ade1dc934165fb1de8e5a3b211bc5ee0
function M.snippet_replace(snippet, fn)
  return snippet:gsub("%$%b{}", function(m)
    local n, name = m:match("^%${(%d+):(.+)}$")
    return n and fn({ n = n, text = name }) or m
  end) or snippet
end

-- This function resolves nested placeholders in a snippet.
function M.snippet_preview(snippet)
  local ok, parsed = pcall(function()
    return vim.lsp._snippet_grammar.parse(snippet)
  end)
  return ok and tostring(parsed)
      or M.snippet_replace(snippet, function(placeholder)
        return M.snippet_preview(placeholder.text)
      end):gsub("%$0", "")
end

-- This function replaces nested placeholders in a snippet with LSP placeholders.
function M.snippet_fix(snippet)
  local texts = {}
  return M.snippet_replace(snippet, function(placeholder)
    texts[placeholder.n] = texts[placeholder.n] or M.snippet_preview(placeholder.text)
    return "${" .. placeholder.n .. ":" .. texts[placeholder.n] .. "}"
  end)
end

-- local snip_status_ok, luasnip = pcall(require, "luasnip")
-- if not snip_status_ok then
--   return
-- end

-- require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

-- see https://www.nerdfonts.com/cheat-sheet
local kind_icons = {
  Class = "",
  Color = "󰏘",
  Constant = "",
  Constructor = "",
  Enum = "",
  EnumMember = "",
  Event = "",
  Field = "",
  File = "",
  Folder = "󰉋",
  Function = "󰊕",
  Interface = "",
  Keyword = "󰌋",
  Method = "",
  Misc = " ",
  Module = "",
  Operator = "󰆕",
  Property = "",
  Reference = "",
  Snippet = "",
  Struct = "",
  Text = "󰉿",
  TypeParameter = "",
  Unit = "󰑭",
  Value = "",
  Variable = "",
}

cmp.setup {
  snippet = {
    expand = function(args)
      -- luasnip.lsp_expand(args.body) -- For `luasnip` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
      -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)

      local fixed = M.snippet_fix(args.body)
      vim.snippet.expand(fixed)
    end,
  },
  mapping = {
    ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
    ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
    ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
    ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
    -- ["<C-k>"] = cmp.mapping.select_prev_item(),
    -- ["<C-j>"] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(1),
    ['<C-u>'] = cmp.mapping.scroll_docs(-1),
    -- ["<C-y>"] = cmp.config.disable,
    -- ["<C-e>"] = cmp.mapping {
    --   i = cmp.mapping.abort(),
    --   c = cmp.mapping.close(),
    -- },
    -- ['<C-Space>'] = cmp.mapping.complete(),
    ["<C-Space>"] = cmp.mapping({
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
    ["<C-l>"] = cmp.mapping(cmp.mapping.confirm { select = true }, { "i", "c" }),
    -- ['<CR>'] = cmp.mapping.confirm({
    --   behavior = cmp.ConfirmBehavior.Replace,
    --   select = false,
    -- }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
        -- elseif luasnip.expandable() then
        --   luasnip.expand()
        -- elseif luasnip.expand_or_jumpable() then
        --   luasnip.expand_or_jump()
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
        -- elseif luasnip.jumpable(-1) then
        --   luasnip.jump(-1)
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
      -- tailwind previewer (replaced by nvim-colorizer.lua):
      -- require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)

      -- Kind icons
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])

      -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        -- ultisnips = "[Ult]",
        -- vsnip = "[Vsnip]",
        -- snippy = "[Snippy]",
        -- luasnip = "[Snippet]",
        snippets = "[Snippet]",
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
    { name = "nvim_lsp" },
    -- { name = 'ultisnips' },
    -- { name = 'vsnip' },
    -- { name = 'snippy' },
    -- { name = "luasnip" },
    { name = "snippets" },
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
    completeopt = 'menu,menuone,noinsert' -- autoselect to show the completion preview
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
      winhighlight = "Normal:Normal,NormalFloat:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None"
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
