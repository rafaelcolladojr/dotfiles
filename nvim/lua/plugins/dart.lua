return {
  {
    'dart-lang/dart-vim-plugin',
    init = function()
      vim.g.dart_style_guide = 2
      vim.g.dart_format_on_save = 1
      vim.g.dart_trailing_comma_indent = true
    end,
  },
  {
    'akinsho/flutter-tools.nvim',
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
      widget_guides = {
        enabled = false,
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
        color = {
          enabled = true,
          background = true,
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
    end
  },
  { 'wa11breaker/flutter-bloc.nvim' },
}
