vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')

-- Disable some default keymaps
vim.keymap.set('n', '<F1>', '<nop>')

-- Move highlighted code blocks
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '>-2<CR>gv=gv")

-- Keep pasted item in clipboard
vim.keymap.set('x', '<leader>p', '\"_dP')

-- Yank into system clipboard
vim.keymap.set('n', '<leader>y', '\"+y')
vim.keymap.set('v', '<leader>Y', '\"+y')
vim.keymap.set('n', '<leader>Y', '\"+Y')

-- Keep cursor centered on up/down half-page
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Improved movemen
vim.keymap.set('n', 'J', '5j')
vim.keymap.set('n', 'K', '5k')
vim.keymap.set('x', 'J', '5j')
vim.keymap.set('x', 'K', '5k')

-- Split navigation
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-w>-', ':resize -3<CR>')
vim.keymap.set('n', '<C-w>=', ':resize +3<CR>')

-- Tab navigation
vim.keymap.set('n', '<C-t>', ':tabedit<CR>')
vim.keymap.set('n', '<C-x>', ':tabclose<CR>')
vim.keymap.set('n', '<S-Tab>', ':tabprevious<CR>')
vim.keymap.set('n', '<Tab>', ':tabnext<CR>')

-- No yank on X
-- vim.keymap.set('n', 'x', '_x')

-- Select All
vim.keymap.set('n', '<C-a>', 'gg<S-v>G')

-- Open simulator
vim.keymap.set('n', '<leader>os', ':silent !open -a simulator<CR>')

-- Reload current plugin in development
-- vim.keymap.set('n', '<leader>bb', ':lua require("arrowhead").swap_notation(false)<CR>')
-- vim.keymap.set('n', '<leader>t', '<Plug>PlenaryTestFile<CR>')
