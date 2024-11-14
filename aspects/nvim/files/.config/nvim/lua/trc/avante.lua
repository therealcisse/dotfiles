local status_ok = pcall(require, "avante")
if not status_ok then
  return
end

require('render-markdown').setup ({
  -- use recommended settings from above
})

