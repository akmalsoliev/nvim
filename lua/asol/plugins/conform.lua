return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      "<leader>fo",
      function()
        require("conform").format({ async = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      markdown = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      ["_"] = { "trim_whitespace", lsp_format = "prefer" },
    },
    formatters = {
      prettier = {
        prepend_args = function()
          local config_path = vim.fn.expand("$XDG_CONFIG_HOME/prettier/prettier.yaml")
          return { "--config", config_path }
        end,
      },
    },
    format_on_save = { timeout_ms = 500 },
    default_format_opts = {
      lsp_format = "fallback",
    },
  },
}
