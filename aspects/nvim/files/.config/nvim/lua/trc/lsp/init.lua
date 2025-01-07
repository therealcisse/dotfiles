local imap = require('trc.keymap').imap
local nmap = require('trc.keymap').nmap

local has_lsp, lspconfig = pcall(require, 'lspconfig')
if not has_lsp then
	return
end

local M = {}

-- local is_mac = vim.fn.has('macunix') == 1

-- local lspconfig_util = require('lspconfig.util')
local util = require('trc.lsp.lsp_util')

-- local typescript_installer = util.npm_installer({
-- 	server_name = 'tsserver',
-- 	packages = { 'typescript-language-server' },
-- 	binaries = { 'typescript-language-server' },
-- })

local telescope_mapper = require('trc.telescope.mappings')
local handlers = require('trc.lsp.handlers')

-- local ts_util = require('nvim-lsp-ts-utils')

-- Can set this lower if needed.
-- require('vim.lsp.log').set_level 'debug'
-- require('vim.lsp.log').set_level 'trace'

local status = require('trc.lsp.status')
if status then
	status.activate()
end

function M.on_init(client, bufnr)
	client.config.flags = client.config.flags or {}
	client.config.flags.allow_incremental_sync = true

end

local augroup_format = vim.api.nvim_create_augroup('my_lsp_format', { clear = true })
local autocmd_format = function(async, filter)
	vim.api.nvim_clear_autocmds({ buffer = 0, group = augroup_format })
	vim.api.nvim_create_autocmd('BufWritePre', {
		buffer = 0,
		callback = function()
			vim.lsp.buf.format({ async = async, filter = filter })
		end,
	})
end

local filetype_attach = setmetatable({
	-- go = function()
	--   autocmd_format(false)
	-- end,

	-- scss = function()
	--   autocmd_format(false)
	-- end,

	sqls = function() end,

	-- jdtls = function()
	--      require('java').setup({})
	--  end,

	lua_ls = function() end,

	-- dartls = function()
	--   autocmd_format(true)
	-- end,

	terraformls = function()
		autocmd_format(false)
	end,

	tflint = function()
		autocmd_format(false)
	end,

	hls = function()
		autocmd_format(false)
	end,

	clang = function()
		autocmd_format(true)
	end,

	-- scala = function()
	--   autocmd_format(false)
	-- end,

	-- ziggy = function()
	--   autocmd_format(false)
	-- end,

	-- ziggy_schema = function()
	--   autocmd_format(false)
	-- end,

	-- rust = function()
	--   -- vim.cmd [[
	--   --   autocmd BufEnter,BufWritePost <buffer> :lua require('lsp_extensions.inlay_hints').request {aligned = true, prefix = ' » '}
	--   -- ]]
	--
	--   telescope_mapper('<leader>wf', 'lsp_workspace_symbols', {
	--     ignore_filename = true,
	--     query = '#',
	--   }, true)
	--
	--   autocmd_format(false)
	-- end,

	-- typescript = function()
	-- 	autocmd_format(false)
	-- 	-- autocmd_format(false, function(clients)
	-- 	-- 	return vim.tbl_filter(function(client)
	-- 	-- 		return client.name ~= 'tsserver'
	-- 	-- 	end, clients)
	-- 	-- end)
	-- end,
}, {
	__index = function()
		return function() end
	end,
})

local buf_nnoremap = function(opts)
	if opts[3] == nil then
		opts[3] = {}
	end
	opts[3].buffer = 0

	nmap(opts)
end

local buf_inoremap = function(opts)
	if opts[3] == nil then
		opts[3] = {}
	end
	opts[3].buffer = 0

	imap(opts)
end

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(args)
		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		if client.server_capabilities.inlayHintProvider then
			-- vim.lsp.inlay_hint.enable(true, bufnr)
		end

		if client.server_capabilities.completionProvider then
			vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
		end

		if client.server_capabilities.definitionProvider then
			vim.bo[bufnr].tagfunc = 'v:lua.vim.lsp.tagfunc'
		end
	end,
})

