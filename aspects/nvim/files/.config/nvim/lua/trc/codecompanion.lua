local status_ok, codecompanion = pcall(require, 'codecompanion')
if not status_ok then
  return
end

codecompanion.setup({
  strategies = {
    chat = {
      adapter = 'openai',
    },
    inline = {
      adapter = 'openai',
    },
    keymaps = {
      compeletion = {
        modes = {
          i = '<C-Space>'
        },
      },
    },
    cmd = {
      adapter = "openai"
    },
  },
  display = {
    diff = {
      provider = 'mini_pick',
      -- provider = 'mini_diff',
    },

  },
  opts = {
    log_level = 'DEBUG',
  },
})

vim.api.nvim_set_keymap('n', '<C-a>', '<cmd>CodeCompanionActions<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-a>', '<cmd>CodeCompanionActions<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<localLeader>a', '<cmd>CodeCompanionChat Toggle<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<localLeader>a', '<cmd>CodeCompanionChat Toggle<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'ga', '<cmd>CodeCompanionChat Add<cr>', { noremap = true, silent = true })

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])
