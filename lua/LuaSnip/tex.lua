local luasnip = require("luasnip")
local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local extras = require("luasnip.extras")
local rep = extras.rep

luasnip.add_snippets("tex", {
  s(
    "beg",
    fmt(
      [[
      \begin{<>}
          <>
      \end{<>}
      ]],
      { i(1), i(2), rep(1) },
      { delimiters = "<>" }
    )
  ),
})
