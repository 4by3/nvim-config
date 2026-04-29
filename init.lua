vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.opt_local.spell = true
		vim.opt_local.spelllang = 'en_au'
	end,
})


-- Spam Ctrl < and Ctrl >
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- Persistent undo
local undodir = vim.fn.stdpath('state') .. '/undo'

-- Go through display lines
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Create the directory if it doesn't exist
if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.mkdir(undodir, 'p')
end

vim.opt.undodir = undodir
vim.opt.undofile = true

-- Wrap at word boundary
vim.opt.linebreak = true
-- Alt backspace
vim.keymap.set("i", "<A-BS>", "<C-w>", { noremap = true })
vim.keymap.set("i", "<A-Del>", "<C-o>dw", { noremap = true })

-- Set <space> as leader (must happen before other plugins loaded)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Bind Ctrl-C to Esc
vim.keymap.set('i', '<C-c>', '<Esc>')

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

-- Vim diagnostics
vim.diagnostic.config({
	severity_sort = true,    -- show most severe error first
	update_in_insert = false, -- don't update while typing
	float = { source = 'if_many' }, -- nicer look for floats and show source if multiple sources (ex. ruff and ty)
	jump = { float = true }, -- automatically open the diagnostic float if you jump with [d ]d
})



-- Show diagnostics
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Show diagnostics' })

-- Easily move between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
-- Moving from terminal
vim.keymap.set('t', '<C-k>', [[<C-\><C-n><C-w>k]], { silent = true })
vim.keymap.set('t', '<C-h>', [[<C-\><C-n><C-w>h]], { silent = true })
vim.keymap.set('t', '<C-j>', [[<C-\><C-n><C-w>j]], { silent = true })
vim.keymap.set('t', '<C-l>', [[<C-\><C-n><C-w>l]], { silent = true })

-- -- Open terminal in a horizontal split at the bottom
-- vim.keymap.set('n', '<C-_>', ':botright split | term<CR>A', { silent = true })
-- vim.keymap.set('n', '<C-/>', ':botright split | term<CR>A', { silent = true })
--
-- -- Terminal mode: Allow toggling or escaping back to normal mode
-- -- Note: <C-/> is often interpreted as <C-_> in terminal mode
-- vim.keymap.set('t', '<C-_>', [[<C-\><C-n>:q<CR>]], { silent = true })
-- vim.keymap.set('t', '<C-/>', [[<C-\><C-n>:q<CR>]], { silent = true })
local function toggle_terminal()
	-- Look for a buffer with 'terminal' in its name or type
	local term_buf = nil
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.bo[buf].buftype == 'terminal' then
			term_buf = buf
			break
		end
	end

	if term_buf then
		-- Check if the terminal is already visible in a window
		local term_win = vim.fn.bufwinnr(term_buf)
		if term_win > 0 then
			-- If visible, close it (toggle off)
			vim.cmd(term_win .. "hide")
		else
			-- If exists but hidden, open in a split and switch to it
			vim.cmd("botright sbuf " .. term_buf)
			vim.cmd("startinsert")
		end
	else
		-- No terminal exists, create a new one
		vim.cmd("botright split | term")
		vim.cmd("startinsert")
	end
end

-- Normal mode: Toggle
vim.keymap.set('n', '<C-_>', toggle_terminal, { silent = true })
vim.keymap.set('n', '<C-/>', toggle_terminal, { silent = true })

-- Terminal mode: Hide the window (simulates "closing" without killing the process)
vim.keymap.set('t', '<C-_>', [[<C-\><C-n>:hide<CR>]], { silent = true })
vim.keymap.set('t', '<C-/>', [[<C-\><C-n>:hide<CR>]], { silent = true })

-- Highlight yanks
vim.api.nvim_create_autocmd('TextYankPost', {
	group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
	callback = function() vim.highlight.on_yank() end,
})

-- Hide diagnostics in insert mode, show them when leaving
vim.api.nvim_create_autocmd('InsertEnter', {
	group = vim.api.nvim_create_augroup('diagnostic_cmds', { clear = true }),
	callback = function()
		vim.diagnostic.hide()
	end,
})

vim.api.nvim_create_autocmd('InsertLeave', {
	group = vim.api.nvim_create_augroup('diagnostic_cmds', { clear = false }),
	callback = function()
		vim.diagnostic.show()
	end,
})

