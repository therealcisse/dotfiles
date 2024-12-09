local has_ft, ft = pcall(require, "guard.filetype")
if not has_ft then
  return
end

ft('c'):fmt('clang-format')
       :lint('clang-tidy')

ft('lua'):fmt('lsp')
        :append('stylua')
        :lint('selene')

-- Call setup() LAST!
require('guard').setup({
    -- Choose to format on every write to a buffer
    fmt_on_save = true,
    -- Use lsp if no formatter was defined for this filetype
    lsp_as_default_formatter = false,
    -- By default, Guard writes the buffer on every format
    -- You can disable this by setting:
    -- save_on_fmt = false,
})
