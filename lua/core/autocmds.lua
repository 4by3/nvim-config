-- Markdown spell check
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.opt_local.spell = true
		vim.opt_local.spelllang = 'en_au'
	end,
})

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

-- Treesitter auto-start
vim.api.nvim_create_autocmd('FileType', {
	callback = function() pcall(vim.treesitter.start) end,
})

-- LSP auto-format on save
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
