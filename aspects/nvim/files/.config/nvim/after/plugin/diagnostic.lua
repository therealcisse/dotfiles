local nmap = require("trc.keymap").nmap

vim.diagnostic.config({
	virtual_lines = { only_on_current_line = true, highlight_whole_line = false },
	update_in_insert = true,
	-- scope = 'cursor',
	-- virt_text_pos = 'inline',

	virtual_text = false,
	-- virtual_text = {
	--   prefix = '●', -- Could be '■', '▎', 'x'
	--   severity = nil,
	--   source = "if_many",
	--   format = nil,
	-- },
	-- better_virtual_text = {
	-- 	prefix = function(diagnostic)
	-- 		if diagnostic.severity == vim.diagnostic.severity.ERROR then
	-- 			return "" -- Nerd font icon for error
	-- 		elseif diagnostic.severity == vim.diagnostic.severity.WARN then
	-- 			return "" -- Nerd font icon for warning
	-- 		elseif diagnostic.severity == vim.diagnostic.severity.INFO then
	-- 			return "" -- Nerd font icon for info
	-- 		else
	-- 			return "" -- Nerd font icon for hint
	-- 		end
	-- 	end,
	-- },

	signs = true,

	-- options for floating windows:
	float = {
		show_header = true,
		border = "rounded",
		-- source = "always",
		format = function(d)
			local t = vim.deepcopy(d)
			local code = d.code or d.user_data.lsp.code
			if code then
				t.message = string.format("%s [%s]", t.message, code):gsub("1. ", "")
			end
			return t.message
		end,
	},

	-- general purpose
	severity_sort = true,
})

local goto_opts = {
	wrap = true,
	float = true,
}

vim.keymap.set("", "<leader>l", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })

nmap({
	"<leader>gj",
	function()
		vim.diagnostic.goto_next(goto_opts)
	end,
})

nmap({
	"<leader>gk",
	function()
		vim.diagnostic.goto_prev(goto_opts)
	end,
})

nmap({
	"<localleader>cd",
	function()
		vim.diagnostic.open_float(0, {
			scope = "line",
		})
	end,
})
