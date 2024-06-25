local status_ok, java = pcall(require, "java")
if not status_ok then
  return
end

java.setup()
