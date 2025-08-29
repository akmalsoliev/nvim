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
      markdown = { "mdformat" },
      json = { "prettier" },
      yaml = { "yamlfmt" },
      ["_"] = { "trim_whitespace", lsp_format = "prefer" },
    },
    formatters = {
      yamlfmt = {
        prepend_args = { "-global_conf" },
      },
    },
    format_on_save = { timeout_ms = 500 },
    default_format_opts = {
      lsp_format = "fallback",
    },
  },
}
