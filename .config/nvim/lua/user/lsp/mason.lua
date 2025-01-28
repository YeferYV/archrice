local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
  return
end

-- local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
-- if not mason_lspconfig_status_ok then
--   return
-- end

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

------------------------------------------------------------------------------------------------------------------------

-- mason_lspconfig.setup_handlers({
--   -- The first entry (without a key) will be the default handler
--   -- and will be called for each installed server that doesn't have
--   -- a dedicated handler.
--   function(server_name) -- default handler (optional)
--     local opts = {
--       on_attach = require("user.lsp.handlers").on_attach,
--       capabilities = require("user.lsp.handlers").capabilities,
--     }
--
--     local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server_name)
--     if has_custom_opts then
--       opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
--     end
--
--     require("lspconfig")[server_name].setup(opts)
--   end,
--
--   -- -- Next, you can provide targeted overrides for specific servers.
--   -- ["rust_analyzer"] = function ()
--   --     require("rust-tools").setup {}
--   -- end,
--   -- ["lua_ls"] = function ()
--   --     lspconfig.lua_ls.setup {
--   --         settings = {
--   --             Lua = {
--   --                 diagnostics = {
--   --                     globals = { "vim" }
--   --                 }
--   --             }
--   --         }
--   --     }
--   -- end,
--
--
--   -- https://github.com/creativenull/efmls-configs-nvim/tree/v1.9.0/lua/efmls-configs/formatters
--   -- https://github.com/creativenull/efmls-configs-nvim/tree/v1.9.0/lua/efmls-configs/linters
--   ["efm"] = function()
--     require("lspconfig").efm.setup {
--       init_options = { documentFormatting = true },
--       settings = {
--         rootMarkers = { ".git/" },
--         languages = {
--           python = { { formatCommand = "black -", formatStdin = true } },
--           javascript = { { formatCommand = "prettier --stdin-filepath '${INPUT}'", formatStdin = true } },
--           javascriptreact = { { formatCommand = "prettier --stdin-filepath '${INPUT}'", formatStdin = true } },
--           typescript = { { formatCommand = "prettier --stdin-filepath '${INPUT}'", formatStdin = true } },
--           typescriptreact = { { formatCommand = "prettier --stdin-filepath '${INPUT}'", formatStdin = true } },
--           css = { { formatCommand = "prettier --stdin-filepath '${INPUT}'", formatStdin = true } },
--           html = { { formatCommand = "prettier --stdin-filepath '${INPUT}'", formatStdin = true } },
--           json = { { formatCommand = "prettier --stdin-filepath '${INPUT}'", formatStdin = true } },
--           markdown = { { formatCommand = "prettier --stdin-filepath '${INPUT}'", formatStdin = true } },
--           yaml = { { formatCommand = "prettier --stdin-filepath '${INPUT}'", formatStdin = true } },
--         }
--       }
--     }
--   end,
-- })

------------------------------------------------------------------------------------------------------------------------

-- https://github.com/NvChad/ui/blob/v3.0/lua/nvchad/mason/names.lua
-- local servers = vim.lsp.get_clients()
-- local servers = require("lspconfig").util.available_servers()
local masonames = {
  angularls = "angular-language-server",
  astro = "astro-language-server",
  bashls = "bash-language-server",
  cmake = "cmake-language-server",
  csharp_ls = "csharp-language-server",
  css_variables = "css-variables-language-server",
  cssls = "css-lsp",
  cssmodules_ls = "cssmodules-language-server",
  denols = "deno",
  docker_compose_language_service = "docker-compose-language-service",
  dockerls = "dockerfile-language-server",
  emmet_language_server = "emmet-language-server",
  emmet_ls = "emmet-ls",
  eslint = "eslint-lsp",
  graphql = "graphql-language-service-cli",
  gitlab_ci_ls = "gitlab-ci-ls",
  gopls = "gopls",
  html = "html-lsp",
  htmx = "htmx-lsp",
  java_language_server = "java-language-server",
  jdtls = "jdtls",
  jsonls = "json-lsp",
  kotlin_language_server = "kotlin-language-server",
  lua_ls = "lua-language-server",
  neocmake = "neocmakelsp",
  nginx_language_server = "nginx-language-server",
  omnisharp = "omnisharp",
  prismals = "prisma-language-server",
  pylsp = "python-lsp-server",
  pylyzer = "pylyzer",
  quick_lint_js = "quick-lint-js",
  r_language_server = "r-languageserver",
  ruby_lsp = "ruby-lsp",
  ruff_lsp = "ruff-lsp",
  rust_analyzer = "rust-analyzer",
  svelte = "svelte-language-server",
  tailwindcss = "tailwindcss-language-server",
  ts_ls = "typescript-language-server",
  volar = "vue-language-server",
  vuels = "vetur-vls",
  yamlls = "yaml-language-server",
}

-- extract installed lsp servers from mason.nvim
local servers = {}
local pkgs = require("mason-registry").get_installed_packages()
for _, pkgvalue in pairs(pkgs) do
  if pkgvalue.spec.categories[1] == "LSP" then
    table.insert(servers, pkgvalue.name)
  end
end

-- update incompatible mason's lsp names according to nvim-lspconfig
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvchad/mason/init.lua
for masonkey, masonvalue in pairs(masonames) do
  for serverkey, servervalue in pairs(servers) do
    if masonvalue == servervalue then
      servers[serverkey] = masonkey
    end
  end
end

-- autoconfigure lsp servers installed by mason
-- oneliner: require'lspconfig'.pyright.setup{}
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

-- https://github.com/creativenull/efmls-configs-nvim/tree/v1.9.0/lua/efmls-configs/formatters
-- https://github.com/creativenull/efmls-configs-nvim/tree/v1.9.0/lua/efmls-configs/linters
if vim.tbl_contains(servers, "efm") then
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
end

------------------------------------------------------------------------------------------------------------------------

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

------------------------------------------------------------------------------------------------------------------------

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

------------------------------------------------------------------------------------------------------------------------