vim.api.nvim_create_autocmd('LspDetach', {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		-- Do something with the client
		-- vim.cmd('setlocal tagfunc< omnifunc<')
	end,
})

-- require('trc.lsp.codelens').setup()

vim.keymap.set('n', '<leader>h', function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end)

vim.keymap.set('n', '<leader>k', function()
	vim.lsp.codelens.run()
end)

vim.keymap.set('n', '<leader>b', function()
	require('dap').toggle_breakpoint()
end, { noremap = true })
vim.keymap.set('n', '<leader>dt', function()
	require('dapui').toggle()
end, { noremap = true })
vim.keymap.set('n', '<leader>dc', function()
	require('dap').continue()
end, { noremap = true })
vim.keymap.set('n', '<leader>dr', function()
	require('dapui').open({ reset = true })
end, { noremap = true })

vim.keymap.set('n', '<leader>dE', function()
	require('dapui').eval(vim.fn.input('[DAP] Expression > '))
end)

function M.on_attach(client, bufnr)
  -- client.server_capabilities.semanticTokensProvider = nil

	local filetype = vim.api.nvim_buf_get_option(0, 'filetype')

	if vim.g.vscode then
    buf_inoremap({ 'K', vim.lsp.buf.hover })
	end

	buf_inoremap({ '<c-s>s', vim.lsp.buf.signature_help })

	buf_nnoremap({ '<localleader>rn', vim.lsp.buf.rename })
	buf_nnoremap({ '<localleader>ca', vim.lsp.buf.code_action })
	buf_nnoremap({ '<leader>e', vim.diagnostic.open_float })

	buf_nnoremap({ 'gd', vim.lsp.buf.definition })
	buf_nnoremap({ 'gD', vim.lsp.buf.declaration })
	buf_nnoremap({ 'gT', vim.lsp.buf.type_definition })

	buf_nnoremap({ 'gi', handlers.implementation })

	-- buf_nnoremap { '<leader><enter>', 'LspRestart' }

	telescope_mapper('<localleader>gr', 'lsp_references', nil, true)
	telescope_mapper('gI', 'lsp_implementations', nil, true)

	-- telescope_mapper(
	--   '<localleader>wd',
	--   'lsp_document_symbols',
	--   { ignore_filename = true },
	--   true
	-- )

	-- telescope_mapper(
	--   '<localleader>ww',
	--   'lsp_dynamic_workspace_symbols',
	--   { ignore_filename = true },
	--   true
	-- )

	if filetype ~= 'lua' then
		-- buf_nnoremap { 'K', vim.lsp.buf.hover, { desc = 'lsp:hover' } }
	end

	-- Attach any filetype specific options to the client
	filetype_attach[filetype](client)
end

local updated_capabilities = require('blink.cmp').get_lsp_capabilities() -- vim.lsp.protocol.make_client_capabilities()
updated_capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}
-- updated_capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false
updated_capabilities.textDocument.codeLens = { dynamicRegistration = false }

-- updated_capabilities = vim.tbl_deep_extend('force', updated_capabilities, require('cmp_nvim_lsp').default_capabilities(updated_capabilities))
-- TODO: check if this is the problem.
-- updated_capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false
updated_capabilities.textDocument.completion.completionItem.insertReplaceSupport = false

M.capabilities = updated_capabilities

-- vim.lsp.buf_request(0, 'textDocument/codeLens', { textDocument = vim.lsp.util.make_text_document_params() })

