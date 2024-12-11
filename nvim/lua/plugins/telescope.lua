return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    opts = {
      sort_mru = true,
      sort_lastused = true,
      ignore_current_buffer = true,
      picker = { buffers = { sort_lastused = true } },
      file_ignore_patterns = { '%.jpg', '%.png', '%.svg', '%.svg', '%.gif', '%.otf', '%.ttf' },
      pickers = {
        find_files = {
          hidden = true,
        }
      },
      defaults = {
        path_display = {
          'smart'
        },
      },
    },
    init = function()
      require('telescope').load_extension('ui-select')

      local builtin = require('telescope.builtin')

      vim.keymap.set('n', '<c-p>', builtin.find_files, {})
      vim.keymap.set('n', '<Space><Space>', builtin.oldfiles, {})
      vim.keymap.set('n', '<Space>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<Space>he', builtin.help_tags, {})
    end,
  }
}
