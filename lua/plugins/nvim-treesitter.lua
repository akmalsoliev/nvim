return { -- Highlight, edit, and navigate code
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

    ---@diagnostic disable-next-line: missing-fields
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "bash",
        "dockerfile",
        "go",
        "javascript",
        "json",
        "lua",
        "make",
        "markdown",
        "python",
        "regex",
        "rust",
        "sql",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
