---@type vim.lsp.Config
return {
  cmd = { "dbt-ls" },
  filetypes = { "sql" },
  root_markers = { "dbt_project.yml" },
}
