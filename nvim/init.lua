-- @@@@@@@@@@@@@@@@@@@@@@@@@@ --
-- @@@@@@ VIM SETTINGS @@@@@@ --
-- @@@@@@@@@@@@@@@@@@@@@@@@@@ --

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.backspace = '2'
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.signcolumn = 'yes'
vim.opt.autoread = true

-- use spaces for tabs and stuff
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftround = true
vim.opt.smartindent = true

-- Relative line numbers
vim.opt.relativenumber = true
vim.opt.nu = true
vim.opt.wrap = false

-- Don't highlight search results
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.scrolloff = 8
vim.opt.updatetime = 50
vim.opt.colorcolumn = ''

-- When opening a window, put it right or below the current one
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Enable mouse support
vim.opt.mouse = 'a'



-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@ --
-- @@@@@@ GENERAL KEYMAPS @@@@@@ --
-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@ --

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
vim.keymap.set('n', '<leader>rr', ':lua R("dart-boiler")<CR>')
vim.keymap.set('v', '<leader>bb', ':lua require("dart-boiler").boil(true, true)<CR>')
vim.keymap.set('n', '<leader>t', '<Plug>PlenaryTestFile<CR>')



-- @@@@@@@@@@@@@@@@@@@@@@@@@@ --
-- @@@@@@    PLUGINS   @@@@@@ --
-- @@@@@@@@@@@@@@@@@@@@@@@@@@ --

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- plugins
require("lazy").setup({
  'gelguy/wilder.nvim',
  'nvim-lua/plenary.nvim',

  -- COLORSCHEMES
  'shaunsingh/nord.nvim',
  {'catppuccin/nvim', name = 'catppuccin'},

  -- IDE
  'nvim-tree/nvim-tree.lua',
  'nvim-tree/nvim-web-devicons',
  'nvim-lualine/lualine.nvim',
  {
    'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'
  },
  'nvim-treesitter/playground',
  'windwp/nvim-autopairs',
  'rrethy/nvim-treesitter-endwise',
  'mtdl9/vim-log-highlighting',
  'akinsho/toggleterm.nvim',
  'akinsho/bufferline.nvim',
  'AndrewRadev/switch.vim',
  'mfussenegger/nvim-dap',
  'rcarriga/nvim-dap-ui',

  -- LSP Support
  'neovim/nvim-lspconfig',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',

  -- Autocompletion
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'saadparwaiz1/cmp_luasnip',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-nvim-lua',

  -- Snippets
  'L3MON4D3/LuaSnip',
  'rafamadriz/friendly-snippets',

  -- Formatting
  'onsails/lspkind.nvim',

  -- LSP
  'VonHeikemen/lsp-zero.nvim',

  -- TELESCOPE
  {'nvim-telescope/telescope.nvim', tag = '0.1.1'},
  'nvim-telescope/telescope-ui-select.nvim',

  -- TPOPE THE GOD
  'tpope/vim-fugitive',
  'tpope/vim-surround',
  'tpope/vim-commentary',


  -- THEPRIMEAGEN
  'theprimeagen/vim-be-good',
  {'theprimeagen/harpoon', 'nvim-lua/plenary.nvim'},

  -- FLUTTER
  'dart-lang/dart-vim-plugin',
  {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    config = true,
  },

  -- LUA (PLUGIN) DEV
  'milisims/nvim-luaref',
  'folke/neodev.nvim',

  { dir = '~/Documents/Projects/lua/nvim-plugins/dart-boiler.nvim' },
  -- 'rafaelcolladojr/dart-boiler.nvim',
})



-- @@@@@@@@@@@@@@@@@@@@@@@@@@ --
-- @@@  PLUGIN  CONFIGS   @@@ --
-- @@@@@@@@@@@@@@@@@@@@@@@@@@ --


-- dart-vim-plugin
vim.g.dart_style_guide = 2
vim.g.dart_format_on_save = 1
vim.g.dart_trailing_comma_indent = true


-- nvim-autopairs
require('nvim-autopairs').setup({
  disable_filetype = { 'TelescopePrompt', 'vim' }
})


-- LSP
local lsp = require('lsp-zero')

