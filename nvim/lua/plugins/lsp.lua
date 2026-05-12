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
        },
        config = function(_, opts)
          require('lspsaga').setup(opts)
          -- Patch goto_pos: Lspsaga b821192 moved to vim.diagnostic.jump with
          -- on_jump, but Neovim 0.12 schedules on_jump asynchronously, so the
          -- float isn't ready when the code-action enrichment runs.
          -- Fix: open the float synchronously after the jump instead.
          local diag_ctx = require('lspsaga.diagnostic')
          local diag_mt = getmetatable(diag_ctx)
          local saga_config = require('lspsaga').config

          diag_mt.goto_pos = function(self, pos, jump_opts)
            local entry = vim.diagnostic.jump(vim.tbl_extend('keep', {
              count = pos == 1 and 1 or -1,
            }, jump_opts or {}))

            if not entry then return end

            require('lspsaga.util').valid_markdown_parser()
            require('lspsaga.beacon').jump_beacon(
              { entry.lnum, entry.col },
              #vim.api.nvim_get_current_line()
            )

            -- Open float inside vim.schedule so pending CursorMoved events
            -- from the jump are processed first and don't close the float.
            vim.schedule(function()
              vim.diagnostic.open_float({
                border = saga_config.ui.border,
                format = function(d)
                  if not vim.bo[vim.api.nvim_get_current_buf()].filetype == 'rust' then
                    return d.message
                  end
                  return d.message:find('\\n`$') and d.message:gsub('\\n`$', '`') or d.message
                end,
                header = '',
                prefix = { '• ', 'Title' },
              })

              if not self:valid_win_buf() then return end
              vim.bo[self.float_bufnr].filetype = 'markdown'
              vim.wo[self.float_winid].conceallevel = 2
              vim.wo[self.float_winid].cocu = 'niv'
              vim.bo[self.float_bufnr].bufhidden = 'wipe'
              vim.api.nvim_create_autocmd('WinClosed', {
                buffer = self.float_bufnr,
                once = true,
                callback = function() self:clean_data() end,
              })

              local util = require('lspsaga.util')
              if #util.get_client_by_method('textDocument/codeAction') == 0 then return end
              local curbuf = vim.api.nvim_get_current_buf()
              local diagnostics = self:get_cursor_diagnostic()
              local win_conf = vim.api.nvim_win_get_config(self.float_winid)
              local act = require('lspsaga.codeaction')
              act:send_request(curbuf, {
                context = { diagnostics = diagnostics },
                range = {
                  start = { entry.lnum + 1, (entry.col or 1) },
                  ['end'] = { entry.lnum + 1, (entry.col or 1) },
                },
                gitsign = false,
              }, function(action_tuples, enriched_ctx)
                if #action_tuples == 0 or not self:valid_win_buf() then return end
                vim.bo[self.float_bufnr].modifiable = true
                self.main_buf = curbuf
                self:code_action_cb(action_tuples, enriched_ctx, win_conf)
                vim.bo[self.float_bufnr].modifiable = false
              end)
            end)
          end
        end,
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
          map('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>', 'LSP code action')
          -- end
          -- if client.supports_method('textDocument/definition') then
          map('n', 'gd', '<cmd>Lspsaga goto_definition<CR>', 'LSP goto definition')
          -- end
          -- if client.supports_method('textDocument/hover') then
          map('n', '<leader>ch', '<cmd>Lspsaga hover_doc<CR>', 'LSP hover')
          -- end
          -- if client.supports_method('textDocument/rename') then
          map('n', '<F2>', '<cmd>Lspsaga rename<CR>', 'LSP rename symbol')
          -- end
          -- if client.supports_method('textDocument/implementation') then
          map('n', 'gi', '<cmd>FzfLua lsp_implementations<CR>', 'LSP implementations')
          -- end
          -- if client.supports_method('textDocument/references') then
          map('n', 'gr', '<cmd>FzfLua lsp_references<CR>', 'LSP references')
          -- end
          -- For some reason dartls isn't listing textDocument/diagnostic as a
          -- supported method...
          map('n', '<leader>dn', '<cmd>Lspsaga diagnostic_jump_next<CR>', 'Next diagnostic')
          map('n', '<leader>dp', '<cmd>Lspsaga diagnostic_jump_prev<CR>', 'Previous diagnostic')

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
