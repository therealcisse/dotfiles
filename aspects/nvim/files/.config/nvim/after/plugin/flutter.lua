local has_flutter_tools = pcall(require, "flutter-tools")
if not has_flutter_tools then
  -- return
end

-- local g = require('colorbuddy.group').groups

-- local Group = require("colorbuddy.group").Group
-- local c = require("colorbuddy.color").colors
-- local s = require("colorbuddy.style").styles
--
-- Group.new("FlutterClosingTag", c.gray3, nil, s.italic)
-- Group.new("FlutterWidgetGuides", c.gray2)

local lsp = require "trc.lsp"

require("flutter-tools").setup {
  ui = {
    -- the border type to use for all floating windows, the same options/formats
    -- used for ":h nvim_open_win" e.g. "single" | "shadow" | {<table-of-eight-chars>}
    border = "rounded",
    -- This determines whether notifications are show with `vim.notify` or with the plugin's custom UI
    -- please note that this option is eventually going to be deprecated and users will need to
    -- depend on plugins like `nvim-notify` instead.
    notification_style = 'native'
  },


  debugger = {
    enabled = false,
    run_via_dap = true, -- use dap instead of a plenary job to run flutter apps
  },

  lsp = {
    color = { -- show the derived colours for dart variables
      enabled = false, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
      background = false, -- highlight the background
      foreground = false, -- highlight the foreground
      virtual_text = true, -- show the highlight using virtual text
      virtual_text_str = "■", -- the virtual text character to highlight
    },
    capabilities = lsp.capabilities,
    on_attach = lsp.on_attach,
    --- OR you can specify a function to deactivate or change or control how the config is created
    -- capabilities = function(config)
    --   config.specificThingIDontWant = false
    --   return config
    -- end,
    settings = {
      showTodos = true,
      completeFunctionCalls = true,
      analysisExcludedFolders = {}
    }
  },

  widget_guides = {
    enabled = true,
  },

  closing_tags = {
    enabled = true,
    highlight = "FlutterClosingTag",
    -- format = " </%s>",
    -- prefix = "~~ "
  },

}

