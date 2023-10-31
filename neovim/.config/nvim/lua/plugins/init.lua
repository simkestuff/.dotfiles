return {
    -- surround plugin
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },

    -- "gc" to comment visual regions/lines
    { 'numToStr/Comment.nvim', opts = {} },

    -- autopairs
    {
        "windwp/nvim-autopairs",
        dependencies = { "hrsh7th/nvim-cmp" },
        config = function()
            require("nvim-autopairs").setup()
            -- If you want to automatically add `(` after selecting a function or method
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            local cmp = require('cmp')
            cmp.event:on(
                'confirm_done',
                cmp_autopairs.on_confirm_done()
            )
        end,
    },

    -- undotree
    {
        'mbbill/undotree',
        keys = {
            { "<leader>u", vim.cmd.UndotreeToggle },
        }
    },

    -- show indentation lines
    {
        -- Add indentation guides even on blank lines
        'lukas-reineke/indent-blankline.nvim',
        -- Enable `lukas-reineke/indent-blankline.nvim`
        -- See `:help indent_blankline.txt`
        main = "ibl",
        -- opts = {
        --     char = '┊',
        --     show_trailing_blankline_indent = false,
        -- },
        opts = {},
    },

    -- {
    --     'nvim-lualine/lualine.nvim',
    --     dependencies = {
    --         'nvim-tree/nvim-web-devicons'
    --     },
    --     opts = {
    --         options = {
    --             icons_enabled = true,
    --             theme = 'catppuccin',
    --             component_separators = '|',
    --             section_separators = '',
    --         },
    --     },
    -- },

    -- using same keybindigs here and in tmux
    {'christoomey/vim-tmux-navigator'},

    {
        "szw/vim-maximizer",
        keys = {
            { "<leader>wm", "<cmd>MaximizerToggle<CR>", { desc = "Maximize/minimize a split" } },
        },
    },
}
