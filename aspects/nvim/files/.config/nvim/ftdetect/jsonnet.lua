vim.api.nvim_create_autocmd(
  { "BufNewFile", "BufRead"},
  { pattern = {"*.jsonnet", "*.libsonnet"}, command = "set ft=jsonnet" }
)

