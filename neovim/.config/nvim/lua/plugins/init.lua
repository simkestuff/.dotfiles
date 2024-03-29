return {
	{
		-- Collection of various small independent plugins/modules
		--  Check out: https://github.com/echasnovski/mini.nvim
		"echasnovski/mini.nvim",
		config = function()
			-- Better Around/Inside textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]parenthen
			--  - yinq - [Y]ank [I]nside [N]ext [']quote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({ n_lines = 500 })

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			--
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			require("mini.surround").setup()

			-- Simple and easy statusline.
			--  You could remove this setup call if you don't like it,
			--  and try some other statusline plugin
			require("mini.statusline").setup()
		end,
	},

	-- undotree
	{
		"mbbill/undotree",
		keys = {
			{ "<leader>u", vim.cmd.UndotreeToggle },
		},
	},

	-- show indentation lines
	{
		-- Add indentation guides even on blank lines
		"lukas-reineke/indent-blankline.nvim",
		-- Enable `lukas-reineke/indent-blankline.nvim`
		-- See `:help indent_blankline.txt`
		main = "ibl",
		opts = {
			indent = {
				char = "┊",
			},
			scope = {
				enabled = false,
			},
		},
	},

	-- using same keybindigs here and in tmux
	{ "christoomey/vim-tmux-navigator" },

	{
		"szw/vim-maximizer",
		keys = {
			{ "<leader>wm", "<cmd>MaximizerToggle<CR>", { desc = "Maximize/minimize a split" } },
		},
	},

	-- "gc" to comment visual regions/lines
	{ "numToStr/Comment.nvim", opts = {} },

	{ -- Autoformat
		"stevearc/conform.nvim",
		opts = {
			notify_on_error = false,
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
			formatters_by_ft = {
				lua = { "stylua" },
				ocaml = { "ocamlformat" },
				-- Conform can also run multiple formatters sequentially
				-- python = { "isort", "black" },
				--
				-- You can use a sub-list to tell conform to run *until* a formatter
				-- is found.
				-- javascript = { { "prettierd", "prettier" } },
			},
		},
	},
}
