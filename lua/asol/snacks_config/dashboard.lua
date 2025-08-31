return {
  enabled = true,
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
      { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
      {
        key = "u",
        icon = "󰊳 ",
        desc = "Update",
        action = function()
          vim.cmd("Lazy update")
          print("Lazy Updated")
          vim.cmd("MasonToolsUpdate")
          print("Mason Updated")
          vim.fn.system("uv tool upgrade --all")
          print("UV Updated")
          vim.fn.system("bun update --global")
          print("bun Updated")
          vim.fn.system("rustup update")
          print("rustup Updated")
        end,
      },
      { icon = " ", key = "q", desc = "Quit", action = ":qa" },
    },
  },
}
