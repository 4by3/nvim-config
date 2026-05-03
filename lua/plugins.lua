-- Plugins registration
vim.pack.add({
	-- dap ui
	'https://github.com/folke/lazydev.nvim',
	'https://github.com/nvim-neotest/nvim-nio',

	'https://github.com/rcarriga/nvim-dap-ui',
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

-- DAP UI
local dap, dapui = require("dap"), require("dapui")
dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

-- DAP Adapters & Configs
dap.adapters.debugpy = function(cb, config)
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
dap.configurations.python = {
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

-- Mason
require('mason').setup()

-- Image.nvim
require("image").setup({
	backend = "kitty",
	processor = "magick_cli",
	integrations = {
		markdown = {
			enabled = true,
			clear_in_insert_mode = false,
			download_remote_images = true,
			only_render_image_at_cursor = false,
			only_render_image_at_cursor_mode = "popup",
			floating_windows = false,
			filetypes = { "markdown", "vimwiki" },
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
		neorg = { enabled = true, filetypes = { "norg" } },
		rst = { enabled = true },
		typst = { enabled = true, filetypes = { "typst" } },
		html = { enabled = false },
		css = { enabled = false },
	},
	max_height_window_percentage = 50,
	scale_factor = 1.0,
	window_overlap_clear_enabled = false,
	window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "snacks_notif", "scrollview", "scrollview_sign" },
	editor_only_render_when_focused = false,
	tmux_show_only_in_active_window = false,
	hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" },
})

-- Autopairs
require('nvim-autopairs').setup({})

-- Kanagawa
require('kanagawa').setup({
	colors = { theme = { all = { ui = { bg_gutter = "none" } } } }
})
vim.cmd('colorscheme kanagawa-wave')

-- Markview
vim.api.nvim_set_hl(0, "@markup.strong", { bold = true })
vim.api.nvim_set_hl(0, "@markup.strong.markdown", { bold = true })
require("markview").setup({
	preview = {
		enable = true,
		enable_hybrid_mode = true,
		hybrid_modes = { "n", "i" },
	},
})

-- FzfLua
require('fzf-lua').setup({
	keymap = {
		builtin = {
			["<C-d>"] = 'preview-page-down',
			["<C-u>"] = 'preview-page-up',
		},
	},
})

-- Treesitter
vim.cmd('syntax off')

-- LSP Diagnostics Config
vim.diagnostic.config({
	severity_sort = true,
	update_in_insert = false,
	float = { source = 'if_many' },
	jump = { float = true },
})

-- LSP Enablement
vim.lsp.enable({
	'ty',
	'ruff',
	'lua_ls',
	'config_lsp',
	'csvls',
	'nginx_ls',
	'yaml_ls',
	'bash_ls',
	'clangd',
	'ts_ls',
})

-- LuaSnip
require("luasnip").config.set_config({
	history = true,
	updateevents = "TextChanged,TextChangedI",
})

-- Blink.cmp
require('blink.cmp').setup({
	keymap = { preset = 'super-tab' },
	snippets = { preset = 'luasnip' },
	sources = {
		default = { 'lsp', 'path', 'snippets', 'buffer' },
		providers = {
			lsp = {
				name = 'LSP',
				module = 'blink.cmp.sources.lsp',
				---@param items blink.cmp.CompletionItem[]
				transform_items = function(_, items)
					for _, item in ipairs(items) do
						item.additionalTextEdits = nil
					end
					return items
				end,
			},
		},
	},
})

-- Neoscroll
require('neoscroll').setup({
	hide_cursor = false,
	stop_eof = true,
	easing = 'quadratic',
	duration_multiplier = 0.30,
})

-- Oil.nvim
require("oil").setup({
	view_options = { show_hidden = true },
})

-- Codediff
require("codediff").setup({})
