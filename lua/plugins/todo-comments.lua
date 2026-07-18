return {
  "folke/todo-comments.nvim",
  -- without a buffer event this only loaded on <leader>st, so TODO/FIXME
  -- highlighting never activated in normal editing
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = { signs = false },
  keys = {
    {
      "<leader>st",
      function()
        Snacks.picker.todo_comments()
      end,
      desc = "Todo",
    },
  },
}
