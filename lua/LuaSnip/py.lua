local luasnip = require("luasnip")
local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node
local fmt = require("luasnip.extras.fmt").fmt
luasnip.add_snippets("python", {
  s(
    "defmain",
    fmt(
      [[
    def main():
        {}
    if __name__ == '__main__':
        main()
    ]],
      {
        i(1, "test_case"),
      }
    )
  ),
  s(
    "def",
    fmt(
      [[
        def {}({}):
            """{}"""
            {}
    ]],
      {
        i(1, "function_name"),
        i(2, "args"),
        i(3, "docstring"),
        i(0),
      }
    )
  ),
})
