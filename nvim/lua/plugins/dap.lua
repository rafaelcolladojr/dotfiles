return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio"
    },
    opts = {},
    init = function()
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

      sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
      sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
      sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })


      vim.keymap.set('n', '<leader>db', ':lua require("dap").toggle_breakpoint()<CR>')
      vim.keymap.set('n', '<leader>dB', ':lua require("dap").set_breakpoint(vim.fn.input("Breakpoint Condition: "))<CR>')
      vim.keymap.set('n', '<leader>dd', ':lua require("dap").continue()<CR>')
      vim.keymap.set('n', '<leader>do', ':lua require("dap").step_over()<CR>')
      vim.keymap.set('n', '<leader>di', ':lua require("dap").step_ito()<CR>')

      vim.keymap.set('v', '<C-k>', 'lua require("dapui").eval()<CR>')
    end
  },
}
