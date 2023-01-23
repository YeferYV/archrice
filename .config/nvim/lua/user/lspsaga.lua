require("lspsaga").setup({

  -- Default Options
  preview = {
    lines_above = 0,
    lines_below = 10,
  },
  scroll_preview = {
    scroll_down = '<C-f>',
    scroll_up = '<C-b>',
  },
  request_timeout = 2000,

  -- :Lspsaga lsp_finder
  finder = {
    edit = { 'o', '<CR>' },
    vsplit = 's',
    split = 'i',
    tabe = 't',
    quit = { 'q', '<ESC>' },
  },

  -- :Lspsaga peek_definition
  definition = {
    edit = '<C-c>o',
    vsplit = '<C-c>v',
    split = '<C-c>i',
    tabe = '<C-c>t',
    quit = 'q',
    close = '<Esc>',
  },

  -- :Lspsaga code_action
  code_action = {
    num_shortcut = true,
    keys = {
      -- string |table type
      quit = 'q',
      exec = '<CR>',
    },
  },

  -- Lightbulb
  lightbulb = {
    enable = true,
    enable_in_insert = true,
    sign = true,
    sign_priority = 40,
    virtual_text = true,
  },

  -- :Lspsaga diagnostic_jump_next
  diagnostic = {
    show_code_action = true,
    show_source = true,
    jump_num_shortcut = true,
    keys = {
      exec_action = 'o',
      quit = 'q',
      go_action = 'g'
    },
  },

  -- :Lspsaga rename
  rename = {
    quit = '<C-c>',
    exec = '<CR>',
    mark = 'x',
    confirm = '<CR>',
    in_select = true,
  },

  -- :Lspsaga outline
  outline = {
    win_position = 'right',
    win_with = '',
    win_width = 30,
    show_detail = true,
    auto_preview = true,
    auto_refresh = true,
    auto_close = true,
    custom_sort = nil,
    keys = {
      jump = 'o',
      expand_collapse = 'u',
      quit = 'q',
    },
  },

  -- :Lspsaga incoming_calls
  callhierarchy = {
    show_detail = false,
    keys = {
      edit = 'e',
      vsplit = 's',
      split = 'i',
      tabe = 't',
      jump = 'o',
      quit = 'q',
      expand_collapse = 'u',
    },
  },

  -- Winbar
  symbol_in_winbar = {
    enable = true,
    separator = ' ',
    hide_keyword = true,
    show_file = true,
    folder_level = 1,
    respect_root = false,
    color_mode = true,
  },

  -- UI
  ui = {
    -- currently only round theme
    theme = 'round',
    -- this option only work in neovim 0.9
    title = true,
    -- border type can be single,double,rounded,solid,shadow.
    border = 'rounded',
    winblend = 0,
    expand = '',
    collapse = '',
    preview = ' ',
    code_action = '💡',
    diagnostic = '🐞',
    incoming = ' ',
    outgoing = ' ',
    colors = {
      --float window normal background color
      normal_bg = 'none',
      --title background color
      title_bg = '#afd700',
      red = '#e95678',
      magenta = '#b33076',
      orange = '#FF8700',
      yellow = '#f7bb3b',
      green = '#afd700',
      cyan = '#36d0e0',
      blue = '#61afef',
      purple = '#CBA6F7',
      white = '#d1d4cf',
      black = '#1c1c19',
    },
    kind = {
      File          = { ' ', '#495466' },
      Module        = { ' ', '#495466' },
      Namespace     = { ' ', '#495466' },
      Package       = { ' ', '#495466' },
      Class         = { ' ', '#495466' },
      Method        = { ' ', '#495466' },
      Property      = { ' ', '#495466' },
      Field         = { ' ', '#495466' },
      Constructor   = { ' ', '#495466' },
      Enum          = { '了', '#495466' },
      Interface     = { ' ', '#495466' },
      Function      = { ' ', '#495466' },
      Variable      = { ' ', '#495466' },
      Constant      = { ' ', '#495466' },
      String        = { ' ', '#495466' },
      Number        = { ' ', '#495466' },
      Boolean       = { ' ', '#495466' },
      Array         = { ' ', '#495466' },
      Object        = { ' ', '#495466' },
      Key           = { ' ', '#495466' },
      Null          = { ' ', '#495466' },
      EnumMember    = { ' ', '#495466' },
      Struct        = { ' ', '#495466' },
      Event         = { ' ', '#495466' },
      Operator      = { ' ', '#495466' },
      TypeParameter = { ' ', '#495466' },
      TypeAlias     = { ' ', '#495466' },
      Parameter     = { ' ', '#495466' },
      StaticMethod  = { 'ﴂ ', '#495466' },
      Macro         = { ' ', '#495466' },
    },
  },

})
