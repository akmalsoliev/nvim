local runner = require("config.code_runner")

vim.keymap.set("n", "<leader>cr", function()
  runner.run("cargo run")
end, { desc = "󱘗 Cargo Run" })
vim.keymap.set("n", "<leader>ct", function()
  runner.run("cargo test")
end, { desc = "󱘗 Cargo Test" })
vim.keymap.set("n", "<leader>cc", function()
  runner.run("cargo clippy")
end, { desc = "󱘗 Cargo Clippy" })
vim.keymap.set("n", "<leader>cp", function()
  vim.ui.input({ prompt = "cargo add " }, function(input)
    if input and input ~= "" then
      runner.run("cargo add " .. input)
    end
  end)
end, { desc = "󱘗 Cargo Package (add)" })
vim.keymap.set("n", "<leader>cx", function()
  runner.close()
end, { desc = "Close Runner" })

-- Word suggestion
vim.keymap.set("n", "<leader>sg", "z=", {
  silent = true,
  desc = "Word [S]u[g]gestion",
})