lsp.preset({
  name = 'recommended',
  set_lsp_keymaps = false,
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp_mappings = {
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({select = false}),
    ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
}
local cmp_sources = {
  {name = 'path'},
  {name = 'nvim_lsp'},
  {name = 'luasnip'},
}
local cmp_formatting = {
    fields = { 'abbr', 'menu', 'kind' },
    format = function (_, vim_item)
      vim_item.menu = ' '
      return vim_item
    end
}

cmp.event:on(
'confirm_done',
cmp_autopairs.on_confirm_done()
)

cmp.setup({
  mapping = cmp_mappings,
  sources = cmp_sources,
  formatting = cmp_formatting,
})

lsp.set_preferences({
  suggest_lsp_servers = true,
})

require('neodev').setup()

lsp.setup()

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = false,
  severity_sort = false,
  float = true,
})

-- Keymaps
vim.keymap.set('n', 'gd', ':lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>')
vim.keymap.set('n', 'gi', ':Telescope lsp_implementations<CR>')
vim.keymap.set('n', 'gr', ':Telescope lsp_references<CR>')

vim.keymap.set('n', '<leader>fh', ':lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', '<leader>fe', ':lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', '<F2>', ':lua vim.lsp.buf.rename()<CR>')
vim.keymap.set('n', '<leader>fa', ':lua vim.lsp.buf.code_action()<CR>')
vim.keymap.set('n', '<leader>fn', ':lua vim.diagnostic.goto_next()<CR>')

local function toggleDiagnostics()
  if (vim.diagnostic.is_disabled(0)) then
    vim.diagnostic.enable(0)
  else
    vim.diagnostic.disable(0)
  end
end

vim.keymap.set('n', '<leader>dt', function() toggleDiagnostics() end)


-- flutter-tools
require('flutter-tools').setup {
  decorations = {
    statusline = {
      app_version = true,
      device = true,
    },
  },
  widget_guides = {
    enabled = false,
  },
  closing_tags = {
    highlight = 'Comment',
    prefix = '//',
    enabled = true,
  },
  dev_log = {
    enabled = false,
  },
  lsp = {
    color = {
      enabled = true,
      background = true,
      foreground = false,
      virtual_text = true,
      virtual_text_str = "■",
    },
    settings = {
      showTodos = true,
      completeFunctionCalls = true,
      enableSnippets = true,
    },
  },
  debugger = {
    enabled = true,
    run_via_dap = true,
    exception_breakpoints = {},
    register_configurations = function(_)
      require("dap.ext.vscode").load_launchjs()
    end,
  },
}

vim.keymap.set('n', '<leader>fr', ':FlutterReload<CR>')
vim.keymap.set('n', '<leader>fR', ':FlutterRestart<CR>')
vim.keymap.set('n', '<leader>fs', ':FlutterVSplit<CR>')
vim.keymap.set('n', '<leader>fS', ':FlutterSplit<CR>')
vim.keymap.set('n', '<leader>ff', ':FlutterRun<CR>')
vim.keymap.set('n', '<leader>fq', ':FlutterQuit<CR>')



-- lualine
local function flutter_app_version()
  return vim.g.flutter_tools_decorations.app_version
end

require('lualine').setup {
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
    lualine_x = { flutter_app_version,  },
  },
}



-- catppuccin
vim.o.termguicolors = true
vim.cmd [[ colorscheme catppuccin-frappe ]]

require('catppuccin').setup {
  integrations = {
    treesitter = true,
    telescope = true,
    nvimtree = true,
    harpoon = true,
    mason = true,
    cmp = true,
    dap = {
      enabled = true,
      enable_ui = true,
    },
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
    },
  },
}



-- nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

require('nvim-tree').setup {
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    show_on_open_dirs = false,
  }
}

vim.keymap.set('n', '<c-n>', ':NvimTreeFindFileToggle<CR>')



-- telescope
local telescope = require('telescope')

telescope.setup {
    sort_mru = true,
    sort_lastused = true,
    ignore_current_buffer = true,
    picker = { buffers = { sort_lastused = true } },
    file_ignore_patterns = { '%.jpg', '%.png', '%.svg', '%.otf', '%.ttf' },
    defaults = {
      path_display = {
        'smart'
      },
    },
}

telescope.load_extension('ui-select')

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<c-p>', builtin.find_files, {})
vim.keymap.set('n', '<Space><Space>', builtin.oldfiles, {})
vim.keymap.set('n', '<Space>fg', builtin.live_grep, {})
vim.keymap.set('n', '<Space>he', builtin.help_tags, {})



-- treesitter
require('nvim-treesitter.configs').setup {
  -- A list of parser names, or "all"
  ensure_installed = { 'lua', 'vim', 'vimdoc', 'dart', 'java', 'kotlin', 'latex' },

  -- Install parsers synchronously (only applied to 'ensure_installed')
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
  playground = {
    enable = false,
  },
  query_linter = {
    enable = false,
    use_vertual_text = true,
    lint_events = {"BufWrite", "CursorHold"},
  }
}

