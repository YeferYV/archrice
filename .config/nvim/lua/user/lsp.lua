vim.diagnostic.config({
  update_in_insert = true,
  severity_sort = true,
  virtual_text = true,
  float = {
    focusable = true,
    style = "minimal",
    border = "rounded",
  },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
})


---------------------------------------------------------------------------------------------------------------------

-- https://neovim.io/doc/user/lsp.html#_quickstart
vim.lsp.config('*', {
  -- https://www.reddit.com/r/neovim/comments/1ao6c5a/how_to_make_the_lsp_aware_of_changes_made_to/
  -- `:=vim.lsp.protocol.make_client_capabilities()`
  capabilities = {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true, -- TODO: still not working/implemented (required by `next dev --turbo`)
      }
    },
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true, -- better semantic highlighting?
      }
    }
  },
  root_markers = { '.git' },
})

vim.lsp.config['luals']                   = {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  settings = {
    Lua = {
      diagnostics = {
        globals = {
          "vim"
        }
      }
    }
  }
}

-- https://github.com/creativenull/efmls-configs-nvim/tree/v1.9.0/lua/efmls-configs/formatters
-- https://github.com/creativenull/efmls-configs-nvim/tree/v1.9.0/lua/efmls-configs/linters
vim.lsp.config['efm']                     = {
  cmd = { 'efm-langserver' },
  filetypes = { 'python', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'css', 'html', 'json', 'markdown', 'yaml' },
  init_options = { documentFormatting = true },
  settings = {
    rootMarkers = { ".git/" },
    languages = {
      python          = { { formatCommand = "black -", formatStdin = true } },
      javascript      = { { formatCommand = "prettier --stdin-filepath '${INPUT}'", formatStdin = true } },
      javascriptreact = { { formatCommand = "prettier --stdin-filepath '${INPUT}'", formatStdin = true } },
      typescript      = { { formatCommand = "prettier --stdin-filepath '${INPUT}'", formatStdin = true } },
      typescriptreact = { { formatCommand = "prettier --stdin-filepath '${INPUT}'", formatStdin = true } },
      css             = { { formatCommand = "prettier --stdin-filepath '${INPUT}'", formatStdin = true } },
      html            = { { formatCommand = "prettier --stdin-filepath '${INPUT}'", formatStdin = true } },
      json            = { { formatCommand = "prettier --stdin-filepath '${INPUT}'", formatStdin = true } },
      markdown        = { { formatCommand = "prettier --stdin-filepath '${INPUT}'", formatStdin = true } },
      yaml            = { { formatCommand = "prettier --stdin-filepath '${INPUT}'", formatStdin = true } },
    }
  }
}

