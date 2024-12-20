local status_ok, pounce = pcall(require, 'pounce')
if not status_ok then
  return
end

pounce.setup{
  accept_keys = "JFKDLSAHGNUVRBYTMICEOXWPQZ",
  accept_best_key = "<enter>",
  multi_window = true,
  debug = false,
}

local map = vim.keymap.set
map("n", "gS", function() require'pounce'.pounce { } end)
map("n", "gs", function() require'pounce'.pounce { do_repeat = true } end)
map("x", "gS", function() require'pounce'.pounce { } end)
map("o", "gS", function() require'pounce'.pounce { } end)
map("n", "gs", function() require'pounce'.pounce { input = {reg="/"} } end)

