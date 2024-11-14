local status_ok, self = pcall(require, "colorizer")
if not status_ok then
	return
end

self.setup({
	css = {
		RRGGBBAA = true,
		css = true,
		css_fn = true,
	},
	html = {
		names = false,
	},
})
