return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
    config = function()
      -- Defer Treesitter setup after first render to improve startup time
      vim.defer_fn(function()
        ---@diagnostic disable-next-line: missing-fields
        require('nvim-treesitter.configs').setup({
          -- A list of parser names, or "all"
          ensure_installed = { 'dart', 'gleam', 'lua', 'vim', 'vimdoc', 'java', 'kotlin', 'latex' },

          auto_install = false,
          sync_install = false,

          ignore_install = {},

          -- modules = ts_modules,
          highlight = {
            enable = true,
            disable = function(_, buf)
              local max_filesize = 100 * 1024 -- 100 KB
              local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
              if ok and stats and stats.size > max_filesize then
                return true
              end
            end,
            additional_vim_regex_highlighting = false,
          },
          indent = {
            enable = true,
          },
          playground = {
            enable = true,
          },
          query_linter = {
            enable = false,
            use_virtual_text = true,
            lint_events = { "BufWrite", "CursorHold" },
          }
        })
      end, 0)
    end,
  },
  {
    'nvim-treesitter/playground',
  },
  {
    'rrethy/nvim-treesitter-endwise',
  }
}
