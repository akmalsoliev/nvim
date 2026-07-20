local snacks_config = require("snacks_config")
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- default 1.5MB threshold turned multi-MB json fixtures into ft=bigfile,
    -- killing LSP/treesitter (and <leader>a symbols)
    -- bigfile = { enabled = true, size = 4 * 1024 * 1024 },
    dashboard = snacks_config.dashboard,
    dim = { enabled = true },
    git = { enabled = true },
    indent = { enabled = true },
    picker = {
      enabled = true,
      matcher = { history_bonus = true },
      sort = {
        fields = { "history:desc", "score:desc", "#text", "idx" },
      },
    },
    quickfile = { enabled = true },
    rename = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    toggle = { enabled = true },
    words = { enabled = true },
    notifier = snacks_config.notifier,
    notify = { enabled = true },
    styles = snacks_config.styles,
    zen = {
      enabled = true,
      width = 70,
      toggles = {
        dim = false,
        -- git_signs = false,
        -- mini_diff_signs = false,
      },
    },
  },
  keys = snacks_config.keys,
  init = snacks_config.configuration,
}
