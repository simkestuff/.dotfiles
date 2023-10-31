-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- use jj to exit insert mode
vim.keymap.set("i", "jj", "<ESC>")

-- nvim Explorer
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

-- keep cursor on center while scrolling
vim.keymap.set("n", "<c-d>", "<c-d>zz")
vim.keymap.set("n", "<c-u>", "<c-u>zz")

-- clear search highlights
vim.keymap.set("n", "<leader>nh", ":nohl<CR>")

-- delete single character without copying to register
vim.keymap.set("n", "x", '"_x')

-- window management
vim.keymap.set("n", "<leader>wv", "<C-w>v") -- split window vertically
vim.keymap.set("n", "<leader>wh", "<C-w>s") -- split window horizontally
vim.keymap.set("n", "<leader>we", "<C-w>=") -- make split windows equal widht & hight
vim.keymap.set("n", "<leader>wx", ":close<CR>") -- close current split window
vim.keymap.set("n", "<leader>wt", "<C-w>T") -- move window into new tab

vim.keymap.set("n", "<leader>tt", ":tabnew<CR>") -- open new tab
vim.keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
vim.keymap.set("n", "<leader>tn", ":tabn<CR>") --  go to next tab
vim.keymap.set("n", "<leader>tp", ":tabp<CR>") --  go to previous tab

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- using šđ umjesto []
-- vim.keymap.set("n", "šc", "[c")
-- vim.keymap.set("n", "đc", "]c")
-- vim.keymap.set("n", "š", "[")
-- vim.keymap.set("n", "đ", "]")
-- vim.keymap.set("n", "Š", "{")
-- vim.keymap.set("n", "Đ", "}")

vim.opt.langmap = "š[,đ],Š{,Đ}"

vim.keymap.set("t", "<ESC>", "<C-\\><C-n>")
