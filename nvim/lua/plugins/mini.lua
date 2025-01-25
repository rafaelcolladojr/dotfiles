return {
  {
    'echasnovski/mini.nvim',
    version = false, -- main branch
    config = function()
      require('mini.ai').setup()
      require('mini.cursorword').setup()
      require('mini.icons').setup()
      require('mini.sessions').setup()
      require('mini.surround').setup()
      require('mini.pairs').setup()
    end
  }
}
