-- lua/plugins/snacks.lua

return {
  "folke/snacks.nvim",
  opts = {
    -- This section configures the default behavior for the terminal window
    terminal = {
      -- Change the default position/layout
      win = {
        size = 30, -- optional: set the width (e.g., 30 columns)
      },
    },
  },
}
