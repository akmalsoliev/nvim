return {
  "dmtrKovalenko/fff.nvim",
  build = "cargo build --release",
  opts = {
    keymaps = {
      close = "<C-c>",
    },
  },
  keys = {
    {
      "<leader>ff",
      function()
        require("fff").find_files()
      end,
      desc = "Open file picker",
    },
  },
}
