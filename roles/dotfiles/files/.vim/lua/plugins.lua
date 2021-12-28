local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({
    'git',
    'clone',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
  execute 'packadd packer.nvim'
end

vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
  use { 'wbthomason/packer.nvim', opt = true }
  -- use 'scrooloose/nerdcommenter'
  -- use 'christianchiarulli/nvcode-color-schemes.vim'
  -- use {'vim-airline/vim-airline', requires = {{'vim-airline/vim-airline-themes'}}}
  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function ()
      require'lualine'.setup()
    end
  }
  use {
    'neovim/nvim-lspconfig',
  }
  -- use 'glepnir/lspsaga.nvim'
  use 'windwp/nvim-autopairs'
  use { 'hrsh7th/nvim-compe', requires = {{'hrsh7th/vim-vsnip'}} }
  use 'hrsh7th/vim-vsnip-integ'
  use 'DataWraith/auto_mkdir'
  use 'tpope/vim-unimpaired'

  use 'tpope/vim-rhubarb'            -- Fugitive-companion to interact with github

  use 'onsails/lspkind-nvim'
  use 'norcalli/snippets.nvim'

  use { 'MTDL9/vim-log-highlighting' }

  -- use { 'lukas-reineke/indent-blankline.nvim', branch="lua" }

  use 'kazhala/close-buffers.nvim'

  -- use 'ggandor/lightspeed.nvim'

  use { 'wincent/vim-clipper' }

  use 'haya14busa/incsearch.vim'
  use 'junegunn/vim-slash'
  use { 'vim-scripts/gitignore' }
  use { 'justinmk/vim-dirvish'}
  use { 'kristijanhusak/vim-dirvish-git'}

  use { 'kana/vim-textobj-entire', requires = {{'kana/vim-textobj-user'}} }-- ae, ie
  use { 'kana/vim-textobj-indent', requires = {{'kana/vim-textobj-user'}} } -- ai, ii
  use { 'kana/vim-textobj-line', requires = {{'kana/vim-textobj-user'}} } -- al, il
  use { 'coderifous/textobj-word-column.vim', requires = {{'kana/vim-textobj-user'}} }-- ic, ac, iC, and aC or vic, cic, and daC
  use { 'mattn/vim-textobj-url', requires = {{'kana/vim-textobj-user'}} } -- au, iu

  use {'JulesWang/css.vim', ft = {'haml', 'scss', 'sass'}}
  use 'ap/vim-css-color'
  use {'tpope/vim-haml', ft = {'haml', 'scss', 'sass'}}

  use 'mattn/webapi-vim'
  use 'othree/html5.vim'
  use {'plasticboy/vim-markdown', ft = {'markdown'}}
  use 'airblade/vim-gitgutter'
  -- use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'} }
  -- use 'tomtom/tcomment_vim'
  use { 'tpope/vim-commentary' }
  use 'tpope/vim-fugitive'
  use {'junegunn/gv.vim', cmd = {'GV'}}
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'

  use 'Shougo/echodoc.vim'

  use 'tommcdo/vim-lion' -- Align = gl, gL

  use {'derekwyatt/vim-scala', ft = {'scala'}}

  use 'ryanoasis/vim-webdevicons'

  use 'mhinz/vim-startify'

  use 'tpope/vim-eunuch' --  =SudoWrite, ...

  use {'FooSoft/vim-argwrap', cmd = {'ArgWrap'}}

  use 'matze/vim-move' -- <c-k>, <c-j>

  use 'voldikss/vim-floaterm'

  use 'vim-scripts/ReplaceWithRegister' -- replace <motion> with register

  -- use 'kepbod/quick-scope'

  use 'tommcdo/vim-exchange' -- cx

  -- use { 'camspiers/snap'}
  use {'junegunn/fzf', dir = '~/.fzf', run = './install --all' }
  use 'junegunn/fzf.vim'

  -- use {
  --   'nvim-telescope/telescope.nvim',
  --   requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  -- }

  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function ()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

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

  use {"haringsrob/nvim_context_vt"}
  use { "stevearc/dressing.nvim" }

  use {
    "TimUntersberger/neogit",
    requires = 'nvim-lua/plenary.nvim',
    cmd = "Neogit",
    config = function()
      require("config.neogit").setup()
    end,
  }
  use {"sindrets/diffview.nvim"}
  use { "rhysd/git-messenger.vim" }
  use {
    "tanvirtin/vgit.nvim",
    event = "BufWinEnter",
    config = function()
      require("vgit").setup()
    end,
  }

  use {
    "nacro90/numb.nvim",
    config = function()
      require("numb").setup()
    end,
  }

  -- Better Start-up Time
  use("nathom/filetype.nvim")

  use "kdav5758/NoCLC.nvim"
  use {
    'folke/lsp-colors.nvim',
    config = function ()
      require("lsp-colors").setup({
        Error = "#db4b4b",
        Warning = "#e0af68",
        Information = "#0db9d7",
        Hint = "#10B981"
      })
    end
  }

  use {
    'scalameta/nvim-metals',
    requires = { "nvim-lua/plenary.nvim" }

  }
  -- use 'mfussenegger/nvim-dap'

  use 'sunjon/shade.nvim'

  -- use {
  --   'glacambre/firenvim',
  --   run = function() vim.fn['firenvim#install'](0) end
  -- }

  -- use "arnamak/stay-centered.nvim"

  use {
    "SmiteshP/nvim-gps",
    config = function()
      require("nvim-gps").setup()
    end,
  }

  use {
    'folke/zen-mode.nvim',
    config = function()
      require("zen-mode").setup {
        window = {
          width = .98
        }
      }
    end
  }

  use {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use {'nvim-treesitter/nvim-treesitter-textobjects'}
  use {'nvim-treesitter/nvim-treesitter-refactor'}

  use {
    'romgrk/nvim-treesitter-context',
    config = function()
      require('treesitter-context.config').setup {enable = true}
    end
  }

  use { 'folke/which-key.nvim' }

  -- use { 'NLKNguyen/papercolor-theme' }
  use { 'cohama/lexima.vim' }

  use { 'fenetikm/falcon' }

  use { 'RRethy/vim-illuminate' }

  -- use { 'Th3Whit3Wolf/one-nvim' }

  use { 'kdheepak/lazygit.nvim' }

  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  use {'ray-x/lsp_signature.nvim'}
end)
