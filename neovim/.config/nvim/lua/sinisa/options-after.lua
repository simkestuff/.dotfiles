-- background color (this line is changed by external script)
vim.o.background = "dark"

-- set themes and other details as wanted
if vim.o.background == "light" then
	vim.api.nvim_set_hl(0, "Normal", { bg = "white" })
	vim.cmd("colorscheme modus")
	vim.api.nvim_set_hl(0, "@comment.c", { fg = "NvimLightGrey4" })
else
	vim.cmd("colorscheme gruber-darker")
end

-- if during session background changes to light
-- set bg color to white
-- vim.api.nvim_create_autocmd("OptionSet", {
-- 	pattern = "background",
-- 	callback = function()
-- 		if vim.o.background == "light" then
-- 			vim.api.nvim_set_hl(0, "Normal", { bg = "white" })
-- 			vim.api.nvim_set_hl(0, "@comment.c", { fg = "NvimLightGrey4" })
-- 		end
-- 	end,
-- })
