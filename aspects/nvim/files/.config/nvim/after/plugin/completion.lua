vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- Don't show the dumb matching stuff.
vim.opt.shortmess:append 'c'

-- Complextras.nvim configuration
-- vim.api.nvim_set_keymap(
--   'i',
--   '<C-x><C-m>',
--   [[<c-r>=luaeval('require('complextras').complete_matching_line()')<CR>]],
--   { noremap = true }
-- )

-- vim.api.nvim_set_keymap(
--   'i',
--   '<C-x><C-d>',
--   [[<c-r>=luaeval('require('complextras').complete_line_from_cwd()')<CR>]],
--   { noremap = true }
-- )

local ok, lspkind = pcall(require, 'lspkind')
if not ok then
  return
end

lspkind.init()

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

local cmp = require 'cmp'
local luasnip = require('luasnip')

cmp.setup {
  mapping = cmp.mapping.preset.insert({
    -- ['<C-e>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    ['<C-J>'] = cmp.mapping(function(fallback)
      if luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
      elseif cmp.visible() then cmp.select_next_item()
      elseif has_words_before() then cmp.complete()
      else fallback()
      end
    end, { 'i', 's' }),

    ['<C-n>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    ['<C-p>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },

    ['<C-K>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then luasnip.jump(-1)
      elseif cmp.visible() then cmp.select_prev_item()
      else fallback()
      end
    end, { 'i', 's' }),

    -- ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),

    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),

  sorting = {
    priority_weight = 1,
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.recently_used,
      -- require("clangd_extensions.cmp_scores"),
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },

  -- Youtube:
  --    the order of your sources matter (by default). That gives them priority
  --    you can configure:
  --        keyword_length
  --        priority
  --        max_item_count
  --        (more?)
  sources = cmp.config.sources({
    -- { name = 'gh_issues' },

    -- Youtube: Could enable this only for lua, but nvim_lua handles that already.
    -- { name = 'nvim_lua' },

    {name = 'nvim_lsp_signature_help'},
    -- { name = 'codeium' },
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
    {
        name = 'lazydev',
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
    },

    -- { name = 'nvim_lsp_signature_help' },
  }),

  -- sorting = {
  --   -- TODO: Would be cool to add stuff like 'See variable names before method names' in rust, or something like that.
  --   comparators = {
  --     cmp.config.compare.offset,
  --     cmp.config.compare.exact,
  --     cmp.config.compare.score,
  --
  --     -- copied from cmp-under, but I don't think I need the plugin for this.
  --     -- I might add some more of my own.
  --     function(entry1, entry2)
  --       local _, entry1_under = entry1.completion_item.label:find '^_+'
  --       local _, entry2_under = entry2.completion_item.label:find '^_+'
  --       entry1_under = entry1_under or 0
  --       entry2_under = entry2_under or 0
  --       if entry1_under > entry2_under then
  --         return false
  --       elseif entry1_under < entry2_under then
  --         return true
  --       end
  --     end,
  --
  --     cmp.config.compare.kind,
  --     cmp.config.compare.sort_text,
  --     cmp.config.compare.length,
  --     cmp.config.compare.order,
  --   },compare.sort_text
  -- },

  -- Youtube: mention that you need a separate snippets plugin
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },

  formatting = {
    expandable_indicator = true,
    fields = { 'abbr' },
    -- Youtube: How to set up nice formatting for your sources.
    format = lspkind.cmp_format {
      with_text = true,
      menu = {
        buffer = '[buf]',
        nvim_lsp = '[LSP]',
        nvim_lua = '[api]',
        path = '[path]',
        luasnip = '[snip]',
        gh_issues = '[issues]',
        tn = '[TabNine]',
      },
    },
  },

  -- experimental = {
  --   -- I like the new menu better! Nice work hrsh7th
  --   native_menu = false,
  --
  --   -- Let's play with this for a day or two
  --   -- ghost_text = true,
  -- },
}

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  -- completion = {
  --   -- Might allow this later, but I don't like it right now really.
  --   -- Although, perhaps if it just triggers w/ @ then we could.
  --   --
  --   -- I will have to come back to this.
  --   autocomplete = false,
  -- },
  sources = cmp.config.sources({
    { name = 'nvim_lsp_document_symbol' },
  }, {
    { name = 'buffer', keyword_length = 5 },
  }),
})

cmp.setup.cmdline(':', {
  -- completion = {
  --   autocomplete = false,
  -- },
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    {
      name = 'path',
    },
  }, {
    {
      name = 'cmdline',
      max_item_count = 20,
      keyword_length = 4,
    },
  }),
})

