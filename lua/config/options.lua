-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

---@diagnostic disable: undefined-global

vim.opt.relativenumber = true

vim.opt.clipboard = "unnamedplus"

vim.opt.wrap = true

-- vim.g.clipboard = {
--   name = "wl-clipboard",
--   copy = {
--     ["+"] = { "wl-copy", "--foreground", "--type", "text/plain" },
--     ["*"] = { "wl-copy", "--foreground", "--primary", "--type", "text/plain" },
--   },
--   paste = {
--     ["+"] = { "wl-paste", "--no-newline" },
--     ["*"] = { "wl-paste", "--no-newline", "--primary" },
--   },
--   cache_enabled = true,
-- }
--
-- vim.g.clipboard = {
--   name = "wl-clipboard",
--   copy = {
--     ["+"] = "wl-copy",
--     ["*"] = "wl-copy",
--   },
--   paste = {
--     ["+"] = "wl-paste",
--     ["*"] = "wl-paste",
--   },
--   cache_enabled = 1,
-- }

--- vimtex okular
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_view_forward_search_on_start = false
vim.g.vimtex_compiler_latexmk = {
  aux_dir = "/home/fbyt/Notes/1Uni-Monash/Math/.texfiles",
  out_dir = "/home/fbyt/Notes/1Uni-Monash/Math/.texfiles",
}
