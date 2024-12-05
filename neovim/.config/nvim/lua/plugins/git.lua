return {
	-- {
	-- 	"NeogitOrg/neogit",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim", -- required
	-- 		"sindrets/diffview.nvim", -- optional - Diff integration
	--
	-- 		-- Only one of these is needed, not both.
	-- 		"nvim-telescope/telescope.nvim", -- optional
	-- 		-- "ibhagwan/fzf-lua", -- optional
	-- 	},
	-- 	config = function()
	-- 		local neogit = require("neogit")
	-- 		neogit.setup({
	-- 			integrations = {
	-- 				telescope = true,
	-- 				diffview = true,
	-- 			},
	-- 			vim.keymap.set("n", "<leader>g", "<cmd>Neogit<CR>", { desc = "Git status" }),
	-- 		})
	-- 	end,
	-- },
	-- {
	-- 	"tpope/vim-fugitive",
	-- },
	{
		-- Adds git releated signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		opts = {
			-- See `:help gitsigns.txt`
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			on_attach = function(bufnr)
				-- Navigation
				vim.keymap.set(
					"n",
					"<leader>hb",
					require("gitsigns").prev_hunk,
					{ buffer = bufnr, desc = "Go to Previous Hunk" }
				)
				vim.keymap.set(
					"n",
					"<leader>hf",
					require("gitsigns").next_hunk,
					{ buffer = bufnr, desc = "Go to Next Hunk" }
				)
				vim.keymap.set(
					"n",
					"<leader>hs",
					require("gitsigns").stage_hunk,
					{ buffer = bufnr, desc = "Stage Hunk" }
				)
				vim.keymap.set(
					"n",
					"<leader>hr",
					require("gitsigns").reset_hunk,
					{ buffer = bufnr, desc = "Reset Hunk" }
				)
				vim.keymap.set(
					"n",
					"<leader>hS",
					require("gitsigns").stage_buffer,
					{ buffer = bufnr, desc = "Stage buffer" }
				)
				vim.keymap.set("v", "<leader>hs", function()
					require("gitsigns").stage_hunk(
						{ vim.fn.line("."), vim.fn.line("v") },
						{ buffer = bufnr, desc = "Stage hunk" }
					)
				end)
				vim.keymap.set("v", "<leader>hr", function()
					require("gitsigns").reset_hunk(
						{ vim.fn.line("."), vim.fn.line("v") },
						{ buffer = bufnr, desc = "Reset hunk" }
					)
				end)
				vim.keymap.set(
					"n",
					"<leader>hu",
					require("gitsigns").undo_stage_hunk,
					{ buffer = bufnr, desc = "Undo Stage hunk" }
				)

				vim.keymap.set(
					"n",
					"<leader>hR",
					require("gitsigns").reset_buffer,
					{ buffer = bufnr, desc = "Reset buffer" }
				)
				vim.keymap.set(
					"n",
					"<leader>hp",
					require("gitsigns").preview_hunk,
					{ buffer = bufnr, desc = "Preview hunk" }
				)
			end,
		},
	},
	{
		{
			"kdheepak/lazygit.nvim",
			lazy = true,
			cmd = {
				"LazyGit",
				"LazyGitConfig",
				"LazyGitCurrentFile",
				"LazyGitFilter",
				"LazyGitFilterCurrentFile",
			},
			-- optional for floating window border decoration
			dependencies = {
				"nvim-lua/plenary.nvim",
			},
			-- setting the keybinding for LazyGit with 'keys' is recommended in
			-- order to load the plugin when the command is run for the first time
			keys = {
				{ "<leader>g", "<cmd>LazyGit<cr>", desc = "LazyGit" },
			},
		},
	},
}
