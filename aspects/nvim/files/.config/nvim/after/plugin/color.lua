-- local augroup = require'trc.vim'.augroup
-- local autocmd = require'trc.vim'.autocmd

-- Convenience function so we don't have to escape input and pass it to
-- `:echoerr`.
local echoerr = function (msg)
  vim.api.nvim_err_writeln(msg)
end

local check = function ()
  local pinnacle = require'wincent.pinnacle'

  -- vim.opt.background = 'dark'
  -- vim.cmd('colorscheme falcon')

  local dark = vim.o.background == 'dark'

  vim.cmd('highlight Comment ' .. pinnacle.italicize('Comment'))

  -- Hide (or at least make less obvious) the EndOfBuffer region
  -- vim.cmd('highlight! EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg')

  -- Grey, just like we used to get with https://github.com/Yggdroot/indentLine
  vim.cmd('highlight clear Conceal')
  if dark then
    vim.cmd('highlight Conceal ctermfg=239 guifg=Grey30')
    vim.cmd('highlight IndentBlanklineChar guifg=Grey10 gui=nocombine')
  else
    vim.cmd('highlight Conceal ctermfg=249 guifg=Grey70')
    vim.cmd('highlight IndentBlanklineChar guifg=Grey90 gui=nocombine')
  end

  vim.cmd [[
    highlight clear NonText
    highlight link NonText Conceal
    highlight clear CursorLineNr
  ]]
  vim.cmd('highlight CursorLineNr ' .. pinnacle.extract_highlight('DiffText'))
  vim.cmd [[
    highlight clear Pmenu
    highlight link Pmenu Visual

    " See :help 'pb'.
    highlight PmenuSel blend=0

    highlight clear DiffDelete
    highlight link DiffDelete Conceal
    highlight clear VertSplit
    highlight link VertSplit LineNr

    " Resolve clashes with ColorColumn.
    " Instead of linking to Normal (which has a higher priority, link to nothing).
    highlight link vimUserFunc NONE
  ]]

  -- For Git commits, suppress the background of these groups:
  -- for _, group in ipairs({'DiffAdded', 'DiffFile', 'DiffNewFile', 'DiffLine', 'DiffRemoved'}) do
  --   local highlight = pinnacle.dump(group)
  --   highlight['bg'] = nil
  --   vim.cmd('highlight! clear ' .. group)
  --   vim.cmd('highlight! ' .. group .. ' ' .. pinnacle.highlight(highlight))
  -- end

  -- More subtle highlighting during merge conflict resolution.
  vim.cmd [[
    highlight clear DiffAdd
    highlight clear DiffChange
    highlight clear DiffText
  ]]

  vim.cmd('highlight User8 ' .. pinnacle.italicize('ModeMsg'))

  -- Make floating windows look nicer, as seen in wiki:
  -- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization
  local factor = dark and 0.15 or -0.15
  local normal = pinnacle.adjust_lightness('Normal', factor)
  vim.cmd('highlight! clear NormalFloat')
  vim.cmd('highlight! NormalFloat ' .. pinnacle.highlight(normal))
  normal['fg'] = dark and '#ffffff' or '#000000'
  vim.cmd('highlight! clear FloatBorder')
  vim.cmd('highlight! FloatBorder ' .. pinnacle.highlight(normal) .. ' blend=' .. vim.o.winblend)

  -- Allow for overrides:
  -- - `lua/trc/statusline.lua` will re-set User1, User2 etc.
  -- - `after/plugin/loupe.lua` will override Search.
  -- vim.cmd('doautocmd ColorScheme')
end

-- if vim.v.progname ~= 'vi' then
--   augroup('MyAutocolor', function ()
--     autocmd('FocusGained', '*', check)
--   end)
--
--   -- This is not all roses... some things stop FocusGained from running; like a
--   -- .tmux script that keeps focus away from Vim... should defer a check anyway;
--   -- if we don't get a call in, say, 250ms... call!
--   if vim.fn.exists('$TMUX') == 0 then
--     -- In tmux we're going to get a `FocusGained` event on launch, but not when
--     -- outside of it.
--     check()
--   end
-- end

vim.cmd('augroup MyAutocolor')
vim.cmd('autocmd!')
--check()
vim.cmd('augroup END')