vim.keymap.set('n', '<leader>Tp', ':TSPlaygroundToggle<CR>')



-- wilder
local wilder = require('wilder')

wilder.setup(
{
    modes = {':', '/', '?'},
    next_key = '<Tab>',
    previous = '<S-Tab>',
    accept_key = '<Enter>',
    reject_key = '<Esc>',
}
)

wilder.set_option('renderer', wilder.renderer_mux({
    [':'] = wilder.popupmenu_renderer({
        left = {
            ' ',
            wilder.popupmenu_devicons()
        },
        right = {
            ' ',
            wilder.popupmenu_scrollbar()
        },
    }),
}))



-- toggleterm
require("toggleterm").setup()

local Terminal  = require('toggleterm.terminal').Terminal

-- Lazygit integration
local lazygit = Terminal:new({
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "double",
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "<C-q>", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
  -- function to run on closing the terminal
  on_close = function(_)
    vim.cmd("startinsert!")
  end,
})

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>lg", "<cmd> lua _lazygit_toggle()<CR>", {noremap = true, silent = true})

--Flutter integration
vim.keymap.set('n', '<leader>ft', ':2ToggleTerm<CR>')

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
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



-- harpoon
local mark = require('harpoon.mark')
local ui = require('harpoon.ui')

vim.keymap.set('n', '<leader>ha', mark.add_file)
vim.keymap.set('n', '<leader>hh', ui.toggle_quick_menu)

-- Navigation
vim.keymap.set('n', '<leader>h1', function() ui.nav_file(1) end)
vim.keymap.set('n', '<leader>h2', function() ui.nav_file(2) end)
vim.keymap.set('n', '<leader>h3', function() ui.nav_file(3) end)
vim.keymap.set('n', '<leader>h4', function() ui.nav_file(4) end)



-- bufferline
local bufferline = require('bufferline')

local color_palette = require('catppuccin.palettes').get_palette 'frappe'
bufferline.setup {
  options = {
    mode = 'tabs',
    separator_style = 'padded_slant',
    show_buffer_close_icons = false,
    show_close_icon = false,
    always_show_bufferline = false,
    color_icons = true,
  },
    highlights = require('catppuccin.groups.integrations.bufferline').get {
        styles = { 'italic', 'bold' },
        custom = {
            all = {
                fill = { bg = '#000000' },
            },
            color_palette = {
                background = { fg = color_palette.text },
            },
            latte = {
                background = { fg = '#000000' },
            },
        },
    },
}



-- dap
require('dapui').setup(

  {
    controls = {
      element = "repl",
      enabled = true,
      icons = {
        disconnect = "",
        pause = "",
        play = "",
        run_last = "",
        step_back = "",
        step_into = "",
        step_out = "",
        step_over = "",
        terminate = ""
      }
    },
    element_mappings = {},
    expand_lines = true,
    floating = {
      border = "single",
      mappings = {
        close = { "q", "<Esc>" }
      }
    },
    force_buffers = true,
    icons = {
      collapsed = "",
      current_frame = "",
      expanded = ""
    },
    layouts = { {
        elements = { {
            id = "scopes",
            size = 0.5
          }, {
            id = "breakpoints",
            size = 0.25
          }, {
            id = "watches",
            size = 0.25
          } },
        position = "left",
        size = 40
      }, {
        elements = { {
            id = "repl",
            size = 1
          } },
        position = "bottom",
        size = 10
      } },
    mappings = {
      edit = "e",
      expand = { "<CR>", "<2-LeftMouse>" },
      open = "o",
      remove = "d",
      repl = "r",
      toggle = "t"
    },
    render = {
      indent = 1,
      max_value_lines = 100
    }
  }
)

local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

local sign = vim.fn.sign_define

sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = ""})
sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = ""})
sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = ""})


vim.keymap.set('n', '<leader>db', ':lua require("dap").toggle_breakpoint()<CR>')
vim.keymap.set('n', '<leader>dB', ':lua require("dap").set_breakpoint(vim.fn.input("Breakpoint Condition: "))<CR>')
vim.keymap.set('n', '<leader>dd', ':lua require("dap").continue()<CR>')
vim.keymap.set('n', '<leader>do', ':lua require("dap").step_over()<CR>')
vim.keymap.set('n', '<leader>di', ':lua require("dap").step_ito()<CR>')

vim.keymap.set('v', '<C-k>', 'lua require("dapui").eval()<CR>')

