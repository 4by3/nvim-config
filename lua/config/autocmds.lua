-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Force diagnostics to show inline immediately after leaving Insert mode
vim.api.nvim_create_autocmd({ "InsertLeave", "InsertLeavePre" }, {
  callback = function()
    if vim.bo.filetype ~= "" then
      vim.diagnostic.show(nil, 0)
    end
  end,
  desc = "Show diagnostics after leaving insert mode",
})

vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = "i*:n*",
  callback = function()
    if vim.bo.buftype == "" and vim.bo.filetype ~= "" then
      vim.diagnostic.show(nil, 0)
    end
  end,
  desc = "Show inline diagnostics after leaving Insert",
})
