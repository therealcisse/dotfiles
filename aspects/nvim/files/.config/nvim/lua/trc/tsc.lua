local status_ok, tsc = pcall(require, 'tsc')
if not status_ok then
  return
end

tsc.setup()
