return {
  {
    'akinsho/flutter-tools.nvim',
    lazy = true,
    ft = "dart",
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {
      decorations = {
        statusline = {
          app_version = true,
          device = true,
        },
      },
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
        flags = {
          debounce_text_changes = 500,
        },
        init_options = {
          onlyAnalyzeProjectsWithOpenFiles = true,
          closingLabels = true,
          outline = false,
          flutterOutline = false,
        },
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
          analysisExcludedFolders = {
            vim.fn.expand("$HOME/.pub-cache"),
            vim.fn.expand("$HOME/fvm"),
            ".dart_tool",
            "build",
            ".android",
            ".ios",
          },
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
      -- flutter-tools' ftplugin guards LSP attach behind b:flutter_tools_did_ftplugin,
      -- which survives `:e` (same bufnr) so the buffer never reattaches dartls on reload.
      -- Clear it before the ftplugin re-sources so attach() runs again.
      vim.api.nvim_create_autocmd('BufReadPre', {
        pattern = '*.dart',
        callback = function(args)
          vim.b[args.buf].flutter_tools_did_ftplugin = nil
        end,
      })
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
}
