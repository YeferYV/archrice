local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local dashboard = require "alpha.themes.dashboard"
dashboard.section.header.val = {
  [[ ]],
  [[ﾎﾌ ｯ     ｦ  ｩ  ~ｷ  ":   ﾝ   ｫ   ｷ]],
  [[ｩﾘ ,     ﾒ  `  ﾝｷ  ｧﾒ   ﾙ   ﾚ   |]],
  [[<ﾓ ｯ     The Matrixｬｯ   ﾀ   ﾐ   3]],
  [[ﾁｬ }   ｮ    ､  6ｴ  ﾘ､   4   ﾄ   ｧ]],
  [[7ﾖ 7        ﾎ  ｶﾊ  1ｲ   ﾀ   °   <]],
  [[ ]],
}
dashboard.section.buttons.val = {
  dashboard.button("p", " " .. " Find Project", ":Telescope projects     initial_mode=normal<cr>"),
  dashboard.button("f", " " .. " Find File   ", ":Telescope find_files   initial_mode=normal<cr>"),
  dashboard.button("o", "󰈙 " .. " Recents     ", ":Telescope oldfiles     initial_mode=normal<cr>"),
  dashboard.button("w", "󰈭 " .. " Find Word   ", ":Telescope live_grep    initial_mode=normal<cr>"),
  dashboard.button("n", " " .. " New File    ", ":enew<cr>"),
  dashboard.button("r", " " .. " Bookmarks   ", ":Telescope marks        initial_mode=normal<cr>"),
  dashboard.button("m", " " .. " Mini Files",
    ":lua require('mini.files').open(vim.api.nvim_buf_get_name(0), true) <cr>"),
  dashboard.button("q", "󰙅 " .. " Neotree",
    ":lua _G.neotree_blend = true; vim.cmd [[ Neotree filesystem reveal float ]] <cr>"),
  dashboard.button("r", "󰉖 " .. " File Browser",
    ":Telescope file_browser initial_mode=normal<cr>"),
  dashboard.button("l", " " .. " LF File Manager",
    ":lua _LF_TOGGLE(vim.api.nvim_buf_get_name(0), 'tabreplace', 'lf -selection-path') <cr>"),
  dashboard.button("y", " " .. " Yazi File Manager",
    ":lua _LF_TOGGLE(vim.api.nvim_buf_get_name(0), 'tabreplace', 'yazi --chooser-file') <cr>"),
  dashboard.button("t", " " .. " Terminal",
    ":lua vim.cmd [[ tabedit | terminal ]] vim.cmd [[ tabclose # ]] vim.cmd [[ set ft=tab-terminal nonumber laststatus=0 ]] <cr>"),
  dashboard.button("T", " " .. " Tmux        ",
    "<cmd>lua vim.cmd[[ tabnew | terminal tmux ]] vim.cmd[[ tabclose # ]] vim.cmd[[ set ft=tab-terminal nonumber laststatus=0 ]]<cr>"),
  dashboard.button("s", " " .. " Last Session",
    "<cmd>lua require('mini.sessions').read(require('mini.sessions').get_latest(), { verbose = false })<cr>"),
}
local function footer()
  return ""
end

dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)
