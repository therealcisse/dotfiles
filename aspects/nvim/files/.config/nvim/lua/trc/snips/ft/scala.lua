local ls = require "luasnip"
local snippet_collection = require "luasnip.session.snippet_collection"

-- local snippet = ls.s
-- local snippet_from_nodes = ls.sn

local s = ls.s
local i = ls.insert_node
local t = ls.text_node
-- local d = ls.dynamic_node
local c = ls.choice_node
-- local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

local shared = R "trc.snips"
local same = shared.same

-- ls.cl
snippet_collection.clear_snippets "scala"
ls.add_snippets("scala", {
  s(
    "main",
    fmt(
      [[
    def main(args: Array[String]): Unit = {{
      <>
    }}
    ]],
      {}
    )
  ),

  s("arg", {
    i(1),
    t { ": " },
    i(2),
    t { "," },
    i(0),
  }),

  s("val", {
    t { "val " },
    i(1),
    t { ": " },
    t { " = " },
    i(2),
    i(0),
  }),

  s("def", {
    t { "def " },
    i(1, "Name"),
    t { "(" },
    i(2),
    t { "):" },
    i(3),
    t { " = " },
    i(0),
  }),

  s("enum", {
    t { "enum " },
    i(1, "Name"),
    t { " {", "  " },
    i(0),
    t { "", "}" },
  }),

  s("trait", {
    t { "trait " },
    i(1, "Name"),
    t { " {", "  " },
    i(0),
    t { "", "}" },
  }),

  s("strait", {
    t { "sealed trait " },
    i(1, "Name"),
    t { " {", "  " },
    i(0),
    t { "", "}" },
  }),

  s("cclass", {
    t { "final case class " },
    i(1, "Name"),
    t { " (", "    " },
    i(0),
    t { "", ")" },
  }),

  s("match", {
    t { "match " },
    t { " {", "    " },
    i(0),
    t { "", "}" },
  }),

  s("cs", {
    t { "case " },
    i(1),
    t { " => " },
    i(0),
  }),

  s("pd", {
    t { "println" },
    t { "", "(" },
    i(0),
    t { "", ")" },
  }),

})

