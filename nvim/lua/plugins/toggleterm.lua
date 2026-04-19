return {
  {
    'akinsho/toggleterm.nvim',
    opts = {},
    config = function(_, opts)
      require('toggleterm').setup(opts)
      local Terminal = require('toggleterm.terminal').Terminal

      -- floating scratch term
      ---@type TermCreateArgs
      local termArgs = {
        id = 2,
        direction = 'float',
        float_opts = {
          height = 30,
        },
      }

      local scratchTerm = Terminal:new(termArgs)

      --Flutter integration
      vim.keymap.set('n', '<leader>ft', function()
        scratchTerm:toggle()
      end, { noremap = true, silent = true, desc = 'Toggle scratch terminal' })

      local function set_terminal_keymaps()
        local opts = { buffer = 0 }
        -- vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
        -- vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], vim.tbl_extend('force', opts, { desc = 'Terminal focus left split' }))
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], vim.tbl_extend('force', opts, { desc = 'Terminal focus lower split' }))
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], vim.tbl_extend('force', opts, { desc = 'Terminal focus upper split' }))
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], vim.tbl_extend('force', opts, { desc = 'Terminal focus right split' }))
        vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], vim.tbl_extend('force', opts, { desc = 'Terminal window command' }))
      end

      local term_group = vim.api.nvim_create_augroup('RaffToggleTermKeymaps', { clear = true })
      vim.api.nvim_create_autocmd('TermOpen', {
        group = term_group,
        pattern = 'term://*',
        callback = function()
          set_terminal_keymaps()
        end,
      })
    end,
  }
}
