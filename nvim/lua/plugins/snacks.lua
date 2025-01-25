return {
  {
    'folke/snacks.nvim',
    dependencies = {
      'nvim-tree/nvim-tree.lua',
    },
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      animate = {},
      dashboard = {
        enabled = true,
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 2 },
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 2 },
          { section = "startup" },
        },
      },
      dim = {},
      input = {},
      lazygit = {},
      notifier = {},
      notify = {},
      ---@type snacks.terminal.Config
      indent = {},
      win = {},
      zen = {
        enabled = true,
        dim = true,
      },
    },
    init = function()
      -- NOTIFIER
      ---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
      local progress = vim.defaulttable()
      vim.api.nvim_create_autocmd("LspProgress", {
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
              notif.icon = #progress[client.id] == 0 and " "
                  or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
            end,
          })
        end,
      })


      -- KEYBINDINGS
      vim.keymap.set('n', '<leader>lg', ':lua Snacks.lazygit.open()<CR>')
      vim.keymap.set('n', '<leader>z', ':lua Snacks.zen()<CR>')
    end
  }
}
