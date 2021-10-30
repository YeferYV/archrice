-- require'lspconfig'.eslint.setup{}
require'lspconfig'.eslint.setup{

  -- Commands:
  -- - EslintFixAll: Fix all eslint problems for this buffer
  -- Default Values:
    cmd = { "vscode-eslint-language-server", "--stdio" };
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue" };
    on_new_config = function(config, new_root_dir)
          -- The "workspaceFolder" is a VSCode concept. It limits how far the
          -- server will traverse the file system when locating the ESLint config
          -- file (e.g., .eslintrc).
          config.settings.workspaceFolder = {
            uri = new_root_dir,
            name = vim.fn.fnamemodify(new_root_dir, ':t'),
          }
        end,
    -- root_dir = function(startpath)
    --     return M.search_ancestors(startpath, matcher)
    --   end,
    root_dir = function()
      return vim.fn.getcwd()
    end,
    settings = {
      codeAction = {
        disableRuleComment = {
          enable = true,
          location = "separateLine"
        },
        showDocumentation = {
          enable = true
        }
      },
      codeActionOnSave = {
        enable = false,
        mode = "all"
      },
      format = true,
      nodePath = "",
      onIgnoredFiles = "off",
      packageManager = "npm",
      quiet = false,
      rulesCustomizations = {},
      run = "onType",
      useESLintClass = false,
      validate = "on",
      workingDirectory = {
        mode = "auto"
      }
    }
}
