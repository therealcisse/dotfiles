-- Setup nvim-cmp.
local status_ok, npairs = pcall(require, "autoclose")
if not status_ok then
  return
end

npairs.setup {
}

