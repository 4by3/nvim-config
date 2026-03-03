---@diagnostic disable: undefined-global
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- lua/config/keymaps.lua
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true, desc = "" }

keymap("n", "<C-d>", "<C-d>zz", vim.tbl_extend("force", opts, { desc = "Scroll down & center" }))
keymap("n", "<C-u>", "<C-u>zz", vim.tbl_extend("force", opts, { desc = "Scroll up & center" }))
keymap(
  "n",
  "<leader>xx",
  "<cmd>Trouble diagnostics toggle focus=true <cr>",
  { desc = "Trouble: workspace diagnostics", silent = true }
)

vim.keymap.set("n", "<leader>rr", "<cmd>wincmd =<cr>", { desc = "Restore window sizes" })

vim.keymap.set({ "n", "t" }, "<c-/>", function()
  require("snacks").terminal(nil, {
    cwd = require("lazyvim.util").root(), -- <-- CORRECTED THIS LINE
    position = "right",
  })
end, { desc = "Terminal (Root Dir) Vertical" })

local ls = require("luasnip")
vim.keymap.set({ "i", "s" }, "<A-n>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

vim.keymap.set({ "i", "s" }, "<A-j>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<A-k>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })
