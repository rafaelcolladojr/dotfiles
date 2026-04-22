return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'saghen/blink.cmp',
      {
        'nvimdev/lspsaga.nvim',
        opts = {},
        dependencies = {
          'nvim-treesitter/nvim-treesitter',
          'nvim-tree/nvim-web-devicons',
        }
      }
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

          -- if client.supports_method('textDocument/codeAction') then
          map('n', '<leader>fa', '<cmd>Lspsaga code_action<CR>', 'LSP code action')
          -- end
          -- if client.supports_method('textDocument/definition') then
          map('n', 'gd', '<cmd>Lspsaga goto_definition<CR>', 'LSP goto definition')
          -- end
          -- if client.supports_method('textDocument/hover') then
          map('n', '<leader>fh', '<cmd>Lspsaga hover_doc<CR>', 'LSP hover')
          -- end
          -- if client.supports_method('textDocument/rename') then
          map('n', '<F2>', '<cmd>Lspsaga rename<CR>', 'LSP rename symbol')
          -- end
          -- if client.supports_method('textDocument/implementation') then
          map('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', 'LSP implementations')
          -- end
          -- if client.supports_method('textDocument/references') then
          map('n', 'gr', '<cmd>Telescope lsp_references<CR>', 'LSP references')
          -- end
          -- For some reason dartls isn't listing textDocument/diagnostic as a
          -- supported method...
          map('n', '<leader>fn', function()
            vim.diagnostic.jump({ count = 1, float = true })
          end, 'Next diagnostic')
          map('n', '<leader>fp', function()
            vim.diagnostic.jump({ count = -1, float = true })
          end, 'Previous diagnostic')

          local function toggleDiagnostics()
            vim.diagnostic.enable(not vim.diagnostic.is_enabled())
          end

          map('n', '<leader>dt', function() toggleDiagnostics() end, 'Toggle diagnostics')

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
