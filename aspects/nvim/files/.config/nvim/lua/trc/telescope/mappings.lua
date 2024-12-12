if not pcall(require, "telescope") then
  return
end

local sorters = require "telescope.sorters"

TelescopeMapArgs = TelescopeMapArgs or {}

local map_tele = function(key, f, options, buffer)
  local map_key = vim.api.nvim_replace_termcodes(key .. f, true, true, true)

  TelescopeMapArgs[map_key] = options or {}

  local mode = "n"
  local rhs = string.format("<cmd>lua R('trc.telescope')['%s'](TelescopeMapArgs['%s'])<CR>", f, map_key)

  local map_options = {
    noremap = true,
    silent = true,
  }

  if not buffer then
    vim.api.nvim_set_keymap(mode, key, rhs, map_options)
  else
    vim.api.nvim_buf_set_keymap(0, mode, key, rhs, map_options)
  end
end

vim.api.nvim_set_keymap("c", "<c-r><c-r>", "<Plug>(TelescopeFuzzyCommandSearch)", { noremap = false, nowait = true })


-- Dotfiles
-- map_tele("<leader>ez", "edit_zsh")
-- map_tele("<localleader>cd", "diagnostics")

map_tele("<leader>ep", "ep")
map_tele("<leader>ec", "ec")
map_tele("<leader>fg", "multi_rg")

-- Search
-- TODO: I would like to completely remove _mock from my search results here when I'm in SG/SG
map_tele("<C-g>/", "live_grep_args", {
  short_path = true,
  word_match = "-w",
  only_sort_text = true,
  layout_strategy = "vertical",
  sorter = sorters.get_fzy_sorter(),
})

map_tele("<C-Y>", "yaml", {
})

map_tele("<C-g>]", "ast_grep", {
  short_path = true,
  word_match = "-w",
  only_sort_text = true,
  layout_strategy = "vertical",
  sorter = sorters.get_fzy_sorter(),
})

map_tele("<leader>/", "live_grep_args", {
  short_path = true,
  word_match = "-w",
  only_sort_text = true,
  layout_strategy = "vertical",
  sorter = sorters.get_fzy_sorter(),
})

-- List git worktrees
map_tele("<leader>,", "list_git_worktrees")

-- Create worktree
map_tele("<leader>c", "create_git_worktree")


-- map_tele("<leader>f/", "grep_last_search", {
--   layout_strategy = "vertical",
-- })

-- Files
-- map_tele("<leader>ft", "git_files")
-- map_tele("<C-g>", "live_grep")
-- map_tele("<leader>fg", "multi_rg")
-- map_tele("<leader>fo", "oldfiles")
map_tele("<C-p>", "fs")
map_tele("<leader>p", "fs")
-- map_tele("<leader><backspace>", "fs")
map_tele("<leader>fs", "fs")
-- map_tele("<leader>pp", "project_search")
-- map_tele("<leader>fv", "find_nvim_source")
-- map_tele("<leader>fe", "file_browser")
-- map_tele("<leader>fz", "search_only_certain_files")

-- Git
-- map_tele("<leader>gs", "git_status")
-- map_tele("<leader>gc", "git_commits")

-- Nvim
map_tele("<leader>fd", "fs")
-- map_tele("<leader>fa", "installed_plugins")
-- map_tele("<leader>fi", "search_all_files")
-- map_tele("<leader>ff", "curbuf")
-- map_tele("<leader>fh", "help_tags")
-- map_tele("<leader>bo", "vim_options")
-- map_tele("<leader>gp", "grep_prompt")
-- map_tele("<leader>wt", "treesitter")

-- Telescope Meta
-- map_tele("<leader>fB", "builtin")

return map_tele
