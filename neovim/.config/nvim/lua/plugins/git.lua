return {
    {
        "TimUntersberger/neogit",
        cmd = "Neogit",
        config = function()
            require("neogit").setup({
                kind = "tab", -- opens neogit in a split
                signs = {
                    -- { CLOSED, OPENED }
                    section = { "", "" },
                    item = { "", "" },
                    hunk = { "", "" },
                },
                integrations = { diffview = true }, -- adds integration with diffview.nvim
                disable_commit_confirmation = true,
            })
        end,
        keys = {
            { "<leader>gg", "<cmd>Neogit<cr>", "n", desc = "Git Status" },
        },
    },

    {
        "tpope/vim-fugitive",
    },

    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },

        keys = {
            { "<leader>gd", "<cmd>DiffviewOpen<CR>" },
        }
    },
    {
        -- Adds git releated signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        opts = {
            -- See `:help gitsigns.txt`
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns
                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                vim.keymap.set('n', '<leader>hk', require('gitsigns').prev_hunk,
                    { buffer = bufnr, desc = 'Go to Previous Hunk' })
                vim.keymap.set('n', '<leader>hj', require('gitsigns').next_hunk,
                    { buffer = bufnr, desc = 'Go to Next Hunk' })
                vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk,
                    { buffer = bufnr, desc = 'Preview Hunk' })
                map('n', '<leader>hs', gs.stage_hunk)
                map('n', '<leader>hr', gs.reset_hunk)
                map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
                map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
            end,
        },
    },
}