-- Plugins
vim.pack.add({
	'https://github.com/lervag/vimtex',
	'https://github.com/windwp/nvim-autopairs',
	'https://github.com/folke/which-key.nvim',
	'https://github.com/ibhagwan/fzf-lua',
	'https://github.com/3rd/image.nvim',
	'https://github.com/nvim-treesitter/nvim-treesitter',
	'https://github.com/neovim/nvim-lspconfig',
	'https://github.com/mason-org/mason.nvim',
	'https://github.com/karb94/neoscroll.nvim',
	'https://github.com/mfussenegger/nvim-dap',
	'https://github.com/stevearc/oil.nvim',
	'https://github.com/kdheepak/lazygit.nvim',
	'https://github.com/esmuellert/codediff.nvim',
	'https://github.com/goolord/alpha-nvim',
	'https://github.com/rebelot/kanagawa.nvim',
	'https://github.com/L3MON4D3/LuaSnip',
	-- 'https://github.com/MeanderingProgrammer/render-markdown.nvim',
	'https://github.com/OXY2DEV/markview.nvim',
	'https://github.com/nvim-lua/plenary.nvim',
	'https://github.com/nvim-telescope/telescope.nvim',
	{ src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('1.x') }, -- pinning so rust binary dependency automatically downloads
})


--- vimtex zathura
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_view_forward_search_on_start = false
vim.g.vimtex_compiler_latexmk = {
	aux_dir = "/home/fbyt/Notes/1Uni/Latex/.texfiles",
	out_dir = "/home/fbyt/Notes/1Uni/Latex/.texfiles",
}

require('mason').setup()

require("image").setup({
	backend = "kitty", -- or "ueberzug" or "sixel"
	processor = "magick_cli", -- or "magick_rock"
	integrations = {
		markdown = {
			enabled = true,
			clear_in_insert_mode = false,
			download_remote_images = true,
			only_render_image_at_cursor = false,
			only_render_image_at_cursor_mode = "popup", -- or "inline"
			floating_windows = false, -- if true, images will be rendered in floating markdown windows
			filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
		},
		asciidoc = {
			enabled = true,
			clear_in_insert_mode = false,
			download_remote_images = true,
			only_render_image_at_cursor = false,
			only_render_image_at_cursor_mode = "popup",
			floating_windows = false,
			filetypes = { "asciidoc", "adoc" },
		},
		neorg = {
			enabled = true,
			filetypes = { "norg" },
		},
		rst = {
			enabled = true,
		},
		typst = {
			enabled = true,
			filetypes = { "typst" },
		},
		html = {
			enabled = false,
		},
		css = {
			enabled = false,
		},
	},
	max_width = nil,
	max_height = nil,
	max_width_window_percentage = nil,
	max_height_window_percentage = 50,
	scale_factor = 1.0,
	window_overlap_clear_enabled = false,                                        -- toggles images when windows are overlapped
	window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "snacks_notif", "scrollview", "scrollview_sign" },
	editor_only_render_when_focused = false,                                     -- auto show/hide images when the editor gains/looses focus
	tmux_show_only_in_active_window = false,                                     -- auto show/hide images in the correct Tmux window (needs visual-activity off)
	hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
})

require('nvim-autopairs').setup({})

-- Kanagawa
require('kanagawa').setup({
	colors = {
		theme = {
			all = {
				ui = {
					bg_gutter = "none"
				}
			}
		}
	}
})
vim.cmd('colorscheme kanagawa-wave') -- need to call after setup

-- Markdown
-- require("markview").setup({
-- 	hybrid_mode = true,
-- 	-- linewise_hybrid_mode = true,
-- 	-- hybrid_modes = { "n", "i" },
-- })

vim.api.nvim_set_hl(0, "@markup.strong", { bold = true })
vim.api.nvim_set_hl(0, "@markup.strong.markdown", { bold = true })

require("markview").setup({
	preview = {
		enable = true,
		enable_hybrid_mode = true,
		-- You MUST define which modes hybrid mode is active in
		hybrid_modes = { "n", "i" },
	},
	-- -- Markview also needs to know which modes to show the preview in generally
	-- modes = { "n", "i", "no", "c" },
	--
	-- callbacks = {
	-- 	on_enable = function(_, win)
	-- 		-- These are mandatory for hybrid mode to visually function
	-- 		vim.wo[win].conceallevel = 2
	-- 		vim.wo[win].concealcursor = "nc"
	-- 	end
	-- }
})


