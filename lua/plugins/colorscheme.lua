return {
  "mcauley-penney/techbase.nvim",
  event = "VimEnter", -- Sets the loading event to 'VimEnter'
  config = function()
    vim.cmd.colorscheme("techbase")
  end,
  priority = 1000,
}
