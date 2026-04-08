-- For `plugins/markview.lua` users.
return {
  "OXY2DEV/markview.nvim",
  lazy = false,
  opts = {
    hybrid_mode = true,
    preview = {
      -- This clears decorations on the current line/block
      linewise_hybrid_mode = true,

      -- Optional: specific modes where hybrid mode is active
      -- Usually 'n' (normal) and 'i' (insert)
      hybrid_modes = { "n", "i" },
    },
  },

  -- Completion for `blink.cmp`
  -- dependencies = { "saghen/blink.cmp" },
}
