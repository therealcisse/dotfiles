local setup = {
	"c",
	"cpp",
	"html",
	"css",
	"json",
	"zig",
	"python",
	"rust",
	"solidity",
	"lua",
	"javascript",
	"javascriptreact",
	"typescript",
	"typescriptreact",
	"yaml",
	"sql",
	"sh",
	"scala",
	"go",
	"gomod",
	"java",
	"r",
	"bib",
}

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup lazy_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | Lazy sync
  augroup end
]])

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

local has = function(x)
	return vim.fn.has(x) == 1
end

local executable = function(x)
	return vim.fn.executable(x) == 1
end

local is_mac = has("macunix")

local max_jobs = nil
if is_mac then
	max_jobs = 32
end

local local_ = function(first, second, opts)
	opts = opts or {}

	local plug_path, home
	if second == nil then
		plug_path = first
		home = "tjdevries"
	else
		plug_path = second
		home = first
	end

	if vim.fn.isdirectory(vim.fn.expand("~/plugins/" .. plug_path)) == 1 then
		opts[1] = "~/plugins/" .. plug_path
	else
		opts[1] = string.format("%s/%s", home, plug_path)
	end

	use(opts)
end

local py_ = function(opts)
	if not has("python3") then
		return
	end

	use(opts)
end

return require("lazy").setup({
	-- Alternative to impatient, uses sqlite. Faster ;)
	-- https://github.com/tami5/impatient.nvim
	"lewis6991/impatient.nvim",
	-- My Plugins
	-- local_use('ThePrimeagen', 'refactoring.nvim')

	"TovarishFin/vim-solidity",
	-- { 'tomlion/vim-solidity' }

	-----------------------------------------------------------
	-- {
	--   'SmiteshP/nvim-navic',
	--   dependencies = 'neovim/nvim-lspconfig'
	-- }

	{
		"SmiteshP/nvim-navic",
		module = "nvim-navic",
		config = function()
			vim.g.navic_silence = true
			require("nvim-navic").setup({ separator = " ", highlight = true, depth_limit = 5 })
		end,
	},
	{ "famiu/bufdelete.nvim", cmd = "Bdelete" },
	"ekalinin/Dockerfile.vim",
	"petertriho/nvim-scrollbar",
	{
		"anuvyklack/animation.nvim",
	},
	{
		"nvim-zh/colorful-winsep.nvim",
		config = function()
			require("colorful-winsep").setup()
		end,
	},
	-- {
	--     'glepnir/lspsaga.nvim',
	--     after = 'nvim-lspconfig',
	--     config = function()
	--         require('lspsaga').setup(
	--             {
	--                 border_style = 'rounded',
	--                 code_action = {
	--                     num_shortcut = true,
	--                     keys = {
	--                         -- string |table type
	--                         quit = 'q',
	--                         exec = '<CR>'
	--                     }
	--                 },
	--                 diagnostic = {
	--                     show_code_action = true,
	--                     show_source = true,
	--                     jump_num_shortcut = true,
	--                     keys = {
	--                         exec_action = 'o',
	--                         quit = 'q',
	--                         go_action = 'g'
	--                     }
	--                 },
	--                 lightbulb = {
	--                     enable = false,
	--                     enable_in_insert = false,
	--                     sign = false,
	--                     sign_priority = 40,
	--                     virtual_text = false
	--                 },
	--                 symbol_in_winbar = {
	--                     enable = true
	--                 }
	--             }
	--         )
	--     end,
	--     ft = lsp_filetypes
	-- },
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {

			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },

			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true },
	{
		"theHamsta/nvim-semantic-tokens",
		config = function()
			-- vim.o.winwidth = 5
			-- vim.o.winminwidth = 5
			-- vim.o.equalalways = false

			require("nvim-semantic-tokens").setup({
				preset = "default",
				-- highlighters is a list of modules following the interface of nvim-semantic-tokens.table-highlighter or
				-- function with the signature: highlight_token(ctx, token, highlight) where
				--        ctx (as defined in :h lsp-handler)
				--        token  (as defined in :h vim.lsp.semantic_tokens.on_full())
				--        highlight (a helper function that you can call (also multiple times) with the determined highlight group(s) as the only parameter)
				highlighters = { require("nvim-semantic-tokens.table-highlighter") },
			})
		end,
	},
	{
		"anuvyklack/windows.nvim",
		dependencies = {
			"anuvyklack/middleclass",
			"anuvyklack/animation.nvim",
		},
		config = function()
			-- vim.o.winwidth = 5
			-- vim.o.winminwidth = 5
			-- vim.o.equalalways = false

			require("windows").setup({
				autowidth = {
					enable = false, -- false
					winwidth = 5,
					filetype = {
						help = 2,
					},
				},
				ignore = {
					buftype = { "quickfix" },
					filetype = {
						"undotree",
						"gundo",
						"NvimTree",
						"neo-tree",
						"Outline", -- simrat39/symbols-outline.nvim
					},
				},
				animation = {
					enable = true,
					duration = 300,
					fps = 30,
					easing = "in_out_sine", ---@diagnostic disable-line
				},
			})
		end,
	},
	-- {
	--   'ggandor/leap.nvim',
	--   config = function()
	--     for _, _1_ in ipairs(
	--       {
	--         {{'n', 'x', 'o'}, 'f', '<Plug>(leap-forward-to)'},
	--         {{'n', 'x', 'o'}, 'F', '<Plug>(leap-backward-to)'},
	--         {{'x', 'o'}, 'x', '<Plug>(leap-forward-till)'},
	--         {{'x', 'o'}, 'X', '<Plug>(leap-backward-till)'},
	--         {{'n', 'x', 'o'}, 'gs', '<Plug>(leap-cross-window)'}
	--       }
	--     ) do
	--       local _each_2_ = _1_
	--       local modes = _each_2_[1]
	--       local lhs = _each_2_[2]
	--       local rhs = _each_2_[3]
	--       for _0, mode in ipairs(modes) do
	--         if (force_3f or ((vim.fn.mapcheck(lhs, mode) == '') and (vim.fn.hasmapto(rhs, mode) == 0))) then
	--           vim.keymap.set(mode, lhs, rhs, {silent = true})
	--         else
	--         end
	--       end
	--     end
	--     -- require('leap').add_default_mappings()
	--   end
	--
	--
	-- }

	-- {
	--   'jcdickinson/codeium.nvim',
	--   dependencies = {
	--     'nvim-lua/plenary.nvim',
	--     'MunifTanjim/nui.nvim',
	--     'hrsh7th/nvim-cmp',
	--   },
	--   config = function()
	--     require('codeium').setup({
	--     })
	--   end
	-- },

	-- {
	--   'Exafunction/codeium.vim',
	--   event = 'BufEnter',
	--   config = function ()
	--     vim.g.codeium_disable_bindings = 1
	--
	--     -- Change '<C-g>' here to any keycode you like.
	--     vim.keymap.set('i', '<C-g>', function () return vim.fn['codeium#Accept']() end, { expr = true })
	--     vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
	--     vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
	--     vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
	--   end,
	-- },

	"mustache/vim-mustache-handlebars",
	-- {
	--   'jackMort/ChatGPT.nvim',
	--   event = 'VeryLazy',
	--   config = function()
	--     require('chatgpt').setup({
	--       api_key_cmd = 'op read op://private/ChatGPT/password --no-newline'
	--     })
	--   end,
	--   dependencies = {
	--     'MunifTanjim/nui.nvim',
	--     'nvim-lua/plenary.nvim',
	--     'nvim-telescope/telescope.nvim'
	--   }
	-- },

	{
		"levouh/tint.nvim",
	},
	-- { 'typicode/bg.nvim', lazy = false },

	-- {
	--     'lvimuser/lsp-inlayhints.nvim',
	--     config = function()
	--         local config = {
	--             inlay_hints = {
	--                 parameter_hints = {
	--                     show = true,
	--                     separator = ', '
	--                 },
	--                 type_hints = {
	--                     show = true,
	--                     prefix = '',
	--                     separator = ', ',
	--                     remove_colon_end = false,
	--                     remove_colon_start = false
	--                 },
	--                 labels_separator = '  ',
	--                 max_len_align = false,
	--                 max_len_align_padding = 1,
	--                 right_align = false,
	--                 right_align_padding = 7,
	--                 highlight = 'Comment'
	--             },
	--             debug_mode = false
	--         }
	--
	--         require('lsp-inlayhints').setup(config)
	--     end
	-- }

	-- 'RRethy/vim-illuminate'
	"tpope/vim-fugitive",
	"DataWraith/auto_mkdir",
	"tpope/vim-unimpaired",
	-- { 'justinmk/vim-dirvish'},
	-- { 'kristijanhusak/vim-dirvish-git'},
	"tommcdo/vim-lion", -- Align = gl, gL
	"tpope/vim-eunuch", --  =SudoWrite, ...
	-- J
	{ "FooSoft/vim-argwrap", cmd = { "ArgWrap" } },
	"matze/vim-move", -- <c-k>, <c-j>
	"vim-scripts/ReplaceWithRegister", -- replace <motion> with register
	-- { 'fenetikm/falcon' },
	-- 'folke/tokyonight.nvim',

	{ "EdenEast/nightfox.nvim" },
	{
		"ethanholz/nvim-lastplace",
		event = "BufRead",
		config = function()
			require("nvim-lastplace").setup({
				lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
				lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
				lastplace_open_folds = true,
			})
		end,
	},
	-- { "folke/neodev.nvim", opts = {} },
	{
		"scalameta/nvim-metals",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-telescope/telescope-dap.nvim",
			"leoluz/nvim-dap-go",
			"LiadOz/nvim-dap-repl-highlights",
		},
		config = function(self, opts)

			require("dapui").setup()
			require("dap-go").setup()
			-- require('nvim-dap-virtual-text').setup()

			require("nvim-dap-repl-highlights").setup()
		end,
	},
	"JASONews/glow-hover",
	{ "kana/vim-textobj-entire", dependencies = { { "kana/vim-textobj-user" } } }, -- ae, ie
	{ "kana/vim-textobj-indent", dependencies = { { "kana/vim-textobj-user" } } }, -- ai, ii
	{ "kana/vim-textobj-line", dependencies = { { "kana/vim-textobj-user" } } }, -- al, il
	{ "coderifous/textobj-word-column.vim", dependencies = { { "kana/vim-textobj-user" } } }, -- ic, ac, iC, and aC or vic, cic, and daC
	{ "mattn/vim-textobj-url", dependencies = { { "kana/vim-textobj-user" } } }, -- au, iu
	-----------------------------------------------------------

	-- Contributor Plugins
	"L3MON4D3/LuaSnip",
	-- When I have some extra time...
	--local_'train.vim'
	--local_'command_and_conquer.nvim'
	--local_'streamer.nvim'
	--local_'bandaid.nvim'

	-- LSP Plugins:

	-- NOTE: lspconfig ONLY has configs, for people reading this :)
	{ "luc-tielen/telescope_hoogle" },
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason-lspconfig.nvim" },
			{ "williamboman/mason.nvim" },
		},
	},
	{ "Vigemus/iron.nvim" },
	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			{ "kevinhwang91/promise-async" },
		},
	},
	"williamboman/nvim-lsp-installer",
	-- 'wbthomason/lsp-status.nvim',

	{
		"j-hui/fidget.nvim",
		module = "fidget",
		tag = "legacy",
		config = function()
			require("fidget").setup({
				window = {
					relative = "editor",
				},
			})
			-- HACK: prevent error when exiting Neovim
			vim.api.nvim_create_autocmd("VimLeavePre", { command = [[silent! FidgetClose]] })
		end,
	},
	{
		"ericpubu/lsp_codelens_extensions.nvim",
		config = function()
			require("codelens_extensions").setup()
		end,
	},
	"jose-elias-alvarez/null-ls.nvim",
	"nvim-lua/lsp_extensions.nvim",
	-- 'onsails/lspkind-nvim',
	"justinsgithub/wezterm-types",
	-- 'glepnir/lspsaga.nvim',
	-- https://github.com/rmagatti/goto-preview

	{ "dart-lang/dart-vim-plugin" },
	{ "akinsho/flutter-tools.nvim" },
	"simrat39/rust-tools.nvim",
	-- 'ray-x/go.nvim',
	-- 'ray-x/guihua.lua',
	"jose-elias-alvarez/nvim-lsp-ts-utils",
	{
		"folke/trouble.nvim",
		event = "BufReadPre",
		module = "trouble",
		cmd = { "TroubleToggle", "Trouble" },
		config = function()
			require("trouble").setup({
				auto_open = false,
				use_diagnostic_signs = true, -- en
			})
		end,
	},
	{
		"monkoose/matchparen.nvim",
		branch = "main",
		config = function()
			require("matchparen").setup({
				on_startup = true, -- Should it be enabled by default
				hl_group = "MatchParen", -- highlight group for matched characters
				augroup_name = "matchparen", -- almost no reason to touch this unless there is already augroup with such name
			})
		end,
	},
	{
		"rmagatti/goto-preview",
		config = function()
			require("goto-preview").setup({})
		end,
	},
	{ "wincent/pinnacle" },
	{
		"gbprod/stay-in-place.nvim",
		config = function()
			require("stay-in-place").setup({})
		end,
	},
	{
		"stevearc/overseer.nvim",
		config = function()
			require("overseer").setup()
		end,
	},
	{
		"anuvyklack/fold-preview.nvim",
		dependencies = "anuvyklack/keymap-amend.nvim",
		config = function()
			require("fold-preview").setup()
		end,
	},
	-- use({
	--   'zakharykaplan/nvim-retrail',
	--   config = function()
	--     require('retrail').setup()
	--   end,
	-- })

	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		config = function()
			require("lsp_lines").setup()
		end,
	},
	{ "stevearc/dressing.nvim", event = "User PackerDefered" },
	{
		"rcarriga/nvim-notify",
		-- event = 'User PackerDefered',
		config = function()
			require("notify").setup({ level = vim.log.levels.INFO, fps = 20 })
			vim.notify = require("notify")
		end,
	},
	{
		"vigoux/notifier.nvim",
		config = function()
			require("notifier").setup({})
		end,
	},
	-- TODO: Investigate
	-- 'jose-elias-alvarez/nvim-lsp-ts-utils',

	"nvim-lua/popup.nvim",
	"nvim-lua/plenary.nvim",
	"nvim-telescope/telescope.nvim",
	"nvim-telescope/telescope-rs.nvim",
	"nvim-telescope/telescope-fzf-writer.nvim",
	"nvim-telescope/telescope-fzy-native.nvim",
	"nvim-telescope/telescope-github.nvim",
	"nvim-telescope/telescope-symbols.nvim",
	"Marskey/telescope-sg",
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	{ "nvim-telescope/telescope-hop.nvim" },
	{ "nvim-telescope/telescope-file-browser.nvim" },
	{ "nvim-telescope/telescope-ui-select.nvim" },
	{
		"Shatur/neovim-ayu",
		config = function()
			require("ayu").setup({
				overrides = {},
			})
		end,
	},
	{ "nvim-telescope/telescope-live-grep-args.nvim" },
	-- local_use('nvim-telescope', 'telescope-async-sorter-test.nvim')

	{
		"AckslD/nvim-neoclip.lua",
		config = function()
			require("neoclip").setup()
		end,
	},
	-- TODO: When i'm back w/ some npm stuff, get this working.
	-- elianiva/telescope-npm.nvim

	--local_'telescope-hacks.nvim'
	-- local_'sg.nvim'
	--local_'green_light.nvim'

	-- 'vimwiki/vimwiki'

	-- TODO: Need to figure out how to install all of this stuff on mac
	-- if not is_mac then
	--    {'tami5/sql.nvim', rocks = {'sqlite', 'luv'}}
	--    {'nvim-telescope/telescope-smart-history.nvim'}
	--     'nvim-telescope/telescope-frecency.nvim'
	--    'nvim-telescope/telescope-cheat.nvim'
	--    {'nvim-telescope/telescope-arecibo.nvim', rocks = {'openssl', 'lua-http-parser'}}
	-- end

	-- {
	--     'NTBBloodbath/rest.nvim',
	--     config = function()
	--         require('rest-nvim').setup()
	--     end
	-- },

	-- {
	--   'antoinemadec/FixCursorHold.nvim',
	--   run = function()
	--     vim.g.curshold_updatime = 1000
	--   end,
	-- },

	"nanotee/luv-vimdocs",
	"milisims/nvim-luaref",
	-- PRACTICE:
	{
		"tpope/vim-projectionist", -- STREAM: Alternate file editting and some helpful stuff,
		enable = false,
	},
	-- For narrowing regions of text to look at them alone
	{
		"chrisbra/NrrwRgn",
		cmd = { "NarrowRegion", "NarrowWindow" },
	},
	-- {
	--   'luukvbaal/stabilize.nvim',
	--   config = function()
	--     require('stabilize').setup()
	--   end,
	-- },

	"tweekmonster/spellrotate.vim",
	"haya14busa/vim-metarepeat", -- Never figured out how to this, but looks like fun.
	--
	-- VIM EDITOR:

	-- Little know features:
	--   :SSave
	--   :SLoad
	--       These are wrappers for mksession that work great. I never have to use
	--       mksession anymore or worry about where things are saved / loaded from.
	{
		"mhinz/vim-startify",
		-- cmd = { 'SLoad', 'SSave' },
		config = function()
			vim.g.startify_disable_at_vimenter = false
		end,
	},
	-- Better profiling output for startup.
	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
	},
	-- Pretty colors
	"norcalli/nvim-colorizer.lua",
	{
		"norcalli/nvim-terminal.lua",
		config = function()
			require("terminal").setup()
		end,
	},
	-- Make comments appear IN YO FACE
	-- {
	--   'tjdevries/vim-inyoface',
	--   config = function()
	--     vim.api.nvim_set_keymap('n', '<leader>cc', '<Plug>(InYoFace_Toggle)', {})
	--   end,
	-- },

	-- Show only what you're searching for.
	-- STREAM: Could probably make this a bit better. Definitely needs docs
	-- 'tjdevries/fold_search.vim',

	{
		"tweekmonster/haunted.vim",
		cmd = "Haunt",
	},
	{
		"tpope/vim-scriptease",
		cmd = {
			"Messages", --view messages in quickfix list
			"Verbose", -- view verbose output in preview window.
			"Time", -- measure how long it takes to build some stuff.
		},
	},
	-- Quickfix enhancements. See :help vim-qf
	"romainl/vim-qf",
	{
		"glacambre/firenvim",
		build = function()
			vim.fn["firenvim#install"](0)
		end,
	},
	-- TODO: Eventually statusline should consume this.
	"mkitt/tabline.vim",
	-- TODO: This would be cool to add back, but it breaks sg.nvim for now.
	-- 'lambdalisue/vim-protocol'

	-- Undo helper
	"sjl/gundo.vim",
	-- Crazy good box drawing
	"gyim/vim-boxdraw",
	-- Better increment/decrement
	"monaqa/dial.nvim",
	--   FOCUSING:
	-- local use_folke = true
	-- if use_folke then
	--   'folke/zen-mode.nvim'
	--   'folke/twilight.nvim'
	-- else
	--   {
	--     'junegunn/goyo.vim',
	--     cmd = 'Goyo',
	--     disable = use_folke,
	--   }
	--
	--   {
	--     'junegunn/limelight.vim',
	--     after = 'goyo.vim',
	--     disable = use_folke,
	--   }
	-- end

	--
	--
	--  LANGUAGE:
	-- TODO: Should check on these if they are the best ones
	{ "neovimhaskell/haskell-vim", ft = "haskell" },
	{ "elzr/vim-json", ft = "json" },
	{ "goodell/vim-mscgen", ft = "mscgen" },
	"PProvost/vim-ps1",
	"Glench/Vim-Jinja2-Syntax",
	"justinmk/vim-syntax-extra",
	-- 'pearofducks/ansible-vim',
	-- { 'cespare/vim-toml', ft = 'toml' },

	{ "ziglang/zig.vim", ft = "zig" },
	-- { 'JuliaEditorSupport/julia-vim', ft = 'julia' },

	-- { 'iamcco/markdown-preview.nvim', ft = 'markdown', build = 'cd app && yarn install' },
	{ "simaxme/java.nvim" },
	{ "dmmulroy/tsc.nvim" },
	{ "nanotee/sqls.nvim" },
	{ "mfussenegger/nvim-jdtls" },

	"haya14busa/is.vim",
	"osyo-manga/vim-anzu",
	"haya14busa/vim-asterisk",
	-- Typescript
	-- if false then
	"jelera/vim-javascript-syntax",
	"othree/javascript-libraries-syntax.vim",
	"leafgarland/typescript-vim",
	"peitalin/vim-jsx-typescript",
	{ "vim-scripts/JavaScript-Indent", ft = "javascript" },
	{ "pangloss/vim-javascript", ft = { "javascript", "html" } },
	-- Godot
	"habamax/vim-godot",
	-- end,

	-- TODO: Turn emmet back on when I someday it
	-- 'mattn/emmet-vim'

	"tpope/vim-liquid",
	-- Sql
	"tpope/vim-dadbod",
	{ "kristijanhusak/vim-dadbod-completion" },
	{ "kristijanhusak/vim-dadbod-ui" },
	--
	-- Lisp
	-- { 'eraserhd/parinfer-rust', build = 'cargo build --release' }
	--
	-- STREAM: Figure out how to snippets better
	--

	-- Completion

	-- Sources
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-nvim-lua",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-nvim-lsp-document-symbol",
	"saadparwaiz1/cmp_luasnip",
	"tamago324/cmp-zsh",
	"ray-x/lsp_signature.nvim",
	"hrsh7th/cmp-nvim-lsp-signature-help",
	-- Comparators
	"lukas-reineke/cmp-under-comparator",
	-- ddc.vim
	--  if executable 'deno' then
	--      'vim-denops/denops.vim'
	--      'lambdalisue/guise.vim'
	--  end

	-- 'Shougo/ddc.vim'
	-- 'Shougo/ddc-nvim-lsp'

	-- coq.nvim
	-- { 'ms-jpq/coq_nvim', branch = 'coq' }

	-- Completion stuff
	-- local_'rofl.nvim'

	-- Cool tags based viewer
	--   :Vista  <-- Opens up a really cool sidebar with info about file.
	-- { "liuchengxu/vista.vim", cmd = "Vista" },
	-- Find and replace
	{
    "windwp/nvim-spectre",
		config = function()
      require('spectre').setup()
		end,
	},
	-- 'mfussenegger/nvim-dap-python',
	-- 'jbyuki/one-small-step-for-vimkind',

	-- 'airblade/vim-gitgutter',

	-- {
	--   'rcarriga/vim-ultest',

	--   enable = false,
	--   dependencies = { 'vim-test/vim-test' },
	--   build = ':UpdateRemotePlugins',
	--   config = function()
	--     vim.cmd [[nmap ]t <Plug>(ultest-next-fail)]]
	--     vim.cmd [[nmap [t <Plug>(ultest-prev-fail)]]
	--   end,
	-- },

	-- TREE SITTER:
	{
		"nvim-treesitter/nvim-treesitter",
		-- build = 'TSUpdate',
		-- commit = 'f2778bd',
		event = "BufReadPost",
		-- commit = '33eb472',
	},
	"nvim-treesitter/nvim-treesitter-context",
	"nvim-treesitter/playground",
	-- 'vigoux/architext.nvim',

	-- TODO: YouTube Highlight
	-- 'danymat/neogen',

	"nvim-treesitter/nvim-treesitter-textobjects",
	-- 'JoosepAlviste/nvim-ts-context-commentstring',
	{
		"mfussenegger/nvim-ts-hint-textobject",
		config = function()
			vim.cmd([[omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>]])
			vim.cmd([[vnoremap <silent> m :lua require('tsht').nodes()<CR>]])
		end,
	},
	-- {
	--   'romgrk/nvim-treesitter-context',
	--   config = function()
	--     require('treesitter-context.config').setup {
	--       enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
	--     }

	--     -- TODO: Decide on a better highlighting color
	--     -- vim.cmd [[highlight TreesitterContext link NormalFloat]]
	--   end,
	-- },

	-- Grammars
	-- local_'tree-sitter-lua'
	-- { 'm-novikov/tree-sitter-sql' }
	-- { 'DerekStride/tree-sitter-sql' }
	-- local_'tree-sitter-sql'

	--
	-- NAVIGATION:
	-- STREAM: Show off edit_alternate.vim
	-- {
	--   'tjdevries/edit_alternate.vim',
	--   config = function()
	--     vim.fn['edit_alternate#rule#add']('go', function(filename)
	--       if filename:find '_test.go' then
	--         return (filename:gsub('_test%.go', '.go'))
	--       else
	--         return (filename:gsub('%.go', '_test.go'))
	--       end
	--     end)
	--
	--     vim.api.nvim_set_keymap('n', '<leader>ea', '<cmd>EditAlternate<CR>', { silent = true })
	--   end,
	-- }

	"google/vim-searchindex",
	"tamago324/lir.nvim",
	"tamago324/lir-git-status.nvim",
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
	"godlygeek/tabular", -- Quickly align text by pattern
	"tpope/vim-repeat", -- Repeat actions better
	"tpope/vim-abolish", -- Cool things with words!
	"tpope/vim-characterize",
	{ "tpope/vim-dispatch", cmd = { "Dispatch", "Make" } },
	-- 'numToStr/Comment.nvim',

	{
		"AndrewRadev/splitjoin.vim",
		keys = { "gJ", "gS" },
	},
	{
		"m-demare/hlargs.nvim",
		event = "User PackerDefered",
		config = function()
			require("hlargs").setup({
				color = require("tokyonight.colors").setup().yellow,
			})
		end,
	},
	{
		"simrat39/symbols-outline.nvim",
		cmd = { "SymbolsOutline" },
		config = function()
			require("symbols-outline").setup()
		end,
		setup = function()
			vim.keymap.set("n", "<leader>cs", "<cmd>SymbolsOutline<cr>", { desc = "Symbols Outline" })
		end,
	},
	-- TODO: Check out macvhakann/vim-sandwich at some point
	-- 'tpope/vim-surround' -- Surround text objects easily

	{
		"kylechui/nvim-surround",
		-- version = '*', -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{ "akinsho/toggleterm.nvim", version = "v2.*" },
	"windwp/nvim-autopairs", -- Auto } }pairs, integrates with both cmp and treesitter
	-- { 'lukas-reineke/indent-blankline.nvim' , main = 'ibl', opts = {} },

	-- { 'm4xshen/autoclose.nvim' },

	--
	-- GIT:
	-- "TimUntersberger/neogit",
	-- Github integration
	--  if vim.fn.executable 'gh' == 1 then
	--      'pwntester/octo.nvim'
	--  end
	-- "ruifm/gitlinker.nvim",
	-- Sweet message committer
	"rhysd/committia.vim",
	-- Floating windows are awesome :)
	{
		"rhysd/git-messenger.vim",
		keys = "<Plug>(git-messenger)",
	},
	-- Async signs!
	"lewis6991/gitsigns.nvim",
	-- use({
	--   'dense-analysis/neural',
	--   config = function()
	--     require('neural').setup({
	--       mappings = {
	--         swift = '<C-.>', -- Context completion
	--         prompt = '<C-space>', -- Open prompt
	--       },
	--       open_ai = {
	--         api_key = os.getenv('OPENAI_API_KEY'),
	--       }
	--     })
	--   end,
	--   dependencies = {
	--     'MunifTanjim/nui.nvim',
	--     'ElPiloto/significant.nvim'
	--   },
	-- })

	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		config = function()
			require("lsp_lines").setup()
		end,
	},

	{
		"nvimdev/guard.nvim",
		-- Builtin configuration, optional
		dependencies = {
			"nvimdev/guard-collection",
		},
	},

	-- Git worktree utility
	-- {
	-- 	"ThePrimeagen/git-worktree.nvim",
	-- 	config = function() end,
	-- },
	{ "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },
	-- {
	--     'ThePrimeagen/harpoon',
	--     dependencies = {'nvim-lua/plenary.nvim'}
	-- },
	-- 'untitled-ai/jupyter_ascending.vim'

	-- 'tjdevries/standard.vim',
	-- 'tjdevries/conf.vim',

	-- {'junegunn/fzf', build = './install --all'},
	-- {'junegunn/fzf.vim'},

	--     if false and vim.fn.executable 'neuron' == 1 then
	--         {
	--             'oberblastmeister/neuron.nvim',
	--             branch = 'unstable',
	--             config = function()
	-- these are all the default values
	--                 require('neuron').setup {
	--                     virtual_titles = true,
	--                     mappings = true,
	--                     build = nil,
	--                     neuron_dir = '~/neuron',
	--                     leader = 'gz'
	--                 }
	--             end
	--        }
	--     end

	-- {
	-- 	"alec-gibson/nvim-tetris",
	-- 	cmd = "Tetris",
	-- },
	-- 'troydm/zoomwintab.vim',

	"levouh/tint.nvim",
	-- use({
	--   'Pocco81/true-zen.nvim',
	--   config = function()
	--     require('true-zen').setup {
	--       -- your config goes here
	--       -- or just leave it empty :)
	--       callbacks = {
	--         open_pre = nil,
	--         open_pos = nil,
	--         close_pre = nil,
	--         close_pos = nil
	--       },
	--       integrations = {
	--         tmux = false, -- hide tmux status bar in (minimalist, ataraxis)
	--         kitty = { -- increment font size in Kitty. Note: you must set `allow_remote_control socket-only` and `listen_on unix:/tmp/kitty` in your personal config (ataraxis)
	--           enabled = true,
	--           font = '+3'
	--         },
	--         twilight = false, -- enable twilight (ataraxis)
	--         lualine = false -- hide nvim-lualine (ataraxis)
	--       },
	--     }
	--   end,
	-- })

	-- {
	--   'nyngwang/NeoNoName.lua',
	--   config = function ()
	--     -- vim.keymap.set('n', '<M-w>', function () vim.cmd('NeoNoName') end, {slient=true, noremap=true, nowait=true})
	--     -- If you are using bufferline.nvim
	--     -- vim.keymap.set('n', '<M-w>', function () vim.cmd('NeoNoNameBufferline') end, {slient=true, noremap=true, nowait=true})
	--   end
	-- }

	-- {
	--   'nyngwang/NeoZoom.lua',
	--   config = function ()
	--     require('neo-zoom').setup { -- the defaults or UNCOMMENT and change any one to overwrite
	--     -- left_ratio = 0.2,
	--     -- top_ratio = 0.03,
	--     -- width_ratio = 0.67,
	--     -- height_ratio = 0.9,
	--     -- border = 'double',
	--       exclude_filetype = {
	--         'fzf',
	--         'qf',
	--         'dashboard',
	--         'telescope'
	--       },
	--     }
	--
	--     local NOREF_NOERR_TRUNC = { silent = true, nowait = true }
	--     vim.keymap.set('n', '<C-CR>', require('neo-zoom').neo_zoom, NOREF_NOERR_TRUNC)
	--
	--     -- My setup (This dependencies NeoNoName.lua, and optionally NeoWell.lua)
	--     local cur_buf = nil
	--     local cur_cur = nil
	--     vim.keymap.set('n', '<C-CR>', function ()
	--       -- Pop-up Effect
	--       if vim.api.nvim_win_get_config(0).relative == '' then
	--         cur_buf = vim.fn.bufnr()
	--         cur_cur = vim.api.nvim_win_get_cursor(0)
	--         if vim.fn.bufname() ~= '' then
	--           vim.cmd('NeoNoName')
	--         end
	--         vim.cmd('NeoZoomToggle')
	--         vim.api.nvim_set_current_buf(cur_buf)
	--         vim.api.nvim_win_set_cursor(0, cur_cur)
	--         vim.cmd('normal! zt')
	--         vim.cmd('normal! 7k7j')
	--         return
	--       end
	--       vim.cmd('NeoZoomToggle')
	--       vim.api.nvim_set_current_buf(cur_buf)
	--       cur_buf = nil
	--       cur_cur = nil
	--       -- vim.cmd('NeoWellJump') -- you can safely remove this line.
	--     end, NOREF_NOERR_TRUNC)
	--   end
	-- }

	-- 'fladson/vim-kitty'

	-- TODO: Figure out why this randomly popups
	--       Figure out if I want to it later as well :)
	-- {
	--   'folke/which-key.nvim',
	--   config = function()
	--     -- TODO: Consider changing my timeoutlen?
	--     require('which-key').setup {
	--       presets = {
	--         g = true,
	--       },
	--     }
	--   end,
	-- }

	-- It would be fun to think about making a wiki again...
	-- local_'wander.nvim'
	-- local_'riki.nvim'

	-- {
	--     'Vhyrro/neorg'
	--     -- branch = 'unstable'
	-- },

	-- {
	--   'smithbm2316/centerpad.nvim'
	-- },

	{ "xiyaowong/transparent.nvim" },
	{
		"tiagovla/tokyodark.nvim",
		opts = {},
		config = function(_, opts)
			require("tokyodark").setup(opts) -- calling setup is optional
			vim.cmd([[colorscheme tokyodark]])
		end,
	},
	{
		"folke/noice.nvim",
		event = "VimEnter",
		config = function()
			require("noice").setup({
				cmdline = {
					enabled = true,
					format = {
						cmdline = { icon = ">" },
						search_down = { icon = "🔍⌄" },
						search_up = { icon = "🔍⌃" },
						filter = { icon = "$" },
						lua = { icon = "☾" },
						help = { icon = "?" },
					},
				},
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
				notify = {
					enabled = true,
				},
				messages = {
					enabled = true,
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
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
			"hrsh7th/nvim-cmp",
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},
	-- Theme: icons

	{
		"nvim-tree/nvim-web-devicons",
		-- module = 'nvim-web-devicons',
		config = function()
			require("nvim-web-devicons").setup({})
		end,
	},
	config = {
		max_jobs = max_jobs,
		luarocks = {
			python_cmd = "python3",
		},
		display = {},
	},
})
