return {
  {
    'theprimeagen/vim-be-good',
  },
  {
    'theprimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
    init = function()
      local harpoon = require('harpoon')

      vim.keymap.set('n', '<leader>ha', function() harpoon:list():add() end)
      vim.keymap.set('n', '<leader>hh', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

      -- Navigation
      vim.keymap.set('n', '<leader>h1', function() harpoon:list():select(1) end)
      vim.keymap.set('n', '<leader>h2', function() harpoon:list():select(2) end)
      vim.keymap.set('n', '<leader>h3', function() harpoon:list():select(3) end)
      vim.keymap.set('n', '<leader>h4', function() harpoon:list():select(4) end)
    end
  },
}
