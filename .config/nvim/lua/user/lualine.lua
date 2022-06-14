local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local colors = {
  -- bg       = '#202328',
  bg       = '#000000',
  fg       = '#bbc2cf',
  yellow   = '#ECBE7B',
  cyan     = '#008080',
  darkblue = '#081633',
  green    = '#98be65',
  orange   = '#FF8800',
  violet   = '#a9a1e1',
  magenta  = '#c678dd',
  blue     = '#51afef',
  red      = '#ec5f67',
}

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
  sections = { 'error', 'warn', 'info', 'hint' },
	symbols = { error = " ", warn = " " },
	colored = false,
	update_in_insert = false,
	always_visible = true,
}

local diff = {
	"diff",
	colored = false,
	symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  cond = hide_in_width
}

local branch = {
	"branch",
	icons_enabled = true,
	icon = "",
}

local location = {
	"location",
	padding = 0,
}

-- cool function for progress
local progress = {
  color = { bg = '#000000', gui = 'bold' },
  'progress'
  -- function()
  --   local current_line = vim.fn.line(".")
  --   local total_lines = vim.fn.line("$")
  --   local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
  --   local line_ratio = current_line / total_lines
  --   local index = math.ceil(line_ratio * #chars)
  --   return chars[index]
  -- end,
}

local treesitterIcon = {
  color = { fg = '#224422', gui = 'bold' },
  function()--
    if next(vim.treesitter.highlighter.active) ~= nil then
      return " "
    end
    return ""
  end,
}

local lspServer = {
  -- Lsp server name .
  function()
    local msg = 'No Active Lsp'
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end,
  icon = ' ',
  color = { fg = '#ffffff', gui = 'bold' },
}

local spaces = function()
	return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

lualine.setup({
	options = {
		icons_enabled = true,
		-- theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
		always_divide_middle = true,
	},
  theme = {
    -- We are going to use lualine_c an lualine_x as left and
    -- right section. Both are highlighted by c theme .  So we
    -- are just setting default looks o statusline
    -- normal = { c = { fg = colors.fg, bg = colors.bg } },
    -- inactive = { c = { fg = colors.fg, bg = colors.bg } },
    normal = {
      a = { fg = colors.fg, bg = colors.blue, gui = "bold" },
      b = { fg = colors.fg, bg = colors.bg },
      c = { fg = colors.fg, bg = colors.bg },
    },
    inactive = {
      a = { fg = colors.gray1, bg = colors.bg, gui = "bold" },
      b = { fg = colors.gray1, bg = colors.bg },
      c = { fg = colors.gray1, bg = colors.bg },
    },
  },

	sections = {
		lualine_a = { branch },
		lualine_b = {},
		lualine_c = {},
		-- lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_x = { 'diagnostics',treesitterIcon, lspServer,  'filetype' , diff, spaces, "encoding"},
		lualine_y = { location },
		lualine_z = { progress } ,
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
