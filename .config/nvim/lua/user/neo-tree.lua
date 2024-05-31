local status_ok, neotree = pcall(require, "neo-tree")
if not status_ok then
  return
end

-- local highlights = require("neo-tree.ui.highlights")

local number_of_lines = function(state)
  local node = state.tree:get_node()
  local wc = vim.print(vim.api.nvim_exec2(string.format("!cat '%s' | wc -l", node.path), { output = true }))
  local wc_digit = wc.output:match("(%d+)")
  vim.notify(" " .. wc_digit)
end


neotree.setup({
  add_blank_line_at_top = false, -- Add a blank line at the top of the tree.
  close_if_last_window = true,   -- Close Neo-tree if it is the last window left in the tab
  hide_root_node = true,
  source_selector = {
    winbar = true,
    sources = {
      { source = "filesystem", display_name = " 󰉓 File " },
      { source = "buffers", display_name = " 󰈚 Bufs " },
      { source = "git_status", display_name = " 󰊢 Git " },
    },
  },
  default_component_configs = {
    indent = {
      with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
    },
  },
  window = {
    auto_expand_width = true,
    width = "28",
    popup = { -- settings that apply to float position only
      size = { height = "80%", width = "30", },
      position = { col = "10%", row = "4" },
    },
    mappings = {
      ["<space>"] = false, -- disable space until we figure out which-key disabling
      -- ["<2-LeftMouse>"] = {
      --   "open",
      --   nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
      -- },
      -- ["<cr>"] = "open",
      ["<esc>"] = "revert_preview",
      ["0"] = "focus_preview",
      -- ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
      ["s"] = false,
      ["S"] = false,
      -- ["s"] = "vsplit_with_window_picker",
      -- ["S"] = "split_with_window_picker",
      -- ["t"] = "open_tabnew",
      -- ["T"] = "open_tab_drop",
      ["v"] = function(state)
        state.commands["open_vsplit"](state)
        vim.cmd("Neotree close")
      end,
      ["V"] = function(state)
        state.commands["open_split"](state)
        vim.cmd("Neotree close")
      end,
      -- ["w"] = "open_with_window_picker",
      ["f"] = false,
      ["fa"] = function()
        vim.cmd [[normal 0]]
        vim.cmd [[/ a]]
        vim.cmd [[normal n]]
      end,
      ["fb"] = function()
        vim.cmd [[normal 0]]
        vim.cmd [[/ b]]
        vim.cmd [[normal n]]
      end,
      ["fc"] = function()
        vim.cmd [[normal 0]]
        vim.cmd [[/ c]]
        vim.cmd [[normal n]]
      end,
      ["fd"] = function()
        vim.cmd [[normal 0]]
        vim.cmd [[/ d]]
        vim.cmd [[normal n]]
      end,
      ["fe"] = function()
        vim.cmd [[normal 0]]
        vim.cmd [[/ e]]
        vim.cmd [[normal n]]
      end,
      ["ff"] = function()
        vim.cmd [[normal 0]]
        vim.cmd [[/ f]]
        vim.cmd [[normal n]]
      end,
      ["fg"] = function()
        vim.cmd [[normal 0]]
        vim.cmd [[/ g]]
        vim.cmd [[normal n]]
      end,
      ["fh"] = function()
        vim.cmd [[normal 0]]
        vim.cmd [[/ h]]
        vim.cmd [[normal n]]
      end,
      ["fi"] = function()
        vim.cmd [[normal 0]]
        vim.cmd [[/ i]]
        vim.cmd [[normal n]]
      end,
      ["fj"] = function()
        vim.cmd [[normal 0]]
        vim.cmd [[/ j]]
        vim.cmd [[normal n]]
      end,
      ["fk"] = function()
        vim.cmd [[normal 0]]
        vim.cmd [[/ k]]
        vim.cmd [[normal n]]
      end,
      ["fl"] = function()
        vim.cmd [[normal 0]]
        vim.cmd [[/ l]]
        vim.cmd [[normal n]]
      end,
      ["fm"] = function()
        vim.cmd [[normal 0]]
        vim.cmd [[/ m]]
        vim.cmd [[normal n]]
      end,
      ["fn"] = function()
        vim.cmd [[normal 0]]
        vim.cmd [[/ n]]
        vim.cmd [[normal n]]
      end,
      ["fo"] = function()
        vim.cmd [[normal 0]]
        vim.cmd [[/ o]]
        vim.cmd [[normal n]]
      end,
      ["fp"] = function()
        vim.cmd [[normal 0]]
        vim.cmd [[/ p]]
        vim.cmd [[normal n]]
      end,
      ["fq"] = function()
        vim.cmd [[normal 0]]
        vim.cmd [[/ q]]
        vim.cmd [[normal n]]
      end,
      ["fr"] = function()
        vim.cmd [[normal 0]]
        vim.cmd [[/ r]]
        vim.cmd [[normal n]]
      end,
      ["fs"] = function()
        vim.cmd [[normal 0]]
        vim.cmd [[/ s]]
        vim.cmd [[normal n]]
      end,
      ["ft"] = function()
        vim.cmd [[normal 0]]
        vim.cmd [[/ t]]
        vim.cmd [[normal n]]
      end,
      ["fu"] = function()
        vim.cmd [[normal 0]]
        vim.cmd [[/ u]]
        vim.cmd [[normal n]]
      end,
      ["fv"] = function()
        vim.cmd [[normal 0]]
        vim.cmd [[/ v]]
        vim.cmd [[normal n]]
      end,
      ["fw"] = function()
        vim.cmd [[normal 0]]
        vim.cmd [[/ w]]
        vim.cmd [[normal n]]
      end,
      ["fx"] = function()
        vim.cmd [[normal 0]]
        vim.cmd [[/ x]]
        vim.cmd [[normal n]]
      end,
      ["fy"] = function()
        vim.cmd [[normal 0]]
        vim.cmd [[/ y]]
        vim.cmd [[normal n]]
      end,
      ["fz"] = function()
        vim.cmd [[normal 0]]
        vim.cmd [[/ z]]
        vim.cmd [[normal n]]
      end,
      ["f/"] = function()
        vim.cmd [[normal 0]]
        vim.cmd [[/\v( | )]]
        vim.cmd [[normal n]]
      end,

      -- ["a"] = {
      --   "add",
      --   -- some commands may take optional config options, see `:h neo-tree-mappings` for details
      --   config = {
      --     show_path = "none" -- "none", "relative", "absolute"
      --   }
      -- },
      -- ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add".
      -- ["c"] = "copy",          -- takes text input for destination, also accepts the optional config.show_path option like "add":
      -- ["C"] = {
      --  "copy",
      --  config = {
      --    show_path = "none" -- "none", "relative", "absolute"
      --  }
      --}
      -- ["d"] = "delete",
      ["I"] = "show_file_details",
      -- ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
      -- ["p"] = "paste_from_clipboard",
      -- ["q"] = "close_window",
      -- ["r"] = "rename",
      -- ["R"] = "refresh",
      -- ["x"] = "cut_to_clipboard",
      -- ["y"] = "copy_to_clipboard",
      ["zc"] = "close_node",
      ["zC"] = "close_all_nodes",
      ["zO"] = "expand_all_nodes",
      -- ["?"] = "show_help",
      -- ["<"] = "prev_source",
      -- [">"] = "next_source",
    }
  },

  filesystem = {

    -- https://github.com/nvim-neo-tree/neo-tree.nvim/wiki/Recipes#custom-icons
    -- https://github.com/nvim-neo-tree/neo-tree.nvim/issues/823
    -- https://github.com/nvim-neo-tree/neo-tree.nvim/pull/1527
    components = {
      icon = function(config, node, state)
        -- local highlight = config.highlight or highlights.FILE_ICON -- or highlights.DIRECTORY_ICON
        -- local icon = config.default or " "
        local padding = config.padding or " "
        local success, web_devicons = pcall(require, "mini.icons")
        local devicon, hl

        if node.type == "directory" then
          devicon, hl = web_devicons.get("directory", node.name)
          if node.is_link then
            devicon = ""
          end
        elseif node.type == "file" then
          devicon, hl = web_devicons.get("file", node.name)
          if node.link_to then
            devicon = ""
          end
        end

        return {
          text = devicon .. padding,
          highlight = hl,
        }
      end
    },

    filtered_items = {
      hide_dotfiles = false,
      hide_hidden = false, -- only works on Windows for hidden files/directories
      hide_by_name = {
        "node_modules",
        ".git"
      },
    },

    find_by_full_path_words = true,

    follow_current_file = {
      enabled = true,         -- This will find and focus the file in the active buffer
      leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
    },

    commands = {

      getparent_closenode = function(state)
        local node = state.tree:get_node()
        if node.type == 'directory' and node:is_expanded() then
          state.commands.toggle_node(state)
        else
          require 'neo-tree.ui.renderer'.focus_node(state, node:get_parent_id())
        end
      end,

      getchild_open = function(state)
        local node = state.tree:get_node()
        if node.type == 'directory' then
          if not node:is_expanded() then
            state.commands.toggle_node(state)
          elseif node:has_children() then
            require 'neo-tree.ui.renderer'.focus_node(state, node:get_child_ids()[1])
          end
        else
          state.commands["open"](state)
        end
      end,

      open_unfocus = function(state)
        state.commands["open"](state)
        vim.cmd("Neotree reveal")
      end,

      print_path = function(state)
        local node = state.tree:get_node()
        if node.is_link then
          vim.notify("\n" .. node.path .. " ➛ " .. node.link_to)
        else
          vim.notify("\n" .. node.path)
        end
        number_of_lines(state)
      end,

      nav_down = function(state)
        vim.cmd [[normal! j]]
        number_of_lines(state)
      end,

      nav_up = function(state)
        vim.cmd [[normal! k]]
        number_of_lines(state)
      end,

      quit_on_open = function(state)
        local node = state.tree:get_node()
        if node.type == 'directory' then
          if not node:is_expanded() then
            require 'neo-tree.sources.filesystem'.toggle_directory(state, node)
          elseif node:has_children() then
            require 'neo-tree.ui.renderer'.focus_node(state, node:get_child_ids()[1])
          end
        else
          state.commands['open'](state)
          state.commands["close_window"](state)
          vim.cmd('normal! M')
        end
      end,

      system_open = function(state)
        local node = state.tree:get_node()
        local path = node:get_id()
        vim.api.nvim_command(string.format("silent !xdg-open '%s'", path))
      end,

      open_image_with_sixel = function(state)
        local node = state.tree:get_node()
        local path = node:get_id()
        vim.cmd [[wincmd l]]
        vim.api.nvim_command(
          string.format(
          -- "term img2sixel --width=800 '%s' > $PTS && printf 'press any key to clear the image and <esc><esc><space>x to close window' && read -k1 && killall -s SIGWINCH nvim",
            "term img2sixel --width=800 '%s' > $PTS && read -k1 && killall -s SIGWINCH nvim",
            path
          )
        );
        vim.cmd [[set filetype=terminal]]
      end,

      open_image_with_wezterm = function(state)
        local node = state.tree:get_node()
        local path = node:get_id()
        vim.api.nvim_command(
          string.format(
            "silent !wezterm cli split-pane --horizontal -- bash -c 'wezterm imgcat '%s' && read -n1'",
            path
          )
        )
      end,

    },

    window = {
      mappings = {

        -- ["<bs>"] = "navigate_up",
        -- ["."] = "set_root",
        ["h"] = "getparent_closenode",
        -- ["H"] = "toggle_hidden",
        ["l"] = "getchild_open",
        ["L"] = "quit_on_open",
        ["i"] = "print_path",
        ["<down>"] = "nav_down",
        ["<up>"] = "nav_up",
        ["o"] = "open_unfocus",
        ["O"] = "system_open",
        ["w"] = "open_image_with_wezterm",
        ["|"] = "open_image_with_sixel",
        -- ["/"] = "fuzzy_finder",
        -- ["D"] = "fuzzy_finder_directory",
        -- ["D"] = "fuzzy_sorter_directory",
        -- ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
        ["F"] = "filter_on_submit",
        -- ["<c-x>"] = "clear_filter",
        ["gk"] = "prev_git_modified",
        ["gj"] = "next_git_modified",
        -- ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
        -- ["oc"] = { "order_by_created", nowait = false },
        -- ["od"] = { "order_by_diagnostics", nowait = false },
        -- ["og"] = { "order_by_git_status", nowait = false },
        -- ["om"] = { "order_by_modified", nowait = false },
        -- ["on"] = { "order_by_name", nowait = false },
        -- ["os"] = { "order_by_size", nowait = false },
        -- ["ot"] = { "order_by_type", nowait = false },

      }
    }
  },

  buffers = {
    follow_current_file = {
      enabled = true,         -- TODO: Not working with `:Neotree buffers` or switching with `>` key, only works with `:Neotree buffers reveal`
      leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
    },
  },

  event_handlers = {
    {
      event = "neo_tree_buffer_enter",
      handler = function()
        if _G.neotree_blend == true then
          vim.cmd [[hi Cursor guifg=#5555ff blend=100 | setlocal guicursor=n:Cursor/lCursor]]
        end
        vim.cmd [[hi Search guifg=#5555ff guibg=#111111]]
      end
    },
    {
      event = "neo_tree_buffer_leave",
      handler = function()
        vim.cmd [[setlocal guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20]]
        vim.cmd [[hi Search guifg=#5555ff guibg=#ffff00]]
        vim.cmd [[:let @/ = ""]] -- clear highlight
      end
    },
    {
      event = "neo_tree_window_after_close",
      handler = function()
        vim.cmd [[setlocal guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20]]
        vim.cmd [[hi Search guifg=#5555ff guibg=#ffff00]]
        vim.cmd [[:let @/ = ""]] -- clear highlight
      end
    }
  },
})
