local status_ok, codecompanion = pcall(require, 'codecompanion')
if not status_ok then
  return
end

codecompanion.setup({
  adapters = {
    openai = function()
      return require('codecompanion.adapters').extend('openai', {
        env = {
          api_key = 'OPENAI_API_KEY',
          model = 'gpt-4o',
        },
      })
    end,
  },

  strategies = {
    chat = {
      adapter = 'openai',

      keymaps = {
        hide = {
          modes = {
            n = '<localleader>z',
            i = '<localleader>z',
          },
          callback = function(chat)
            -- chat.ui:hide()
          end,
          description = 'Hide the chat buffer',
        },
      },
    },
    inline = {
      adapter = 'openai',
    },
    cmd = {
      adapter = 'openai'
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
vim.api.nvim_set_keymap('n', '<localleader>a', '<cmd>CodeCompanionChat Toggle<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<localleader>a', '<cmd>CodeCompanionChat Toggle<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'ga', '<cmd>CodeCompanionChat Add<cr>', { noremap = true, silent = true })

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])
