local masonConfig = {
  "basedpyright", --python
  "ruff", -- python
  "lua-language-server", -- lua
  "stylua", -- lua
  "rust-analyzer", --rust
  "terraform-ls", --terraform
  "prettier", --js, ts, json, json, markdown
  "yamlfmt", -- yaml
}

require("mason").setup()
require("mason-tool-installer").setup({
  ensure_installed = masonConfig,
  auto_update = true,
  run_on_start = true,
  run_on_config = true,
})
