local f = require("config.functions")
local map = f.map

local setup = function()
  map("n", "<C-p>", [[<cmd>lua require("telescope.builtin").find_files({layout_strategy="vertical"})<CR>]])
  map("n", "<C-g>/", [[<cmd>lua require("telescope.builtin").live_grep({layout_strategy="vertical"})<CR>]])
  map("n", "<C-g>gh", [[<cmd>lua require("telescope.builtin").git_commits({layout_strategy="vertical"})<CR>]])
  map("n", "<leader>mc", [[<cmd>lua require("telescope").extensions.metals.commands()<CR>]])
  map("n", "<leader>cc", [[<cmd>lua RELOAD("telescope").extensions.coursier.complete()<CR>]])

  map("n", "gds", [[<cmd>lua require("telescope.builtin").lsp_document_symbols()<CR>]])
  map("n", "gws", [[<cmd>lua require("telescope.builtin").lsp_dynamic_workspace_symbols()<CR>]])

  local actions = require("telescope.actions")
  require("telescope").setup({
    defaults = {
      file_ignore_patterns = { "target", "node_modules", "parser.c", "out", "%.min.js" },
      file_ignore_patterns = {"node_modules","%.out"},
      prompt_prefix = " 🔍 ",
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      mappings = {
        i = {
          ["<ESC>"] = actions.close,
          ["<C-q>"] = actions.smart_send_to_qflist,
          ["<C-k>"] = actions.smart_send_to_loclist
        },
        n = {
          ["f"] = actions.send_to_qflist,
        },
      },
    },
  })

  require("telescope").load_extension("fzy_native")
end

return {
  setup = setup,
}
