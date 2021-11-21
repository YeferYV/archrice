
local lsp_installer = require("nvim-lsp-installer")

-- Provide settings first!
lsp_installer.settings {
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
}

-- lsp_installer.on_server_ready(function(server) server:setup{} end)



-- local lsp_installer = require("nvim-lsp-installer")

function common_on_attach(client, bufnr)
    -- ... set up buffer keymaps, etc.
end

lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = common_on_attach,
    }

    -- -- (optional) Customize the options passed to the server
    -- if server.name == "tsserver" then
    --     -- opts.root_dir = function() ... end
    --     opts.root_dir = function() return vim.loop.cwd() end
    --     opts.settings = {
    --         showDocumentation = {
    --           enable = true
    --         },
    --         quiet = false,
    --         run = {"onType","onInsert"},
    --         validate = "on",
    --         workingDirectory = {
    --           mode = "auto"
    --         },
    --         languages = {
    --           ["javascript"] = {
    --             validate = "on",
    --             -- runtime = {
    --             --     -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
    --             --     version = 'node',
    --             --     -- Setup your lua path
    --             --     path = vim.split(package.path, ';')
    --             -- },
    --             diagnostics = {
    --                 -- Get the language server to recognize the `vim` global
    --                 globals = {'vim'}
    --             },
    --             workspace = {
    --               -- Make the server aware of Neovim runtime files
    --               library = vim.api.nvim_get_runtime_file("", true),
    --             },
    --             -- workspace = {
    --             --     -- Make the server aware of Neovim runtime files
    --             --     library = {[vim.fn.expand('$VIMRUNTIME/node')] = true, [vim.fn.expand('$VIMRUNTIME/node/vim/lsp')] = true}
    --             -- }
    --            },
    --         },
    --     }
    -- end

    -- if server.name == "eslint" then
    --     -- require('lsp.eslint-lsp').setup()
    --     opts.cmd = { "vscode-eslint-language-server", "--stdio" , "--config /home/drknss/.config/nvim/lua/lsp/.eslintrc.json" };
    --     opts.root_dir = function() return vim.loop.cwd() end
    -- end

    server:setup(opts)
    vim.cmd [[ do User LspAttachBuffers ]]
end)

