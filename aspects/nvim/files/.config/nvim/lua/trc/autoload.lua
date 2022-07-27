-- Provides a lazy autoload mechanism similar to Vimscript's autoload mechanism.
--
-- Examples:
--
--    " Vimscript - looks for function named `trc#foo#bar#baz()` in
--    " autoload/trc/foo/bar.vim):
--
--    call trc#foo#bar#baz()
--
--    -- Lua - lazy-loads these files in sequence before calling
--    -- `trc.foo.bar.baz()`:
--    --
--    --    1. lua/trc/foo.lua (or lua/trc/foo/init.lua)
--    --    2. lua/trc/foo/bar.lua (or lua/trc/foo/bar/init.lua)
--    --    3. lua/trc/foo/bar/baz.lua (or lua/trc/foo/bar/baz/init.lua)
--
--    local trc = require'trc'
--    trc.foo.bar.baz()
--
--    -- Note that because `require'trc'` appears at the top of the top-level
--    -- init.lua, the previous example can be written as:
--
--    trc.foo.bar.baz()
--
local autoload = function(base)
  local storage = {}
  local mt = {
    __index = function(_, key)
      if storage[key] == nil then
        storage[key] = require(base .. '.' .. key)
      end
      return storage[key]
    end
  }

  return setmetatable({}, mt)
end

return autoload
