local icons = require("trc.icons")

local M = {}

local sign_name = 'NavigatorCodeLensLightBulb'
if vim.tbl_isempty(vim.fn.sign_getdefined(sign_name)) then
  vim.fn.sign_define(sign_name, { text = icons.ui.Lightbulb, texthl = 'LspDiagnosticsSignHint' })
end

local sign_group = 'nvcodelensaction'

local is_enabled = true
local code_lens_action = {}

local function _update_sign(line)
  local winid = vim.api.nvim_get_current_win()
  if code_lens_action[winid] == nil then
    code_lens_action[winid] = {}
  end
  if code_lens_action[winid].lightbulb_line ~= 0 then
    vim.fn.sign_unplace(sign_group, { id = code_lens_action[winid].lightbulb_line, buffer = '%' })
  end

  if line then
    -- log("updatasign", line, sign_group, sign_name)
    vim.fn.sign_place(
      line,
      sign_group,
      sign_name,
      '%',
      { lnum = line + 1, priority = 40 }
    )

    code_lens_action[winid].lightbulb_line = line
  end
end

local codelens_hdlr = function(err, result, ctx, cfg)
  M.codelens_ctx = ctx

  if err or result == nil then
    if err then
      log('lsp code lens', vim.inspect(err), ctx, cfg)
    end
    return
  end

  for _, v in pairs(result) do
    _update_sign(v.range.start.line)
  end
end

function M.setup()
  vim.cmd('highlight! link LspCodeLens LspDiagnosticsHint')
  vim.cmd('highlight! link LspCodeLensText LspDiagnosticsInformation')
  vim.cmd('highlight! link LspCodeLensTextSign LspDiagnosticsSignInformation')
  vim.cmd('highlight! link LspCodeLensTextSeparator Boolean')

  local on_codelens = vim.lsp.handlers['textDocument/codeLens']

  vim.lsp.handlers['textDocument/codeLens'] = function(err, result, ctx, cfg)
    -- trace(err, result, ctx.client_id, ctx.bufnr, cfg or {})
    cfg = cfg or {}
    ctx = ctx or { bufnr = vim.api.nvim_get_current_buf() }
    on_codelens(err, result, ctx, cfg)
    codelens_hdlr(err, result, ctx, cfg)
  end
end

M.run = function()
  if vim.o.modified then
    vim.cmd [[w]]
  end

  local bufnr = vim.api.nvim_get_current_buf()
  local line = vim.api.nvim_win_get_cursor(0)[1]

  local lenses = vim.deepcopy(vim.lsp.codelens.get(bufnr))

  lenses = vim.tbl_filter(function(v)
    return v.range.start.line < line
  end, lenses)

  table.sort(lenses, function(a, b)
    return a.range.start.line < b.range.start.line
  end)

  local _, lens = next(lenses)

  local client_id = next(vim.lsp.buf_get_clients(bufnr))
  local client = vim.lsp.get_client_by_id(client_id)
  client.request("workspace/executeCommand", lens.command, function(...)
    local result = vim.lsp.handlers["workspace/executeCommand"](...)
    vim.lsp.codelens.refresh()
    return result
  end, bufnr)
end

return M
