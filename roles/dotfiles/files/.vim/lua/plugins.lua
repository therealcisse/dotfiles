local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({
    'git', 'clone', 'https://github.com/wbthomason/packer.nvim',
    install_path
  })
  execute 'packadd packer.nvim'
end

vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
  use { 'wbthomason/packer.nvim', opt = true }
  use 'nvim-treesitter/nvim-treesitter'
  use 'scrooloose/nerdcommenter'
  -- use 'christianchiarulli/nvcode-color-schemes.vim'
  use {'vim-airline/vim-airline', requires = {{'vim-airline/vim-airline-themes'}}}
  use 'neovim/nvim-lspconfig'
  use 'glepnir/lspsaga.nvim'
  use 'windwp/nvim-autopairs'
  use { 'hrsh7th/nvim-compe', requires = {{'hrsh7th/vim-vsnip'}} }
  use 'hrsh7th/vim-vsnip-integ'
  use 'DataWraith/auto_mkdir'
  use 'tpope/vim-unimpaired'

  use 'onsails/lspkind-nvim'
  use 'norcalli/snippets.nvim'

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
  use 'tomtom/tcomment_vim'
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

  use 'kepbod/quick-scope'

  use 'tommcdo/vim-exchange' -- cx

  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }

  use {
    "folke/lsp-trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function ()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  use "kdav5758/NoCLC.nvim"
  use 'folke/lsp-colors.nvim'

  use {'scalameta/nvim-metals'}
  use 'mfussenegger/nvim-dap'

  use { 'folke/which-key.nvim' }

  use { 'NLKNguyen/papercolor-theme' }
  use { 'cohama/lexima.vim' }

  use { 'RRethy/vim-illuminate' }

  -- use { 'Th3Whit3Wolf/one-nvim' }

  use { 'kdheepak/lazygit.nvim' }

  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
end)
