_ = vim.cmd [[packadd packer.nvim]]
_ = vim.cmd [[packadd vimball]]

-- vim.api.nvim_cmd({
--   cmd = "packadd",
--   args = { "packer.vim" },
-- }, {})

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

local has = function(x)
  return vim.fn.has(x) == 1
end

local executable = function(x)
  return vim.fn.executable(x) == 1
end

local is_mac = has "macunix"

local max_jobs = nil
if is_mac then
  max_jobs = 32
end

return require("packer").startup {
  function(use)
    local local_use = function(first, second, opts)
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

    local py_use = function(opts)
      if not has "python3" then
        return
      end

      use(opts)
    end

    use "wbthomason/packer.nvim"

    -- Alternative to impatient, uses sqlite. Faster ;)
    -- use https://github.com/tami5/impatient.nvim
    use "lewis6991/impatient.nvim"

    -- My Plugins
    local_use("ThePrimeagen", "refactoring.nvim")

    use 'TovarishFin/vim-solidity'

    -----------------------------------------------------------
    -- use {
    --   "SmiteshP/nvim-navic",
    --   requires = "neovim/nvim-lspconfig"
    -- }
    use({
      "SmiteshP/nvim-navic",
      module = "nvim-navic",
      config = function()
        vim.g.navic_silence = true
        require("nvim-navic").setup({ separator = " ", highlight = true, depth_limit = 5 })
      end,
    })

    use({ "famiu/bufdelete.nvim", cmd = "Bdelete" })

    use 'ekalinin/Dockerfile.vim'

    use("petertriho/nvim-scrollbar")

    use { "anuvyklack/windows.nvim",
    requires = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim"
    },
    config = function()
      vim.o.winwidth = 5
      vim.o.winminwidth = 5
      vim.o.equalalways = false

      require('windows').setup()
    end
  }

    -- use "RRethy/vim-illuminate"
    use 'tpope/vim-fugitive'

    use 'DataWraith/auto_mkdir'
    use 'tpope/vim-unimpaired'
    -- use { 'justinmk/vim-dirvish'}
    -- use { 'kristijanhusak/vim-dirvish-git'}
    use 'tommcdo/vim-lion' -- Align = gl, gL
    use 'tpope/vim-eunuch' --  =SudoWrite, ...

    use {'FooSoft/vim-argwrap', cmd = {'ArgWrap'}}

    use 'matze/vim-move' -- <c-k>, <c-j>
    use 'vim-scripts/ReplaceWithRegister' -- replace <motion> with register

    -- use { 'fenetikm/falcon' }
    use 'folke/tokyonight.nvim'

    use({
      "ethanholz/nvim-lastplace",
      event = "BufRead",
      config = function()
        require("nvim-lastplace").setup({
          lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
          lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
          lastplace_open_folds = true,
        })
      end,
    })

    use {
      'scalameta/nvim-metals',
      requires = { "nvim-lua/plenary.nvim" }

    }

    use 'JASONews/glow-hover'

    use { 'kana/vim-textobj-entire', requires = {{'kana/vim-textobj-user'}} } -- ae, ie
    use { 'kana/vim-textobj-indent', requires = {{'kana/vim-textobj-user'}} } -- ai, ii
    use { 'kana/vim-textobj-line', requires = {{'kana/vim-textobj-user'}} } -- al, il
    use { 'coderifous/textobj-word-column.vim', requires = {{'kana/vim-textobj-user'}} } -- ic, ac, iC, and aC or vic, cic, and daC
    use { 'mattn/vim-textobj-url', requires = {{'kana/vim-textobj-user'}} } -- au, iu

    -----------------------------------------------------------

    local_use "nlua.nvim"
    local_use "vim9jit"
    local_use "vimterface.nvim"
    -- local_use "colorbuddy.nvim"
    -- local_use "gruvbuddy.nvim"
    local_use "apyrori.nvim"
    local_use "manillua.nvim"
    local_use "cyclist.vim"
    local_use "express_line.nvim"
    -- local_use "overlength.vim"
    local_use "pastery.vim"
    local_use "complextras.nvim"
    local_use "lazy.nvim"
    -- local_use("tjdevries", "astronauta.nvim")
    local_use "diff-therapy.nvim"

    -- Contributor Plugins
    local_use("L3MON4D3", "LuaSnip")

    -- When I have some extra time...
    local_use "train.vim"
    local_use "command_and_conquer.nvim"
    local_use "streamer.nvim"
    local_use "bandaid.nvim"

    -- LSP Plugins:

    -- NOTE: lspconfig ONLY has configs, for people reading this :)
    use "neovim/nvim-lspconfig"
    if is_mac then
      use "williamboman/nvim-lsp-installer"
    end
    -- use "wbthomason/lsp-status.nvim"
    use({
      "j-hui/fidget.nvim",
      module = "fidget",
      config = function()
        require("fidget").setup({
          window = {
            relative = "editor",
          },
        })
        -- HACK: prevent error when exiting Neovim
        vim.api.nvim_create_autocmd("VimLeavePre", { command = [[silent! FidgetClose]] })
      end,
    })

    use {
      "ericpubu/lsp_codelens_extensions.nvim",
      config = function()
        require("codelens_extensions").setup()
      end,
    }
    use "jose-elias-alvarez/null-ls.nvim"

    use "nvim-lua/lsp_extensions.nvim"
    use "onsails/lspkind-nvim"
    -- use "glepnir/lspsaga.nvim"
    -- https://github.com/rmagatti/goto-preview

    use {"dart-lang/dart-vim-plugin"}
    use {"akinsho/flutter-tools.nvim"}

    -- use "/home/tjdevries/plugins/stackmap.nvim"
    -- Plug "/home/bash/plugins/stackmap.nvim"

    use "simrat39/rust-tools.nvim"
    -- use "ray-x/go.nvim"
    -- use "ray-x/guihua.lua"
    use "jose-elias-alvarez/nvim-lsp-ts-utils"

    use({
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
    })

    use {
      'monkoose/matchparen.nvim',
      branch = 'main',
      config = function ()
        require('matchparen').setup({
          on_startup = true, -- Should it be enabled by default
          hl_group = 'MatchParen', -- highlight group for matched characters
          augroup_name = 'matchparen',  -- almost no reason to touch this unless there is already augroup with such name
        })
      end,

    }

    use {
      'rmagatti/goto-preview',
      config = function()
        require('goto-preview').setup {}
      end
    }

    use {'wincent/pinnacle'}

    use({
      "gbprod/stay-in-place.nvim",
      config = function()
        require("stay-in-place").setup({
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        })
      end
    })

    use {
      'stevearc/overseer.nvim',
      config = function() require('overseer').setup() end
    }

    use { 'anuvyklack/fold-preview.nvim',
      requires = 'anuvyklack/keymap-amend.nvim',
      config = function()
        require('fold-preview').setup()
      end
    }

    -- use({
    --   "zakharykaplan/nvim-retrail",
    --   config = function()
    --     require("retrail").setup()
    --   end,
    -- })

    use({
      "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
      config = function()
        require("lsp_lines").setup()
      end,
    })

    use({ "stevearc/dressing.nvim", event = "User PackerDefered" })

    use({
      "rcarriga/nvim-notify",
      -- event = "User PackerDefered",
      config = function()
        require("notify").setup({ level = vim.log.levels.INFO, fps = 20 })
        vim.notify = require("notify")
      end,
    })

    use {
      "vigoux/notifier.nvim",
      config = function()
        require'notifier'.setup {
          -- You configuration here
        }
      end
    }
    -- TODO: Investigate
    -- use 'jose-elias-alvarez/nvim-lsp-ts-utils'

    local_use("nvim-lua", "popup.nvim")
    local_use("nvim-lua", "plenary.nvim")

    local_use("nvim-telescope", "telescope.nvim")
    local_use("nvim-telescope", "telescope-rs.nvim")
    local_use("nvim-telescope", "telescope-fzf-writer.nvim")
    local_use("nvim-telescope", "telescope-packer.nvim")
    local_use("nvim-telescope", "telescope-fzy-native.nvim")
    local_use("nvim-telescope", "telescope-github.nvim")
    local_use("nvim-telescope", "telescope-symbols.nvim")

    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
    use { "nvim-telescope/telescope-hop.nvim" }
    use { "nvim-telescope/telescope-file-browser.nvim" }
    use { "nvim-telescope/telescope-ui-select.nvim" }

    use { "nvim-telescope/telescope-live-grep-args.nvim" }

    -- local_use("nvim-telescope", "telescope-async-sorter-test.nvim")

    use {
      "AckslD/nvim-neoclip.lua",
      config = function()
        require("neoclip").setup()
      end,
    }

    -- TODO: When i'm back w/ some npm stuff, get this working.
    -- elianiva/telescope-npm.nvim

    local_use "telescope-hacks.nvim"
    -- local_use "sg.nvim"
    local_use "green_light.nvim"

    -- use 'vimwiki/vimwiki'

    -- TODO: Need to figure out how to install all of this stuff on mac
    if not is_mac then
      use { "tami5/sql.nvim", rocks = { "sqlite", "luv" } }
      use { "nvim-telescope/telescope-smart-history.nvim" }
      use "nvim-telescope/telescope-frecency.nvim"
      use "nvim-telescope/telescope-cheat.nvim"
      use { "nvim-telescope/telescope-arecibo.nvim", rocks = { "openssl", "lua-http-parser" } }
    end

    if executable "jq" then
      use {
        "NTBBloodbath/rest.nvim",
        config = function()
          require("rest-nvim").setup()
        end,
      }
    end

    -- use {
    --   "antoinemadec/FixCursorHold.nvim",
    --   run = function()
    --     vim.g.curshold_updatime = 1000
    --   end,
    -- }

    use "nanotee/luv-vimdocs"
    use "milisims/nvim-luaref"

    -- PRACTICE:
    use {
      "tpope/vim-projectionist", -- STREAM: Alternate file editting and some helpful stuff,
      enable = false,
    }

    -- For narrowing regions of text to look at them alone
    use {
      "chrisbra/NrrwRgn",
      cmd = { "NarrowRegion", "NarrowWindow" },
    }

    -- use {
    --   "luukvbaal/stabilize.nvim",
    --   config = function()
    --     require("stabilize").setup()
    --   end,
    -- }

    use "tweekmonster/spellrotate.vim"
    use "haya14busa/vim-metarepeat" -- Never figured out how to use this, but looks like fun.
    --
    -- VIM EDITOR:

    -- Little know features:
    --   :SSave
    --   :SLoad
    --       These are wrappers for mksession that work great. I never have to use
    --       mksession anymore or worry about where things are saved / loaded from.
    use {
      "mhinz/vim-startify",
      -- cmd = { "SLoad", "SSave" },
      config = function()
        -- vim.g.startify_disable_at_vimenter = true
      end,
    }

    -- Better profiling output for startup.
    use {
      "dstein64/vim-startuptime",
      cmd = "StartupTime",
    }

    -- Pretty colors
    use "norcalli/nvim-colorizer.lua"
    use {
      "norcalli/nvim-terminal.lua",
      config = function()
        require("terminal").setup()
      end,
    }

    -- Make comments appear IN YO FACE
    -- use {
    --   "tjdevries/vim-inyoface",
    --   config = function()
    --     vim.api.nvim_set_keymap("n", "<leader>cc", "<Plug>(InYoFace_Toggle)", {})
    --   end,
    -- }

    -- Show only what you're searching for.
    -- STREAM: Could probably make this a bit better. Definitely needs docs
    -- use "tjdevries/fold_search.vim"

    use {
      "tweekmonster/haunted.vim",
      cmd = "Haunt",
    }

    use {
      "tpope/vim-scriptease",
      cmd = {
        "Messages", --view messages in quickfix list
        "Verbose", -- view verbose output in preview window.
        "Time", -- measure how long it takes to run some stuff.
      },
    }

    -- Quickfix enhancements. See :help vim-qf
    use "romainl/vim-qf"

    use {
      "glacambre/firenvim",
      run = function()
        vim.fn["firenvim#install"](0)
      end,
    }

    -- TODO: Eventually statusline should consume this.
    use "mkitt/tabline.vim"

    -- TODO: This would be cool to add back, but it breaks sg.nvim for now.
    -- use "lambdalisue/vim-protocol"

    -- Undo helper
    use "sjl/gundo.vim"

    -- Crazy good box drawing
    use "gyim/vim-boxdraw"

    -- Better increment/decrement
    use "monaqa/dial.nvim"

    --   FOCUSING:
    -- local use_folke = true
    -- if use_folke then
    --   use "folke/zen-mode.nvim"
    --   use "folke/twilight.nvim"
    -- else
    --   use {
    --     "junegunn/goyo.vim",
    --     cmd = "Goyo",
    --     disable = use_folke,
    --   }
    --
    --   use {
    --     "junegunn/limelight.vim",
    --     after = "goyo.vim",
    --     disable = use_folke,
    --   }
    -- end

    --
    --
    --  LANGUAGE:
    -- TODO: Should check on these if they are the best ones
    use { "neovimhaskell/haskell-vim", ft = "haskell" }
    use { "elzr/vim-json", ft = "json" }
    use { "goodell/vim-mscgen", ft = "mscgen" }
    use "PProvost/vim-ps1"
    use "Glench/Vim-Jinja2-Syntax"
    use "justinmk/vim-syntax-extra"

    -- use "pearofducks/ansible-vim"
    -- use { "cespare/vim-toml", ft = "toml" }

    use { "ziglang/zig.vim", ft = "zig" }
    -- use { 'JuliaEditorSupport/julia-vim', ft = "julia" }

    -- use { "iamcco/markdown-preview.nvim", ft = "markdown", run = "cd app && yarn install" }

    use 'haya14busa/is.vim'
    use 'osyo-manga/vim-anzu'
    use 'haya14busa/vim-asterisk'

    -- Typescript
    if false then
      use "jelera/vim-javascript-syntax"
      use "othree/javascript-libraries-syntax.vim"
      use "leafgarland/typescript-vim"
      use "peitalin/vim-jsx-typescript"

      use { "vim-scripts/JavaScript-Indent", ft = "javascript" }
      use { "pangloss/vim-javascript", ft = { "javascript", "html" } }

      -- Godot
      use "habamax/vim-godot"
    end

    -- TODO: Turn emmet back on when I someday use it
    -- use 'mattn/emmet-vim'

    use "tpope/vim-liquid"

    -- Sql
    use "tpope/vim-dadbod"
    use { "kristijanhusak/vim-dadbod-completion" }
    use { "kristijanhusak/vim-dadbod-ui" }

    --
    -- Lisp
    -- use { 'eraserhd/parinfer-rust', run = 'cargo build --release' }
    --
    -- STREAM: Figure out how to use snippets better
    --

    -- Completion

    -- Sources
    use "hrsh7th/nvim-cmp"
    -- use "hrsh7th/cmp-cmdline"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-nvim-lua"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-nvim-lsp-document-symbol"
    use "saadparwaiz1/cmp_luasnip"
    use "tamago324/cmp-zsh"
    use "ray-x/lsp_signature.nvim"
    use 'hrsh7th/cmp-nvim-lsp-signature-help'

    -- Comparators
    use "lukas-reineke/cmp-under-comparator"

    -- ddc.vim
    if executable "deno" then
      use "vim-denops/denops.vim"
      use "lambdalisue/guise.vim"
    end

    -- use "Shougo/ddc.vim"
    -- use "Shougo/ddc-nvim-lsp"

    -- coq.nvim
    -- use { "ms-jpq/coq_nvim", branch = "coq" }

    -- Completion stuff
    local_use "rofl.nvim"

    -- Cool tags based viewer
    --   :Vista  <-- Opens up a really cool sidebar with info about file.
    use { "liuchengxu/vista.vim", cmd = "Vista" }

    -- Find and replace
    use "windwp/nvim-spectre"

    -- Debug adapter protocol
    use "mfussenegger/nvim-dap"
    use "rcarriga/nvim-dap-ui"
    use "theHamsta/nvim-dap-virtual-text"
    use "nvim-telescope/telescope-dap.nvim"

    -- use "mfussenegger/nvim-dap-python"
    -- use "jbyuki/one-small-step-for-vimkind"

    -- use 'airblade/vim-gitgutter'

    -- use {
    --   "rcarriga/vim-ultest",

    --   enable = false,
    --   requires = { "vim-test/vim-test" },
    --   run = ":UpdateRemotePlugins",
    --   config = function()
    --     vim.cmd [[nmap ]t <Plug>(ultest-next-fail)]]
    --     vim.cmd [[nmap [t <Plug>(ultest-prev-fail)]]
    --   end,
    -- }

    -- TREE SITTER:
    local_use("nvim-treesitter", "nvim-treesitter")
    use "nvim-treesitter/nvim-treesitter-context"
    use "nvim-treesitter/playground"
    -- use "vigoux/architext.nvim"

    -- TODO: YouTube Highlight
    -- use "danymat/neogen"

    use "nvim-treesitter/nvim-treesitter-textobjects"
    use "JoosepAlviste/nvim-ts-context-commentstring"
    use {
      "mfussenegger/nvim-ts-hint-textobject",
      config = function()
        vim.cmd [[omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>]]
        vim.cmd [[vnoremap <silent> m :lua require('tsht').nodes()<CR>]]
      end,
    }

    -- use {
    --   "romgrk/nvim-treesitter-context",
    --   config = function()
    --     require("treesitter-context.config").setup {
    --       enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    --     }

    --     -- TODO: Decide on a better highlighting color
    --     -- vim.cmd [[highlight TreesitterContext link NormalFloat]]
    --   end,
    -- }

    -- Grammars
    -- local_use "tree-sitter-lua"
    -- use { "m-novikov/tree-sitter-sql" }
    -- use { "DerekStride/tree-sitter-sql" }
    -- local_use "tree-sitter-sql"

    --
    -- NAVIGATION:
    -- STREAM: Show off edit_alternate.vim
    -- use {
    --   "tjdevries/edit_alternate.vim",
    --   config = function()
    --     vim.fn["edit_alternate#rule#add"]("go", function(filename)
    --       if filename:find "_test.go" then
    --         return (filename:gsub("_test%.go", ".go"))
    --       else
    --         return (filename:gsub("%.go", "_test.go"))
    --       end
    --     end)
    --
    --     vim.api.nvim_set_keymap("n", "<leader>ea", "<cmd>EditAlternate<CR>", { silent = true })
    --   end,
    -- }

    use "google/vim-searchindex"

    use "tamago324/lir.nvim"
    use "tamago324/lir-git-status.nvim"
    if executable "mmv" then
      use "tamago324/lir-mmv.nvim"
    end

    use "pechorin/any-jump.vim"

    --
    -- TEXT MANIUPLATION
    use "godlygeek/tabular" -- Quickly align text by pattern
    use "tpope/vim-repeat" -- Repeat actions better
    use "tpope/vim-abolish" -- Cool things with words!
    use "tpope/vim-characterize"
    use { "tpope/vim-dispatch", cmd = { "Dispatch", "Make" } }

    use "numToStr/Comment.nvim"

    use {
      "AndrewRadev/splitjoin.vim",
      keys = { "gJ", "gS" },
    }

    use({
      "m-demare/hlargs.nvim",
      event = "User PackerDefered",
      config = function()
        require("hlargs").setup({
          color = require("tokyonight.colors").setup().yellow,
        })
      end,
    })

    use({
      "simrat39/symbols-outline.nvim",
      cmd = { "SymbolsOutline" },
      config = function()
        require("symbols-outline").setup()
      end,
      setup = function()
        vim.keymap.set("n", "<leader>cs", "<cmd>SymbolsOutline<cr>", { desc = "Symbols Outline" })
      end,
    })

    -- TODO: Check out macvhakann/vim-sandwich at some point
    -- use "tpope/vim-surround" -- Surround text objects easily
     use({
       "kylechui/nvim-surround",
       event = "BufReadPre",
       config = function()
       end,
     })

     -- use {"akinsho/toggleterm.nvim", tag = 'v2.*'}
     use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
     use "lukas-reineke/indent-blankline.nvim"

    --
    -- GIT:
    use "TimUntersberger/neogit"

    -- Github integration
    if vim.fn.executable "gh" == 1 then
      use "pwntester/octo.nvim"
    end
    use "ruifm/gitlinker.nvim"

    -- Sweet message committer
    use "rhysd/committia.vim"

    -- Floating windows are awesome :)
    use {
      "rhysd/git-messenger.vim",
      keys = "<Plug>(git-messenger)",
    }

    -- Async signs!
    use "lewis6991/gitsigns.nvim"

    -- Git worktree utility
    use {
      "ThePrimeagen/git-worktree.nvim",
      config = function()
      end,
    }

    use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

    use {
      "ThePrimeagen/harpoon",
      requires = { "nvim-lua/plenary.nvim" }
    }
    -- use 'untitled-ai/jupyter_ascending.vim'

    use "tjdevries/standard.vim"
    use "tjdevries/conf.vim"

    use { "junegunn/fzf", run = "./install --all" }
    use { "junegunn/fzf.vim" }

    if false and vim.fn.executable "neuron" == 1 then
      use {
        "oberblastmeister/neuron.nvim",
        branch = "unstable",
        config = function()
          -- these are all the default values
          require("neuron").setup {
            virtual_titles = true,
            mappings = true,
            run = nil,
            neuron_dir = "~/neuron",
            leader = "gz",
          }
        end,
      }
    end

    use {
      "alec-gibson/nvim-tetris",
      cmd = "Tetris",
    }

    -- use 'troydm/zoomwintab.vim'

    use 'levouh/tint.nvim'

    -- use({
    --   "Pocco81/true-zen.nvim",
    --   config = function()
    --     require("true-zen").setup {
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
    --           font = "+3"
    --         },
    --         twilight = false, -- enable twilight (ataraxis)
    --         lualine = false -- hide nvim-lualine (ataraxis)
    --       },
    --     }
    --   end,
    -- })

    -- use {
    --   'nyngwang/NeoNoName.lua',
    --   config = function ()
    --     -- vim.keymap.set('n', '<M-w>', function () vim.cmd('NeoNoName') end, {slient=true, noremap=true, nowait=true})
    --     -- If you are using bufferline.nvim
    --     -- vim.keymap.set('n', '<M-w>', function () vim.cmd('NeoNoNameBufferline') end, {slient=true, noremap=true, nowait=true})
    --   end
    -- }

    -- use {
    --   'nyngwang/NeoZoom.lua',
    --   config = function ()
    --     require('neo-zoom').setup { -- use the defaults or UNCOMMENT and change any one to overwrite
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
    --     vim.keymap.set('n', '<C-CR>', require("neo-zoom").neo_zoom, NOREF_NOERR_TRUNC)
    --
    --     -- My setup (This requires NeoNoName.lua, and optionally NeoWell.lua)
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
    --         vim.cmd("normal! zt")
    --         vim.cmd("normal! 7k7j")
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

    -- use "fladson/vim-kitty"

    -- TODO: Figure out why this randomly popups
    --       Figure out if I want to use it later as well :)
    -- use {
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
    -- local_use 'wander.nvim'
    -- local_use 'riki.nvim'

    use {
      "Vhyrro/neorg",
      -- branch = "unstable"
    }

    -- use({
    --   "folke/noice.nvim",
    --   event = "VimEnter",
    --   config = function()
    --     require("noice").setup()
    --   end,
    --   requires = {
    --     -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    --     "MunifTanjim/nui.nvim",
    --     "rcarriga/nvim-notify",
    --     "hrsh7th/nvim-cmp",
    --     "nvim-treesitter/nvim-treesitter",
    --     "kyazdani42/nvim-web-devicons",
    --   }
    -- })

    -- Theme: icons
    use({
      "kyazdani42/nvim-web-devicons",
      module = "nvim-web-devicons",
      config = function()
        require("nvim-web-devicons").setup({ default = true })
      end,
    })

    -- pretty sure I'm done w/ these
    -- local_use 'vlog.nvim'
  end,

  config = {
    max_jobs = max_jobs,
    luarocks = {
      python_cmd = "python3",
    },
    display = {
      -- open_fn = require('packer.util').float,
    },
  },
}

--[[ Replacements Needed
" Plug 'https://github.com/AndrewRadev/linediff.vim'
" Plug 'https://github.com/AndrewRadev/switch.vim'

Plu 'plasticboy/vim-markdown', { 'for': 'markdown' }
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_fenced_languages = [
\ 'python=python',
\ 'json=json',
\ ]

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}

-- Should get a test helper.
Plug 'alfredodeza/pytest.vim'

-- completes issue names in commit messages
Plug 'tpope/vim-rhubarb'

-- Create menus easily.
Plug 'skywind3000/quickmenu.vim'

-- Indentation guides
Plug 'nathanaelkane/vim-indent-guides'                       " See indentation guides

--]]
