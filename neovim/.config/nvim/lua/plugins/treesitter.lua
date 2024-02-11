return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  build = function()
    require("nvim-treesitter.install").update({ with_sync = true })
  end,
  event = {"BufReadPre", "BufNewFile"},
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python", "haskell", "ocaml" },
      sync_install = false,
      auto_install = true,
      ignore_install = {},
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<c-space>',
          node_incremental = '<c-space>',
          scope_incremental = '<c-s>',
          node_decremental = 'bs',
        },
      },
      textobjects = {
        enable = true,
      },
      autopairs = {
        enable = true,
      }
    })
  end,
}
