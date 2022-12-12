local navic = require("nvim-navic")
navic.setup {
  icons = {
    File          = " ",
    Module        = " ",
    Namespace     = " ",
    Package       = " ",
    Class         = " ",
    Method        = " ",
    Property      = " ",
    Field         = " ",
    Constructor   = " ",
    Enum          = "練",
    Interface     = "練",
    Function      = " ",
    Variable      = " ",
    Constant      = " ",
    String        = " ",
    Number        = " ",
    Boolean       = "◩ ",
    Array         = " ",
    Object        = " ",
    Key           = " ",
    Null          = "ﳠ ",
    EnumMember    = " ",
    Struct        = " ",
    Event         = " ",
    Operator      = " ",
    TypeParameter = " ",
  },
  -- -- Vscode Icons
  -- icons = {
  --   File = ' ',
  --   Module = ' ',
  --   Namespace = ' ',
  --   Package = ' ',
  --   Class = ' ',
  --   Method = ' ',
  --   Property = ' ',
  --   Field = ' ',
  --   Constructor = ' ',
  --   Enum = ' ',
  --   Interface = ' ',
  --   Function = ' ',
  --   Variable = ' ',
  --   Constant = ' ',
  --   String = ' ',
  --   Number = ' ',
  --   Boolean = ' ',
  --   Array = ' ',
  --   Object = ' ',
  --   Key = ' ',
  --   Null = ' ',
  --   EnumMember = ' ',
  --   Struct = ' ',
  --   Event = ' ',
  --   Operator = ' ',
  --   TypeParameter = ' '
  -- },
  highlight = true,
  separator = " > ",
  depth_limit = 0,
  depth_limit_indicator = "..",
  safe_output = true
}
vim.o.winbar = " %{%v:lua.require'nvim-navic'.get_location()%}"
