-- return {
--   "sainnhe/everforest",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     vim.o.background = "dark"
--     vim.g.everforest_background = "medium"
--     vim.cmd.colorscheme("everforest")
--   end,
-- }
--

return {
  "ayu-theme/ayu-vim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.opt.termguicolors = true
    vim.g.ayucolor = "dark" -- or "mirage" or "light"
    vim.cmd("colorscheme ayu")
  end,
}
