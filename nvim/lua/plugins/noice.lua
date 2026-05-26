return {
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    opts = {
      cmdline = {
        view = 'cmdline_popup',
        format = {
          cmdline = { icon = ' ' },
          search_down = { icon = ' ' },
          search_up = { icon = ' ' },
        },
      },
      lsp = {
        -- noice handles hover (markdown float); blink.cmp handles signature
        hover = { enabled = true },
        signature = { enabled = false },
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
        },
      },
      presets = {
        bottom_search = false,
        command_palette = true,
        long_message_to_split = true,
      },
      routes = {
        {
          filter = { event = 'notify', find = 'No information available' },
          opts = { skip = true },
        },
      },
    },
  },
}
