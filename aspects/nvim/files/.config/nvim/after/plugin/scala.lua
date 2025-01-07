local has_metals, metals = pcall(require, 'metals')

if not has_metals then
  return
end

local lsp = require 'trc.lsp'

local metals_config = metals.bare_config()

-- Example of settings
metals_config.settings = {
  autoImportBuild = "initial",
  showImplicitArguments = false,
  showInferredType = false,
  excludedPackages = {
    'akka.actor.typed.javadsl',
    'com.github.swagger.akka.javadsl'
  },
  superMethodLensesEnabled = false,
  inlayHints = {
    implicitArguments = { enable = false },
    implicitConversions = { enable = false },
    typeParameters = { enable = false },
    inferredTypes = { enable = false },
    hintsInPatternMatch = { enable = false },

  },
  enableSemanticHighlighting = false,
}

-- *READ THIS*
-- I *highly* recommend setting statusBarProvider to true, however if you do,
-- you *have* to have a setting to display this in your statusline or else
-- you'll not see any messages from metals. There is more info in the help
-- docs about this
metals_config.init_options.statusBarProvider = 'on'


-- Example if you are using cmp how to make sure the correct capabilities for snippets are set
metals_config.capabilities = lsp.capabilities

metals_config.on_attach = function(client, bufnr)
  lsp.on_attach(client, bufnr)
end

metals_config.on_init = function(client)
  lsp.on_init(client)
end

local nvim_metals_group = vim.api.nvim_create_augroup('nvim-metals', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  -- NOTE: You may or may not want java included here. You will need it if you
  -- want basic Java support but it may also conflict if you are using
  -- something like nvim-jdtls which also works on a java filetype autocmd.
  pattern = {
    'scala',
    'sbt',
    'java',
  },
  callback = function()
    metals.initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})

