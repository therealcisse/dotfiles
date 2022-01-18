require'lspconfig'.tsserver.setup({})

require('nvim-autopairs').setup({})

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- list of language that will be disabled
    disable = { "c", "rust" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  -- incremental_selection = {
  --   enable = true,
  --   keymaps = {
  --     init_selection = "gnn",
  --     node_incremental = "grn",
  --     scope_incremental = "grc",
  --     node_decremental = "grm",
  --   },
  -- },
  textobjects = {
    swap = {
       enable = true,
       swap_next = {["<leader>xp"] = "@parameter.inner"},
       swap_previous = {["<leader>xP"] = "@parameter.inner"}
    },
    lsp_interop = {
      enable = true,
       border = 'none',
       peek_definition_code = {
          ["<leader>pf"] = "@function.outer",
          ["<leader>pc"] = "@class.outer"
       }
     },
     context_commentstring = {enable = true},
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner"
      }
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer'
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer'
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer'
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer'
      }
    }
  }
}

local gps = require("nvim-gps")

require("lualine").setup({
  options = {theme = 'gruvbox'},
  sections = {
    lualine_c = {
      { gps.get_location, cond = gps.is_available },
    }
  }
})

require('lspkind').init({
  with_text = true,
  symbol_map = {
    Text = '',
    Method = 'ƒ',
    Function = '',
    Constructor = '',
    Variable = '',
    Class = '',
    Interface = 'ﰮ',
    Module = '',
    Property = '',
    Unit = '',
    Value = '',
    Enum = '了',
    Keyword = '',
    Snippet = '﬌',
    Color = '',
    File = '',
    Folder = '',
    EnumMember = '',
    Constant = '',
    Struct = ''
  },
})

require'lsp_signature'.on_attach({})

-- local cmp = require'cmp'

-- cmp.setup({
--   snippet = {
--     -- REQUIRED - you must specify a snippet engine
--     expand = function(args)
--       vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
--       -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
--       -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
--       -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
--     end,
--   },
--   mapping = {
--     -- ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
--     -- ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
--     ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
--     ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
--     -- ['<C-e>'] = cmp.mapping({
--     --   i = cmp.mapping.abort(),
--     --   c = cmp.mapping.close(),
--     -- }),
--     ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
--   },
--   sources = cmp.config.sources({
--     { name = 'nvim_lsp' },
--     { name = 'vsnip' }, -- For vsnip users.
--     -- { name = 'luasnip' }, -- For luasnip users.
--     -- { name = 'ultisnips' }, -- For ultisnips users.
--     -- { name = 'snippy' }, -- For snippy users.
--   }, {
--     { name = 'buffer' },
--   })
-- })

-- -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline('/', {
--   sources = {
--     { name = 'buffer' }
--   }
-- })

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline(':', {
--   sources = cmp.config.sources({
--     { name = 'path' }
--   }, {
--     { name = 'cmdline' }
--   })
-- })

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require('lspconfig')['rust_analyzer'].setup {capabilities = capabilities}
require('lspconfig')['tsserver'].setup {capabilities = capabilities}

require'snippets'.use_suggested_mappings()

local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')

-- -- skip it, if you use another global object
-- _G.MUtils = {}

-- vim.g.completion_confirm_key = ""
-- MUtils.completion_confirm = function ()
--   if vim.fn.pumvisible() ~= 0 then
--     if vim.fn.complete_info()["selected"] ~= -1 then
--       return vim.fn["compe#confirm"](npairs.esc("<cr>"))
--     else
--       return npairs.esc("<cr>")
--     end
--   else
--     return npairs.autopairs_cr()
--   end
-- end

-- remap('i', '<CR>', 'v:lua.MUtils.completion_confirm()',
-- {expr = true, noremap = true})

-- local t = function (str)
--   return vim.api.nvim_replace_termcodes(str, true, true, true)
-- end

-- local check_back_space = function ()
--   local col = vim.fn.col('.') - 1
--   if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
--     return true
--   else
--     return false
--   end
-- end

-- --  Use (s-)tab to:
-- -- move to prev/next item in completion menuone
-- -- jump to prev/next snippet's placeholder
-- _G.tab_complete = function ()
--   if vim.fn.pumvisible() == 1 then
--     return t "<C-n>"
--   elseif vim.fn.call("vsnip#available", {1}) == 1 then
--     return t "<Plug>(vsnip-expand-or-jump)"
--   elseif check_back_space() then
--     return t "<Tab>"
--   else
--     return vim.fn['compe#complete']()
--   end
-- end

-- _G.s_tab_complete = function ()
--   if vim.fn.pumvisible() == 1 then
--     return t "<C-p>"
--   elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
--     return t "<Plug>(vsnip-jump-prev)"
--   else
--     return t "<S-Tab>"
--   end
-- end

-- vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

require'shade'.setup({
  overlay_opacity = 50,
  opacity_step = 1,
  keys = {
    brightness_up    = '<localleader><Up>',
    brightness_down  = '<localleader><Down>',
    toggle           = '<localleader>d',
  }
})

-- require("stay-centered")

-- function _G.qftf(info)
--     local items
--     local ret = {}
--     if info.quickfix == 1 then
--         items = fn.getqflist({id = info.id, items = 0}).items
--     else
--         items = fn.getloclist(info.winid, {id = info.id, items = 0}).items
--     end
--     local limit = 31
--     local fname_fmt1, fname_fmt2 = '%-' .. limit .. 's', '…%.' .. (limit - 1) .. 's'
--     local valid_fmt = '%s │%5d:%-3d│%s %s'
--     for i = info.start_idx, info.end_idx do
--         local e = items[i]
--         local fname = ''
--         local str
--         if e.valid == 1 then
--             if e.bufnr > 0 then
--                 fname = fn.bufname(e.bufnr)
--                 if fname == '' then
--                     fname = '[No Name]'
--                 else
--                     fname = fname:gsub('^' .. vim.env.HOME, '~')
--                 end
--                 -- char in fname may occur more than 1 width, ignore this issue in order to keep performance
--                 if #fname <= limit then
--                     fname = fname_fmt1:format(fname)
--                 else
--                     fname = fname_fmt2:format(fname:sub(1 - limit))
--                 end
--             end
--             local lnum = e.lnum > 99999 and -1 or e.lnum
--             local col = e.col > 999 and -1 or e.col
--             local qtype = e.type == '' and '' or ' ' .. e.type:sub(1, 1):upper()
--             str = valid_fmt:format(fname, lnum, col, qtype, e.text)
--         else
--             str = e.text
--         end
--         table.insert(ret, str)
--     end
--     return ret
-- end

-- vim.o.qftf = '{info -> v:lua._G.qftf(info)}'
