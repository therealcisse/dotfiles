-- Autocommand that reloads neovim whenever you save the plugins.lua file
-- vim.cmd([[
--   augroup lazy_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | Lazy sync
--   augroup end
-- ]])

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

local has = function(x)
	return vim.fn.has(x) == 1
end

local is_mac = has('macunix')

local max_jobs = nil
if is_mac then
	max_jobs = 32
end

return require('lazy').setup({
	-- Alternative to impatient, uses sqlite. Faster ;)
	-- https://github.com/tami5/impatient.nvim
	'lewis6991/impatient.nvim',
	-- My Plugins
	-- local_use('ThePrimeagen', 'refactoring.nvim')

	'TovarishFin/vim-solidity',
	-- { 'tomlion/vim-solidity' }

	-----------------------------------------------------------

	{ 'famiu/bufdelete.nvim', cmd = 'Bdelete' },
	'ekalinin/Dockerfile.vim',
	{
		'anuvyklack/animation.nvim',
	},
	{
		'nvim-zh/colorful-winsep.nvim',
		config = function()
			require('colorful-winsep').setup()
		end,
	},
	{
		'folke/lazydev.nvim',
		ft = 'lua', -- only load on lua files
		opts = {

			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = 'luvit-meta/library', words = { 'vim%.uv' } },

			},
		},
	},
  'hashivim/vim-terraform',
	{
		'anuvyklack/windows.nvim',
		dependencies = {
			'anuvyklack/middleclass',
			'anuvyklack/animation.nvim',
		},
		config = function()
			vim.o.winwidth = 10
			vim.o.winminwidth = 10
			vim.o.equalalways = false

			require('windows').setup({
				autowidth = {
					enable = false, -- false
					winwidth = 5,
					filetype = {
						help = 2,
					},
				},
				ignore = {
					buftype = { 'quickfix' },
					filetype = {
						'undotree',
						'gundo',
						'NvimTree',
						'neo-tree',
						'Outline', -- simrat39/symbols-outline.nvim
					},
				},
				animation = {
					enable = true,
					duration = 300,
					fps = 30,
					easing = 'in_out_sine', ---@diagnostic disable-line
				},
			})
		end,
	},
	'mustache/vim-mustache-handlebars',
  { 'neovim/nvim-lspconfig' },

  {
    'someone-stole-my-name/yaml-companion.nvim',
    requires = {
      { 'neovim/nvim-lspconfig' },
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope.nvim' },
    },
    config = function()
      require('telescope').load_extension('yaml_schema')
    end,
  },

  {
    'Duologic/nvim-jsonnet',
  },
  'google/vim-jsonnet',
  'b0o/schemastore.nvim',

	'tpope/vim-fugitive',
	'DataWraith/auto_mkdir',
	'tpope/vim-unimpaired',
	'tommcdo/vim-lion', -- Align = gl, gL
	'tpope/vim-eunuch', --  =SudoWrite, ...
	-- J
	{ 'FooSoft/vim-argwrap', cmd = { 'ArgWrap' } },
	'matze/vim-move', -- <c-k>, <c-j>
  {
    'vim-scripts/ReplaceWithRegister',
    keys = {
      -- { '<leader>gr', '<Plug>ReplaceWithRegisterOperator', {'n', 'v'}, desc = 'ReplaceWithRegisterOperator' },
      { 'mr', '<Plug>ReplaceWithRegisterOperator', {'n', 'v'}, desc = 'ReplaceWithRegisterOperator' },
    },
  }, -- replace <motion> with register

	{ 'EdenEast/nightfox.nvim' },
	{
		'ethanholz/nvim-lastplace',
		event = 'BufRead',
		config = function()
			require('nvim-lastplace').setup({
				lastplace_ignore_buftype = { 'quickfix', 'nofile', 'help' },
				lastplace_ignore_filetype = { 'gitcommit', 'gitrebase', 'svn', 'hgcommit' },
				lastplace_open_folds = true,
			})
		end,
	},
	{
		'scalameta/nvim-metals',
		dependencies = {
			'nvim-lua/plenary.nvim',
			-- 'mfussenegger/nvim-dap',
			-- 'rcarriga/nvim-dap-ui',
			'nvim-neotest/nvim-nio',
			-- 'theHamsta/nvim-dap-virtual-text',
			-- 'nvim-telescope/telescope-dap.nvim',
			-- 'leoluz/nvim-dap-go',
			-- 'LiadOz/nvim-dap-repl-highlights',
		},
		config = function(self, opts)

			-- require('dapui').setup()
			-- require('dap-go').setup()
			-- require('nvim-dap-virtual-text').setup()

			-- require('nvim-dap-repl-highlights').setup()
		end,
	},
	'JASONews/glow-hover',
	{ 'kana/vim-textobj-entire', dependencies = { { 'kana/vim-textobj-user' } } }, -- ae, ie
	{ 'kana/vim-textobj-indent', dependencies = { { 'kana/vim-textobj-user' } } }, -- ai, ii
	{ 'kana/vim-textobj-line', dependencies = { { 'kana/vim-textobj-user' } } }, -- al, il
	{ 'coderifous/textobj-word-column.vim', dependencies = { { 'kana/vim-textobj-user' } } }, -- ic, ac, iC, and aC or vic, cic, and daC
	{ 'mattn/vim-textobj-url', dependencies = { { 'kana/vim-textobj-user' } } }, -- au, iu
	-----------------------------------------------------------

	-- Contributor Plugins
	'L3MON4D3/LuaSnip',
	{ 'Vigemus/iron.nvim' },

  { 'echasnovski/mini.nvim', version = false },

	-- 'onsails/lspkind-nvim',
	'justinsgithub/wezterm-types',
  {'isaksamsten/better-virtual-text.nvim'},

	{ 'dart-lang/dart-vim-plugin' },
	{ 'akinsho/flutter-tools.nvim' },
	'simrat39/rust-tools.nvim',
	{
		'folke/trouble.nvim',
		event = 'BufReadPre',
		module = 'trouble',
		cmd = { 'TroubleToggle', 'Trouble' },
		config = function()
			require('trouble').setup({
				auto_open = false,
				use_diagnostic_signs = true, -- en
			})
		end,
	},
	{
		'monkoose/matchparen.nvim',
		branch = 'main',
		config = function()
			require('matchparen').setup({
				on_startup = true, -- Should it be enabled by default
				hl_group = 'MatchParen', -- highlight group for matched characters
				augroup_name = 'matchparen', -- almost no reason to touch this unless there is already augroup with such name
			})
		end,
	},
	{
		'rmagatti/goto-preview',
		config = function()
			require('goto-preview').setup({})
		end,
	},
	{ 'wincent/pinnacle' },
	{
		'gbprod/stay-in-place.nvim',
		config = function()
			require('stay-in-place').setup({})
		end,
	},

	{
		'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
		config = function()
			require('lsp_lines').setup()
		end,
	},
	{ 'stevearc/dressing.nvim', event = 'User PackerDefered' },
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- zen = { enabled = true },
      indent = { enabled = true },
      bigfile = { enabled = true },
      dashboard = {
        enabled = true,
        sections = {
          { section = 'header' },
          { icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1 },
          { icon = ' ', title = 'Keymaps', section = 'keys', indent = 2, padding = 1 },
          { icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 1 },
          { section = 'startup' },
        },
      },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      styles = {
        notification = {
          wo = { wrap = true } -- Wrap notifications
        }
      }
    },
    keys = {
      -- { '<leader>un', function() Snacks.notifier.hide() end, desc = 'Dismiss All Notifications' },
      -- { '<leader>bd', function() Snacks.bufdelete() end, desc = 'Delete Buffer' },
      -- { '<leader>gg', function() Snacks.lazygit() end, desc = 'Lazygit' },
      -- { '<leader>gb', function() Snacks.git.blame_line() end, desc = 'Git Blame Line' },
      -- { '<leader>gB', function() Snacks.gitbrowse() end, desc = 'Git Browse' },
      -- { '<leader>gf', function() Snacks.lazygit.log_file() end, desc = 'Lazygit Current File History' },
      -- { '<leader>gl', function() Snacks.lazygit.log() end, desc = 'Lazygit Log (cwd)' },
      -- { '<leader>cR', function() Snacks.rename.rename_file() end, desc = 'Rename File' },
      { '<c-/>',      function() Snacks.terminal('zsh') end, desc = 'Toggle Terminal' },
      -- { '<c-_>',      function() Snacks.terminal() end, desc = 'which_key_ignore' },
      -- { ']]',         function() Snacks.words.jump(vim.v.count1) end, desc = 'Next Reference', mode = { 'n', 't' } },
      -- { '[[',         function() Snacks.words.jump(-vim.v.count1) end, desc = 'Prev Reference', mode = { 'n', 't' } },
      {
        '<leader>N',
        desc = 'Neovim News',
        function()
          Snacks.win({
            file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1],
            width = 0.6,
            height = 0.6,
            wo = {
              spell = false,
              wrap = false,
              signcolumn = 'yes',
              statuscolumn = ' ',
              conceallevel = 3,
            },
          })
        end,
      }
    },
    init = function()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          Snacks.toggle.option('spell', { name = 'Spelling' }):map('<leader>us')
          Snacks.toggle.option('wrap', { name = 'Wrap' }):map('<leader>uw')
          Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map('<leader>uL')
          Snacks.toggle.diagnostics():map('<leader>ud')
          Snacks.toggle.line_number():map('<leader>ul')
          Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map('<leader>uc')
          Snacks.toggle.treesitter():map('<leader>uT')
          Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map('<leader>ub')
          Snacks.toggle.inlay_hints():map('<leader>uh')
        end,
      })
    end,
  },

	'nvim-lua/popup.nvim',
	'nvim-lua/plenary.nvim',
	'nvim-telescope/telescope.nvim',
	-- 'nvim-telescope/telescope-rs.nvim',
	-- 'nvim-telescope/telescope-fzf-writer.nvim',
	-- 'nvim-telescope/telescope-fzy-native.nvim',
	'nvim-telescope/telescope-github.nvim',
	'nvim-telescope/telescope-symbols.nvim',
	'Marskey/telescope-sg',
	{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
	{ 'nvim-telescope/telescope-hop.nvim' },
	{ 'nvim-telescope/telescope-file-browser.nvim' },
	{ 'nvim-telescope/telescope-ui-select.nvim' },
	{ 'nvim-telescope/telescope-live-grep-args.nvim' },

	-- Little know features:
	--   :SSave
	--   :SLoad
	--       These are wrappers for mksession that work great. I never have to use
	--       mksession anymore or worry about where things are saved / loaded from.
	-- Better profiling output for startup.
	{
		'dstein64/vim-startuptime',
		cmd = 'StartupTime',
	},
	-- Pretty colors
	'norcalli/nvim-colorizer.lua',
  { 'brenoprata10/nvim-highlight-colors' },
  { 'gen740/SmoothCursor.nvim',
    config = function()
      require('smoothcursor').setup {}
    end
  },

	-- Quickfix enhancements. See :help vim-qf
	'romainl/vim-qf',
	-- {
	-- 	'glacambre/firenvim',
	-- 	build = function()
	-- 		vim.fn['firenvim#install'](0)
	-- 	end,
	-- },

	-- Undo helper
	'sjl/gundo.vim',
	-- Crazy good box drawing
	-- Better increment/decrement
	'monaqa/dial.nvim',
	--  LANGUAGE:
	-- TODO: Should check on these if they are the best ones
	{ 'neovimhaskell/haskell-vim', ft = 'haskell' },
	{ 'elzr/vim-json', ft = 'json' },
	{ 'goodell/vim-mscgen', ft = 'mscgen' },
	'Glench/Vim-Jinja2-Syntax',
	-- 'pearofducks/ansible-vim',
	-- { 'cespare/vim-toml', ft = 'toml' },

	{ 'ziglang/zig.vim', ft = 'zig' },
	-- { 'JuliaEditorSupport/julia-vim', ft = 'julia' },

	{ 'dmmulroy/tsc.nvim' },
	{ 'nanotee/sqls.nvim' },

	'haya14busa/is.vim',
	'osyo-manga/vim-anzu',
	'haya14busa/vim-asterisk',
	-- Typescript
	-- if false then
	'jelera/vim-javascript-syntax',
	'othree/javascript-libraries-syntax.vim',
	'leafgarland/typescript-vim',
	'peitalin/vim-jsx-typescript',
	{ 'vim-scripts/JavaScript-Indent', ft = 'javascript' },
	{ 'pangloss/vim-javascript', ft = { 'javascript', 'html' } },

	-- TODO: Turn emmet back on when I someday it
	-- 'mattn/emmet-vim'

	-- Sql
	-- 'tpope/vim-dadbod',
	-- { 'kristijanhusak/vim-dadbod-completion' },
	-- { 'kristijanhusak/vim-dadbod-ui' },

	-- Completion

	-- Sources
	-- 'hrsh7th/nvim-cmp',
	-- 'hrsh7th/cmp-cmdline',
	-- 'hrsh7th/cmp-buffer',
	-- 'hrsh7th/cmp-path',
	-- 'hrsh7th/cmp-nvim-lua',
	-- 'hrsh7th/cmp-nvim-lsp',
	-- 'hrsh7th/cmp-nvim-lsp-document-symbol',
	-- 'saadparwaiz1/cmp_luasnip',
	-- 'tamago324/cmp-zsh',
	-- 'ray-x/lsp_signature.nvim',
	-- 'hrsh7th/cmp-nvim-lsp-signature-help',
	-- Comparators
	-- 'lukas-reineke/cmp-under-comparator',
	-- Find and replace
	-- {
	--    'windwp/nvim-spectre',
	-- 	config = function()
	--      require('spectre').setup()
	-- 	end,
	-- },

	-- TREE SITTER:
	{
		'nvim-treesitter/nvim-treesitter',
		-- build = 'TSUpdate',
		-- commit = 'f2778bd',
		event = 'BufReadPost',
		-- commit = '33eb472',
	},
	-- 'nvim-treesitter/nvim-treesitter-context',
	-- 'nvim-treesitter/playground',

	'nvim-treesitter/nvim-treesitter-textobjects',
	-- 'JoosepAlviste/nvim-ts-context-commentstring',
	{
		'mfussenegger/nvim-ts-hint-textobject',
		config = function()
			vim.cmd([[omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>]])
			vim.cmd([[vnoremap <silent> m :lua require('tsht').nodes()<CR>]])
		end,
	},

	'google/vim-searchindex',
	'tamago324/lir.nvim',
	'tamago324/lir-git-status.nvim',
	-- if executable 'mmv' then
	--     'tamago324/lir-mmv.nvim'
	-- end,

	-- {
	--   'stevearc/oil.nvim',
	--   opts = {},
	--   -- Optional dependencies
	--   dependencies = { 'nvim-tree/nvim-web-devicons' },
	-- },

	-- 'pechorin/any-jump.vim'

	--
	-- TEXT MANIUPLATION
	'godlygeek/tabular', -- Quickly align text by pattern
	'tpope/vim-repeat', -- Repeat actions better
	'tpope/vim-abolish', -- Cool things with words!
	'tpope/vim-characterize',
	{ 'tpope/vim-dispatch', cmd = { 'Dispatch', 'Make' } },

	{
		'AndrewRadev/splitjoin.vim',
		keys = { 'gJ', 'gS' },
	},
	-- {
	-- 	'm-demare/hlargs.nvim',
	-- 	event = 'User PackerDefered',
	-- 	config = function()
	-- 		require('hlargs').setup({
	-- 			color = require('tokyonight.colors').setup().yellow,
	-- 		})
	-- 	end,
	-- },

	{
		'kylechui/nvim-surround',
		-- version = '*', -- Use for stability; omit to use `main` branch for the latest features
		event = 'VeryLazy',
		config = function()
			require('nvim-surround').setup({})
		end,
	},
	{ 'akinsho/toggleterm.nvim', version = '*', config = true },
	'windwp/nvim-autopairs', -- Auto } }pairs, integrates with both cmp and treesitter

  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      -- stylua: ignore
      local colors = {
        blue   = '#80a0ff',
        cyan   = '#79dac8',
        black  = '#080808',
        white  = '#c6c6c6',
        red    = '#ff5189',
        violet = '#d183e8',
        grey   = '#303030',
      }

      local bubbles_theme = {
        normal = {
          a = { fg = colors.black, bg = colors.violet },
          b = { fg = colors.white, bg = colors.grey },
          c = { fg = colors.white },
        },

        insert = { a = { fg = colors.black, bg = colors.blue } },
        visual = { a = { fg = colors.black, bg = colors.cyan } },
        replace = { a = { fg = colors.black, bg = colors.red } },

        inactive = {
          a = { fg = colors.white, bg = colors.black },
          b = { fg = colors.white, bg = colors.black },
          c = { fg = colors.white },
        },
      }

      require('lualine').setup {
        options = {
          theme = bubbles_theme,
          component_separators = '',
          section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
          lualine_b = { 'filename', 'branch' },
          lualine_c = {
            '%=', --[[ add your center compoentnts here in place of this comment ]]
          },
          lualine_x = {},
          -- lualine_x = { '%n', buf_lsp_info, 'filetype' },
          lualine_y = { 'filetype', 'progress' },
          lualine_z = {
            { 'location', separator = { right = '' }, left_padding = 2 },
          },
        },
        inactive_sections = {
          lualine_a = { 'filename' },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { 'location' },
        },
        tabline = {},
        extensions = {},
      }
    end,
  },
	-- Sweet message committer
	'rhysd/committia.vim',
	-- Floating windows are awesome :)
	{
		'rhysd/git-messenger.vim',
		keys = '<Plug>(git-messenger)',
	},
	-- Async signs!
	'lewis6991/gitsigns.nvim',

	{
		'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
		config = function()
			require('lsp_lines').setup()
		end,
	},

	{
		'tiagovla/tokyodark.nvim',
		opts = {},
		config = function(_, opts)
			-- require('tokyodark').setup(opts) -- calling setup is optional
			vim.cmd([[colorscheme tokyodark]])
		end,
	},
	{
		'folke/noice.nvim',
		event = 'VimEnter',
		config = function()
			require('noice').setup({
				cmdline = {
					enabled = true,
					format = {
						cmdline = { icon = '>' },
						search_down = { icon = '🔍⌄' },
						search_up = { icon = '🔍⌃' },
						filter = { icon = '$' },
						lua = { icon = '☾' },
						help = { icon = '?' },
					},
				},
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins **Treesitter**
					override = {
						['vim.lsp.util.convert_input_to_markdown_lines'] = true,
						['vim.lsp.util.stylize_markdown'] = true,
						['cmp.entry.get_documentation'] = true,
					},
				},
				notify = {
					enabled = false,
				},
				messages = {
					enabled = false,
				},
				-- you can enable a preset for easier configuration
				presets = {
					bottom_search = true, -- a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = false, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = false, -- add a border to hover docs and signature help
				},
			})
		end,
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module='...'` entries
			'MunifTanjim/nui.nvim',
			-- 'rcarriga/nvim-notify',
			'hrsh7th/nvim-cmp',
			'nvim-treesitter/nvim-treesitter',
			'nvim-tree/nvim-web-devicons',
		},
	},
	-- Theme: icons

  'fgheng/winbar.nvim',

  'rlane/pounce.nvim',

  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
  },

  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {
      file_types = {
        'markdown',
        'Avante',
        'AvanteInput',
        'codecompanion',
        'CopilotChat',
      },
    },
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' },
    ft = {
      'markdown',
      'Avante',
      'AvanteInput',
      'codecompanion'
    },
  },

  {
    'robitx/gp.nvim',
    config = function()
      local conf = {
        openai_api_key = os.getenv('OPENAI_API_KEY'),

        default_command_agent = 'CodeGemini',
        default_chat_agent = 'CodeGemini',

        providers = {
          googleai = {
            disable = false,
            endpoint = 'https://generativelanguage.googleapis.com/v1beta/models/{{model}}:streamGenerateContent?key={{secret}}',
            secret = os.getenv('GOOGLEAI_API_KEY'),
          },
        },

        agents = {
          {
            name = 'ChatGPT4o',
            chat = true,
            command = false,
            -- string with model name or table with model name and parameters
            model = { model = 'gpt-4o', temperature = 1.1, top_p = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = require('gp.defaults').chat_system_prompt,
          },
          {
            provider = 'openai',
            name = 'ChatGPT4o-mini',
            chat = true,
            command = false,
            -- string with model name or table with model name and parameters
            model = { model = 'gpt-4o-mini', temperature = 1.1, top_p = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = require('gp.defaults').chat_system_prompt,
          },
          {
            provider = 'googleai',
            name = 'ChatGemini',
            chat = true,
            command = false,
            -- string with model name or table with model name and parameters
            -- model = { model = 'gemini-pro', temperature = 1.1, top_p = 1 },
            -- model = { model = 'gemini-2.0-flash-exp', temperature = 1.1, top_p = 1 },
            -- model = { model = 'gemini-exp-1206', temperature = 1.1, top_p = 1 },
            model = { model = 'gemini-2.0-flash-thinking-exp-1219', temperature = 1.1, top_p = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = require('gp.defaults').chat_system_prompt,
          },
        },

        hooks = {
          -- example of adding command which writes unit tests for the selected code
          UnitTests = function(gp, params)
            local template = 'I have the following code from {{filename}}:\n\n'
            .. '```{{filetype}}\n{{selection}}\n```\n\n'
            .. 'Please respond by writing table driven unit tests for the code above.'
            local agent = gp.get_command_agent()
            gp.Prompt(params, gp.Target.vnew, agent, template)
          end,

          -- example of adding command which explains the selected code
          Explain = function(gp, params)
            local template = 'I have the following code from {{filename}}:\n\n'
            .. '```{{filetype}}\n{{selection}}\n```\n\n'
            .. 'Please respond by explaining the code above.'
            local agent = gp.get_chat_agent()
            gp.Prompt(params, gp.Target.popup, agent, template)
          end,

          -- example of usig enew as a function specifying type for the new buffer
          CodeReview = function(gp, params)
            local template = 'I have the following code from {{filename}}:\n\n'
            .. '```{{filetype}}\n{{selection}}\n```\n\n'
            .. 'Please analyze for code smells and suggest improvements.'
            local agent = gp.get_chat_agent()
            gp.Prompt(params, gp.Target.enew('markdown'), agent, template)
          end,

          -- example of adding command which opens new chat dedicated for translation
          Translator = function(gp, params)
            local chat_system_prompt = 'You are a Translator, please translate between English and Chinese.'
            gp.cmd.ChatNew(params, chat_system_prompt)

            -- -- you can also create a chat with a specific fixed agent like this:
            -- local agent = gp.get_chat_agent('ChatGPT4o')
            -- gp.cmd.ChatNew(params, chat_system_prompt, agent)
          end,

        },
      }
      require('gp').setup(conf)

      -- Setup shortcuts here (see Usage > Shortcuts in the Documentation/Readme)
    end,
  },

  'NoahTheDuke/vim-just',

  {
    'javiorfo/nvim-nyctophilia',
    lazy = false,
    init = function()
      -- Available themes: nox, umbra, nebula and tenebra
      -- vim.cmd[[colorscheme nox]]
    end
  },

  -- {
  --   "folke/edgy.nvim",
  --   event = "VeryLazy",
  --   opts = {}
  -- },
  {
    'saghen/blink.compat',
    -- use the latest release, via version = '*', if you also use the latest release for blink.cmp
    version = '*',
    -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
    lazy = true,
    -- make sure to set opts so that lazy.nvim calls blink.compat's setup
    opts = {
    },
  },
  {
    'saghen/blink.cmp',
    dependencies = {
      'rafamadriz/friendly-snippets',
      'giuxtaposition/blink-cmp-copilot',
    },

    version = 'v0.*',

    lazy = false,

    opts = {
      enabled = function()
        return not vim.tbl_contains({
          'AvanteInput',
          'copilot-chat',
          'markdown',
          'codecompanion',
          'CopilotChat',
        }, vim.bo.filetype) and vim.bo.buftype ~= 'prompt' and vim.b.completion ~= false
      end,

      keymap = {
        preset = 'default',

        ['<CR>'] = { 'accept', 'fallback' },
        ['<C-e>'] = { 'select_and_accept', 'fallback' },
        ['<C-j>'] = { 'snippet_forward', 'fallback' },
        ['<C-k>'] = { 'snippet_backward', 'fallback' },
      },

      snippets = {
        expand = function(snippet) require('luasnip').lsp_expand(snippet) end,
        active = function(filter)
          if filter and filter.direction then
            return require('luasnip').jumpable(filter.direction)
          end
          return require('luasnip').in_snippet()
        end,
        jump = function(direction) require('luasnip').jump(direction) end,
      },

      completion = {

        trigger = {
          show_on_keyword = true,
          -- show_on_trigger_character = true,
          -- show_on_insert_on_trigger_character = true,
          -- show_on_accept_on_trigger_character = true,
        },

        list = {
          selection = function(ctx)
            return ctx.mode == 'cmdline' and 'auto_insert' or 'preselect'
          end
        },

        menu = {

          draw = {
            components = {
              kind_icon = {
                ellipsis = false,
                text = function(ctx)
                  local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                  return kind_icon
                end,
                -- Optionally, you may also use the highlights from mini.icons
                highlight = function(ctx)
                  local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                  return hl
                end,
              }
            }
          },

          auto_show = function(ctx) return ctx.mode ~= 'cmdline' end,
          scrollbar = false,
          border = {
            { '󱐋', 'WarningMsg' },
            '─',
            '╮',
            '│',
            '╯',
            '─',
            '╰',
            '│',
          },
        },
        documentation = {
          auto_show_delay_ms = 500,
          auto_show = true,
          treesitter_highlighting = true,
          window = {
            border = {
              { '', 'DiagnosticHint' },
              '─',
              '╮',
              '│',
              '╯',
              '─',
              '╰',
              '│',
            },
          },
        },
        ghost_text = {
          enabled = false,
        },
      },

      sources = {
        default = function(ctx)
          local success, node = pcall(vim.treesitter.get_node)
          if vim.bo.filetype == 'lua' then
            return { 'lsp', 'path' }
          elseif success and node and vim.tbl_contains({ 'comment', 'line_comment', 'block_comment' }, node:type()) then
            return { 'buffer' }
          else
            return {
              'lsp',
              'path',
              'cmdline',
              'snippets',
              'buffer',
              'copilot',
              'avante_commands',
              'avante_mentions',
              'avante_files',
             }
          end
        end,
        -- cmdline = {},
        providers = {
          avante_commands = {
            name = 'avante_commands',
            module = 'blink.compat.source',
            score_offset = 90, -- show at a higher priority than lsp
            opts = {},
          },
          avante_files = {
            name = 'avante_commands',
            module = 'blink.compat.source',
            score_offset = 100, -- show at a higher priority than lsp
            opts = {},
          },
          avante_mentions = {
            name = 'avante_mentions',
            module = 'blink.compat.source',
            score_offset = 1000, -- show at a higher priority than lsp
            opts = {},
          },
          -- dadbod = {
          --   name = 'Dadbod',
          --   module = 'vim_dadbod_completion.blink',
          --   score_offset = 950,
          -- },
          copilot = {
            enabled = function()
              return not vim.tbl_contains({ 'scala', 'sbt', 'java', 'dart' }, vim.bo.filetype) and vim.bo.buftype ~= 'prompt'
            end,
            name = 'copilot',
            module = 'blink-cmp-copilot',
            score_offset = 2000,
            async = true,
            transform_items = function(_, items)
              local CompletionItemKind = require('blink.cmp.types').CompletionItemKind
              local kind_idx = #CompletionItemKind + 1
              CompletionItemKind[kind_idx] = 'Copilot'
              for _, item in ipairs(items) do
                item.kind = kind_idx
              end
              return items
            end,
          },
        },
      },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono',
        -- Blink does not expose its default kind icons so you must copy them all (or set your custom ones) and add Copilot
        kind_icons = {
          Copilot = '',
          Text = '󰉿',
          Method = '󰊕',
          Function = '󰊕',
          Constructor = '󰒓',

          Field = '󰜢',
          Variable = '󰆦',
          Property = '󰖷',

          Class = '󱡠',
          Interface = '󱡠',
          Struct = '󱡠',
          Module = '󰅩',

          Unit = '󰪚',
          Value = '󰦨',
          Enum = '󰦨',
          EnumMember = '󰦨',

          Keyword = '󰻾',
          Constant = '󰏿',

          Snippet = '󱄽',
          Color = '󰏘',
          File = '󰈔',
          Reference = '󰬲',
          Folder = '󰉋',
          Event = '󱐋',
          Operator = '󰪚',
          TypeParameter = '󰬛',
        },
      },

      signature = {
        enabled = true,
        window = {
          border = {
            { '', 'DiagnosticHint' },
            '─',
            '╮',
            '│',
            '╯',
            '─',
            '╰',
            '│',
          },
        },

      },

    },
    opts_extend = { 'sources.default' }
  },

  {
    'CopilotC-Nvim/CopilotChat.nvim',
    -- version = 'v3.3.0', -- Use a specific version to prevent breaking changes
    dependencies = {
      { 'nvim-telescope/telescope.nvim' }, -- Use telescope for help actions
      { 'nvim-lua/plenary.nvim' },
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    opts = {
      question_header = '## User ',
      answer_header = '## Copilot ',
      error_header = '## Error ',
      prompts = {
        -- Code related prompts
        Explain = 'Please explain how the following code works.',
        Review = 'Please review the following code and provide suggestions for improvement.',
        Tests = 'Please explain how the selected code works, then generate unit tests for it.',
        Refactor = 'Please refactor the following code to improve its clarity and readability.',
        FixCode = 'Please fix the following code to make it work as intended.',
        FixError = 'Please explain the error in the following text and provide a solution.',
        BetterNamings = 'Please provide better names for the following variables and functions.',
        Documentation = 'Please provide documentation for the following code.',
        SwaggerApiDocs = 'Please provide documentation for the following API using Swagger.',
        SwaggerJsDocs = 'Please write JSDoc for the following API using Swagger.',
        -- Text related prompts
        Summarize = 'Please summarize the following text.',
        Spelling = 'Please correct any grammar and spelling errors in the following text.',
        Wording = 'Please improve the grammar and wording of the following text.',
        Concise = 'Please rewrite the following text to make it more concise.',
      },
      auto_follow_cursor = false, -- Don't follow the cursor after getting response
      mappings = {
        chat_autocomplete = false,
        -- Use tab for completion
        complete = {
          detail = 'Use @<C-space> or /<C-space> for options.',
          insert = '<C-space>',
        },
        -- Close the chat
        close = {
          normal = 'q',
          insert = '',
        },
        -- Reset the chat buffer
        reset = {
          normal = '<C-x>',
          insert = '<C-x>',
        },
        -- Submit the prompt to Copilot
        submit_prompt = {
          normal = '<C-g><C-g>',
          insert = '<C-g><C-g>',
        },
        -- Accept the diff
        accept_diff = {
          normal = '<C-y>',
          insert = '<C-y>',
        },
        -- Show help
        show_help = {
          normal = 'g?',
        },
      },
    },
    config = function(_, opts)
      local chat = require('CopilotChat')
      chat.setup(opts)

      local select = require('CopilotChat.select')
      vim.api.nvim_create_user_command('CopilotChatVisual', function(args)
        chat.ask(args.args, { selection = select.visual })
      end, { nargs = '*', range = true })

      -- Inline chat with Copilot
      vim.api.nvim_create_user_command('CopilotChatInline', function(args)
        chat.ask(args.args, {
          selection = select.visual,
          window = {
            layout = 'float',
            relative = 'cursor',
            width = 1,
            height = 0.4,
            row = 1,
          },
        })
      end, { nargs = '*', range = true })

      -- Restore CopilotChatBuffer
      vim.api.nvim_create_user_command('CopilotChatBuffer', function(args)
        chat.ask(args.args, { selection = select.buffer })
      end, { nargs = '*', range = true })

      -- Custom buffer for CopilotChat
      vim.api.nvim_create_autocmd('BufEnter', {
        pattern = 'copilot-*',
        callback = function()
          vim.opt_local.relativenumber = true
          vim.opt_local.number = true

          -- Get current filetype and set it to markdown if the current filetype is copilot-chat
          local ft = vim.bo.filetype
          if ft == 'copilot-chat' then
            vim.bo.filetype = 'markdown'
          end
        end,
      })
    end,
    event = 'VeryLazy',
    keys = {
      -- Show prompts actions with telescope
      {
        '<leader>gp',
        function()
          local actions = require('CopilotChat.actions')
          require('CopilotChat.integrations.telescope').pick(actions.prompt_actions())
        end,
        desc = 'CopilotChat - Prompt actions',
      },
      {
        '<leader>gp',
        ':lua require("CopilotChat.integrations.telescope").pick(require("CopilotChat.actions").prompt_actions({selection = require("CopilotChat.select").visual}))<CR>',
        mode = 'x',
        desc = 'CopilotChat - Prompt actions',
      },
      -- Code related commands
      { '<leader>ge', '<cmd>CopilotChatExplain<cr>', desc = 'CopilotChat - Explain code' },
      { '<leader>gt', '<cmd>CopilotChatTests<cr>', desc = 'CopilotChat - Generate tests' },
      { '<leader>gr', '<cmd>CopilotChatReview<cr>', desc = 'CopilotChat - Review code' },
      { '<leader>gR', '<cmd>CopilotChatRefactor<cr>', desc = 'CopilotChat - Refactor code' },
      { '<leader>gn', '<cmd>CopilotChatBetterNamings<cr>', desc = 'CopilotChat - Better Naming' },
      -- Chat with Copilot in visual mode
      {
        '<leader>gv',
        ':CopilotChatVisual',
        mode = 'x',
        desc = 'CopilotChat - Open in vertical split',
      },
      {
        '<leader>gx',
        ':CopilotChatInline<cr>',
        mode = 'x',
        desc = 'CopilotChat - Inline chat',
      },
      -- Custom input for CopilotChat
      {
        '<leader>gi',
        function()
          local input = vim.fn.input('Ask Copilot: ')
          if input ~= '' then
            vim.cmd('CopilotChat ' .. input)
          end
        end,
        desc = 'CopilotChat - Ask input',
      },
      -- Generate commit message based on the git diff
      {
        '<leader>gm',
        '<cmd>CopilotChatCommit<cr>',
        desc = 'CopilotChat - Generate commit message for all changes',
      },
      -- Quick chat with Copilot
      {
        '<leader>gq',
        function()
          local input = vim.fn.input('Quick Chat: ')
          if input ~= '' then
            vim.cmd('CopilotChatBuffer ' .. input)
          end
        end,
        desc = 'CopilotChat - Quick chat',
      },
      { '<leader>gd', '<cmd>CopilotChatDebugInfo<cr>', desc = 'CopilotChat - Debug Info' },
      { '<leader>gf', '<cmd>CopilotChatFixDiagnostic<cr>', desc = 'CopilotChat - Fix Diagnostic' },
      { '<leader>gl', '<cmd>CopilotChatReset<cr>', desc = 'CopilotChat - Clear buffer and chat history' },
      { '<leader>gv', '<cmd>CopilotChatToggle<cr>', desc = 'CopilotChat - Toggle' },
      { '<leader>g?', '<cmd>CopilotChatModels<cr>', desc = 'CopilotChat - Select Models' },
      { '<leader>gs', '<cmd>CopilotChatStop<cr>',  desc = 'AI Stop'  },
      { '<leader>ga', '<cmd>CopilotChatToggle<cr>',  desc = 'AI Toggle'  },
    },
  },

  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      -- provider = 'gemini-2.0-flash-exp',
      -- provider = 'gemini-exp-1206',
      provider = 'gemini-2.0-flash-thinking-exp-1219',
      auto_suggestions_provider = 'copilot',
      openai = {
        -- endpoint = 'https://api.openai.com/v1/chat/completions',
        model = 'gpt-4o',
        temperature = 1.1,
        max_tokens = 4096,
      },
      vendors = {
        ['gemini-2.0-flash-thinking-exp-1219'] = {
          __inherited_from = 'gemini',
          endpoint = 'https://generativelanguage.googleapis.com/v1beta/models',
          -- model = 'gemini-2.0-flash-exp',
          -- model = 'gemini-exp-1206',
          model = 'gemini-2.0-flash-thinking-exp-1219',
          timeout = 30000, -- Timeout in milliseconds
          temperature = 1.1,
          max_tokens = 4096,
        },
      },
      file_selector = {
        provider = 'telescope',
        -- Options override for custom providers
        provider_opts = {},
      },
      behaviour = {
        close = { 'q' },
        auto_focus_sidebar = true,
        auto_suggestions_respect_ignore = true,
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = 'make',
    -- build = 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false' -- for windows
    dependencies = {
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      --- The below dependencies are optional,
      'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
      {
        'zbirenbaum/copilot.lua',
        cmd = 'Copilot',
        event = 'InsertEnter',
        config = function()
          require('copilot').setup({
            suggestion = { enabled = false },
            panel = { enabled = false },
            filetypes = {
              scala = true, -- allow specific filetype
              -- javascript = true, -- allow specific filetype
              -- typescript = true, -- allow specific filetype
              -- dart = true, -- allow specific filetype
              ['*'] = false, -- disable for all other filetypes and ignore default `filetypes`
            },
          })

        end,
      }, -- for providers='copilot'
      {
         -- support for image pasting
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
    },
  },

  {
    'brenoprata10/nvim-highlight-colors',
    config = function()
      require('nvim-highlight-colors').setup({})
    end,
  },

	{
		'nvim-tree/nvim-web-devicons',
		-- module = 'nvim-web-devicons',
		config = function()
			require('nvim-web-devicons').setup({})
		end,
	},
	config = {
		max_jobs = max_jobs,
		luarocks = {
			python_cmd = 'python3',
		},
		display = {},
	},
  ui = {
    border = 'single',
  },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})