local servers = {
	-- gdscript = true,
	graphql = true,
	sqls = true,
  -- jdtls = {
  --   auto_start = false,
  --   settings = {
  --     java = {
  --       signatureHelp = {enabled = true},
  --       import = {enabled = true},
  --       rename = {enabled = true}
  --     }
  --   },
  --   init_options = {
  --     jvm_args = { '--enable-preview' },
  --   },
  -- },
	-- pyright = true,
  pylsp = {
        plugins = {
          pycodestyle = { enabled = true, maxLineLength = 120 },
          pylint = { enabled = false },
          pyflakes = { enabled = true },
          jedi_completion = { fuzzy = true },
        },
  },
	-- vimls = true,
	-- eslint = true,

  jsonls = {
    settings = {
      json = {
        schemas = require('schemastore').json.schemas {
          select = {
            'Renovate',
            'GitHub Workflow Template Properties'
          }
        },
        validate = { enable = true },
      }
    }
  },

  -- metals = vim.tbl_deep_extend(require('metals').bare_config(), {
  -- filetypes = { 'scala', 'java', 'sbt' },
  -- root_dir = util.root_pattern('build.sbt', '.git'),
  --
  --   init_options = {
  --     statusBarProvider = 'on'
  --   },
  --
  --   settings = {
  --     showImplicitArguments = false,
  --     showInferredType = false,
  --     excludedPackages = {
  --       'akka.actor.typed.javadsl',
  --       'com.github.swagger.akka.javadsl'
  --     },
  --     superMethodLensesEnabled = false,
  --     inlayHints = true,
  --     inlayHints = {
  --       implicitArguments = { enable = false },
  --       implicitConversions = { enable = false },
  --       typeParameters = { enable = false },
  --       inferredTypes = { enable = false },
  --       hintsInPatternMatch = { enable = false },
  --
  --     },
  --     enableSemanticHighlighting = false,
  --
  --   },
  --
  -- }),

  -- https://www.arthurkoziel.com/json-schemas-in-neovim/
  yamlls = require('yaml-companion').setup {
    -- detect k8s schemas based on file content
    builtin_matchers = {
      kubernetes = { enabled = true }
    },

    -- schemas available in Telescope picker
    schemas = {
      -- not loaded automatically, manually select with
      -- :Telescope yaml_schema
      {
        name = 'Argo CD Application',
        uri = 'https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json'
      },
      {
        name = 'SealedSecret',
        uri = 'https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/bitnami.com/sealedsecret_v1alpha1.json'
      },
      -- schemas below are automatically loaded, but added
      -- them here so that they show up in the statusline
      {
        name = 'Kustomization',
        uri = 'https://json.schemastore.org/kustomization.json'
      },
      {
        name = 'GitHub Workflow',
        uri = 'https://json.schemastore.org/github-workflow.json'
      },
    },

    lspconfig = {
      flags = {
        debounce_text_changes = 150,
      },
      settings = {
        yaml = {
          validate = true,
          hover = true,
          schemaStore = {
            enable = false,
            url = ''
          },

          schemaDownload = { enable = true },
          -- trace = { server = 'debug' },

          -- schemas from store, matched by filename
          -- loaded automatically
          schemas = require('schemastore').yaml.schemas {
            select = {
              'kustomization.yaml',
              'GitHub Workflow',
            }
          }
        }
      }
    }
  },

	cmake = (1 == vim.fn.executable('cmake-language-server')),
	zls = (1 == vim.fn.executable('zig')),
	dartls = true,

	solang = true,

	solidity = {
		default_config = {
			cmd = { 'nomicfoundation-solidity-language-server', '--stdio' },
			filetypes = { 'solidity' },
			root_dir = lspconfig.util.find_git_ancestor,
			single_file_support = true,
		},
	},

	clangd = {
		cmd = {
			'clangd',
			'--background-index',
			'--clang-tidy',
			'--header-insertion=iwyu',
      '--log=verbose'
		},
		-- Required for lsp-status
    initialization_options = {
      fallback_flags = { '-std=c++17' },
			clangdFileStatus = true,
    },
		init_options = {
      fallback_flags = { '-std=c++17' },
			clangdFileStatus = true,
		},
		handlers = nil,
	},

	gopls = {
		root_dir = function(fname)
			local Path = require('plenary.path')

			local absolute_cwd = Path:new(vim.loop.cwd()):absolute()
			local absolute_fname = Path:new(fname):absolute()

			if string.find(absolute_cwd, '/cmd/', 1, true) and string.find(absolute_fname, absolute_cwd, 1, true) then
				return absolute_cwd
			end

			return util.root_pattern('go.mod', '.git')(fname)
		end,

		settings = {
			gopls = {
				codelenses = { test = true },
				completeUnimported = true,
				usePlaceholders = true,
				analyses = {
					unusedparams = true,
				},
				hints = {
					parameterNames = true,
					constantValues = true,
					compositeLiteralTypes = true,
					assignVariableTypes = true,
				},
			},
		},

		flags = {
			debounce_text_changes = 200,
		},
	},

	-- omnisharp = {
	--   cmd = { vim.fn.expand '~/build/omnisharp/run', '--languageserver', '--hostPID', tostring(vim.fn.getpid()) },
	-- },

	rust_analyzer = {
		cmd = { 'rustup', 'run', 'stable', 'rust-analyzer' },
		flags = {
			debounce_text_changes = 150,
		},
		settings = {
			['rust-analyzer'] = {
				cargo = {
					allFeatures = true,
				},
				completion = {
					postfix = {
						enable = false,
					},
				},
			},
		},
	},

	-- elmls = true,

	lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },

	-- tsserver = {
	-- 	init_options = ts_util.init_options,
	-- 	cmd = { 'typescript-language-server', '--stdio' },
	-- 	install = typescript_installer.install,
	-- 	install_info = typescript_installer.info,
	-- 	on_new_config = function(new_config)
	-- 		local install_info = typescript_installer.info()
	-- 		if install_info.is_installed then
	-- 			if type(new_config.cmd) == 'table' then
	-- 				-- Try to preserve any additional args from upstream changes.
	-- 				new_config.cmd[1] = install_info.binaries['typescript-language-server']
	-- 			else
	-- 				new_config.cmd = { install_info.binaries['typescript-language-server'] }
	-- 			end
	-- 		end
	-- 	end,
	-- 	filetypes = {
	-- 		'js',
	-- 		'javascript',
	-- 		'javascriptreact',
	-- 		'javascript.jsx',
	-- 		'typescript',
	-- 		'typescriptreact',
	-- 		'typescript.tsx',
	-- 	},
	-- 	root_dir = util.root_pattern('package.json'),
	--
	-- 	on_attach = function(client)
	-- 		custom_attach(client)
	--
	-- 		ts_util.setup({ auto_inlay_hints = false })
	-- 		ts_util.setup_client(client)
	-- 	end,
	-- },

  terraformls = true,
  tflint = true,

	hls = {
		cmd = {
			'haskell-language-server-wrapper',
			'--lsp',
			'-d',
			'-l',
			'/tmp/hls.log',
		},
		filetypes = { 'haskell', 'lhaskell' },
		root_dir = util.root_pattern('*.cabal', 'stack.yaml', 'cabal.project', 'package.yaml', 'hie.yaml'),
	},

	-- ziggy = {
	--   cmd = {'ziggy', 'lsp'},
	--   filetypes = {'ziggy'},
	--   root_dir = util.root_pattern('*.ziggy'),
	-- },

	-- ziggy_schema = {
	--   cmd = {'ziggy', 'lsp', '--schema'},
	--   filetypes = {'ziggy'},
	--   root_dir = util.root_pattern('*.ziggy_schema'),
	-- },
}

local setup_server = function(server, config)
	if not config then
		return
	end

	if type(config) ~= 'table' then
		config = {}
	end

	config = vim.tbl_deep_extend('force', {
		on_init = M.on_init,
		on_attach = M.on_attach,
		capabilities = updated_capabilities,
		flags = {
			-- debounce_text_changes = nil,
		},
		hint = {
			enable = true,
			arrayIndex = 'Enable',
			setType = true,
		},
	}, config)

	lspconfig[server].setup(config)
end

for server, config in pairs(servers) do
	setup_server(server, config)
end

return M
