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
  mason_lspconfig.setup({
    handlers = {
      function(server_name)
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

        local server = {}
        -- This handles overriding only values explicitly passed
        -- by the server configuration above. Useful when disabling
        -- certain features of an LSP (for example, turning off formatting for tsserver)
        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
        require('lspconfig')[server_name].setup(server)
      end,
      jdtls = function()
        local config = {
--           cmd = {
--             --
--             "java",
-- '-XX:TieredStopAtLevel=1',
--             "-Declipse.application=org.eclipse.jdt.ls.core.id1",
--             "-Dosgi.bundles.defaultStartLevel=4",
--             "-Declipse.product=org.eclipse.jdt.ls.core.product",
--             "-Dlog.protocol=true",
--             "-Dlog.level=ALL",
--             "-Xms1g",
--             '-XX:+UseZGC',
--             "--enable-preview",
--             "--add-modules=ALL-SYSTEM",
--             "--add-opens", "java.base/java.util=ALL-UNNAMED",
--             "--add-opens", "java.base/java.lang=ALL-UNNAMED",
--             --
--             "-jar", vim.fn.expand('$HOME/jdt-language-server-1.36.0-202405301306/plugins/org.eclipse.equinox.launcher_1.6.800.v20240513-1750.jar'),
--             "-configuration", vim.fn.expand('$HOME/jdt-language-server-1.36.0-202405301306/config_mac_arm'),
--             "-data", vim.fn.expand("$HOME/.local/share/nvim/java")
--           },
--           filetypes = {"java"},
--           root_dir = vim.fs.root(0, {".git", "mvnw", "gradlew", 'pom.xml'}),
          settings = {
            java = {
              signatureHelp = {enabled = true},
              import = {enabled = true},
              rename = {enabled = true}
            }
          },
          init_options = {
            jvm_args = { '--enable-preview' },
          }
        }

        require('java').setup {
          -- Your custom jdtls settings goes here
        }

        require('lspconfig').jdtls.setup {
          -- Your custom nvim-java configuration goes here
          config,
        }

      end,
    },
  })

  -- mason_lspconfig.setup_handlers {
  --   function(server_name)
  --     require("lspconfig")[server_name].setup({})
  --   end
  -- }
end

return _lsp
