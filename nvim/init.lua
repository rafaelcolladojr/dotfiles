-- @@@@@@@@@@@@@@@@@@@@@@@@@@ --
-- @@@@@@ VIM SETTINGS @@@@@@ --
-- @@@@@@@@@@@@@@@@@@@@@@@@@@ --

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.backspace = '2'

-- editor settings
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.signcolumn = 'yes'
vim.opt.autoread = true
vim.opt.colorcolumn = '80'

-- Relative line numbers
vim.opt.relativenumber = true
vim.opt.nu = true
vim.opt.wrap = false

-- command line
vim.opt.pumblend = 20
vim.opt.wildmenu = true
vim.opt.wildmode = 'longest:full'
vim.opt.wildoptions = 'pum'
vim.opt.showmode = false
vim.opt.showcmd = true
vim.opt.cmdheight = 1;

-- use spaces for tabs and stuff
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftround = true
vim.opt.smartindent = true


-- Don't highlight search results
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.scrolloff = 8
vim.opt.updatetime = 50


-- Native clipboard
vim.opt.clipboard = 'unnamedplus'

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
-- vim.keymap.set('n', '<leader>bb', ':lua require("arrowhead").swap_notation(false)<CR>')
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
  {
    'gelguy/wilder.nvim',
    config = function ()
    end
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },
  'nvim-lua/plenary.nvim',

  -- COLORSCHEMES
  {'catppuccin/nvim', name = 'catppuccin', priority = 1000 },

  -- IDE
  'nvim-tree/nvim-tree.lua',
  'nvim-tree/nvim-web-devicons',
  'nvim-lualine/lualine.nvim',
  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },
  'nvim-treesitter/playground',
  'rrethy/nvim-treesitter-endwise',
  'akinsho/toggleterm.nvim',
  'AndrewRadev/switch.vim',
  'mfussenegger/nvim-dap',
  'rcarriga/nvim-dap-ui',
  {
    'j-hui/fidget.nvim',
    opts = {},
  },
  {
    'numToStr/Comment.nvim',
    opts = {},
    lazy = false,
  },

  -- tmux support
  'christoomey/vim-tmux-navigator',

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

  -- TELESCOPE
  {'nvim-telescope/telescope.nvim', tag = '0.1.5'},
  'nvim-telescope/telescope-ui-select.nvim',

  -- TPOPE THE GOD
  'tpope/vim-fugitive',
  'tpope/vim-surround',
  'tpope/vim-commentary',
  'tpope/vim-sleuth',


  -- THEPRIMEAGEN
  'theprimeagen/vim-be-good',
  {
    'theprimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },

  -- FOLKE
  'folke/neodev.nvim',
  {
    'folke/twilight.nvim',
    opts = {},
  },
  {
    'folke/zen-mode.nvim',
    opts = {
      plugins = {
        alacritty = {
          enable = true,
          font = '20',
        },
      },
    },
  },
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
  },
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      severity = vim.diagnostic.severity.ERROR,
    },
  },


  -- Flutter
  'dart-lang/dart-vim-plugin',
  {
    'akinsho/flutter-tools.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim',
    },
  },



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
require('mason').setup()
require('mason-lspconfig').setup()

local servers = {
  lua_ls = {
    Lua = {
      workspace = {
        checkThirdParty = false
      },
      telemetry = { enable = false },
    }
  },
}

-- Setup neovim lua config
require('neodev').setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure above servers are installed
local mason_lspconfig = require('mason-lspconfig')

mason_lspconfig.setup({
  ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
  function(server_name)
    require('lspconfig')[server_name].setup({
      capabilities = capabilities,
      -- on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    })
  end,
})


local cmp = require('cmp')
local luasnip = require('luasnip')
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup()

local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp_snippet = {
  expand = function(args)
    luasnip.lsp_expand(args.body)
  end,
}
local cmp_completion = {
  completeopt = 'menu,menuone,noinsert',
}
local cmp_mappings = {
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({select = false}),
    ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
}
local cmp_sources = {
  {name = 'nvim_lsp'},
  {name = 'luasnip'},
  {name = 'path'},
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
  snippet = cmp_snippet,
  completion = cmp_completion,
  mapping = cmp_mappings,
  sources = cmp_sources,
  formatting = cmp_formatting,
})

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
vim.keymap.set('n', '<leader>fE', ':Trouble<CR>')
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
      showTodos = false,
      completeFunctionCalls = true,
      enableSnippets = true,
    },
  },
  debugger = {
    enabled = true,
    run_via_dap = true,
    exception_breakpoints = {},
    register_configurations = function(_)
      require('dap').configurations.dart = {}
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
    lualine_x = { flutter_app_version },
  },
}






-- catppuccin
---@type CatppuccinOptions
local catp_opts = {
  flavour = 'mocha',
  background = {
    light = 'latte',
    dark = 'mocha',
  },
  transparent_background = false,
  integrations = {
    cmp = true,
    dap = true,
    dap_ui = true,
    fidget = true,
    harpoon = true,
    mason = true,
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
    nvimtree = true,
    telescope = {
      enabled = true,
    },
    treesitter = true,
  },
}

require('catppuccin').setup(catp_opts)
vim.cmd.colorscheme 'catppuccin'
vim.o.termguicolors = true






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
    file_ignore_patterns = { '%.jpg', '%.png', '%.svg', '%.svg', '%.gif', '%.otf', '%.ttf' },
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
-- Defer Treesitter setup after first render to improve startup time
vim.defer_fn(function ()
---@diagnostic disable-next-line: missing-fields
  require('nvim-treesitter.configs').setup({
    -- A list of parser names, or "all"
    ensure_installed = { 'dart', 'lua', 'vim', 'vimdoc', 'java', 'kotlin', 'latex' },

    auto_install = false,
    sync_install = false,

    ignore_install = {},

    -- modules = ts_modules,
    highlight = {
      enable = true,
      disable = function(_, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
      end,
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true,
    },
    playground = {
      enable = true,
    },
    query_linter = {
      enable = false,
      use_virtual_text = true,
      lint_events = {"BufWrite", "CursorHold"},
    }
  })
end, 0)


vim.keymap.set('n', '<leader>Tp', ':TSPlaygroundToggle<CR>')






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

function Raff_lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>lg", "<cmd> lua Raff_lazygit_toggle()<CR>", {noremap = true, silent = true})

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
local harpoon = require('harpoon')

vim.keymap.set('n', '<leader>ha', function() harpoon:list():append() end)
vim.keymap.set('n', '<leader>hh', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

-- Navigation
vim.keymap.set('n', '<leader>h1', function() harpoon:list():select(1) end)
vim.keymap.set('n', '<leader>h2', function() harpoon:list():select(2) end)
vim.keymap.set('n', '<leader>h3', function() harpoon:list():select(3) end)
vim.keymap.set('n', '<leader>h4', function() harpoon:list():select(4) end)






-- dap
require('dapui').setup()

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





-- comments
require('Comment').setup()
