local highlights = require("neo-tree.ui.highlights")
require("neo-tree").setup({
  add_blank_line_at_top = false, -- Add a blank line at the top of the tree.
  close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
  popup_border_style = "rounded",
  enable_git_status = true,
  enable_diagnostics = true,
  sort_case_insensitive = false, -- used when sorting files and directories in the tree
  sort_function = nil , -- use a custom function for sorting files and directories in the tree
  -- sort_function = function (a,b)
  --       if a.type == b.type then
  --           return a.path > b.path
  --       else
  --           return a.type > b.type
  --       end
  --   end , -- this sorts files and directories descendantly
  hide_root_node = true,
  retain_hidden_root_indent = true,
  sources = {
    "filesystem",
    "buffers",
    "git_status",
  },
  source_selector = {
    winbar = true, -- toggle to show selector on winbar
    statusline = false, -- toggle to show selector on statusline
    show_scrolled_off_parent_node = false, -- this will replace the tabs with the parent path
                                           -- of the top visible node when scrolled down.
    tab_labels = { -- falls back to source_name if nil
      filesystem = "  Files ",
      buffers =    "  Bufs ",
      git_status = "  Git ",
      diagnostics = " 裂Diagnostics ",
    },
    content_layout = "start", -- only with `tabs_layout` = "equal", "focus"
    --                start  : |/ 裡 bufname     \/...
    --                end    : |/     裡 bufname \/...
    --                center : |/   裡 bufname   \/...
    tabs_layout = "equal", -- start, end, center, equal, focus
    --             start  : |/  a  \/  b  \/  c  \            |
    --             end    : |            /  a  \/  b  \/  c  \|
    --             center : |      /  a  \/  b  \/  c  \      |
    --             equal  : |/    a    \/    b    \/    c    \|
    --             active : |/  focused tab    \/  b  \/  c  \|
    truncation_character = "…", -- character to use when truncating the tab label
    tabs_min_width = nil, -- nil | int: if int padding is added based on `content_layout`
    tabs_max_width = nil, -- this will truncate text even if `text_trunc_to_fit = false`
    padding = 0, -- can be int or table
    -- padding = { left = 2, right = 0 },
    -- separator = "▕", -- can be string or table, see below
     separator = { left = "▏", right= "▕" },
    -- separator = { left = "/", right = "\\", override = nil },     -- |/  a  \/  b  \/  c  \...
    -- separator = { left = "/", right = "\\", override = "right" }, -- |/  a  \  b  \  c  \...
    -- separator = { left = "/", right = "\\", override = "left" },  -- |/  a  /  b  /  c  /...
    -- separator = { left = "/", right = "\\", override = "active" },-- |/  a  / b:active \  c  \...
    -- separator = "|",                                              -- ||  a  |  b  |  c  |...
    separator_active = nil, -- set separators around the active tab. nil falls back to `source_selector.separator`
    show_separator_on_edge = false,
    --                       true  : |/    a    \/    b    \/    c    \|
    --                       false : |     a    \/    b    \/    c     |
    highlight_tab = "NeoTreeTabInactive",
    highlight_tab_active = "NeoTreeTabActive",
    highlight_background = "NeoTreeTabInactive",
    highlight_separator = "NeoTreeTabSeparatorInactive",
    highlight_separator_active = "NeoTreeTabSeparatorActive",
  },
  default_component_configs = {
    container = {
      enable_character_fade = true
    },
    indent = {
      indent_size = 2,
      padding = 0, -- extra padding on left hand side
      -- indent guides
      with_markers = true,
      indent_marker = "│",
      last_indent_marker = "└",
      highlight = "NeoTreeIndentMarker",
      -- expander config, needed for nesting files
      with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
      expander_collapsed = "",
      expander_expanded = "",
      expander_highlight = "NeoTreeExpander",
    },
    icon = {
      folder_closed = "",
      folder_open = "",
      folder_empty = "",
      -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
      -- then these will never be used.
      default = "",
      highlight = "NeoTreeFileIcon"
    },
    icon_mod = {
      folder_closed = "",
      folder_open = "",
      folder_empty = "",
      -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
      -- then these will never be used.
      default = "",
      symlink = "",
      highlight = "NeoTreeFileIcon"
    },
    modified = {
      symbol = "[+]",
      highlight = "NeoTreeModified",
    },
    name = {
      trailing_slash = false,
      use_git_status_colors = true,
      highlight = "NeoTreeFileName",
    },
    git_status = {
      symbols = {
        -- Change type
        added     = "✚", -- or "✚", but this is redundant info if you use git_status_colors on the name
        modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
        deleted   = "✖",-- this can only be used in the git_status source
        renamed   = "",-- this can only be used in the git_status source
        -- Status type
        untracked = "",
        ignored   = "",
        unstaged  = "",
        staged    = "",
        conflict  = "",
      }
    },
  },
  window = {
    auto_expand_width = true,
    position = "left",
    width = "28",
    popup = { -- settings that apply to float position only
      size = {
        height = "80%",
        width = "20%",
      },
      -- position = { col = "100%", row = "2" },
      position = "50%", -- 50% means center it
      -- you can also specify border here, if you want a different setting from
      -- the global popup_border_style.
    },
    mapping_options = {
      noremap = true,
      nowait = true,
    },
    mappings = {
      ["<space>"] = false, -- disable space until we figure out which-key disabling
      ["<2-LeftMouse>"] = {
        "open",
        nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
      },
      ["h"] = function(state)
        local node = state.tree:get_node()
          if node.type == 'directory' and node:is_expanded() then
            require'neo-tree.sources.filesystem'.toggle_directory(state, node)
          else
            require'neo-tree.ui.renderer'.focus_node(state, node:get_parent_id())
          end
        end,
      ["l"] = function(state)
          local node = state.tree:get_node()
          if node.type == 'directory' then
            if not node:is_expanded() then
              require'neo-tree.sources.filesystem'.toggle_directory(state, node)
            elseif node:has_children() then
              require'neo-tree.ui.renderer'.focus_node(state, node:get_child_ids()[1])
            end
          else
            state.commands["open"](state)
          end
        end,
      ["<cr>"] = "open",
      ["o"] = "quit_on_open",
      ["L"] = function(state)
          state.commands["open"](state)
          vim.cmd("Neotree reveal")
        end,
      ["i"] = {
        command = function(state)
          local node = state.tree:get_node()
          if node.is_link then
            print(node.path ..  " ➛ " .. node.link_to)
          else
            print (node.path)
          end
        end,
      },
      ["<esc>"] = "revert_preview",
      -- ["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
      ["P"] = { "toggle_preview", config = { use_float = true } },
      ["v"] = "open_vsplit",
      ["V"] = "open_split",
      -- ["w"] = "open_with_window_picker",
      -- ["s"] = "vsplit_with_window_picker",
      -- ["S"] = "split_with_window_picker",
      ["s"] = false,
      ["S"] = false,
      ["t"] = function(state)
          state.commands["open_tabnew"](state)
          vim.cmd("Neotree show")
          require('bufferline').setup{options={always_show_bufferline=true}}
        end,
      ["T"] = function(state)
          state.commands["open_tab_drop"](state)
          vim.cmd("Neotree show")
          require('bufferline').setup{options={always_show_bufferline=true}}
        end,
      ["f"] = false,
      ["fa"] = function() vim.cmd[[normal 0]] vim.cmd[[/ a]] vim.cmd[[normal n]] end,
      ["fb"] = function() vim.cmd[[normal 0]] vim.cmd[[/ b]] vim.cmd[[normal n]] end,
      ["fc"] = function() vim.cmd[[normal 0]] vim.cmd[[/ c]] vim.cmd[[normal n]] end,
      ["fd"] = function() vim.cmd[[normal 0]] vim.cmd[[/ d]] vim.cmd[[normal n]] end,
      ["fe"] = function() vim.cmd[[normal 0]] vim.cmd[[/ e]] vim.cmd[[normal n]] end,
      ["ff"] = function() vim.cmd[[normal 0]] vim.cmd[[/ f]] vim.cmd[[normal n]] end,
      ["fg"] = function() vim.cmd[[normal 0]] vim.cmd[[/ g]] vim.cmd[[normal n]] end,
      ["fh"] = function() vim.cmd[[normal 0]] vim.cmd[[/ h]] vim.cmd[[normal n]] end,
      ["fi"] = function() vim.cmd[[normal 0]] vim.cmd[[/ i]] vim.cmd[[normal n]] end,
      ["fj"] = function() vim.cmd[[normal 0]] vim.cmd[[/ j]] vim.cmd[[normal n]] end,
      ["fk"] = function() vim.cmd[[normal 0]] vim.cmd[[/ k]] vim.cmd[[normal n]] end,
      ["fl"] = function() vim.cmd[[normal 0]] vim.cmd[[/ l]] vim.cmd[[normal n]] end,
      ["fm"] = function() vim.cmd[[normal 0]] vim.cmd[[/ m]] vim.cmd[[normal n]] end,
      ["fn"] = function() vim.cmd[[normal 0]] vim.cmd[[/ n]] vim.cmd[[normal n]] end,
      ["fo"] = function() vim.cmd[[normal 0]] vim.cmd[[/ o]] vim.cmd[[normal n]] end,
      ["fp"] = function() vim.cmd[[normal 0]] vim.cmd[[/ p]] vim.cmd[[normal n]] end,
      ["fq"] = function() vim.cmd[[normal 0]] vim.cmd[[/ q]] vim.cmd[[normal n]] end,
      ["fr"] = function() vim.cmd[[normal 0]] vim.cmd[[/ r]] vim.cmd[[normal n]] end,
      ["fs"] = function() vim.cmd[[normal 0]] vim.cmd[[/ s]] vim.cmd[[normal n]] end,
      ["ft"] = function() vim.cmd[[normal 0]] vim.cmd[[/ t]] vim.cmd[[normal n]] end,
      ["fu"] = function() vim.cmd[[normal 0]] vim.cmd[[/ u]] vim.cmd[[normal n]] end,
      ["fv"] = function() vim.cmd[[normal 0]] vim.cmd[[/ v]] vim.cmd[[normal n]] end,
      ["fw"] = function() vim.cmd[[normal 0]] vim.cmd[[/ w]] vim.cmd[[normal n]] end,
      ["fx"] = function() vim.cmd[[normal 0]] vim.cmd[[/ x]] vim.cmd[[normal n]] end,
      ["fy"] = function() vim.cmd[[normal 0]] vim.cmd[[/ y]] vim.cmd[[normal n]] end,
      ["fz"] = function() vim.cmd[[normal 0]] vim.cmd[[/ z]] vim.cmd[[normal n]] end,
      ["z"] = "close_all_nodes",
      ["Z"] = "expand_all_nodes",
      ["a"] = {
        "add",
        -- some commands may take optional config options, see `:h neo-tree-mappings` for details
        config = {
          show_path = "none" -- "none", "relative", "absolute"
        }
      },
      ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add".
      ["d"] = "delete",
      ["r"] = "rename",
      ["y"] = "copy_to_clipboard",
      ["x"] = "cut_to_clipboard",
      ["p"] = "paste_from_clipboard",
      ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
      -- ["c"] = {
      --  "copy",
      --  config = {
      --    show_path = "none" -- "none", "relative", "absolute"
      --  }
      --}
      ["C"] = "close_node",
      ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
      ["q"] = "close_window",
      ["R"] = "refresh",
      ["?"] = "show_help",
      ["<"] = "prev_source",
      [">"] = "next_source",
    }
  },
  nesting_rules = {},
  filesystem = {

    components = {
      icon_mod = function(config, node, state)
        local icon = config.default or " "
        local padding = config.padding or " "
        local highlight = config.highlight or highlights.FILE_ICON

        if node.type == "directory" then
          highlight = highlights.DIRECTORY_ICON
          if node.is_link then
            icon = ""
          elseif node:is_expanded() then
            icon = config.folder_open or "-"
          else
            icon = config.folder_closed or "+"
          end
        elseif node.type == "file" then
          local success, web_devicons = pcall(require, "nvim-material-icon")
          if node.link_to then
            icon = ""
            highlight = "Special"
          elseif success then
            local devicon, hl = web_devicons.get_icon(node.name, node.ext)
            icon = devicon or icon
            highlight = hl or highlight
          end
        end

        return {
          text = icon .. padding,
          highlight = highlight,
        }
      end
    },

    renderers = {
      directory = {
        { "indent" },
        { "icon_mod" },
        { "current_filter" },
        {
          "container",
          content = {
            { "name", zindex = 10 },
            -- {
            --   "symlink_target",
            --   zindex = 10,
            --   highlight = "NeoTreeSymbolicLinkTarget",
            -- },
            { "clipboard", zindex = 10 },
            { "diagnostics", errors_only = true, zindex = 20, align = "right", hide_when_expanded = true },
            { "git_status", zindex = 20, align = "right", hide_when_expanded = true },
          },
        },
      },
      file = {
        { "indent" },
        { "icon_mod" },
        {
          "container",
          content = {
            {
              "name",
              zindex = 10
            },
            -- {
            --   "symlink_target",
            --   zindex = 10,
            --   highlight = "NeoTreeSymbolicLinkTarget",
            -- },
            { "clipboard", zindex = 10 },
            { "bufnr", zindex = 10 },
            { "modified", zindex = 20, align = "right" },
            { "diagnostics",  zindex = 20, align = "right" },
            { "git_status", zindex = 20, align = "right" },
          },
        },
      },
    },

    filtered_items = {
      visible = false, -- when true, they will just be displayed differently than normal items
      hide_dotfiles = false,
      hide_gitignored = true,
      hide_hidden = false, -- only works on Windows for hidden files/directories
      hide_by_name = {
        "node_modules",
        ".git"
      },
      hide_by_pattern = { -- uses glob style patterns
        --"*.meta",
        --"*/src/*/tsconfig.json",
      },
      always_show = { -- remains visible even if other settings would normally hide it
        --".gitignored",
      },
      never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
        --".DS_Store",
        --"thumbs.db"
      },
      never_show_by_pattern = { -- uses glob style patterns
        --".null-ls_*",
      },
    },
    find_by_full_path_words = true,
    follow_current_file = true, -- This will find and focus the file in the active buffer every
                                 -- time the current file is changed while the tree is open.
    group_empty_dirs = false, -- when true, empty folders will be grouped together
    hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
                                            -- in whatever position is specified in window.position
                          -- "open_current",  -- netrw disabled, opening a directory opens within the
                                            -- window like netrw would, regardless of window.position
                          -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
    use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
                                    -- instead of relying on nvim autocmd events.
    commands = {
      quit_on_open = function (state)
        local node = state.tree:get_node()
        if require("neo-tree.utils").is_expandable(node) then
          state.commands["toggle_node"](state)
        else
          state.commands['open'](state)
          state.commands["close_window"](state)
          vim.cmd('normal! M')
        end
      end,
    },
    window = {
      mappings = {
        ["<bs>"] = "navigate_up",
        ["."] = "set_root",
        ["H"] = "toggle_hidden",
        ["O"] = "toggle_node",
        ["/"] = "fuzzy_finder",
        ["D"] = "fuzzy_finder_directory",
        ["F"] = "filter_on_submit",
        ["<c-x>"] = "clear_filter",
        ["gk"] = "prev_git_modified",
        ["gj"] = "next_git_modified",
      }
    }
  },
  buffers = {
    follow_current_file = true, -- This will find and focus the file in the active buffer every
                                 -- time the current file is changed while the tree is open.
    group_empty_dirs = true, -- when true, empty folders will be grouped together
    show_unloaded = true,
    window = {
      mappings = {
        ["bd"] = "buffer_delete",
        ["<bs>"] = "navigate_up",
        ["."] = "set_root",
      }
    },
  },
  git_status = {
    window = {
      position = "float",
      mappings = {
        ["A"]  = "git_add_all",
        ["gu"] = "git_unstage_file",
        ["ga"] = "git_add_file",
        ["gr"] = "git_revert_file",
        ["gc"] = "git_commit",
        ["gp"] = "git_push",
        ["gg"] = "git_commit_and_push",
      }
    }
  },
  event_handlers = {
    {
      event = "neo_tree_buffer_enter",
      handler = function()
        vim.cmd[[hi Cursor guibg=red blend=100 | setlocal guicursor=n:Cursor/lCursor]]
        vim.cmd[[hi Search guifg=#5555ff guibg=#111111]]
      end
    },
    {
      event = "neo_tree_buffer_leave",
      handler = function()
        vim.cmd[[setlocal guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20]]
        vim.cmd[[hi Search guifg=#5555ff guibg=#ffff00]]
        vim.cmd[[:let @/ = ""]] -- clear highlight
      end
    },
    {
      event = "neo_tree_window_after_close",
      handler = function()
        vim.cmd[[setlocal guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20]]
        vim.cmd[[hi Search guifg=#5555ff guibg=#ffff00]]
        vim.cmd[[:let @/ = ""]] -- clear highlight
      end
    }
  },
})
