  -- [[ Configure LSP ]]
  --  This function gets run when an LSP connects to a particular buffer.
  local on_attach = function(client, bufnr)

    vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename"})
    vim.keymap.set("n", "<leader>lc", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Action"})
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Goto Definition"})
    vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, { buffer = bufnr, desc = "Goto References"})
    -- vim.keymap.set("n", "<leader>ld", require("telescope.builtin").lsp_document_symbols, { buffer = bufnr, desc = "Document Symbols"})
    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)
    vim.keymap.set("n", "<leader>lw", require("telescope.builtin").lsp_dynamic_workspace_symbols, { buffer = bufnr, desc = "Workspace Symbols"})
    vim.keymap.set("n", "<leader>ls", function() vim.lsp.buf.signature_help() end, { buffer = bufnr, desc = "Signature help"})
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover documentation"})
    -- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature Documentation"})

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
      vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })

    -- format on save
    -- if client.server_capabilities.documentFormattingProvider then
    --   vim.api.nvim_create_autocmd("BufWritePre", {
    --     group = vim.api.nvim_create_augroup("Format", { clear = true }),
    --     buffer = bufnr,
    --     callback = function() vim.lsp.buf.formatting_seq_sync() end
    --   })
    -- end
  end

  -- decorate floating windows
  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover, { border = 'rounded' }
  )

  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help, { border = 'rounded' }
  )

  vim.diagnostic.config(
    {
      float = {
        border = "single"
      }
    }
  )

  --  Add any additional override configuration in the following tables. They will be passed to
  --  the `settings` field of the server config. You must look up that documentation yourself.
  local servers = {
    pyright = {},
    hls = {},
    ocamllsp = {},

    lua_ls = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      },
    },
  }

  -- Setup neovim lua configuration
  require('neodev').setup()

  -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

  -- Ensure the servers above are installed
  local mason_lspconfig = require 'mason-lspconfig'

  mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
  }

  mason_lspconfig.setup_handlers {
    function(server_name)
      require('lspconfig')[server_name].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = servers[server_name],
      }
    end,
  }

