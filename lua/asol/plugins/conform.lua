return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>fo",
      function()
        require("conform").format({ async = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
    {
      "<leader>ft",
      function()
        vim.g.disable_autoformat = not vim.g.disable_autoformat
        vim.b.disable_autoformat = vim.g.disable_autoformat
        vim.notify("Format on save: " .. (vim.g.disable_autoformat and "OFF" or "ON"))
      end,
      desc = "Toggle format on save",
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
      python = { "ruff_format", "ruff_organize_imports" },
      terraform = { "terraform_fmt" },
      ["_"] = { "trim_whitespace", lsp_format = "prefer" },
    },
    formatters = {
      prettier = {
        prepend_args = function()
          local config_path = vim.fn.expand("$XDG_CONFIG_HOME/prettier/prettier.yaml")
          return { "--config", config_path }
        end,
      },
      rumdl_fmt = {
        command = "rumdl",
        args = { "fmt", "-", "--quiet" },
        stdin = true,
      },
    },
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = 10000, lsp_format = "fallback" }
    end,
    default_format_opts = {
      lsp_format = "fallback",
    },
  },
}