cmp.event:on("menu_opened", function()
  vim.b.copilot_suggestion_hidden = true
end)

cmp.event:on("menu_closed", function()
  vim.b.copilot_suggestion_hidden = false
end)

--[[
' Setup buffer configuration (nvim-lua source only enables in Lua filetype).
'
' ON YOUTUBE I SAID: This only _adds_ sources for a filetype, not removes the global ones.
'
' BUT I WAS WRONG! This will override the global setup. Sorry for any confusion.
autocmd FileType lua lua require'cmp'.setup.buffer {
\   sources = {
\     { name = 'nvim_lua' },
\     { name = 'buffer' },
\   },
\ }
--]]

-- Add vim-dadbod-completion in sql files
_ = vim.cmd [[
  augroup DadbodSql
    au!
    autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer { sources = { { name = 'vim-dadbod-completion' } } }
  augroup END
]]

_ = vim.cmd [[
  augroup CmpZsh
    au!
    autocmd Filetype zsh lua require'cmp'.setup.buffer { sources = { { name = 'zsh' }, } }
  augroup END
]]

--[[
' Disable cmp for a buffer
autocmd FileType TelescopePrompt lua require('cmp').setup.buffer { enabled = false }
--]]

-- Youtube: customizing appearance
--
-- nvim-cmp highlight groups.
-- local Group = require('colorbuddy.group').Group
-- local g = require('colorbuddy.group').groups
-- local s = require('colorbuddy.style').styles
--
-- Group.new('CmpItemAbbr', g.Comment)
-- Group.new('CmpItemAbbrDeprecated', g.Error)
-- Group.new('CmpItemAbbrMatchFuzzy', g.CmpItemAbbr.fg:dark(), nil, s.italic)
-- Group.new('CmpItemKind', g.Special)
-- Group.new('CmpItemMenu', g.NonText)
-- vscode format

require('luasnip.loaders.from_vscode').lazy_load()
require('luasnip.loaders.from_vscode').lazy_load({ paths = vim.g.vscode_snippets_path or '' })

-- snipmate format
require('luasnip.loaders.from_snipmate').load()
require('luasnip.loaders.from_snipmate').lazy_load({ paths = vim.g.snipmate_snippets_path or '' })

-- lua format
require('luasnip.loaders.from_lua').load()
require('luasnip.loaders.from_lua').lazy_load({ paths = vim.g.lua_snippets_path or '' })

vim.api.nvim_create_autocmd('InsertLeave', {
	callback = function()
		if
			require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
			and not require('luasnip').session.jump_active
		then
			require('luasnip').unlink_current()
		end
	end,
})

local aok, autopair = pcall(require, 'autopair')
if aok then
	cmp.event:on('confirm_done', autopair.on_confirm_done())
end


-- Customization for Pmenu
vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#282C34", fg = "NONE" })
vim.api.nvim_set_hl(0, "Pmenu", { fg = "#C5CDD9", bg = "#22252A" })

vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#7E8294", bg = "NONE", strikethrough = true })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#82AAFF", bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#82AAFF", bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#C792EA", bg = "NONE", italic = true })

vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = "#EED8DA", bg = "#B5585F" })
vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = "#EED8DA", bg = "#B5585F" })
vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = "#EED8DA", bg = "#B5585F" })

vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#C3E88D", bg = "#9FBD73" })
vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = "#C3E88D", bg = "#9FBD73" })
vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#C3E88D", bg = "#9FBD73" })

vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = "#FFE082", bg = "#D4BB6C" })
vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = "#FFE082", bg = "#D4BB6C" })
vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = "#FFE082", bg = "#D4BB6C" })

vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#EADFF0", bg = "#A377BF" })
vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = "#EADFF0", bg = "#A377BF" })
vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = "#EADFF0", bg = "#A377BF" })
vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = "#EADFF0", bg = "#A377BF" })
vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = "#EADFF0", bg = "#A377BF" })

vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#C5CDD9", bg = "#7E8294" })
vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = "#C5CDD9", bg = "#7E8294" })

vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = "#F5EBD9", bg = "#D4A959" })
vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = "#F5EBD9", bg = "#D4A959" })
vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = "#F5EBD9", bg = "#D4A959" })

vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#DDE5F5", bg = "#6C8ED4" })
vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = "#DDE5F5", bg = "#6C8ED4" })
vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = "#DDE5F5", bg = "#6C8ED4" })

vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = "#D8EEEB", bg = "#58B5A8" })
vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = "#D8EEEB", bg = "#58B5A8" })
vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = "#D8EEEB", bg = "#58B5A8" })
