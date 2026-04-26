return {
  {
    'dart-lang/dart-vim-plugin',
    enabled = true,
    lazy = true,
    ft = "dart",
    init = function()
      vim.g.dart_style_guide = 2
      vim.g.dart_format_on_save = 0
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
        on_attach = function(client, bufnr)
          vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr, id = client.id })
            end,
          })
        end,
        color = {
          enabled = false,
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
          local vscode = require("dap.ext.vscode")
          local configs = vscode.getconfigs()
          local dap = require("dap")
          dap.configurations.dart = vim.list_extend(dap.configurations.dart or {}, configs)
        end,
      },
    },
    init = function()
      local map = function(lhs, rhs, desc)
        vim.keymap.set('n', lhs, rhs, { silent = true, desc = desc })
      end
      map('<leader>fr', '<cmd>FlutterReload<CR>', 'Flutter reload')
      map('<leader>fR', '<cmd>FlutterRestart<CR>', 'Flutter restart')
      map('<leader>fs', '<cmd>FlutterVSplit<CR>', 'Flutter vsplit')
      map('<leader>fS', '<cmd>FlutterSplit<CR>', 'Flutter split')
      map('<leader>ff', '<cmd>FlutterRun<CR>', 'Flutter run')
      map('<leader>fv', '<cmd>FlutterVisualDebug<CR>', 'Flutter visual debug')
      map('<leader>fq', function()
        vim.cmd('FlutterQuit')
        require("dapui").close()
      end, 'Flutter quit')
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
