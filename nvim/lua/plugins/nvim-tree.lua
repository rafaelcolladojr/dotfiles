return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    view = {
      float = {
        enable = true,
        open_win_config = {
          height = 40,
        }
      },
    },
    diagnostics = {
      enable = true,
      show_on_dirs = true,
      show_on_open_dirs = false,
    },
    filters = {
      enable = false,
    },
  },
  init = function()
    vim.keymap.set('n', '<c-n>', ':NvimTreeFindFileToggle<CR>')
  end,
}
