-- return {
--   entry = function()
--	   ya.hide()
--     Command("lazygit"):output()
--   end,
-- }

-- https://github.com/sxyazi/yazi/blob/v0.4.2/yazi-plugin/preset/plugins/fzf.lua
local state = ya.sync(function() return cx.active.current.cwd end)

local function fail(s, ...) ya.notify { title = "Fzf", content = string.format(s, ...), timeout = 5, level = "error" } end

local function entry()
  local _permit = ya.hide()
  local cwd = tostring(state())

  local cmd_unix = [[
    rg "" --color=always \
          --line-number |
      fzf --ansi \
          --delimiter : \
          --preview "bat --color=always {1} --highlight-line {2}" \
          --preview-window "up,60%,+{2}" \
          --bind "enter:become(ya emit reveal {1} && nvim {1} +{2})"
        # --bind "enter:become(echo {1}; echo $PWD/{1} +{2} > $HOME/.yazi-fzf)"
  ]]

  local cmd_powershell = [[
     rg . --color=always `
          --colors "match:none" `
          --line-number |
      fzf --ansi `
          --delimiter : `
          --preview "bat --color=always {1} --highlight-line {2}" `
          --preview-window "up,60%,+{2}" `
          --bind "enter:become(ya emit reveal {1} && nvim {1} +{2})"
  ]]

  local shell_value = ya.target_family() == "windows" and "powershell" or os.getenv("SHELL"):match(".*/(.*)")
  local cmd_args = ya.target_family() == "windows" and cmd_powershell or cmd_unix

  -- https://github.com/sxyazi/yazi/discussions/1715 but `:stdout(Command.PIPED)` is required to `cd`
  local child, err = Command(shell_value)
      :cwd(cwd)
      :args({ "-c", cmd_args })
      :stdin(Command.INHERIT)
      :stdout(Command.INHERIT)
      :stderr(Command.INHERIT)
      :spawn()

  if not child then
    return fail("Failed to start `fzf`, error: " .. err)
  end

  local output, err = child:wait_with_output()
  if not output then
    return fail("Cannot read `fzf` output, error: " .. err)
  elseif not output.status.success and output.status.code ~= 130 then
    return fail("`fzf` exited with error code %s", output.status.code)
  end

  ------------------------------------------------------------------------------------------------------------------------

  -- local target = output.stdout:gsub("\n$", "")
  -- local target2 = target:gsub(" .*", "")
  -- local target3 = target:gsub(".* ", "")
  -- local nvim_cmd = "nvim " .. target
  -- local child, err = Command("nvim"):cwd(cwd):args({ target2, target3 }):stdout(Command.INHERIT):spawn()
  -- local child, err = Command(shell_value)
  --     :cwd(cwd)
  --     :args({ "-c", nvim_cmd })
  --     :stdin(Command.INHERIT)
  --     :stdout(Command.INHERIT)
  --     :stderr(Command.INHERIT)
  --     :spawn()
  -- local output, err = child:wait_with_output()

  ------------------------------------------------------------------------------------------------------------------------

  -- local target = output.stdout:gsub("\n$", "")
  -- if target ~= "" then
  --   ya.manager_emit("reveal", { target })
  --   ya.manager_emit("open", { tostring(state()) })
  --   local state_target = Url(tostring(state())):join(target)
  --   ya.notify { title = "state_target", content = tostring(state_target), timeout = 5 }
  --   ya.manager_emit(
  --     "shell",
  --     {
  --       block = true,
  --       -- "nvim " .. tostring(state_target)
  --       "nvim $(cat $HOME/.yazi-fzf)"
  --     }
  --   )
  -- end

  ------------------------------------------------------------------------------------------------------------------------
end

return { entry = entry }
