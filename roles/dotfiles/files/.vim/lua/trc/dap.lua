--[[

      enrich_config = function(config, on_config)
        local final_config = vim.deepcopy(config)
        final_config.extra_property = 'This got injected by the adapter'
        on_config(final_config)
      end;

--]]

local Job = require "plenary.job"

local has_dap, dap = pcall(require, "dap")
if not has_dap then
  return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
	return
end

local icons = require "trc.icons"

vim.highlight.create('DapBreakpoint', {
  guifg='#993939',
  guibg=none,
  ctermfg=none,
  ctermbg=none
})

vim.highlight.create('DapLogPoint', {
  guifg='#61afef',
  guibg=none,
  ctermfg=none,
  ctermbg=none
})

vim.highlight.create('DapStopped', {
  guifg='#98c379',
  guibg=none,
  ctermfg=none,
  ctermbg=none
})

vim.fn.sign_define('DapBreakpoint', {
  text=' ',
  texthl='DapBreakpoint',
  linehl='',
  numhl=''
})

vim.fn.sign_define('DapBreakpointCondition', {
  text=' ﳁ',
  texthl='DapBreakpoint',
  linehl='',
  numhl=''
})

vim.fn.sign_define('DapBreakpointRejected', {
  text=' ',
  texthl='DapBreakpoint',
  linehl='',
  numhl= ''
})

vim.fn.sign_define('DapLogPoint', {
  text=' ',
  texthl='DapLogPoint',
  linehl='',
  numhl= ''
})

vim.fn.sign_define('DapStopped', {
  text=' ',
  texthl='DapStopped',
  linehl='',
  numhl= ''
})

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
      --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
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

dap.adapters.c = {
  name = "lldb",

  type = "executable",
  attach = {
    pidProperty = "pid",
    pidSelect = "ask",
  },
  command = "/usr/local/Cellar/llvm/14.0.6/bin/lldb-vscode",
  env = {
    LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES",
  },
}

--  https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#go-using-delve-directly
dap.adapters.go = function(callback, _)
  local stdout = vim.loop.new_pipe(false)
  local handle, pid_or_err
  local port = 38697

  handle, pid_or_err = vim.loop.spawn("dlv", {
    stdio = { nil, stdout },
    args = { "dap", "-l", "127.0.0.1:" .. port },
    detached = true,
  }, function(code)
    stdout:close()
    handle:close()

    print("[delve] Exit Code:", code)
  end)

  assert(handle, "Error running dlv: " .. tostring(pid_or_err))

  stdout:read_start(function(err, chunk)
    assert(not err, err)

    if chunk then
      vim.schedule(function()
        require("dap.repl").append(chunk)
        print("[delve]", chunk)
      end)
    end
  end)

  -- Wait for delve to start
  vim.defer_fn(function()
    callback { type = "server", host = "127.0.0.1", port = port }
  end, 100)
end

dap.configurations.go = {
  {
    type = "go",
    name = "Debug (from vscode-go)",
    request = "launch",
    showLog = false,
    program = "${file}",
    dlvToolPath = vim.fn.exepath "dlv", -- Adjust to where delve is installed
  },
  {
    type = "go",
    name = "Debug (No File)",
    request = "launch",
    program = "",
  },
  {
    type = "go",
    name = "Debug",
    request = "launch",
    program = "${file}",
    showLog = true,
    -- console = "externalTerminal",
    -- dlvToolPath = vim.fn.exepath "dlv",
  },
  {
    name = "Test Current File",
    type = "go",
    request = "launch",
    showLog = true,
    mode = "test",
    program = ".",
    dlvToolPath = vim.fn.exepath "dlv",
  },
}

dap.adapters.lldb = {
  type = "executable",
  command = "/usr/local/Cellar/llvm/14.0.6/bin/lldb-vscode",
  name = "lldb",
  env = function()
    local variables = {}
    for k, v in pairs(vim.fn.environ()) do
      table.insert(variables, string.format("%s=%s", k, v))
    end
    return variables
  end,
}

local extension_path = vim.fn.expand "~/.vscode/extensions/vadimcn.vscode-lldb-1.7.0/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

-- dap.adapters.rt_lldb = {
--   type = "executable",
--   command = codelldb_path,
--   name = "rt_lldb",
-- }

dap.adapters.rt_lldb = function(callback, _)
  local stdout = vim.loop.new_pipe(false)
  local stderr = vim.loop.new_pipe(false)
  local handle
  local pid_or_err
  local port
  local error_message = ""

  local opts = {
    stdio = { nil, stdout, stderr },
    args = { "--liblldb", liblldb_path },
    detached = true,
  }

  handle, pid_or_err = vim.loop.spawn(codelldb_path, opts, function(code)
    stdout:close()
    stderr:close()
    handle:close()
    if code ~= 0 then
      print("codelldb exited with code", code)
      print("error message", error_message)
    end
  end)

  assert(handle, "Error running codelldb: " .. tostring(pid_or_err))

  stdout:read_start(function(err, chunk)
    assert(not err, err)
    if chunk then
      if not port then
        local chunks = {}
        for substring in chunk:gmatch "%S+" do
          table.insert(chunks, substring)
        end
        port = tonumber(chunks[#chunks])
        vim.schedule(function()
          callback {
            type = "server",
            host = "127.0.0.1",
            port = port,
          }
        end)
      else
        vim.schedule(function()
          require("dap.repl").append(chunk)
        end)
      end
    end
  end)
  stderr:read_start(function(_, chunk)
    if chunk then
      error_message = error_message .. chunk

      vim.schedule(function()
        require("dap.repl").append(chunk)
      end)
    end
  end)
end

dap.configurations.rust = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd()  .. '/target/debug/' .. '', "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},

    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    runInTerminal = false,
  },
}

