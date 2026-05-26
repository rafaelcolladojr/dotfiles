return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'saghen/blink.cmp',
    },
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      local lsp_attach_group = vim.api.nvim_create_augroup('RaffLspAttach', { clear = true })
      local lsp_format_group = vim.api.nvim_create_augroup('RaffLspFormatOnSave', { clear = true })
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      -- vim.lsp.config('dartls', { capabilities = capabilities })
      vim.lsp.config('gleam', { capabilities = capabilities })
      vim.lsp.config('cssls', { capabilities = capabilities })
      vim.lsp.config('html', { capabilities = capabilities })
      vim.lsp.config('remark_ls', { capabilities = capabilities })
      vim.lsp.config('lua_ls', {
        capabilities = capabilities,
        Lua = {
          completion = {
            workspaceWord = true,
            callSnippet = 'Both',
          },
          hint = {
            enable = true,
            setType = false,
            paramType = true,
            paramName = 'Disable',
            semicolon = 'Disable',
            arrayIndex = 'Disable',
          },
          diagnostics = {
            disable = { 'incomplete-signature-doc', 'trailing-space' },
            groupSeverity = {
              strong = 'Warning',
              strict = 'Warning',
            },
            globals = { 'vim' }
          },
          doc = {
            privateName = { '^_' },
          },
          format = {
            enable = false,
            defaultConfig = {
              indent_style = 'space',
              indent_size = '2',
              continuation_indent_size = '2',
            },
          },
          type = {
            castNumberToInteger = true,
          },
          workspace = {
            checkThirdParty = false
          },
          telemetry = { enable = false },
        }
      })

      vim.diagnostic.config({
        update_in_insert = true,
      })


      vim.api.nvim_create_autocmd('LspAttach', {
        group = lsp_attach_group,
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, silent = true, desc = desc })
          end

          map('n', '<leader>ca', vim.lsp.buf.code_action, 'Code action')
          map('n', '<leader>ch', vim.lsp.buf.hover, 'Hover doc')
          map('n', '<leader>cr', vim.lsp.buf.rename, 'Rename symbol')
          map('n', 'gd', '<cmd>FzfLua lsp_definitions<CR>', 'Goto definition')
          map('n', 'gi', '<cmd>FzfLua lsp_implementations<CR>', 'Implementations')
          map('n', 'gr', '<cmd>FzfLua lsp_references<CR>', 'References')
          map('n', '<leader>dn', function() vim.diagnostic.jump({ count = 1, float = true }) end, 'Next diagnostic')
          map('n', '<leader>dp', function() vim.diagnostic.jump({ count = -1, float = true }) end, 'Prev diagnostic')
          map('n', '<leader>dt', function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end, 'Toggle diagnostics')

          if client:supports_method('textDocument/formatting') then
            -- Format the current buffer on save
            vim.api.nvim_clear_autocmds({ group = lsp_format_group, buffer = args.buf })
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = lsp_format_group,
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end,
            })
          end
        end,
      })
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        {
          plugins = { "nvim-dap-ui" },
          types = true,
        },
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
