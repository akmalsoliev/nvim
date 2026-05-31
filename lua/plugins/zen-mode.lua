return {
  "folke/zen-mode.nvim",
  keys = {
    {
      "<leader>uz",
      function()
        require("zen-mode").toggle({
          window = {
            width = 0.7, -- width will be 85% of the editor width
          },
        })
      end,
      desc = "Toggle Zen Mode",
    },
  },
}
