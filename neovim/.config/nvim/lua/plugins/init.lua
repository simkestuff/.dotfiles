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
			require("mini.surround").setup(
				-- {
				-- disabled da bi mogao koristiti <space>sf u Telescope-u
				-- mappings = {
				-- find = "",
				-- },
				-- }
			)

			-- Simple and easy statusline.
			--  You could remove this setup call if you don't like it,
			--  and try some other statusline plugin
			require("mini.statusline").setup()

			-- autopairs
			require("mini.pairs").setup()
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
	-- { "christoomey/vim-tmux-navigator" },
	-- using same keybinding here and in wezterm
	{
		"mrjones2014/smart-splits.nvim",
		lazy = false,
		opts = function(_, opts)
			--mappings
			vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
			vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
			vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
			vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
			vim.keymap.set("n", "<C-\\>", require("smart-splits").move_cursor_previous)
			return opts
		end,
	},

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
				tex = { "latexindent" },
				go = { "goimports", "gofmt" },
				-- Conform can also run multiple formatters sequentially
				-- python = { "isort", "black" },
				--
				-- You can use a sub-list to tell conform to run *until* a formatter
				-- is found.
				-- javascript = { { "prettierd", "prettier" } },
			},
		},
	},
	{
		"lervag/vimtex",
		lazy = false, -- we don't want to lazy load VimTeX
		-- tag = "v2.15", -- uncomment to pin to a specific release
		init = function()
			-- VimTeX configuration goes here, e.g.
			vim.g.vimtex_view_method = "zathura"
			vim.g.vimtex_view_general_viewer = "okular"
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VimEnter",
		opts = {
			icons = {
				mappings = vim.g.have_nerd_font,
				icons = {},
			},
			spec = {
				{ "<leader>f", group = "[F]ind stuff" },
				{ "<leader>d", group = "[D]ebug and [D]iagnostic" },
				{ "<leader>n", group = "[N]otes related" },
				{ "<leader>e", group = "[E]xplore" },
				{ "<leader>u", group = "[U]ndo tree" },
				{ "<leader>h", group = "[H]unk Git related" },
			},
		},
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
}
