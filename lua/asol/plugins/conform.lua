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
      markdown = { "rumdl_fmt" },
      json = { "prettier" },
      yaml = { "prettier" },
      go = { "gofmt" },
      ["_"] = { "trim_whitespace", lsp_format = "prefer" },
      sql = { "sqlfluff" },
      pgsql = { "sqlfluff" },
    },
    formatters = {
      prettier = {
        prepend_args = function()
          local config_path = vim.fn.expand("$XDG_CONFIG_HOME/prettier/prettier.yaml")
          return { "--config", config_path }
        end,
      },
      sqlfluff = {
        command = "sqlfluff",
        args = { "fix", "--FIX-EVEN-UNPARSABLE", "$FILENAME" },
        stdin = false,
        cwd = function()
          return vim.fn.getcwd()
        end,
      },
      rumdl_fmt = {
        command = "rumdl",
        args = { "fmt", "-", "--quiet" },
        stdin = true,
      },
    },
    format_on_save = function(bufnr)
      local ft = vim.bo[bufnr].filetype
      if ft == "sql" or ft == "pgsql" then
        return { timeout_ms = 10000, lsp_format = "fallback" }
      end
      return { timeout_ms = 500, lsp_format = "fallback" }
    end,
    default_format_opts = {
      lsp_format = "fallback",
    },
  },
}
