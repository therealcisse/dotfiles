vim.g.copilot_no_tab_map = true
vim.g.copilot_hide_duringk_completion = 0
vim.g.copilot_proxy_strict_ssl = 0

vim.api.nvim_create_autocmd({'BufEnter'}, {
  pattern = 'copilot-*',
  callback = function()
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false

    -- Get current filetype and set it to markdown if the current filetype is copilot-chat
    local ft = vim.bo.filetype
    if ft == 'copilot-chat' then
      vim.bo.filetype = 'CopilotChat'
    end
  end,
})

