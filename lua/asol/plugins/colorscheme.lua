return {
  "mcauley-penney/techbase.nvim",
  event = "VimEnter", -- Sets the loading event to 'VimEnter'
  config = function()
    vim.cmd.colorscheme("techbase")
  end,
  opts = {
    plugin_support = {
      aerial = true,
      blink = true,
      edgy = true,
      gitsigns = true,
      hl_match_area = true,
      lazy = true,
      lualine = true,
      mason = true,
      mini_cursorword = true,
      nvim_cmp = true,
      vim_illuminate = true,
      visual_whitespace = true,
    },
  },
  priority = 1000,
}
