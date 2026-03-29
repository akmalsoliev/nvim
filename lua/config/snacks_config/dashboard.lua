return {
  enabled = true,
  sections = {
    { section = "header" },
    { section = "keys", gap = 1, padding = 1 },
    {
      text = {
        { "  Loaded ", hl = "footer" },
        { tostring(#vim.pack.get()), hl = "Special" },
        { " plugins", hl = "footer" },
      },
      padding = 1,
    },
  },
  preset = {
    ---@type snacks.dashboard.Item[]
    keys = {
      { icon = " ", key = "<leader>ff", desc = "Find File", action = ':lua require("fff").find_files()' },
      { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
      { icon = " ", key = "<leader>/", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
      {
        icon = " ",
        key = "<leader>fc",
        desc = "Config",
        action = ':lua require("fff").find_files_in_dir(vim.fn.stdpath("config"))',
      },
      {
        key = "u",
        icon = "󰊳 ",
        desc = "Update",
        action = function()
          vim.pack.update()
          vim.notify("Plugins Updated")
          vim.fn.system("uv tool upgrade --all")
          vim.notify("UV Updated")
          vim.fn.system("bun update --global")
          vim.notify("bun Updated")
          vim.fn.system("rustup update")
          vim.notify("rustup Updated")
        end,
      },
      { icon = " ", key = "q", desc = "Quit", action = ":qa" },
    },
  },
}
