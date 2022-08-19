local lspconfig = require("lspconfig")
require("mason-lspconfig").setup_handlers({
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function (server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup {}
    end,
    -- -- Next, you can provide targeted overrides for specific servers.
    -- ["rust_analyzer"] = function ()
    --     require("rust-tools").setup {}
    -- end,
    -- ["sumneko_lua"] = function ()
    --     lspconfig.sumneko_lua.setup {
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
local servers = lspconfig.available_servers()
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
