local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
  return
end

local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
  return
end

local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_ok then
  return
end

local _lsp = {}
function _lsp.setup()
  mason.setup({})
  mason_lspconfig.setup({})

  mason_lspconfig.setup_handlers {
    function(server_name)
      require("lspconfig")[server_name].setup({})
    end
  }
end

return _lsp

