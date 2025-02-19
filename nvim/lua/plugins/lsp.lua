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
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      -- require('lspconfig').dartls.setup { capabilities = capabilities }
      require('lspconfig').gleam.setup { capabilities = capabilities }
      require 'lspconfig'.cssls.setup { capabilities = capabilities }
      require 'lspconfig'.html.setup { capabilities = capabilities }
      require 'lspconfig'.remark_ls.setup { capabilities = capabilities }
      require('lspconfig').lua_ls.setup {
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
      }

      vim.diagnostic.config({
        update_in_insert = true,
        float = false,
      })


      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          -- if client.supports_method('textDocument/codeAction') then
          vim.keymap.set('n', '<leader>fa', ':Lspsaga code_action<CR>')
          -- end
          -- if client.supports_method('textDocument/definition') then
          vim.keymap.set('n', 'gd', ':Lspsaga goto_definition<CR>')
          -- end
          -- if client.supports_method('textDocument/hover') then
          vim.keymap.set('n', '<leader>fh', ':Lspsaga hover_doc<CR>')
          -- end
          -- if client.supports_method('textDocument/rename') then
          vim.keymap.set('n', '<F2>', ':Lspsaga rename<CR>')
          -- end
          -- if client.supports_method('textDocument/implementation') then
          vim.keymap.set('n', 'gi', ':Telescope lsp_implementations<CR>')
          -- end
          -- if client.supports_method('textDocument/references') then
          vim.keymap.set('n', 'gr', ':Telescope lsp_references<CR>')
          -- end
          -- For some reason dartls isn't listing textDocument/diagnostic as a
          -- supported method...
          vim.keymap.set('n', '<leader>fn', ":Lspsaga diagnostic_jump_next<CR>")
          vim.keymap.set('n', '<leader>fp', ":Lspsaga diagnostic_jump_prev<CR>")

          local function toggleDiagnostics()
            vim.diagnostic.enable(not vim.diagnostic.is_enabled())
          end

          vim.keymap.set('n', '<leader>dt', function() toggleDiagnostics() end)

          -- Let's not do this for dart files, since we have a plugin for that
          -- if vim.bo.filetype ~= 'dart' then
          if client.supports_method('textDocument/formatting') then
            -- Format the current buffer on save
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end,
            })
          end
          -- end
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
