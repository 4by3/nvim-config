-- Spam Ctrl < and Ctrl >
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- Go through display lines
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Alt backspace
vim.keymap.set("i", "<A-BS>", "<C-w>", { noremap = true })
vim.keymap.set("i", "<A-Del>", "<C-o>dw", { noremap = true })

-- Bind Ctrl-C to Esc
vim.keymap.set('i', '<C-c>', '<Esc>')

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

-- Terminal Toggle Logic
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

-- Oil.nvim
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Lazygit.nvim
vim.keymap.set('n', '<leader>g', '<cmd>LazyGit<cr>', { desc = 'Lazygit' })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Show diagnostics' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show line diagnostics' })

-- LSP keymaps
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code action' })

-- FzfLua keymaps
vim.keymap.set('n', '<leader><leader>', '<cmd>FzfLua files<cr>', { desc = 'Find files' })
vim.keymap.set('n', '<leader>/', '<cmd>FzfLua live_grep<cr>', { desc = 'Find live grep' })

-- Telescope keymaps
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- LuaSnip keymaps
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

-- DAP keymaps
local dap = require("dap")
local dapui = require("dapui")

vim.keymap.set('n', '<leader>du', function() dapui.toggle() end, { desc = "Debug: Toggle UI" })
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug toggle breakpoint' })
vim.keymap.set('n', '<leader>dc', function()
	if vim.bo.modified then
		vim.cmd('write')
	end
	dap.continue()
end, { desc = 'Save and Debug continue' })
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