-- https://github.com/neovim/nvim-lspconfig/tree/master/lua/lspconfig/configs
vim.lsp.config['angularls']               = { cmd = { "ngserver", "--stdio" }, filetypes = { 'typescript', 'html', 'typescriptreact', 'typescript.tsx', 'htmlangular' } }
vim.lsp.config['ansiblels']               = { cmd = { 'ansible-language-server', '--stdio' }, filetypes = { 'yaml.ansible' } }
vim.lsp.config['arduino_language_server'] = { cmd = { 'arduino-language-server' }, filetypes = { 'arduino' } }
vim.lsp.config['astro']                   = { cmd = { 'astro-ls', '--stdio' }, filetypes = { 'astro' } }
vim.lsp.config['autotools_ls']            = { cmd = { 'autotools-language-server' }, filetypes = { 'config', 'automake', 'make' } }
vim.lsp.config['azure_pipelines_ls']      = { cmd = { 'azure-pipelines-language-server', '--stdio' }, filetypes = { 'yaml' } }
vim.lsp.config['basedpyright']            = { cmd = { 'basedpyright-langserver', '--stdio' }, filetypes = { 'python' } }
vim.lsp.config['bashls']                  = { cmd = { 'bash-language-server', 'start' }, filetypes = { 'bash', 'sh' } }
vim.lsp.config['biome']                   = { cmd = { 'biome', 'lsp-proxy' }, filetypes = { 'astro', 'css', 'graphql', 'javascript', 'javascriptreact', 'json', 'jsonc', 'svelte', 'typescript', 'typescript.tsx', 'typescriptreact', 'vue' } }
vim.lsp.config['ccls']                    = { cmd = { 'ccls' }, filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' } }
vim.lsp.config['cmake']                   = { cmd = { 'cmake-language-server' }, filetypes = { 'cmake' } }
vim.lsp.config['csharp_ls']               = { cmd = { 'csharp-ls' }, filetypes = { 'cs' } }
vim.lsp.config['css_variables']           = { cmd = { 'css-variables-language-server', '--stdio' }, filetypes = { 'css', 'scss', 'less' } }
vim.lsp.config['cssls']                   = { cmd = { 'vscode-css-language-server', '--stdio' }, filetypes = { 'css', 'scss', 'less' } }
vim.lsp.config['cssmodules_ls']           = { cmd = { 'cssmodules-language-server' }, filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' } }
vim.lsp.config['denols']                  = { cmd = { 'deno.cache' }, filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' } }
vim.lsp.config['docker_compose']          = { cmd = { 'docker-compose-langserver', '--stdio' }, filetypes = { 'yaml.docker-compose' } }
vim.lsp.config['dockerls']                = { cmd = { 'docker-langserver', '--stdio' }, filetypes = { 'dockerfile' } }
vim.lsp.config['dprint']                  = { cmd = { 'dprint', 'lsp' }, filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'json', 'jsonc', 'markdown', 'python', 'toml', 'rust', 'graphql' } }
vim.lsp.config['emmet_language_server']   = { cmd = { 'emmet-language-server', '--stdio' }, filetypes = { 'astro', 'css', 'html', 'htmldjango', 'javascriptreact', 'svelte', 'typescriptreact', 'vue', 'htmlangular' } }
vim.lsp.config['emmet_ls']                = { cmd = { 'emmet-ls', '--stdio' }, filetypes = { 'astro', 'css', 'html', 'htmldjango', 'javascriptreact', 'svelte', 'typescriptreact', 'vue', 'htmlangular' } }
vim.lsp.config['eslint']                  = { cmd = { 'vscode-eslint-language-server', '--stdio' }, filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx', 'vue', 'svelte', 'astro' } }
vim.lsp.config['gh_actions_ls']           = { cmd = { 'gh-actions-language-server', '--stdio' }, filetypes = { 'yaml' }, }
vim.lsp.config['gitlab_ci_ls']            = { cmd = { 'gitlab-ci-ls' }, filetypes = { 'yaml.gitlab' } }
vim.lsp.config['golangci_lint_ls']        = { cmd = { 'golangci-lint-langserver' }, filetypes = { 'go', 'gomod' } }
vim.lsp.config['gopls']                   = { cmd = { 'gopls' }, filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' } }
vim.lsp.config['graphql']                 = { cmd = { 'graphql-lsp', 'server', '-m', 'stream' }, filetypes = { 'graphql', 'typescriptreact', 'javascriptreact' } }
vim.lsp.config['html']                    = { cmd = { 'vscode-html-language-server', '--stdio' }, filetypes = { 'html', 'templ' } }
vim.lsp.config['htmx']                    = { cmd = { 'htmx-lsp' }, filetypes = { 'astro', 'astro-markdown', 'django-html', 'htmldjango', 'gohtml', 'gohtmltmpl', 'html', 'htmlangular', 'markdown', 'mdx', 'php', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue', 'svelte', 'templ' } }
vim.lsp.config['jsonls']                  = { cmd = { 'vscode-json-language-server', '--stdio' }, filetypes = { 'json', 'jsonc' } }
vim.lsp.config['lsp_ai']                  = { cmd = { 'lsp-ai' } }
vim.lsp.config['marksman']                = { cmd = { 'marksman' }, filetypes = { 'markdown', 'markdown.mdx' } }
vim.lsp.config['matlab_ls']               = { cmd = { 'matlab-language-server', '--stdio' }, filetypes = { 'matlab' } }
vim.lsp.config['neocmake']                = { cmd = { 'neocmakelsp', '--stdio' }, filetypes = { 'cmake' } }
vim.lsp.config['nginx_language_server']   = { cmd = { 'nginx-language-server' }, filetypes = { 'nginx' } }
vim.lsp.config['phpactor']                = { cmd = { 'phpactor', 'language-server' }, filetypes = { 'php' } }
vim.lsp.config['postgres_lsp']            = { cmd = { 'postgres_lsp' }, filetypes = { 'sql' }, }
vim.lsp.config['prismals']                = { cmd = { 'prisma-language-server', '--stdio' }, filetypes = { 'prisma' } }
vim.lsp.config['psalm']                   = { cmd = { 'psalm', '--language-server' }, filetypes = { 'php' } }
vim.lsp.config['pylsp']                   = { cmd = { 'pylsp' }, filetypes = { 'python' } }
vim.lsp.config['pylyzer']                 = { cmd = { 'pylyzer', '--server' }, filetypes = { 'python' } }
vim.lsp.config['pyre']                    = { cmd = { 'pyre', 'persistent' }, filetypes = { 'python' } }
vim.lsp.config['pyright']                 = { cmd = { 'pyright-langserver', '--stdio' }, filetypes = { 'python' } }
vim.lsp.config['quick_lint_js']           = { cmd = { 'quick-lint-js', '--lsp-server' }, filetypes = { 'javascript', 'typescript' } }
vim.lsp.config['r_language_server']       = { cmd = { 'R', '--no-echo', '-e', 'languageserver::run()' }, filetypes = { 'r', 'rmd' } }
vim.lsp.config['rls']                     = { cmd = { 'rls' }, filetypes = { 'rust' } }
vim.lsp.config['ruff']                    = { cmd = { 'ruff' }, filetypes = { 'python' } }
vim.lsp.config['ruff_lsp']                = { cmd = { 'ruff-lsp' }, filetypes = { 'python' } }
vim.lsp.config['rust_analyzer']           = { cmd = { 'rust-analyzer' }, filetypes = { 'rust' } }
vim.lsp.config['slint_lsp']               = { cmd = { 'slint-lsp' }, filetypes = { 'slint' } }
vim.lsp.config['sqlls']                   = { cmd = { 'sql-language-server', 'up', '--method', 'stdio' }, filetypes = { 'sql', 'mysql' } }
vim.lsp.config['sqls']                    = { cmd = { 'sqls' }, filetypes = { 'sql', 'mysql' } }
vim.lsp.config['svelte']                  = { cmd = { 'svelteserver', '--stdio' }, filetypes = { 'svelte' } }
vim.lsp.config['tailwindcss']             = { cmd = { 'tailwindcss-language-server', '--stdio' }, filetypes = { 'astro', 'astro-markdown', 'django-html', 'htmldjango', 'gohtml', 'gohtmltmpl', 'html', 'htmlangular', 'markdown', 'mdx', 'php', 'css', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue', 'svelte', 'templ' } }
vim.lsp.config['templ']                   = { cmd = { 'templ', 'lsp' }, filetypes = { 'templ' } }
vim.lsp.config['terraform_lsp']           = { cmd = { 'terraform-lsp' }, filetypes = { 'terraform', 'hcl' } }
vim.lsp.config['terraformls']             = { cmd = { 'terraform-ls', 'serve' }, filetypes = { 'terraform', 'terraform-vars' } }
vim.lsp.config['tflint']                  = { cmd = { 'tflint', '--stdio' }, filetypes = { 'terraform' } }
vim.lsp.config['ts_ls']                   = { cmd = { 'typescript-language-server', '--stdio' }, filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' } }
vim.lsp.config['volar']                   = { cmd = { 'vue-language-server', '--stdio' }, filetypes = { 'vue' } }
vim.lsp.config['vtsls']                   = { cmd = { 'vtsls', '--stdio' }, filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx', } }
vim.lsp.config['vuels']                   = { cmd = { 'vls' }, filetypes = { 'vue' } }
vim.lsp.config['yamlls']                  = { cmd = { 'yaml-language-server', '--stdio' }, filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab' } }

vim.lsp.enable('luals')
vim.lsp.enable('efm')
vim.lsp.enable('angularls')
vim.lsp.enable('ansiblels')
vim.lsp.enable('arduino_language_server')
vim.lsp.enable('astro')
vim.lsp.enable('autotools_ls')
vim.lsp.enable('azure_pipelines_ls')
vim.lsp.enable('basedpyright')
vim.lsp.enable('bashls')
vim.lsp.enable('biome')
vim.lsp.enable('ccls')
vim.lsp.enable('cmake')
vim.lsp.enable('csharp_ls')
vim.lsp.enable('css_variables')
vim.lsp.enable('cssls')
vim.lsp.enable('cssmodules_ls')
vim.lsp.enable('denols')
vim.lsp.enable('docker_compose')
vim.lsp.enable('dockerls')
vim.lsp.enable('dprint')
vim.lsp.enable('emmet_language_server')
vim.lsp.enable('emmet_ls')
vim.lsp.enable('eslint')
vim.lsp.enable('gh_actions_ls')
vim.lsp.enable('gitlab_ci_ls')
vim.lsp.enable('golangci_lint_ls')
vim.lsp.enable('gopls')
vim.lsp.enable('graphql')
vim.lsp.enable('html')
vim.lsp.enable('htmx')
vim.lsp.enable('jsonls')
vim.lsp.enable('lsp_ai')
vim.lsp.enable('marksman')
vim.lsp.enable('matlab_ls')
vim.lsp.enable('neocmake')
vim.lsp.enable('nginx_language_server')
vim.lsp.enable('phpactor')
vim.lsp.enable('postgres_lsp')
vim.lsp.enable('prismals')
vim.lsp.enable('psalm')
vim.lsp.enable('pylsp')
vim.lsp.enable('pylyzer')
vim.lsp.enable('pyre')
vim.lsp.enable('pyright')
vim.lsp.enable('quick_lint_js')
vim.lsp.enable('r_language_server')
vim.lsp.enable('rls')
vim.lsp.enable('ruff')
vim.lsp.enable('ruff_lsp')
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('slint_lsp')
vim.lsp.enable('sqlls')
vim.lsp.enable('sqls')
vim.lsp.enable('svelte')
vim.lsp.enable('tailwindcss')
vim.lsp.enable('templ')
vim.lsp.enable('terraform_lsp')
vim.lsp.enable('terraformls')
vim.lsp.enable('tflint')
vim.lsp.enable('ts_ls')
vim.lsp.enable('volar')
vim.lsp.enable('vtsls')
vim.lsp.enable('vuels')
vim.lsp.enable('yamlls')

------------------------------------------------------------------------------------------------------------------------
