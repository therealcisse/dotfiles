local status_ok, jsonnet = pcall(require, 'nvim-jsonnet')
if not status_ok then
  return
end

jsonnet.setup({
    -- Opinionated defaults
    jsonnet_bin = 'jsonnet',
    jsonnet_args = { '-J', 'vendor', '-J', 'lib' },
    jsonnet_string_bin = 'jsonnet',
    jsonnet_string_args = { '-S', '-J', 'vendor', '-J', 'lib' },
    use_tanka_if_possible = true,

    -- default to false to not break existing installs
    load_lsp_config = false,
    -- Pass along nvim-cmp capabilities if you use that.
    -- capabilities = require('cmp_nvim_lsp').default_capabilities(),
    capabilities = require('blink.cmp').get_lsp_capabilities(),

    -- default to false to not break existing installs
    load_dap_config = false,
    jsonnet_debugger_bin = 'jsonnet-debugger',
    jsonnet_debugger_args = { '-s', '-d', '-J', 'vendor', '-J', 'lib' },
})
