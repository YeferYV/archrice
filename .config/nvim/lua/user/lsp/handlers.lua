local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
  return
end

-- add snippets capability to nvim-cmp
M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)
-- M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities)

M.setup = function()
  vim.diagnostic.config({
    update_in_insert = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      -- source = "always",
      -- header = "",
      -- prefix = "",
    },
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.WARN] = "",
        [vim.diagnostic.severity.HINT] = "",
        [vim.diagnostic.severity.INFO] = "",
      },
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
end

--> REPLACED BY MINI.CURSORWORD <--
-- replaced by vim-illuminate since lsp_highlight_document is triggered on every CursorMoved making it slow
-- local function lsp_highlight_document(client)
--   -- Set highlighting references on server_capabilities
--   if client.server_capabilities.document_highlight then
--     vim.api.nvim_exec(
--       [[
--       augroup lsp_document_highlight
--         autocmd! * <buffer>
--         autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
--         autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
--       augroup END
--     ]],
--       false
--     )
--   end
-- end

local function lsp_keymaps(bufnr)
  -- -- local opts = { noremap = true, silent = true }
  -- -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gnd", '<cmd>lua vim.diagnostic.goto_next({border="rounded"})<CR>', opts)
  -- -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gpd", '<cmd>lua vim.diagnostic.goto_prev({border="rounded"})<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gA", "<cmd>lua vim.lsp.buf.code_action()<CR>",
  --   { desc = "Code Action", noremap = true, silent = true })
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>",
  --   { desc = "Goto Definition", noremap = true, silent = true })
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>",
  --   { desc = "Goto Declaration", noremap = true, silent = true })
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gF", "<cmd>lua vim.lsp.buf.format { async = true }<CR>",
  --   { desc = "Format", noremap = true, silent = true })
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gh", "<cmd>lua vim.lsp.buf.signature_help()<CR>",
  --   { desc = "Signature", noremap = true, silent = true })
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gH", "<cmd>lua vim.lsp.buf.hover()<CR>",
  --   { desc = "Hover", noremap = true, silent = true })
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>",
  --   { desc = "Goto Implementation", noremap = true, silent = true })
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gL", '<cmd>lua vim.lsp.codelens.run()<CR>',
  --   { desc = "Codelens", noremap = true, silent = true })
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "go", "<cmd>lua vim.diagnostic.open_float()<CR>",
  --   { desc = "Open Diagnotic", noremap = true, silent = true })
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gq", "<cmd>lua vim.diagnostic.setloclist()<CR>",
  --   { desc = "Diagnotic List", noremap = true, silent = true })
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>",
  --   { desc = "References", noremap = true, silent = true })
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gR", "<cmd>lua vim.lsp.buf.rename()<CR>",
  --   { desc = "Rename", noremap = true, silent = true })
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>",
  --   { desc = "Goto TypeDefinition", noremap = true, silent = true })
  -- vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format { async = false }' ]])
end

M.on_attach = function(client, bufnr)
  -- if client.name == "tsserver" then
  --   client.server_capabilities.documentFormattingProvider = false
  -- end

  -- lsp_highlight_document(client)
  lsp_keymaps(bufnr)
end

return M
