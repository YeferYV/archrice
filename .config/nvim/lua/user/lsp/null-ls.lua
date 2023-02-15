local mason_null_ls_status_ok, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status_ok then
  return
end
mason_null_ls.setup({ automatic_setup = true })

local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  debug = false,
  sources = {
    -- formatting.black.with({ extra_args = { "--fast" } }),
    -- formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
    -- formatting.stylua,
    -- formatting.shellharden,
    -- diagnostics.flake8
    -- diagnostics.shellcheck
  },
})

mason_null_ls.setup_handlers({}) -- after null_ls.setup() if custom null_ls.setup()

-- -- https://github.com/williamboman/mason.nvim/discussions/40
-- -- https://github.com/williamboman/mason.nvim/discussions/93
-- local mason_registry = require("mason-registry")
-- local Pkg = require("mason-core.package")
-- local null_sources = {}
-- for _, package in ipairs(mason_registry.get_installed_packages()) do
--   if package.spec.categories[1] == Pkg.Cat.Formatter then
--     table.insert(null_sources, null_ls.builtins.formatting[package.name])
--   end
--   if package.spec.categories[1] == Pkg.Cat.Linter then
--     table.insert(null_sources, null_ls.builtins.diagnostics[package.name])
--   end
-- end

-- null_ls.setup({
--   sources = null_sources,
--   -- on_attach = function(client)
--   --   if client.resolved_capabilities.document_formatting then
--   --     vim.cmd([[
--   --       augroup LspAutoFormatting
--   --       autocmd! * <buffer>
--   --       autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
--   --       augroup END
--   --       ]])
--   --   end
--   -- end,
-- })
