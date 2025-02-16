if not pcall(require, 'nvim-treesitter') then
  return
end

local ts_debugging = false
if ts_debugging then
  RELOAD 'nvim-treesitter'
end

local parser_config = require('nvim-treesitter.parsers').get_parser_configs()

-- parser_config.ziggy = {
--   install_info = {
--     url = 'https://github.com/kristoff-it/ziggy', -- local path or git repo
--     includes = {'tree-sitter-ziggy/src'},
--     files = {'tree-sitter-ziggy/src/parser.c'}, -- note that some parsers also require src/scanner.c or src/scanner.cc
--     -- optional entries:
--     branch = 'main', -- default branch in case of git repo if different from master
--     generate_requires_npm = false, -- if stand-alone parser without npm dependencies
--     requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
--   },
-- }

-- parser_config.ziggy_schema = {
--   install_info = {
--     url = 'https://github.com/kristoff-it/ziggy', -- local path or git repo
--     files = {'tree-sitter-ziggy-schema/src/parser.c'}, -- note that some parsers also require src/scanner.c or src/scanner.cc
--     -- optional entries:
--     branch = 'main', -- default branch in case of git repo if different from master
--     generate_requires_npm = false, -- if stand-alone parser without npm dependencies
--     requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
--   },
--   filetype = 'ziggy-schema',
-- }

-- vim.filetype.add({
--   extension = {
--     ziggy = 'ziggy',
--     ['ziggy-schema'] = 'ziggy_schema',
--   }
-- })

-- parser_config.sql = {
--   install_info = {
--     url = 'https://github.com/DerekStride/tree-sitter-sql',
--     files = { 'src/parser.c' },
--     branch = 'main',
--   },
-- }

-- parser_config.dart = {
--   install_info = {
--     url = 'https://github.com/UserNobody14/tree-sitter-dart',
--     files = { 'src/parser.c', 'src/scanner.c' },
--     revision = '8aa8ab977647da2d4dcfb8c4726341bee26fbce4', -- The last commit before the snail speed
--   },
-- }

-- parser_config.scala = {
--   install_info = {
--     -- url can be Git repo or a local directory:
--     -- url = '~/work/tree-sitter-scala',
--     url = 'https://github.com/tree-sitter/tree-sitter-scala',
--     branch = 'master',
--     files = {'src/parser.c', 'src/scanner.c'},
--     requires_generate_from_grammar = false,
--   },
-- }

-- parser_config.rsx = {
--   install_info = {
--     url = 'https://github.com/tjdevries/tree-sitter-rsx',
--     files = { 'src/parser.c', 'src/scanner.cc' },
--     branch = 'master',
--   },
-- }

-- parser_config.lua = nil

-- :h nvim-treesitter-query-extensions
local custom_captures = {
  ['function.call'] = 'LuaFunctionCall',
  ['function.bracket'] = 'Type',
  ['namespace.type'] = 'TSNamespaceType',
}

-- require('nvim-treesitter.highlight').set_custom_captures(custom_captures)

-- alt+<space>, alt+p -> swap next
-- alt+<backspace>, alt+p -> swap previous
-- swap_previous = {
--   ['<M-s><M-P>'] = '@parameter.inner',
--   ['<M-s><M-F>'] = '@function.outer',
-- },
local swap_next, swap_prev = (function()
  local swap_objects = {
    p = '@parameter.inner',
    f = '@function.outer',
    e = '@element',

    -- Not ready, but I think it's my fault :)
    -- v = '@variable',
  }

  local n, p = {}, {}
  for key, obj in pairs(swap_objects) do
    n[string.format('<M-Space><M-%s>', key)] = obj
    p[string.format('<M-BS><M-%s>', key)] = obj
  end

  return n, p
end)()

