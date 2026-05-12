return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    opts = {
      flavour = 'mocha',
      background = {
        light = 'latte',
        dark = 'mocha',
      },
      transparent_background = true,
      integrations = {
        blink_cmp = true,
        dap = true,
        dap_ui = true,
        gitsigns = true,
        harpoon = true,
        lsp_saga = true,
        mini = { enabled = true },
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
          inlay_hints = {
            background = true,
          }
        },
        noice = true,
        notify = true,
        snacks = true,
        treesitter = true,
        which_key = true,
      },
    }
  },
}
