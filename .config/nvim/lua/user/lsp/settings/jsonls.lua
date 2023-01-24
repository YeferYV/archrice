return {
  settings = {
    json = {
      cmd = { "vscode-json-language-server", "--stdio" },
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
      keepLines = { enable = true },
    },
  },
}
