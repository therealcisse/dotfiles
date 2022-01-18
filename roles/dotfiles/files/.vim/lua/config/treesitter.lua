local setup = function()
  require("nvim-treesitter.configs").setup({
    playground = { enable = true },
    query_linter = {
      enable = true,
      use_virtual_text = true,
      lint_events = { "BufWrite", "CursorHold" },
    },
    ensure_installed = "maintained",
    highlight = {
      enable = true,
      disable = { "scala" },
    },
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

  })
end

return {
  setup = setup,
}
