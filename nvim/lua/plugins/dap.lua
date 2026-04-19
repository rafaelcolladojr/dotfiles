return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio"
    },
    opts = {

      controls = {
        element = "repl",
        enabled = true,
        icons = {
          disconnect = "",
          terminate = "",
          pause = "",
          play = "",
          run_last = "",
          step_back = "",
          step_into = "",
          step_out = "",
          step_over = "",
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
          size = 0.25
        }, {
          id = "breakpoints",
          size = 0.25
        }, {
          id = "stacks",
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
    },
    init = function()
      local dap, dapui = require("dap"), require("dapui")
      local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
      end
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      -- dap.listeners.before.event_terminated["dapui_config"] = function()
      --   dapui.close()
      -- end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      local sign = vim.fn.sign_define

      sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
      sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
      sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })


      map('n', '<leader>db', function() dap.toggle_breakpoint() end, 'DAP toggle breakpoint')
      map('n', '<leader>dB', function()
        dap.set_breakpoint(vim.fn.input("Breakpoint Condition: "))
      end, 'DAP conditional breakpoint')
      map('n', '<leader>dd', function() dap.continue() end, 'DAP continue')
      map('n', '<leader>do', function() dap.step_over() end, 'DAP step over')
      map('n', '<leader>di', function() dap.step_into() end, 'DAP step into')
      map('n', '<leader>dh', function() dapui.toggle() end, 'DAP UI toggle')

      map('v', '<C-k>', function() dapui.eval() end, 'DAP eval selection')
    end
  },
}
