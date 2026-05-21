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
        no_ignore = true,
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
      -- macOS doesn't provide /run; Linux already sets XDG_RUNTIME_DIR=/run/user/$UID.
      -- Only fall back to /tmp when nothing usable is set.
      local current = vim.env.XDG_RUNTIME_DIR
      if not current or vim.fn.isdirectory(current) == 0 then
        local runtime_dir = '/tmp/nvim-' .. (vim.env.USER or 'unknown')
        vim.fn.mkdir(runtime_dir, 'p')
        vim.env.XDG_RUNTIME_DIR = runtime_dir
      end

      local fzf = require('fzf-lua')
      fzf.setup(opts)
      fzf.register_ui_select()

      local map = function(lhs, rhs, desc)
        vim.keymap.set('n', lhs, rhs, { silent = true, desc = desc })
      end

      map('<leader>sf', fzf.files, 'Find files')
      map('<leader>sr', fzf.oldfiles, 'Recent files')
      map('<leader>sg', fzf.live_grep, 'Live grep')
      map('<leader>sh', fzf.help_tags, 'Help tags')
    end,
  },
}
