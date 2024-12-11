local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
  return
end

local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status_ok then
  return
end

-- local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
-- if not lspconfig_status_ok then
--   return
-- end

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
    local opts = {
      on_attach = require("user.lsp.handlers").on_attach,
      capabilities = require("user.lsp.handlers").capabilities,
    }

    local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server_name)
    if has_custom_opts then
      opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
    end

    require("lspconfig")[server_name].setup(opts)
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


  -- https://github.com/creativenull/efmls-configs-nvim/tree/v1.9.0/lua/efmls-configs/formatters
  -- https://github.com/creativenull/efmls-configs-nvim/tree/v1.9.0/lua/efmls-configs/linters
  ["efm"] = function()
    require("lspconfig").efm.setup {
      init_options = { documentFormatting = true },
      settings = {
        rootMarkers = { ".git/" },
        languages = {
          python = { { formatCommand = "black -", formatStdin = true } },
          javascript = { { formatCommand = "prettier --stdin-filepath '${INPUT}'", formatStdin = true } },
          javascriptreact = { { formatCommand = "prettier --stdin-filepath '${INPUT}'", formatStdin = true } },
          typescript = { { formatCommand = "prettier --stdin-filepath '${INPUT}'", formatStdin = true } },
          typescriptreact = { { formatCommand = "prettier --stdin-filepath '${INPUT}'", formatStdin = true } },
          css = { { formatCommand = "prettier --stdin-filepath '${INPUT}'", formatStdin = true } },
          html = { { formatCommand = "prettier --stdin-filepath '${INPUT}'", formatStdin = true } },
          json = { { formatCommand = "prettier --stdin-filepath '${INPUT}'", formatStdin = true } },
          markdown = { { formatCommand = "prettier --stdin-filepath '${INPUT}'", formatStdin = true } },
          yaml = { { formatCommand = "prettier --stdin-filepath '${INPUT}'", formatStdin = true } },
        }
      }
    }
  end,
})

-- -- local server = vim.lsp.buf_get_clients()
-- local servers = lspconfig.util.available_servers()
-- for _, server in pairs(servers) do
--   local opts = {
--     on_attach = require("user.lsp.handlers").on_attach,
--     capabilities = require("user.lsp.handlers").capabilities,
--   }
--   local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)
--   if has_custom_opts then
--     opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
--   end
--   lspconfig[server].setup(opts)
-- end

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



-- local languages = require('efmls-configs.defaults').languages()
-- languages = vim.tbl_extend('force', languages, {
--   python = {
--     -- require('efmls-configs.formatters.ruff'),
--     require('efmls-configs.formatters.black'),
--   },
-- })
--
-- local efmls_config = {
--   filetypes = vim.tbl_keys(languages),
--   settings = {
--     rootMarkers = { '.git/' },
--     languages = languages,
--   },
--   init_options = {
--     documentFormatting = true,
--     documentRangeFormatting = true,
--   },
-- }
--
-- require('lspconfig').efm.setup(vim.tbl_extend('force', efmls_config, {
--   -- Pass your cutom config below like on_attach and capabilities
--   --
--   -- on_attach = on_attach,
--   -- capabilities = capabilities,
-- }))
