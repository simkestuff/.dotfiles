return {
    -- {
    --     "catppuccin/nvim",
    --     name = "catppuccin",
    --     config = function()
    --         require("catppuccin").setup({
    --             flavour = 'mocha',
    --             background = { -- :h background
    --                 light = "latte",
    --                 dark = "mocha"
    --             },
    --             transparent_background = true,
    --         })
    --         -- vim.cmd.colorscheme 'catppuccin'
    --         -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    --         -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    --     end,
    -- },

    -- {
    --     'projekt0n/github-nvim-theme',
    --     lazy = false, -- make sure we load this during startup if it is your main colorscheme
    --     priority = 1000, -- make sure to load this before all the other start plugins
    --     config = function()
    --         require('github-theme').setup({
    --             -- ...
    --         })
    --
    --         -- vim.cmd('colorscheme github_light')
    --     end,
    -- },
    -- {
    --     "miikanissi/modus-themes.nvim",
    --     priority = 1000,
    --     config = function()
    --         require("modus-themes").setup({
    --             -- style = "modus_operandi",
    --             variant = "default",
    --             on_colors = function(colors)
    --                 colors.cursor = colors.red
    --             end,
    --             on_highlights = function (highlights, colors)
    --                 highlights.cursor = {
    --                     fg = colors.cursor,
    --                     bg = colors.cursor
    --                 }
    --             end
    --         })
    --         vim.cmd.colorscheme("modus")
    --     end
    -- },
  {
    'rose-pine/neovim', name = 'rose-pine' ,
    config = function ()
      require("rose-pine").setup({
        variant = "auto",
        dark_variant = "moon",
        styles = {
          bold = true,
          italic = true,
          transparency = true,
        },
      })
      vim.cmd.colorscheme("rose-pine")
    end
  }
}
