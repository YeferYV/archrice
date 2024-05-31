local mason_null_ls_status_ok, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status_ok then
  return
end

local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
-- local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
-- local diagnostics = null_ls.builtins.diagnostics

-- null_ls.setup {
--   debug = false,
--   sources = {
--     -- formatting.black.with({ extra_args = { "--fast" } }),
--     -- formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
--     -- formatting.stylua.with { extra_args = { "--indent-width=2", "--indent-type=Spaces", "--call-parentheses=None", "--quote-style=ForceSingle" } },
--     -- formatting.shellharden,
--     -- diagnostics.flake8
--     -- diagnostics.shellcheck
--   },
-- }

-- https://github.com/williamboman/mason.nvim/discussions/40
-- https://github.com/williamboman/mason.nvim/discussions/93
-- local mason_registry = require "mason-registry"
-- local Pkg = require "mason-core.package"
local null_sources = {}

-- _formatters_and_linters_autoconfig
-- for _, package in ipairs(mason_registry.get_installed_packages()) do
--   if package.spec.categories[1] == Pkg.Cat.Formatter then
--     table.insert(null_sources, null_ls.builtins.formatting[package.name])
--   end
--   if package.spec.categories[1] == Pkg.Cat.Linter then
--     table.insert(null_sources, null_ls.builtins.diagnostics[package.name])
--   end
-- end

-- -- _stylua_config_if_installed
-- for _, package in ipairs(mason_registry.get_installed_packages()) do
--   -- :lua vim.pretty_print(require("mason-registry").get_installed_packages())
--   -- :lua =require("mason-registry").get_installed_packages()[1].name
--   if package.name == "stylua" then
--     table.insert(
--       null_sources,
--       formatting[package.name].with {
--         extra_args = {
--           "--indent-width=2",
--           "--indent-type=Spaces",
--           "--call-parentheses=None",
--           "--collapse-simple-statement=Always",
--           -- "--quote-style=ForceSingle",
--           -- "--quote-style=AutoPreferDouble"
--         },
--       }
--     )
--   end
-- end

null_ls.setup {
  -- sources = { null_ls.builtins.completion.luasnip },
  sources = null_sources,
  -- on_attach = function(client)
  --   if client.resolved_capabilities.document_formatting then
  --     vim.cmd([[
  --       augroup LspAutoFormatting
  --       autocmd! * <buffer>
  --       autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
  --       augroup END
  --       ]])
  --   end
  -- end,
}

mason_null_ls.setup({ handlers = {} }) -- after null_ls.setup() if custom null_ls.setup()
