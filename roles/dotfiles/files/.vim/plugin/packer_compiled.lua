-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/amadou/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/amadou/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/amadou/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/amadou/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/amadou/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["NoCLC.nvim"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/NoCLC.nvim"
  },
  ReplaceWithRegister = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/ReplaceWithRegister"
  },
  auto_mkdir = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/auto_mkdir"
  },
  ["css.vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/opt/css.vim"
  },
  ["echodoc.vim"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/echodoc.vim"
  },
  fzf = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/fzf"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/fzf.vim"
  },
  gitignore = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/gitignore"
  },
  ["gv.vim"] = {
    commands = { "GV" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/opt/gv.vim"
  },
  ["html5.vim"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/html5.vim"
  },
  ["incsearch.vim"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/incsearch.vim"
  },
  ["lazygit.nvim"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/lazygit.nvim"
  },
  ["lexima.vim"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/lexima.vim"
  },
  ["lsp-colors.nvim"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/lsp-colors.nvim"
  },
  ["lsp-trouble.nvim"] = {
    config = { "\27LJ\2\n9\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\ftrouble\frequire\0" },
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/lsp-trouble.nvim"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["lspsaga.nvim"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/lspsaga.nvim"
  },
  ["nvim-autopairs"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/nvim-autopairs"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-metals"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/nvim-metals"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  ["papercolor-theme"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/papercolor-theme"
  },
  ["quick-scope"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/quick-scope"
  },
  ["snippets.nvim"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/snippets.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim"
  },
  ["textobj-word-column.vim"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/textobj-word-column.vim"
  },
  ["vim-airline"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/vim-airline"
  },
  ["vim-airline-themes"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/vim-airline-themes"
  },
  ["vim-argwrap"] = {
    commands = { "ArgWrap" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/opt/vim-argwrap"
  },
  ["vim-clipper"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/vim-clipper"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-css-color"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/vim-css-color"
  },
  ["vim-dirvish"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/vim-dirvish"
  },
  ["vim-dirvish-git"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/vim-dirvish-git"
  },
  ["vim-eunuch"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/vim-eunuch"
  },
  ["vim-exchange"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/vim-exchange"
  },
  ["vim-floaterm"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/vim-floaterm"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-gitgutter"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/vim-gitgutter"
  },
  ["vim-haml"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/opt/vim-haml"
  },
  ["vim-illuminate"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/vim-illuminate"
  },
  ["vim-lion"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/vim-lion"
  },
  ["vim-log-highlighting"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/vim-log-highlighting"
  },
  ["vim-markdown"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/opt/vim-markdown"
  },
  ["vim-move"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/vim-move"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-rhubarb"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/vim-rhubarb"
  },
  ["vim-scala"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/opt/vim-scala"
  },
  ["vim-slash"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/vim-slash"
  },
  ["vim-startify"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/vim-startify"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-textobj-entire"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/vim-textobj-entire"
  },
  ["vim-textobj-indent"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/vim-textobj-indent"
  },
  ["vim-textobj-line"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/vim-textobj-line"
  },
  ["vim-textobj-url"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/vim-textobj-url"
  },
  ["vim-textobj-user"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/vim-textobj-user"
  },
  ["vim-unimpaired"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/vim-unimpaired"
  },
  ["vim-vsnip"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/vim-vsnip"
  },
  ["vim-vsnip-integ"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/vim-vsnip-integ"
  },
  ["vim-webdevicons"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/vim-webdevicons"
  },
  ["webapi-vim"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/webapi-vim"
  },
  ["which-key.nvim"] = {
    loaded = true,
    path = "/Users/amadou/.local/share/nvim/site/pack/packer/start/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: lsp-trouble.nvim
time([[Config for lsp-trouble.nvim]], true)
try_loadstring("\27LJ\2\n9\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\ftrouble\frequire\0", "config", "lsp-trouble.nvim")
time([[Config for lsp-trouble.nvim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
vim.cmd [[command! -nargs=* -range -bang -complete=file ArgWrap lua require("packer.load")({'vim-argwrap'}, { cmd = "ArgWrap", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file GV lua require("packer.load")({'gv.vim'}, { cmd = "GV", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'vim-markdown'}, { ft = "markdown" }, _G.packer_plugins)]]
vim.cmd [[au FileType haml ++once lua require("packer.load")({'css.vim', 'vim-haml'}, { ft = "haml" }, _G.packer_plugins)]]
vim.cmd [[au FileType scss ++once lua require("packer.load")({'css.vim', 'vim-haml'}, { ft = "scss" }, _G.packer_plugins)]]
vim.cmd [[au FileType scala ++once lua require("packer.load")({'vim-scala'}, { ft = "scala" }, _G.packer_plugins)]]
vim.cmd [[au FileType sass ++once lua require("packer.load")({'css.vim', 'vim-haml'}, { ft = "sass" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /Users/amadou/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]], true)
vim.cmd [[source /Users/amadou/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]]
time([[Sourcing ftdetect script at: /Users/amadou/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]], false)
time([[Sourcing ftdetect script at: /Users/amadou/.local/share/nvim/site/pack/packer/opt/vim-scala/ftdetect/scala.vim]], true)
vim.cmd [[source /Users/amadou/.local/share/nvim/site/pack/packer/opt/vim-scala/ftdetect/scala.vim]]
time([[Sourcing ftdetect script at: /Users/amadou/.local/share/nvim/site/pack/packer/opt/vim-scala/ftdetect/scala.vim]], false)
time([[Sourcing ftdetect script at: /Users/amadou/.local/share/nvim/site/pack/packer/opt/vim-haml/ftdetect/haml.vim]], true)
vim.cmd [[source /Users/amadou/.local/share/nvim/site/pack/packer/opt/vim-haml/ftdetect/haml.vim]]
time([[Sourcing ftdetect script at: /Users/amadou/.local/share/nvim/site/pack/packer/opt/vim-haml/ftdetect/haml.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: ".v:exception | echom "Please check your config for correctness" | echohl None')
end
