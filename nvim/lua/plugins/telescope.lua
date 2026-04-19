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
      file_ignore_patterns = { '%.jpg', '%.png', '%.svg', '%.svg', '%.gif', '%.otf', '%.ttf' },
      pickers = {
        buffers = {
          sort_lastused = true,
        },
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
    config = function(_, opts)
      require('telescope').setup(opts)
      require('telescope').load_extension('ui-select')

      local builtin = require('telescope.builtin')
      local map = function(lhs, rhs, desc)
        vim.keymap.set('n', lhs, rhs, { silent = true, desc = desc })
      end

      map('<c-p>', builtin.find_files, 'Find files')
      map('<Space><Space>', builtin.oldfiles, 'Recent files')
      map('<Space>fg', builtin.live_grep, 'Live grep')
      map('<Space>he', builtin.help_tags, 'Help tags')
    end,
  }
}
