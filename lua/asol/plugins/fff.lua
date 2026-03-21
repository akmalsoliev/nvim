return {
  "dmtrKovalenko/fff.nvim",
  build = function()
    -- this will download prebuild binary or try to use existing rustup toolchain to build from source
    -- (if you are using lazy you can use gb for rebuilding a plugin if needed)
    require("fff.download").download_or_build_binary()
  end,
  lazy = false,
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
    {
      "<leader>fc",
      function()
        require("fff").find_files_in_dir(vim.fn.stdpath("config"))
      end,
      desc = "Find Config File",
    },
    {
      "fz",
      function()
        require("fff").live_grep({
          grep = {
            modes = { "fuzzy", "plain" },
          },
        })
      end,
      desc = "Live fffuzy grep",
    },
  },
}
