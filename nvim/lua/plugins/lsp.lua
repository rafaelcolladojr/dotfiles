return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
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
      require('lspconfig').dartls.setup {}
      require('lspconfig').gleam.setup {}
      require('lspconfig').lua_ls.setup {
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

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          if client.supports_method('textDocument/codeAction') then
            vim.keymap.set('n', '<leader>fa', ':lua vim.lsp.buf.code_action()<CR>')
          end
          if client.supports_method('textDocument/declaration') then
            vim.keymap.set('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>')
          end
          if client.supports_method('textDocument/definition') then
            vim.keymap.set('n', 'gd', ':Lspsaga goto_type_definition<CR>')
          end
          if client.supports_method('textDocument/diagnostic') then
            -- vim.keymap.set('n', '<leader>fe', ':lua vim.diagnostic.open_float()<CR>')
            vim.keymap.set('n', '<leader>fn', ":Lspsaga diagnostic_jump_next<CR>")
            vim.keymap.set('n', '<leader>fp', ":Lspsaga diagnostic_jump_prev<CR>")
          end
          if client.supports_method('textDocument/implementation') then
            vim.keymap.set('n', 'gi', ':Telescope lsp_implementations<CR>')
          end
          if client.supports_method('textDocument/hover') then
            vim.keymap.set('n', '<leader>fh', ':Lspsaga hover_doc<CR>')
          end
          if client.supports_method('textDocument/references') then
            vim.keymap.set('n', 'gr', ':Telescope lsp_references<CR>')
          end
          if client.supports_method('textDocument/rename') then
            vim.keymap.set('n', '<F2>', ':Lspsaga rename<CR>')
          end

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
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'saadparwaiz1/cmp_luasnip',
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',
      'onsails/lspkind.nvim',
    },
    config = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      local cmp = require('cmp')
      local luasnip = require('luasnip')
      require('luasnip.loaders.from_vscode').lazy_load()
      luasnip.config.setup()

      local cmp_select = { behavior = cmp.SelectBehavior.Select }
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp_snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      }

      local cmp_completion = {
        completeopt = 'menu,menuone,noselect',
      }
      local cmp_mappings = {
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<Enter>'] = cmp.mapping.confirm(),
        ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
      }
      local cmp_sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
        { name = 'buffer' },
      }

      local lspkind = require('lspkind')

      local cmp_formatting = {
        fields = { 'abbr', 'menu', 'kind' },
        -- format = function(_, vim_item)
        --   vim_item.menu = ' '
        --   return vim_item
        -- end
        format = lspkind.cmp_format({
          mode = 'symbol',          -- show only symbol annotations
          maxwidth = {
            menu = 50,              -- leading text (labelDetails)
            abbr = 50,              -- actual suggestion item
          },
          ellipsis_char = '...',    -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
          show_labelDetails = true, -- show labelDetails in menu. Disabled by default
        }),
      }

      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )

      cmp.setup({
        snippet = cmp_snippet,
        completion = cmp_completion,
        mapping = cmp_mappings,
        sources = cmp_sources,
        formatting = cmp_formatting,
      })

      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        update_in_insert = false,
        underline = false,
        severity_sort = false,
        float = true,
      })

      local function toggleDiagnostics()
        vim.diagnostic.enable(not vim.diagnostic.is_enabled())
      end

      vim.keymap.set('n', '<leader>dt', function() toggleDiagnostics() end)
    end,
  },
}
