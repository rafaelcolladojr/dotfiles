return {
  {
    'dart-lang/dart-vim-plugin',
    lazy = true,
    ft = "dart",
    init = function()
      vim.g.dart_style_guide = 2
      vim.g.dart_format_on_save = 1
      vim.g.dart_trailing_comma_indent = true
    end,
  },
  {
    'akinsho/flutter-tools.nvim',
    lazy = true,
    ft = "dart",
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim',

    },
    opts = {
      decorations = {
        statusline = {
          app_version = true,
          device = true,
        },
      },
      -- widget_guides = {
      --   enabled = false,
      -- },
      closing_tags = {
        highlight = 'Comment',
        prefix = '//',
        enabled = true,
      },
      dev_log = {
        enabled = false,
      },
      lsp = {
        color = {
          enabled = true,
          background = false,
          foreground = false,
          virtual_text = true,
          virtual_text_str = "■",
        },
        settings = {
          showTodos = false,
          completeFunctionCalls = true,
          enableSnippets = true,
        },
      },
      debugger = {
        enabled = true,
        run_via_dap = true,
        exception_breakpoints = {},
        register_configurations = function(_)
          require('dap').configurations.dart = {}
          require("dap.ext.vscode").load_launchjs()
        end,
      },
    },
    init = function()
      vim.keymap.set('n', '<leader>fr', ':FlutterReload<CR>')
      vim.keymap.set('n', '<leader>fR', ':FlutterRestart<CR>')
      vim.keymap.set('n', '<leader>fs', ':FlutterVSplit<CR>')
      vim.keymap.set('n', '<leader>fS', ':FlutterSplit<CR>')
      vim.keymap.set('n', '<leader>ff', ':FlutterRun<CR>')
      vim.keymap.set('n', '<leader>fq', ':FlutterQuit<CR>')

      local
      function reload_dartls_if_inactive()
        local dartls_client
        for _, client in ipairs(vim.lsp.get_clients()) do
          if client.name == "dartls" then
            dartls_client = client
            break
          end
        end

        vim.defer_fn(function()
          if dartls_client and not dartls_client.is_stopped() then
            return
          end

          if dartls_client and dartls_client.stop then
            dartls_client.stop()
          end

          require("flutter-tools.lsp").attach()
        end, 2000)
      end

      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = "*.dart",
        callback = reload_dartls_if_inactive,
      })
    end
  },
  {
    'wa11breaker/flutter-bloc.nvim',
    dependencies = {
      "nvimtools/none-ls.nvim",
    },
    lazy = true,
    ft = "dart",
    opts = {
      bloc_type = 'default',
      use_sealed_classes = false,
      enable_code_actions = true,
    }
  }
}
