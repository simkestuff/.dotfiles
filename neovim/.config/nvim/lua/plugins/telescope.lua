return {
    {
    'nvim-telescope/telescope.nvim', tag = '0.1.2',
      dependencies = { 'nvim-lua/plenary.nvim' },
      keys = {
        {"<leader>ff", function () require("telescope.builtin").find_files() end, desc = "Find files"},
        {"<leader>fg", function () require("telescope.builtin").git_files() end, desc = "Git files"},
        {"<leader>fb", function () require("telescope.builtin").buffers() end, desc = "Show buffers"},
        {"<leader>fs", function () require("telescope.builtin").live_grep() end, desc = "Grep files"},
      },
      config = function()
          require("telescope").setup {
            defaults = {
                mappings = {
                    i = {
                        ["<esc>"] = require("telescope.actions").close,
                        ["<C-k>"] = require("telescope.actions").move_selection_previous,
                        ["<C-j>"] = require("telescope.actions").move_selection_next,
                    },
                },
	        }
	      }
      end,
    },

    {
        'nvim-telescope/telescope-fzf-native.nvim', 
        build = 'make',
        config = function()
            pcall(require("telescope").load_extension, "fzf")
        end,
    }
}