-- FzfLua Setup
require('fzf-lua').setup({
	keymap = {
		builtin = {
			["<C-d>"] = 'preview-page-down', -- Better scrolling within the displays
			["<C-u>"] = 'preview-page-up',
		},
	},
})


vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show line diagnostics' })


vim.keymap.set('n', '<leader><leader>', '<cmd>FzfLua files<cr>', { desc = 'Find files' })
vim.keymap.set('n', '<leader>/', '<cmd>FzfLua live_grep<cr>', { desc = 'Find live grep' })

-- Treesitter
vim.cmd('syntax off') -- Make it obvious if treesitter is missing
vim.api.nvim_create_autocmd('FileType', {
	callback = function() pcall(vim.treesitter.start) end,
})

-- LSP
vim.lsp.enable({
	-- 'harper_ls',
	'ty', -- also $ uv tool install ty@latest
	'ruff', -- also $ uv tool install ruff@latest
	'lua_ls', -- also $ brew install lua-language-server
	'config_lsp',
	'csvls',
	'nginx_ls',
	'yaml_ls',
	'bash_ls',
	'clangd',
	'ts_ls',
})


vim.o.signcolumn = 'yes' -- make lsp warnings not widen the gutter
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
-- Auto-format ("lint") on save (adapted from neovim docs :help auto-format)
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('my.lsp', { clear = true }),
	callback = function(ev)
		local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
		if not client:supports_method('textDocument/willSaveWaitUntil')
		    and client:supports_method('textDocument/formatting') then
			vim.api.nvim_create_autocmd('BufWritePre', {
				group = vim.api.nvim_create_augroup('my.lsp.fmt', { clear = false }),
				buffer = ev.buf,
				callback = function()
					vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
				end,
			})
		end
	end,
})
-- Blink.cmp
require('blink.cmp').setup({
	keymap = {
		preset = 'super-tab', -- Use 'none' to avoid conflicts if defining all manually
	},
})


-- Neoscroll
require('neoscroll').setup({
	hide_cursor = false,
	stop_eof = true,
	easing = 'quadratic',
	duration_multiplier = 0.30,
})

-- Dap (debugging)
local dap = require('dap')
dap.adapters.debugpy = function(cb, config) -- also $ uv tool install debugpy@latest
	if config.request == 'attach' then
		cb({
			type = 'server',
			port = config.connect.port,
			host = config.connect.host or '127.0.0.1',
		})
	else
		cb({
			type = 'executable',
			command = 'debugpy-adapter',
		})
	end
end
dap.configurations.python = { -- https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
	{
		type = 'debugpy',
		request = 'launch',
		name = 'Launch file',
		program = '${file}',
		python = function()
			local root = vim.fs.root(0, '.venv')
			return { root and root .. '/.venv/bin/python' or 'python3' }
		end,
		cwd = function()
			return vim.fs.root(0, '.venv') or vim.fn.getcwd()
		end,
	},
}
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug toggle breakpoint' })
vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'Debug continue' })
vim.keymap.set('n', '<leader>dq', dap.terminate, { desc = 'Debug terminate' })
vim.keymap.set('n', '<leader>dr', dap.repl.open, { desc = 'Debug open REPL' })
vim.keymap.set('n', '<leader>dl', dap.run_last, { desc = 'Debug run last' })
vim.keymap.set({ 'n', 'v' }, '<leader>dh', require('dap.ui.widgets').hover, { desc = 'Debug hover' })
vim.keymap.set('n', '<leader>ds', function()
	require('dap.ui.widgets').centered_float(require('dap.ui.widgets').scopes)
end, { desc = 'Debug scopes' })
vim.keymap.set('n', '<Down>', dap.step_over, { desc = 'Debug step over' })
vim.keymap.set('n', '<Right>', dap.step_into, { desc = 'Debug step into' })
vim.keymap.set('n', '<Left>', dap.step_out, { desc = 'Debug step out' })
vim.keymap.set('n', '<Up>', dap.restart_frame, { desc = 'Debug restart frame' })

-- Oil.nvim
require("oil").setup({
	view_options = {
		show_hidden = true,
	},
})
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Lazygit.nvim
vim.keymap.set('n', '<leader>g', '<cmd>LazyGit<cr>', { desc = 'Lazygit' })

-- Codediff (vscode like diffs :))
require("codediff").setup({})


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


local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