local _ = require('nvim-treesitter.configs').setup {
  sync_install = false,

  auto_install = true,

  ignore_install = {},

  modules = {},

  ensure_installed = {
    -- 'sql',
    'bash',
    'yaml',
    'markdown',
    'markdown_inline',
    'hcl',
    'dap_repl',
    'lua',
    'regex',
    'markdown_inline',
    -- 'dart',
    'scala',
    -- 'zig',
    'go',
    'html',
    'javascript',
    'java',
    'json',
    'markdown',
    'python',
    -- 'query',
    -- 'rust',
    -- 'toml',
    'tsx',
    -- 'typescript',
  },

  highlight = {
    enable = true,
    -- use_languagetree = false,
    -- -- disable = { 'json' },
    -- custom_captures = custom_captures,
  },

  indent = {
    enable = true,
    disable = { 'dart', 'python', 'css', 'html', 'gdscript', 'gdscript3', 'gd' },
  },

  refactor = {
    highlight_definitions = { enable = false },
    highlight_current_scope = { enable = false },

    smart_rename = {
      enable = false,
      keymaps = {
        -- mapping to rename reference under cursor
        smart_rename = 'grr',
      },
    },

    navigation = {
      enable = false,
      keymaps = {
        goto_definition = 'gnd', -- mapping to go to definition of symbol under cursor
        list_definitions = 'gnD', -- mapping to list all definitions in current file
      },
    },
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },

  context_commentstring = {
    enable = true,

    -- With Comment.nvim, we don't need to run this on the autocmd.
    -- Only run it in pre-hook
    enable_autocmd = false,

    config = {
      c = '// %s',
      lua = '-- %s',
    },
  },

  textobjects = {
    move = {
      enable = true,
      set_jumps = true,

      goto_next_start = {
        [']p'] = '@parameter.inner',
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[p'] = '@parameter.inner',
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },

    select = {
      enable = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',

        ['ac'] = '@conditional.outer',
        ['ic'] = '@conditional.inner',

        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',

        ['av'] = '@variable.outer',
        ['iv'] = '@variable.inner',
      },
    },

    swap = {
      enable = true,
      swap_next = swap_next,
      swap_previous = swap_prev,
    },
  },

  playground = {
    enable = true,
    updatetime = 25,
    persist_queries = true,
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',

      -- This shows stuff like literal strings, commas, etc.
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },
}

local read_query = function(filename)
  return table.concat(vim.fn.readfile(vim.fn.expand(filename)), '\n')
end

-- Overrides any existing tree sitter query for a particular name
-- vim.treesitter.set_query('rust', 'highlights', read_query '~/.config/nvim/queries/rust/highlights.scm')
-- vim.treesitter.set_query('sql', 'highlights', read_query '~/.config/nvim/queries/sql/highlights.scm')

vim.cmd [[highlight IncludedC guibg=#373b41]]

vim.cmd [[nnoremap <leader>tp :TSPlaygroundToggle<CR>]]
vim.cmd [[nnoremap <leader>th :TSHighlightCapturesUnderCursor<CR>]]

local ts_repeat_move = require 'nvim-treesitter.textobjects.repeatable_move'

-- Repeat movement with ; and ,
-- ensure ; goes forward and , goes backward regardless of the last direction
vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move_next)
vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_previous)

-- vim way: ; goes to the direction you were moving.
-- vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move)
-- vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_opposite)

-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f_expr, { expr = true })
vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F_expr, { expr = true })
vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t_expr, { expr = true })
vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T_expr, { expr = true })

-- example: make gitsigns.nvim movement repeatable with ; and , keys.
local gs = require('gitsigns')

-- make sure forward function comes first
local next_hunk_repeat, prev_hunk_repeat = ts_repeat_move.make_repeatable_move_pair(gs.next_hunk, gs.prev_hunk)
-- Or, use `make_repeatable_move` or `set_last_move` functions for more control. See the code for instructions.

vim.keymap.set({ 'n', 'x', 'o' }, ']c', next_hunk_repeat)
vim.keymap.set({ 'n', 'x', 'o' }, '[c', prev_hunk_repeat)
