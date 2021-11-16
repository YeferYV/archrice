-- lsp setup
-- Set Default Prefix.
-- Note: You can set a prefix per lsp server in the lv-globals.lua file
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
      prefix = "",
      spacing = 0,
    },
    signs = true,
    underline = true,
  }
)

-- -- uncomment below to enable nerd-font based icons for diagnostics in the
-- -- gutter, see:
-- -- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization#change-diagnostic-symbols-in-the-sign-column-gutter
-- local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
--
-- for type, icon in pairs(signs) do
--   local hl = "LspDiagnosticsSign" .. type
--   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
-- end

-- symbols for autocomplete
-- https://github.com/nikvdp/nvim-lsp-config/blob/master/lua/lsp.lua
-- vim.lsp.protocol.CompletionItemKind = {
--     "   (Text) ",
--     "   (Method)",
--     "   (Function)",
--     "   (Constructor)",
--     " ﴲ  (Field)",
--     "[] (Variable)",
--     "   (Class)",
--     " ﰮ  (Interface)",
--     "   (Module)",
--     " 襁 (Property)",
--     "   (Unit)",
--     "   (Value)",
--     " 練 (Enum)",
--     "   (Keyword)",
--     "   (Snippet)",
--     "   (Color)",
--     "   (File)",
--     "   (Reference)",
--     "   (Folder)",
--     "   (EnumMember)",
--     " ﲀ  (Constant)",
--     " ﳤ  (Struct)",
--     "   (Event)",
--     "   (Operator)",
--     "   (TypeParameter)"
-- }


-- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization
-- local M = {}
-- M.icons = {
--   Class = " ",
--   Color = " ",
--   Constant = " ",
--   Constructor = " ",
--   Enum = "了 ",
--   EnumMember = " ",
--   Field = " ",
--   File = " ",
--   Folder = " ",
--   Function = " ",
--   Interface = "ﰮ ",
--   Keyword = " ",
--   Method = "ƒ ",
--   Module = " ",
--   Property = " ",
--   Snippet = "﬌ ",
--   Struct = " ",
--   Text = " ",
--   Unit = " ",
--   Value = " ",
--   Variable = " ",
-- }
-- function M.setup()
--   local kinds = vim.lsp.protocol.CompletionItemKind
--   for i, kind in ipairs(kinds) do
--     kinds[i] = M.icons[kind] or kind
--   end
-- end
-- do return M end


-- https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance
-- local kind_icons = {
--   Text = "",
--   Method = "",
--   Function = "",
--   Constructor = "",
--   Field = "",
--   Variable = "",
--   Class = "ﴯ",
--   Interface = "",
--   Module = "",
--   Property = "ﰠ",
--   Unit = "",
--   Value = "",
--   Enum = "",
--   Keyword = "",
--   Snippet = "",
--   Color = "",
--   File = "",
--   Reference = "",
--   Folder = "",
--   EnumMember = "",
--   Constant = "",
--   Struct = "",
--   Event = "",
--   Operator = "",
--   TypeParameter = ""
-- }
-- local cmp = require('cmp')
-- cmp.setup {
--   formatting = {
--     format = function(entry, vim_item)
--       -- Kind icons
--       vim_item.kind = string.format('%s %s', vim.lsp.protocol.CompletionItemKind[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
--       -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
--       -- Source
--       vim_item.menu = ({
--         buffer = "[Buffer]",
--         nvim_lsp = "[LSP]",
--         luasnip = "[LuaSnip]",
--         nvim_lua = "[Lua]",
--         latex_symbols = "[LaTeX]",
--       })[entry.source.name]
--       return vim_item
--     end
--   },
-- }



local function documentHighlight(client, bufnr)
    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec(
            [[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=#464646
      hi LspReferenceText cterm=bold ctermbg=red guibg=#464646
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=#464646
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
            false
        )
    end
end

local lsp_config = {}

function lsp_config.common_on_attach(client, bufnr)
    documentHighlight(client, bufnr)
end
function lsp_config.tsserver_on_attach(client, bufnr)
    lsp_config.common_on_attach(client, bufnr)
    client.resolved_capabilities.document_formatting = false
end

-- local function setup_servers()
--   require'lspinstall'.setup()
--   local servers = require'lspinstall'.installed_servers()
--   for _, server in pairs(servers) do
--     require'lspconfig'[server].setup{}
--   end
-- end

-- setup_servers()

-- -- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
-- require'lspinstall'.post_install_hook = function ()
--   setup_servers() -- reload installed servers
--   vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
-- end


