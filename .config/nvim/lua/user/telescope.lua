local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

require('telescope').load_extension('fzf')
local actions = require "telescope.actions"

telescope.setup {
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },
    file_ignore_patterns = {
      "node_modules", ".git",
    },
    -- vimgrep_arguments = {
    --   "rg",
    --   "--color=never",
    --   "--no-heading",
    --   "--with-filename",
    --   "--line-number",
    --   "--column",
    --   "--smart-case",
    --   "--hidden",
    --   "--glob=!.git/",
    -- },
    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,

        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,

        ["<C-c>"] = actions.close,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,

        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<C-y>"] = require("telescope.actions.layout").cycle_layout_next,
        ["<C-?>"] = require("telescope.actions.layout").toggle_preview,
        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-l>"] = actions.complete_tag,
        ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
      },

      n = {
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["H"] = actions.move_to_top,
        ["M"] = actions.move_to_middle,
        ["L"] = actions.move_to_bottom,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,

        ["<C-y>"] = require("telescope.actions.layout").cycle_layout_next,
        ["<C-?>"] = require("telescope.actions.layout").toggle_preview,
        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["?"] = actions.which_key,
      },
    },
  },
  pickers = {
    find_files = {
      mappings = {
        n = {
          ["h"] = function(prompt_bufnr)
            local finders = require "telescope.finders"
            local make_entry = require "telescope.make_entry"
            local action_state = require "telescope.actions.state"
            local current_picker = action_state.get_current_picker(prompt_bufnr)

            local opts = {
              entry_maker = make_entry.gen_from_file(opts),
              default_text = current_picker:_get_prompt()
            }

            local cmd = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" }
            current_picker:refresh(finders.new_oneshot_job(cmd, opts), {})
          end,
          ["l"] = function(prompt_bufnr)
            local finders = require "telescope.finders"
            local make_entry = require "telescope.make_entry"
            local action_state = require "telescope.actions.state"
            local current_picker = action_state.get_current_picker(prompt_bufnr)

            local opts = {
              entry_maker = make_entry.gen_from_file(opts),
              default_text = current_picker:_get_prompt()
            }

            local cmd = { "rg", "--files"}
            current_picker:refresh(finders.new_oneshot_job(cmd, opts), {})
          end,
        },
      },
    },
    live_grep = {
      mappings = {
        i = { ["<c-f>"] = actions.to_fuzzy_refine },
        n = {
          ["h"] = function(prompt_bufnr)
            local current_picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
            local opts = {
              default_text = current_picker:_get_prompt(),
              additional_args = function()
                return {"--hidden"}
              end
            }
            require('telescope.builtin').live_grep(require('telescope.themes').get_ivy(opts))
          end,
          ["l"] = function(prompt_bufnr)
            local current_picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
            local opts = {
              default_text = current_picker:_get_prompt(),
            }
            require('telescope.builtin').live_grep(require('telescope.themes').get_ivy(opts))
          end,
        },
      },
    },
    grep_string = {
      mappings = {
        i = { ["<c-f>"] = actions.to_fuzzy_refine },
        n = {
          ["h"] = function(prompt_bufnr)
            local current_picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
            local opts = {
              default_text = current_picker:_get_prompt(),
              vimgrep_arguments = { 'rg', '--hidden', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case', "--glob", "!**/.git/*" },
            }
            require('telescope.builtin').grep_string(require('telescope.themes').get_ivy(opts))
          end,
          ["l"] = function(prompt_bufnr)
            local current_picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
            local opts = {
              default_text = current_picker:_get_prompt(),
              vimgrep_arguments = { 'rg', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case' },
            }
            require('telescope.builtin').grep_string(require('telescope.themes').get_ivy(opts))
          end,
        },
      },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  },
}

-- local M = {}
-- function M.find_configs()
--   require("telescope.builtin").find_files {
--     prompt_title = " NVim & Term Config Find",
--     results_title = "Config Files Results",
--     path_display = { "smart" },
--     search_dirs = {
--       "~/.config/nvim",
--     },
--     layout_strategy = "horizontal",
--     layout_config = { preview_width = 0.65, width = 0.75 },
--   }
-- end
-- return M
