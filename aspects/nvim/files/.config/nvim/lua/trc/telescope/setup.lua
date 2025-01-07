if not pcall(require, "telescope") then
	return
end

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local action_layout = require("telescope.actions.layout")
local themes = require "telescope.themes"

local set_prompt_to_entry_value = function(prompt_bufnr)
	local entry = action_state.get_selected_entry()
	if not entry or not type(entry) == "table" then
		return
	end

	action_state.get_current_picker(prompt_bufnr):reset_prompt(entry.ordinal)
end

local icons = require("trc.icons")

require("telescope").setup({
	defaults = {
		prompt_prefix = icons.ui.Telescope .. " ",
		selection_caret = " ",
		path_display = { "smart" },
		file_ignore_patterns = { ".git/", "node_modules/", "target/", "docs/", ".settings/" },

		-- path_display = "truncate",

		winblend = 0,

		layout_strategy = "horizontal",
		layout_config = {
			width = 0.95,
			height = 0.85,
			-- preview_cutoff = 120,
			prompt_position = "top",

			horizontal = {
				preview_width = function(_, cols, _)
					if cols > 200 then
						return math.floor(cols * 0.4)
					else
						return math.floor(cols * 0.6)
					end
				end,
			},

			vertical = {
				width = 0.9,
				height = 0.95,
				preview_height = 0.5,
			},

			flex = {
				horizontal = {
					preview_width = 0.9,
				},
			},
		},

		selection_strategy = "reset",
		sorting_strategy = "descending",
		scroll_strategy = "cycle",
		color_devicons = true,

		mappings = {
			i = {
				["<C-c>"] = actions.close,
				["<esc>"] = actions.close,
				["<C-x>"] = false,
				["<C-s>"] = actions.select_horizontal,
				["<C-n>"] = "move_selection_next",

				["<C-e>"] = actions.results_scrolling_down,
				["<C-y>"] = actions.results_scrolling_up,
				-- ["<C-y>"] = set_prompt_to_entry_value,

				-- These are new :)
				["<M-p>"] = action_layout.toggle_preview,
				["<M-m>"] = action_layout.toggle_mirror,
				-- ["<M-p>"] = action_layout.toggle_prompt_position,

				-- ["<M-m>"] = actions.master_stack,

				["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
				["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
				["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

				-- This is nicer when used with smart-history plugin.
				["<C-k>"] = actions.cycle_history_next,
				["<C-j>"] = actions.cycle_history_prev,
				["<c-g>s"] = actions.select_all,
				["<c-g>a"] = actions.add_selection,

				["<c-space>"] = function(prompt_bufnr)
					local opts = {
						callback = actions.toggle_selection,
						loop_callback = actions.send_selected_to_qflist,
					}
					require("telescope").extensions.hop._hop_loop(prompt_bufnr, opts)
				end,

				["<C-w>"] = function()
					vim.api.nvim_input("<c-s-w>")
				end,
			},

			n = {
				["<C-e>"] = actions.results_scrolling_down,
				["<C-y>"] = actions.results_scrolling_up,
			},
		},

		borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },

		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

		history = {
			path = "~/.local/share/nvim/databases/telescope_history.sqlite3",
			limit = 100,
		},
	},

	pickers = {
    find_files = {
      theme = 'ivy'
    },

		fd = {
			mappings = {
				n = {
					["kj"] = "close",
				},
			},
		},

		git_branches = {
			mappings = {
				i = {
					["<C-a>"] = false,
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
    },

		-- fzy_native = {
		-- 	override_generic_sorter = true,
		-- 	override_file_sorter = true,
		-- },

		-- fzf_writer = {
		-- 	use_highlighter = false,
		-- 	minimum_grep_characters = 6,
		-- },

		ast_grep = {
			command = {
				"sg",
				"--json=stream",
			}, -- must have --json and -p
			grep_open_files = false, -- search in opened files
			lang = nil, -- string value, specify language for ast-grep `nil` for default
		},
    live_grep_args = {
      auto_quoting = true, -- enable/disable auto-quoting
      -- define mappings, e.g.
      mappings = { -- extend mappings
        i = {
          -- ["<C-k>"] = lga_actions.quote_prompt(),
          -- ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
          -- -- freeze the current list and start a fuzzy search in the frozen list
          -- ["<C-space>"] = actions.to_fuzzy_refine,
        },
      },
      -- ... also accepts theme settings, for example:
      -- theme = "dropdown", -- use dropdown theme
      theme = themes.get_ivy {
        sorting_strategy = "descending"
      }, -- use own theme spec
      -- layout_config = { mirror=true }, -- mirror preview pane
    },
		hop = {
			-- keys define your hop keys in order; defaults to roughly lower- and uppercased home row
			keys = { "a", "s", "d", "f", "g", "h", "j", "k", "l", ";" }, -- ... and more

			-- Highlight groups to link to signs and lines; the below configuration refers to demo
			-- sign_hl typically only defines foreground to possibly be combined with line_hl
			sign_hl = { "WarningMsg", "Title" },

			-- optional, typically a table of two highlight groups that are alternated between
			line_hl = {
				"CursorLine",
				"Normal",
			},

			-- options specific to `hop_loop`
			-- true temporarily disables Telescope selection highlighting
			clear_selection_hl = false,
			-- highlight hopped to entry with telescope selection highlight
			-- note: mutually exclusive with `clear_selection_hl`
			trace_entry = true,
			-- jump to entry where hoop loop was started from
			reset_selection = true,
		},

		["ui-select"] = {
			require("telescope.themes").get_dropdown({
				-- even more opts
        hidden = false,
        sorting_strategy = "descending",
			}),
		},

		-- frecency = {
		--   workspaces = {
		--     ["conf"] = "/home/tj/.config/nvim/",
		--     ["nvim"] = "/home/tj/build/neovim",
		--   },
		-- },
	},
})

-- pcall(require("telescope").load_extension, "cheat")
-- pcall(require("telescope").load_extension, "arecibo")
-- require("telescope").load_extension "flutter"

-- _ = require("telescope").load_extension("dap")
-- _ = require("telescope").load_extension("notify")
-- _ = require("telescope").load_extension("file_browser")
_ = require("telescope").load_extension("ui-select")
_ = require("telescope").load_extension("fzf")
-- _ = require("telescope").load_extension "git_worktree"
-- _ = require("telescope").load_extension("neoclip")
_ = require("telescope").load_extension("live_grep_args")
_ = require("telescope").load_extension("ast_grep")
-- _ = require("telescope").load_extension "hoggle"

pcall(require("telescope").load_extension, "smart_history")
pcall(require("telescope").load_extension, "frecency")

-- if vim.fn.executable("gh") == 1 then
-- 	pcall(require("telescope").load_extension, "gh")
-- 	pcall(require("telescope").load_extension, "octo")
-- end

-- LOADED_FRECENCY = LOADED_FRECENCY or true
-- local has_frecency = true
-- if not LOADED_FRECENCY then
--   if not pcall(require("telescope").load_extension, "frecency") then
--     require "tj.telescope.frecency"
--   end

--   LOADED_FRECENCY = true
-- end
