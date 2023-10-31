return {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
       require("catppuccin").setup({
           flavour = 'mocha',
           background = { -- :h background
              light = "latte",
              dark = "mocha"
           },
           transparent_background = true,
       })
       vim.cmd.colorscheme 'catppuccin'
       -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
       -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end,
}

