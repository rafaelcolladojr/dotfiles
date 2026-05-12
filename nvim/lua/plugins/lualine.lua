local function flutter_app_version()
  return vim.g.flutter_tools_decorations.app_version
end

local function flutter_device()
  return vim.g.flutter_tools_decorations.device
end

return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        icons_enabled = true,
        theme = 'catppuccin-mocha',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = {
          {
            'filename',
            path = 1,
          }
        },
        lualine_c = { 'branch', 'diff', 'diagnostics' },
        lualine_x = {
          {
            function()
              return require('noice').api.status.mode.get()
            end,
            cond = function()
              local ok, noice = pcall(require, 'noice')
              return ok and noice.api.status.mode.has()
            end,
          },
          flutter_device,
          flutter_app_version,
        },
      },
    }
  }
}
