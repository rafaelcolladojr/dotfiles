local map = function(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

-- Disable some default keymaps
map('n', '<F1>', '<nop>', 'Disable F1')

-- Move highlighted code blocks
map('v', 'J', ":m '>+1<CR>gv=gv", 'Move selection down')
map('v', 'K', ":m '>-2<CR>gv=gv", 'Move selection up')

-- Keep pasted item in clipboard
map('x', '<leader>p', '"_dP', 'Paste without yanking')

-- Keep cursor centered on up/down half-page
map('n', '<C-d>', '<C-d>zz', 'Half-page down and center')
map('n', '<C-u>', '<C-u>zz', 'Half-page up and center')

-- Improved movement
map('n', 'J', '5j', 'Move down 5 lines')
map('n', 'K', '5k', 'Move up 5 lines')
map('x', 'J', '5j', 'Move down 5 lines')
map('x', 'K', '5k', 'Move up 5 lines')

-- Split resizing (navigation handled by tmux-navigation plugin)
map('n', '<C-w>-', '<cmd>resize -3<CR>', 'Decrease split height')
map('n', '<C-w>=', '<cmd>resize +3<CR>', 'Increase split height')

-- Tab navigation
map('n', '<C-t>', '<cmd>tabedit<CR>', 'New tab')
map('n', '<C-x>', '<cmd>tabclose<CR>', 'Close tab')
map('n', '<S-Tab>', '<cmd>tabprevious<CR>', 'Previous tab')
map('n', '<Tab>', '<cmd>tabnext<CR>', 'Next tab')

-- Select All
map('n', '<C-a>', 'gg<S-v>G', 'Select all')

-- Open simulator
map('n', '<leader>os', '<cmd>silent !open -a simulator<CR>', 'Open iOS Simulator')

-- Clear search highlights
map('n', '<Esc>', '<cmd>nohlsearch<CR>', 'Clear search highlights')
