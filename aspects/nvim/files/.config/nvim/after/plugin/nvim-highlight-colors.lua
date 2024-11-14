local status_ok, self = pcall(require, "nvim-highlight-colors")
if not status_ok then
	return
end

self.setup({
	render = "background", -- or 'foreground' or 'first_column'
	enable_tailwind = false,
})
