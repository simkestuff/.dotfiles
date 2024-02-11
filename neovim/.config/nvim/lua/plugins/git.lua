return {
  -- {
  --     "TimUntersberger/neogit",
  --     cmd = "Neogit",
  --     enabled = false,
  --     config = function()
  --         require("neogit").setup({
  --             kind = "tab", -- opens neogit in a split
  --             signs = {
  --                 -- { CLOSED, OPENED }
  --                 section = { "", "" },
  --                 item = { "", "" },
  --                 hunk = { "", "" },
  --             },
  --             integrations = { diffview = true }, -- adds integration with diffview.nvim
  --             disable_commit_confirmation = true,
  --         })
  --     end,
  --     keys = {
  --         { "<leader>gg", "<cmd>Neogit<cr>", "n", desc = "Git Status" },
  --     },
  -- },

  {
    "tpope/vim-fugitive",
  },

  -- {
  --     "sindrets/diffview.nvim",
  --     cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
  --
  --     keys = {
  --         { "<leader>gd", "<cmd>DiffviewOpen<CR>" },
  --     }
  -- },
  {
    -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '│' },
        change = { text = '│' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        vim.keymap.set('n', '[c', require('gitsigns').prev_hunk,
            { buffer = bufnr, desc = 'Go to Previous Hunk' })
        vim.keymap.set('n', ']c', require('gitsigns').next_hunk,
            { buffer = bufnr, desc = 'Go to Next Hunk' })
        map('n', ']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, {expr=true})

        map('n', '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'

        -- actions
        end, {expr=true})vim.keymap.set('n', '<leader>gp', require('gitsigns').preview_hunk,
          { buffer = bufnr, desc = 'Preview Hunk' })
        map('n', '<leader>gs', gs.stage_hunk)
        map('n', '<leader>gr', gs.reset_hunk)
        map('v', '<leader>gs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
        map('v', '<leader>gr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
      end,
    },
  },
}
