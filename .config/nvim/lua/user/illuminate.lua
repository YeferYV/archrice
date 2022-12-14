vim.keymap.set({'n', 'x', 'o'}, '<a-n>', '<cmd>lua require"illuminate".goto_next_reference(wrap)<cr>')
vim.keymap.set({'n', 'x', 'o'}, '<a-p>', '<cmd>lua require"illuminate".goto_prev_reference(wrap)<cr>')
vim.keymap.set({'n', 'x', 'o'}, '<a-i>', '<cmd>lua require"illuminate".textobj_select()<cr>')

require('illuminate').configure({
    -- providers: provider used to get references in the buffer, ordered by priority
    providers = {
      'lsp',
      'treesitter',
      'regex',
    },
    -- delay: delay in milliseconds
    delay = 100,
    -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
    filetypes_denylist = {
      'NvimTree',
    },
    -- min_count_to_highlight: minimum number of matches required to perform highlighting
    min_count_to_highlight = 1,
})
