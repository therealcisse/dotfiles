local autoload = require'trc.autoload'

local trc = autoload('trc')

-- Using a real global here to make sure anything stashed in here (and
-- in `trc.g`) survives even after the last reference to it goes away.
_G.trc = trc

return trc
