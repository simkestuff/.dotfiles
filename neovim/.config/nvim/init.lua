local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

if vim.g.vscode then
	vim.cmd([[source $HOME/.config/nvim/vscode/settings.lua]])
	require("lazy").setup("vsc", {})
else
	require("sinisa.remap")
	require("sinisa.options")

	require("lazy").setup("plugins", {})

  require("sinisa.options-after")
end
