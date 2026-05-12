return {
  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      default_file_explorer = true,
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
      },
      float = {
        padding = 2,
        max_width = 120,
        max_height = 40,
        border = 'rounded',
      },
      keymaps = {
        ['q'] = 'actions.close',
        ['<Esc>'] = 'actions.close',
      },
    },
    keys = {
      {
        '<leader>e',
        function()
          require('oil').toggle_float()
        end,
        desc = 'File explorer',
      },
    },
  },
}
