---@type vim.lsp.Config
return {
  cmd = { "uvx", "pyrefly", "lsp" },
  filetypes = { "python" },
  root_markers = {
    "pyrefly.toml",
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    ".git",
  },
  settings = {
    python = {
      pyrefly = {
        displayTypeErrors = "force-on",
      },
    },
  },
}
