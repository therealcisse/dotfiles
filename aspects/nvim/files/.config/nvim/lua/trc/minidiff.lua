local status_ok, plugin = pcall(require, 'mini.diff')
if not status_ok then
  return
end

plugin.setup()