local map = function(lhs, rhs, desc)
  if desc then
    desc = "[DAP] " .. desc
  end

  vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
end

map("<leader><F5>", function()
  if vim.bo.filetype ~= "rust" then
    vim.notify "This wasn't rust. I don't know what to do"
    return
  end

  R("trc.dap").select_rust_runnable()
end)

map("<F1>", require("dap").step_back, "step_back")
map("<F2>", require("dap").step_into, "step_into")
map("<F3>", require("dap").step_over, "step_over")
map("<F4>", require("dap").step_out, "step_out")
map("<F5>", require("dap").continue, "continue")

-- TODO:
-- disconnect vs. terminate

map("<leader>dr", require("dap").repl.open)

map("<leader>db", require("dap").toggle_breakpoint)
map("<leader>dB", function()
  require("dap").set_breakpoint(vim.fn.input "[DAP] Condition > ")
end)

map("<leader>de", require("dapui").eval)
map("<leader>dE", function()
  require("dapui").eval(vim.fn.input "[DAP] Expression > ")
end)

-- You can set trigger characters OR it will default to '.'
-- You can also trigger with the omnifunc, <c-x><c-o>
vim.cmd [[
augroup DapRepl
  au!
  au FileType dap-repl lua require('dap.ext.autocompl').attach()
augroup END
]]


require("dapui").setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  -- Expand lines larger than the window
  -- Requires >= 0.7
  expand_lines = vim.fn.has("nvim-0.7"),
  -- Layouts define sections of the screen to place windows.
  -- The position can be "left", "right", "top" or "bottom".
  -- The size specifies the height/width depending on position. It can be an Int
  -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
  -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
  -- Elements are the elements shown in the layout (in order).
  -- Layouts are opened in order so that earlier layouts take priority in window sizing.
  layouts = {
    {
      elements = {
      -- Elements can be strings or table with id and size keys.
        { id = "scopes", size = 0.25 },
        "breakpoints",
        "stacks",
        "watches",
      },
      size = 40, -- 40 columns
      position = "left",
    },
    {
      elements = {
        "repl",
        "console",
      },
      size = 0.25, -- 25% of total lines
      position = "bottom",
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
  }
})

local original = {}
local debug_map = function(lhs, rhs, desc)
  local keymaps = vim.api.nvim_get_keymap "n"
  original[lhs] = vim.tbl_filter(function(v)
    return v.lhs == lhs
  end, keymaps)[1] or true

  vim.keymap.set("n", lhs, rhs, { desc = desc })
end

local debug_unmap = function()
  for k, v in pairs(original) do
    if v == true then
      vim.keymap.del("n", k)
    else
      local rhs = v.rhs

      v.lhs = nil
      v.rhs = nil
      v.buffer = nil
      v.mode = nil
      v.sid = nil
      v.lnum = nil

      vim.keymap.set("n", k, rhs, v)
    end
  end

  original = {}
end

dap.listeners.after.event_initialized["dapui_config"] = function()
  debug_map("asdf", ":echo 'hello world<CR>", "showing things")

  dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  debug_unmap()

  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

--[[
nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <leader>dl :lua require'dap'.repl.run_last()<CR>
--]]

-- vim.cmd [[nmap <silent> <space>db <Plug>VimspectorToggleBreakpoint]]
-- vim.cmd [[nmap <space>ds <Plug>VimscectorContinue]]

local M = {}

local get_cargo_args = function(args)
  local result = {}

  assert(args.cargoArgs, vim.inspect(args))
  for idx, a in ipairs(args.cargoArgs) do
    table.insert(result, a)
    if idx == 1 and a == "test" then
      -- Don't run tests, just build
      table.insert(result, "--no-run")
    end
  end

  table.insert(result, "--message-format=json")

  -- TODO: handle cargoExtraArgs

  return result
end

M.select_rust_related = function(bufnr, win)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  win = win or vim.api.nvim_get_current_win()

  vim.lsp.buf_request(bufnr, "rust-analyzer/relatedTests", vim.lsp.util.make_position_params(win), function(err, result)
    local runnables = {}
    for _, v in ipairs(result) do
      table.insert(runnables, v.runnable)
    end

    vim.ui.select(runnables, {
      prompt = "Related Rust Runnables",
      format_item = function(item)
        return item.label
      end,
    }, function(item)
      M.debug_rust_runnable(item)
    end)
  end)
end

M.select_rust_runnable = function(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  vim.lsp.buf_request(
    bufnr,
    "experimental/runnables",
    { textDocument = vim.lsp.util.make_text_document_params(bufnr) },
    function(_, result)
      vim.ui.select(result, {
        prompt = "Rust Runnables",
        format_item = function(item)
          return item.label
        end,
      }, function(item)
        M.debug_rust_runnable(item)
      end)
    end
  )
end

M.debug_rust_runnable = function(item)
  item = item or {}
  item = vim.deepcopy(item)

  vim.notify("Debugging: " .. item.label)

  Job
    :new({
      command = "cargo",
      args = get_cargo_args(item.args),
      cwd = item.args.workspaceRoot,
      on_exit = function(j, code)
        if code and code > 0 then
          vim.notify "An error occured while compiling. Please fix all compilation issues and try again."
        end

        vim.schedule(function()
          for _, value in pairs(j:result()) do
            local json = vim.fn.json_decode(value)
            if type(json) == "table" and json.executable ~= vim.NIL and json.executable ~= nil then
              dap.run {
                name = "Rust tools debug",
                type = "rt_lldb",
                request = "launch",
                program = json.executable,
                args = item.args.executableArgs,
                cwd = item.workspaceRoot,
                stopOnEntry = false,
                runInTerminal = false,
              }
              break
            end
          end
        end)
      end,
    })
    :start()
end

return M
