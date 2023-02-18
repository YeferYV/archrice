return {
  settings = {

    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#jsonls
    json = {
      cmd = { "vscode-json-language-server", "--stdio" },
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },

      -- https://github.com/microsoft/vscode-json-languageservice/blob/main/src/jsonLanguageTypes.ts
      -- https://github.com/microsoft/vscode-json-languageservice/blob/main/src/utils/format.ts
      keepLines = { enable = true },
    },
  },
}
