return {
  {
    'folke/snacks.nvim',
    enabled = true,
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      animate = {},
      dashboard = {
        enabled = true,
        preset = {
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua require('fzf-lua').files()" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua require('fzf-lua').oldfiles()" },
            { icon = " ", key = "g", desc = "Live Grep", action = ":lua require('fzf-lua').live_grep()" },
            { icon = " ", key = "F", desc = "Flutter Run", action = ":FlutterRun" },
            { icon = " ", key = "D", desc = "Flutter Devices", action = ":FlutterDevices" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 2 },
          { section = "startup" },
        },
      },
      dim = {},
      input = {},
      lazygit = {},
      notifier = {},
      notify = {},
      indent = {},
      win = {},
      zen = {
        enabled = true,
        dim = true,
      },
    },
    init = function()
      -- Snacks.input needs explicit enable to override vim.ui.input
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        once = true,
        callback = function()
          Snacks.input.enable()
        end,
      })

      local map = function(lhs, rhs, desc)
        vim.keymap.set('n', lhs, rhs, { silent = true, desc = desc })
      end
      -- NOTIFIER
      ---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
      local progress = vim.defaulttable()
      local progress_group = vim.api.nvim_create_augroup('RaffSnacksLspProgress', { clear = true })
      vim.api.nvim_create_autocmd("LspProgress", {
        group = progress_group,
        ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          local value = ev.data.params
              .value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
          if not client or type(value) ~= "table" then
            return
          end
          local p = progress[client.id]

          for i = 1, #p + 1 do
            if i == #p + 1 or p[i].token == ev.data.params.token then
              p[i] = {
                token = ev.data.params.token,
                msg = ("[%3d%%] %s%s"):format(
                  value.kind == "end" and 100 or value.percentage or 100,
                  value.title or "",
                  value.message and (" **%s**"):format(value.message) or ""
                ),
                done = value.kind == "end",
              }
              break
            end
          end

          local msg = {} ---@type string[]
          progress[client.id] = vim.tbl_filter(function(v)
            return table.insert(msg, v.msg) or not v.done
          end, p)

          local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
          vim.notify(table.concat(msg, "\n"), vim.log.levels.INFO, {
            id = "lsp_progress",
            title = client.name,
            opts = function(notif)
              notif.icon = #progress[client.id] == 0 and " "
                  or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
            end,
          })
        end,
      })


      -- KEYBINDINGS
      map('<leader>lg', function() Snacks.lazygit.open() end, 'Open Lazygit')
      map('<leader>z', function() Snacks.zen() end, 'Toggle Zen mode')
      map('<leader>nm', function() Snacks.notifier.show_history() end, 'Notification history')
    end
  }
}
