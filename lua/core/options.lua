-- Set <space> as leader (must happen before other plugins loaded)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Relative line numbers
vim.o.relativenumber = true
vim.o.number = true -- display absolute line number instead of 0

-- Case-insensitive searching unless we use capital letters
vim.o.ignorecase = true
vim.o.smartcase = true

-- Raise dialog if you close unsaved buffer (prevent mistakes)
vim.o.confirm = true

-- Snappy escape
vim.o.ttimeoutlen = 1

-- Persistent undo
local undodir = vim.fn.stdpath('state') .. '/undo'
-- Create the directory if it doesn't exist
if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.mkdir(undodir, 'p')
end
vim.opt.undodir = undodir
vim.opt.undofile = true

-- Wrap at word boundary
vim.opt.linebreak = true

-- Sign column for LSP
vim.o.signcolumn = 'yes'

-- Vimtex configuration
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_view_forward_search_on_start = false
vim.g.vimtex_compiler_latexmk = {
	aux_dir = "/home/fbyt/Notes/1Uni/Latex/.texfiles",
	out_dir = "/home/fbyt/Notes/1Uni/Latex/.texfiles",
}
