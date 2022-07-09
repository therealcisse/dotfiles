-- vim: set nomodifiable : DO NOT EDIT - edit template source instead (/Users/me/dotfiles/aspects/dotfiles/templates/.hammerspoon/iterm.lua.erb) or use `:set modifiable` to force.

--
-- Switches iTerm dynamic profile based on screen changes.
--

local events = require 'events'
local log = require 'log'

-- Forward function declarations.
local switchProfiles = nil

switchProfiles = (function(screenCount)
  if screenCount == 1 or screenCount == 2 then
    log.i('Configuring iTerm for Retina (internal) display')
    hs.execute("ln -sf \"$HOME/Library/Application Support/iTerm2/Sources/70-Vim-Retina.json\" \"$HOME/Library/Application Support/iTerm2/DynamicProfiles/Vim.json\"")
  else
    log.i('Configuring iTerm for 4K (external) display')
    hs.execute("ln -sf \"$HOME/Library/Application Support/iTerm2/Sources/70-Vim-4K.json\" \"$HOME/Library/Application Support/iTerm2/DynamicProfiles/Vim.json\"")
  end
end)

return {
  init = (function()
    events.subscribe('layout', switchProfiles)
  end),
}
