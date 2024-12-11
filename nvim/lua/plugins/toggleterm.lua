return {
  {

    'akinsho/toggleterm.nvim',
    opts = {},
    init = function()
      local Terminal = require('toggleterm.terminal').Terminal

      -- Lazygit integration
      local lazygit  = Terminal:new({
        cmd = "lazygit",
        dir = "git_dir",
        direction = "float",
        float_opts = {
          border = "double",
        },
        -- function to run on opening the terminal
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "<C-q>", "<cmd>close<CR>", { noremap = true, silent = true })
        end,
        -- function to run on closing the terminal
        on_close = function(_)
          vim.cmd("startinsert!")
        end,
      })

      function Raff_lazygit_toggle()
        lazygit:toggle()
      end

      vim.api.nvim_set_keymap("n", "<leader>lg", "<cmd> lua Raff_lazygit_toggle()<CR>", { noremap = true, silent = true })

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

      function Raff_scratchterm_toggle()
        scratchTerm:toggle()
      end

      --Flutter integration
      -- vim.keymap.set('n', '<leader>ft', ':2ToggleTerm<CR>')
      vim.keymap.set('n', '<leader>ft', '<cmd> lua Raff_scratchterm_toggle()<CR>', { noremap = true, silent = true })

      function _G.set_terminal_keymaps()
        local opts = { buffer = 0 }
        -- vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
        -- vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
        vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
      end

      -- if you only want these mappings for toggle term use term://*toggleterm#* instead
      vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
    end,
  }
}
