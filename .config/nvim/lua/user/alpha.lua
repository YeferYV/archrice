local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local dashboard = require "alpha.themes.dashboard"
dashboard.section.header.val = {
  [[ﾎﾌ ｯ     ｦ  ｩ  ~ｷ  ":   ﾝ   ｫ   ｷ]],
  [[ｩﾘ ,     ﾒ  `  ﾝｷ  ｧﾒ   ﾙ   ﾚ   |]],
  [[<ﾓ ｯ     The Matrixｬｯ   ﾀ   ﾐ   3]],
  [[ﾁｬ }   ｮ    ､  6ｴ  ﾘ､   4   ﾄ   ｧ]],
  [[7ﾖ 7        ﾎ  ｶﾊ  1ｲ   ﾀ   °   <]],
  [[ ]],
}
dashboard.section.buttons.val = {
  dashboard.button("p", " " .. " Find Project", ":Telescope projects initial_mode=normal<cr>"),
  dashboard.button("f", " " .. " Find File", ":Telescope find_files initial_mode=normal<cr>"),
  dashboard.button("o", " " .. " Recents", ":Telescope oldfiles initial_mode=normal<cr>"),
  dashboard.button("w", " " .. " Find Word", ":Telescope live_grep  initial_mode=normal<cr>"),
  dashboard.button("n", " " .. " New File", ":enew<cr>"),
  dashboard.button("m", " " .. " Bookmarks", ":Telescope marks initial_mode=normal<cr>"),
  dashboard.button("b", " " .. " File Browser", ":Telescope file_browser initial_mode=normal<cr>"),
  dashboard.button("l", " " .. " Explorer", ":lua _LF_TAB_TOGGLE()<cr>"),
  dashboard.button("s", " " .. " Last Session", ":SessionManager load_last_session<cr>"),
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
