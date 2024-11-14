local status_ok, _ = pcall(require, "fzf-lua")
if not status_ok then
	return
end

-- vim.keymap.set("n", "<leader>p", function()
--   require("telescope.builtin").find_files()
-- end, { desc = "Files Find" })
vim.keymap.set("n", "<C-p>", require("fzf-lua").files, { desc = "Fzf Files" })

-- vim.keymap.set("n", "<leader>r", function()
--   require("telescope.builtin").registers()
-- end, { desc = "Browse Registers" })
-- vim.keymap.set("n", "<leader>r", require("fzf-lua").registers, { desc = "Registers" })

-- vim.keymap.set("n", "<leader>m", function()
--   require("telescope.builtin").marks()
-- end, { desc = "Browse Marks" })
-- vim.keymap.set("n", "<leader>m", require("fzf-lua").marks, { desc = "Marks" })

-- vim.keymap.set("n", "<leader>f", function()
--   require("telescope.builtin").live_grep()
-- end, { desc = "Find string" })
vim.keymap.set("n", "<C-g>/", require("fzf-lua").live_grep, { desc = "Fzf Grep" })
vim.keymap.set("n", "<leader>/", require("fzf-lua").live_grep, { desc = "Fzf Grep" })

-- vim.keymap.set("n", "<leader>b", function()
--   require("telescope.builtin").buffers({
--     ignore_current_buffer = true,
--     sort_mru = true,
--   })
-- end, { desc = "Browse Buffers" })
vim.keymap.set("n", "<leader>b", require("fzf-lua").buffers, { desc = "Fzf Buffers" })

-- vim.keymap.set("n", "<leader>j", function()
--   require("telescope.builtin").help_tags()
-- end, { desc = "Browse Help Tags" })
vim.keymap.set("n", "<leader>j", require("fzf-lua").helptags, { desc = "Help Tags" })

-- vim.keymap.set("n", "<leader>gc", function()
--   require("telescope.builtin").git_bcommits()
-- end, { desc = "Browse File Commits" })
vim.keymap.set("n", "<leader>gc", require("fzf-lua").git_bcommits, { desc = "Browse File Commits" })

-- vim.keymap.set("n", "<leader>e", function()
--   require("telescope").extensions.file_browser.file_browser()
-- end, { desc = "Files Explore" })

-- vim.keymap.set("n", "<leader>s", function()
--   require("telescope.builtin").spell_suggest(require("telescope.themes").get_cursor({}))
-- end, { desc = "Spelling Suggestions" })
vim.keymap.set(
	"n",
	"<leader>s",
	":lua require'fzf-lua'.spell_suggest({ winopts = {relative='cursor',row=1.01, col=0, height=0.2, width=0.2} })<cr>",
	{ desc = "Spelling Suggestions" }
)

-- vim.keymap.set("n", "<leader>gs", function()
--   require("telescope.builtin").git_status()
-- end, { desc = "Git Status" })
vim.keymap.set("n", "<leader>gs", require("fzf-lua").git_status, { desc = "Git Status" })

-- vim.keymap.set("n", "<leader>ca", function()
--   vim.lsp.buf.code_action()
-- end, { desc = "Code Actions" })
vim.keymap.set(
	"n",
	"<leader>ca",
	":lua require'fzf-lua'.lsp_code_actions({ winopts = {relative='cursor',row=1.01, col=0, height=0.2, width=0.4} })<cr>",
	{ desc = "Code Actions" }
)
-- vim.keymap.set("n", "<leader>ch", function()
--   vim.lsp.buf.hover()
-- end, { desc = "Code Hover" })

-- vim.keymap.set("n", "<leader>cl", function()
--   vim.diagnostic.open_float(0, { scope = "line" })
-- end, { desc = "Line Diagnostics" })
vim.keymap.set("n", "<leader>cl", require("fzf-lua").lsp_document_diagnostics, { desc = "Document Diagnostics" })

-- vim.keymap.set("n", "<leader>cj", function()
--   vim.lsp.buf.definition()
-- end, { desc = "Jump to Definition" })
vim.keymap.set("n", "<leader>cj", require("fzf-lua").lsp_definitions, { desc = "Jump to Definition" })

-- vim.keymap.set("n", "<leader>cs", function()
--   require("telescope.builtin").lsp_document_symbols()
-- end, { desc = "Code Symbols" })
vim.keymap.set("n", "<leader>cs", require("fzf-lua").lsp_document_symbols, { desc = "Document Symbols" })

-- vim.keymap.set("n", "<leader>cd", function()
--   require("telescope.builtin").diagnostics({ bufnr = 0 })
-- end, { desc = "Code Diagnostics" })
vim.keymap.set("n", "<leader>cd", require("fzf-lua").diagnostics_document, { desc = "Document Diagnostics" })

-- vim.keymap.set("n", "<leader>cr", function()
--   require("telescope.builtin").lsp_references()
-- end, { desc = "Code References" })
vim.keymap.set("n", "<leader>cr", require("fzf-lua").lsp_references, { desc = "LSP References" })
