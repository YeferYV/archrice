local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
  return
end

local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status_ok then
  return
end

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

mason.setup({
  ui = {
    border = "rounded",
    -- icons = {
    --   package_installed = "✓",
    --   package_pending = "➜",
    --   package_uninstalled = "✗"
    -- }
  }
})

mason_lspconfig.setup_handlers({
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {}
  end,
  -- -- Next, you can provide targeted overrides for specific servers.
  -- ["rust_analyzer"] = function ()
  --     require("rust-tools").setup {}
  -- end,
  -- ["lua_ls"] = function ()
  --     lspconfig.lua_ls.setup {
  --         settings = {
  --             Lua = {
  --                 diagnostics = {
  --                     globals = { "vim" }
  --                 }
  --             }
  --         }
  --     }
  -- end,
})

-- local server = vim.lsp.buf_get_clients()
local servers = lspconfig.util.available_servers()
for _, server in pairs(servers) do
  local opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }
  local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)
  if has_custom_opts then
    opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
  end
  lspconfig[server].setup(opts)
end

-- -- _manually_lspconfig_setup_using_nix/system_package_manager
-- -- to install lua-language-server version 3.5.3 run:
-- -- :!nix-env -iA sumneko-lua-language-server -f https://github.com/NixOS/nixpkgs/archive/ee01de29d2f58d56b1be4ae24c24bd91c5380cea.tar.gz
-- local handle = io.popen("lua-language-server --version 2>/dev/null")
-- if handle then --handles "Need check nil" warning
--   local output = handle:read("*a")
--   if output:match("^3.*") then
--     require('lspconfig')['lua_ls'].setup {
--       on_attach = require("user.lsp.handlers").on_attach,
--       capabilities = require("user.lsp.handlers").capabilities,
--       settings = {
--         Lua = {
--           telemetry = { enable = false },
--           runtime = { version = "LuaJIT" },
--           diagnostics = { globals = { "vim" } },
--           format = { enable = true, }
--         }
--       }
--     }
--   end
--   handle:close()
-- end
