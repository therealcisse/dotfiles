if false then
  RELOAD "trc.repl"
end

local M = {}

_ReplCurrentJobID = _ReplCurrentJobID or -1
_ReplCurrentCommand = _ReplCurrentCommand or nil

M.set_job_id = function(job_id)
  job_id = job_id or vim.b.terminal_job_id

  print("setting job id..", job_id)
  _ReplCurrentJobID = job_id
end

M.set_job_command = function(command)
  _ReplCurrentCommand = command or vim.fn.input "Send to chan >"
end

M.send_to_term = function(input)
  input = input or _ReplCurrentCommand or vim.fn.input "Send to chan >"

  vim.fn.chansend(_ReplCurrentJobID, { input .. "\r\n" })
end

vim.api.nvim_set_keymap("n", "<leader>rs", '<cmd>lua require("trc.repl").set_job_id()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>rc", '<cmd>lua require("trc.repl").set_job_command()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>ri", '<cmd>lua require("trc.repl").send_to_term()<CR>', { noremap = true })

return M
