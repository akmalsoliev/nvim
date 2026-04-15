local runner = require("config.code_runner")

vim.keymap.set("n", "<leader>cr", function()
  runner.run("cargo run")
end, { desc = "Cargo Run" })
vim.keymap.set("n", "<leader>ct", function()
  runner.run("cargo test")
end, { desc = "Cargo Test" })
vim.keymap.set("n", "<leader>cc", function()
  runner.run("Cargo clippy")
end, { desc = "Cargo Clippy" })
vim.keymap.set("n", "<leader>cx", function()
  runner.close()
end, { desc = "Close Runner" })

-- Word suggestion
vim.keymap.set("n", "<leader>sg", "z=", {
  silent = true,
  desc = "Word [S]u[g]gestion",
})
