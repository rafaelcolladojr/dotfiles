local function flutter_app_version()
  return vim.g.flutter_tools_decorations.app_version
end

return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        icons_enabled = true,
        theme = 'catppuccin',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {
          {
            'filename',
            path = 1,
          }
        },
        lualine_c = {'branch', 'diff', 'diagnostics'},
        lualine_x = { flutter_app_version },
      },
    }
  }
}
