return {
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      defaults = {
        file_icons = true,
        git_icons = true,
      },
      files = {
        hidden = true,
        file_ignore_patterns = { '%.jpg', '%.png', '%.svg', '%.gif', '%.otf', '%.ttf' },
      },
      oldfiles = {
        include_current_session = true,
      },
      grep = {
        hidden = true,
      },
    },
    config = function(_, opts)
      local fzf = require('fzf-lua')
      fzf.setup(opts)
      fzf.register_ui_select()

      local map = function(lhs, rhs, desc)
        vim.keymap.set('n', lhs, rhs, { silent = true, desc = desc })
      end

      map('<C-p>', fzf.files, 'Find files')
      map('<Space><Space>', fzf.oldfiles, 'Recent files')
      map('<Space>fg', fzf.live_grep, 'Live grep')
      map('<Space>he', fzf.help_tags, 'Help tags')
    end,
  },
}
