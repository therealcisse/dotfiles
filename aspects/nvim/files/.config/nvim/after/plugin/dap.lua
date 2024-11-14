-- Explore:
-- - External terminal
-- - make the virt lines thing available if ppl want it
-- - find the nearest codelens above cursor

-- Must Show:
-- - Connect to an existing neovim instance, and step through some plugin
-- - Connect using configuration from VS **** json file (see if VS **** is actually just "it works" LUL)
-- - Completion in the repl, very cool for exploring objects / data

-- - Generating your own config w/ dap.run (can show rust example) (rust BTW)

local has_dap, dap = pcall(require, "dap")
if not has_dap then
  return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
	return
end

local icons = require "trc.icons"

-- vim.fn.sign_define('DapBreakpoint', {text=icons.ui.Bug, texthl='DiagnosticSignError', linehl='', numhl=''})

vim.fn.sign_define("DapBreakpoint", { text = "ß", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "ü", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
-- Setup cool Among Us as avatar
vim.fn.sign_define("DapStopped", { text = "ඞ", texthl = "Error" })

require("nvim-dap-virtual-text").setup {
  enabled = true,

  -- DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, DapVirtualTextForceRefresh
  enabled_commands = false,

  -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
  highlight_changed_variables = true,
  highlight_new_as_changed = true,

  -- prefix virtual text with comment string
  commented = false,

  show_stop_reason = true,

  -- experimental features:
  virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
  all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
}

dap.configurations.scala = {
  {
    type = "scala",
    request = "launch",
    name = "RunOrTest",
    metals = {
      runType = "runOrTestFile",
      args = {}, -- here just as an example
    },
  },
  {
    type = "scala",
    request = "launch",
    name = "Test Target",
    metals = {
      runType = "testTarget",
    },
  },
}

dap.adapters.lldb = {
  name = "lldb",

  type = "executable",
  attach = {
    pidProperty = "pid",
    pidSelect = "ask",
  },
  command = vim.fn.expand("$HOME/.vscode/extensions/lanza.lldb-vscode-0.2.3/bin/darwin/bin/lldb-vscode"),
  env = {
    LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES",
  },
}

dap.configurations.zig = {
  {
    name = 'Debug',
    type = 'lldb',
    request = 'launch',
    program = '${file}',
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
  },
}

-- dap.adapters.c = {
--   name = "lldb",
--
--   type = "executable",
--   attach = {
--     pidProperty = "pid",
--     pidSelect = "ask",
--   },
--   command = "lldb-vscode-11",
--   env = {
--     LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES",
--   },
-- }

--  https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#go-using-delve-directly
-- dap.adapters.go = function(callback, _)
--   local stdout = vim.loop.new_pipe(false)
--   local handle, pid_or_err
--   local port = 38697
--
--   handle, pid_or_err = vim.loop.spawn("dlv", {
--     stdio = { nil, stdout },
--     args = { "dap", "-l", "127.0.0.1:" .. port },
--     detached = true,
--   }, function(code)
--     stdout:close()
--     handle:close()
--
--     print("[delve] Exit Code:", code)
--   end)
--
--   assert(handle, "Error running dlv: " .. tostring(pid_or_err))
--
--   stdout:read_start(function(err, chunk)
--     assert(not err, err)
--
--     if chunk then
--       vim.schedule(function()
--         require("dap.repl").append(chunk)
--         print("[delve]", chunk)
--       end)
--     end
--   end)
--
--   -- Wait for delve to start
--   vim.defer_fn(function()
--     callback { type = "server", host = "127.0.0.1", port = port }
--   end, 100)
-- end

-- dap.configurations.go = {
--   {
--     type = "go",
--     name = "Debug (from vscode-go)",
--     request = "launch",
--     showLog = false,
--     program = "${file}",
--     dlvToolPath = vim.fn.exepath "dlv", -- Adjust to where delve is installed
--   },
--   {
--     type = "go",
--     name = "Debug (No File)",
--     request = "launch",
--     program = "",
--   },
--   {
--     type = "go",
--     name = "Debug",
--     request = "launch",
--     program = "${file}",
--     showLog = true,
--     -- console = "externalTerminal",
--     -- dlvToolPath = vim.fn.exepath "dlv",
--   },
--   {
--     name = "Test Current File",
--     type = "go",
--     request = "launch",
--     showLog = true,
--     mode = "test",
--     program = ".",
--     dlvToolPath = vim.fn.exepath "dlv",
--   },
-- }

-- dap.adapters.lldb = {
--   type = "executable",
--   command = "/usr/bin/lldb-vscode-11",
--   name = "lldb",
-- }

-- local extension_path = vim.fn.expand "~/.vscode/extensions/vadimcn.vscode-lldb-1.7.0/"
-- local codelldb_path = extension_path .. "adapter/codelldb"
-- local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

-- dap.adapters.rt_lldb = {
--   type = "executable",
--   command = codelldb_path,
--   name = "rt_lldb",
-- }

-- dap.adapters.rt_lldb = function(callback, _)
--   local stdout = vim.loop.new_pipe(false)
--   local stderr = vim.loop.new_pipe(false)
--   local handle
--   local pid_or_err
--   local port
--   local error_message = ""
--
--   local opts = {
--     stdio = { nil, stdout, stderr },
--     args = { "--liblldb", liblldb_path },
--     detached = true,
--   }
--
--   handle, pid_or_err = vim.loop.spawn(codelldb_path, opts, function(code)
--     stdout:close()
--     stderr:close()
--     handle:close()
--     if code ~= 0 then
--       print("codelldb exited with code", code)
--       print("error message", error_message)
--     end
--   end)
--
--   assert(handle, "Error running codelldb: " .. tostring(pid_or_err))
--
--   stdout:read_start(function(err, chunk)
--     assert(not err, err)
--     if chunk then
--       if not port then
--         local chunks = {}
--         for substring in chunk:gmatch "%S+" do
--           table.insert(chunks, substring)
--         end
--         port = tonumber(chunks[#chunks])
--         vim.schedule(function()
--           callback {
--             type = "server",
--             host = "127.0.0.1",
--             port = port,
--           }
--         end)
--       else
--         vim.schedule(function()
--           require("dap.repl").append(chunk)
--         end)
--       end
--     end
--   end)
--   stderr:read_start(function(_, chunk)
--     if chunk then
--       error_message = error_message .. chunk
--
--       vim.schedule(function()
--         require("dap.repl").append(chunk)
--       end)
--     end
--   end)
-- end

-- dap.configurations.rust = {
--   {
--     name = "Launch",
--     type = "lldb",
--     request = "launch",
--     program = function()
--       return vim.fn.input("Path to executable: ", vim.fn.getcwd()  .. '/target/debug/' .. '', "file")
--     end,
--     cwd = "${workspaceFolder}",
--     stopOnEntry = false,
--     args = {},
--
--     -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
--     --
--     --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
--     --
--     -- Otherwise you might get the following error:
--     --
--     --    Error on launch: Failed to attach to the target process
--     --
--     -- But you should be aware of the implications:
--     -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
--     runInTerminal = false,
--   },
-- }

-- You can set trigger characters OR it will default to '.'
-- You can also trigger with the omnifunc, <c-x><c-o>
vim.cmd [[
augroup DapRepl
  au!
  au FileType dap-repl lua require('dap.ext.autocompl').attach()
augroup END
]]

dap.listeners.after.event_initialized["dapui_config"]=function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"]=function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"]=function()
  dapui.close()
end

