-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- use jk to exit insert mode
vim.keymap.set("i", "jj", "<ESC>")

-- nvim Explorer
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

-- keep cursor on center while scrolling
vim.keymap.set("n", "<c-d>", "<c-d>zz")
vim.keymap.set("n", "<c-u>", "<c-u>zz")

-- clear search highlights
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- delete single character without copying to register
vim.keymap.set("n", "x", '"_x')

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>dp", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "<leader>dn", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>de", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>dq", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- terminal
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-N>")

local term_buf, term_win

local toggle_terminal = function()
	if term_win and vim.fn.win_gotoid(term_win) == 1 then
		vim.cmd("hide")
	else
		if term_buf and vim.fn.bufexists(term_buf) == 1 then
			vim.cmd("sb " .. term_buf)
			vim.api.nvim_win_set_height(0, 10)
		else
			vim.cmd.new()
			vim.cmd.terminal()
			vim.cmd.wincmd("J")
			vim.api.nvim_win_set_height(0, 10)
			term_buf = vim.fn.bufnr("%")
		end
		term_win = vim.fn.win_getid()
	end
end

vim.keymap.set("n", "<leader>t", toggle_terminal)
-- vim.keymap.set("n", "<leader>t", function()
-- 	vim.cmd.new()
-- 	vim.cmd.terminal()
-- 	vim.cmd.wincmd("J")
-- 	vim.api.nvim_win_set_height(0, 10)
-- end)
