return {
  "echasnovski/mini.nvim",
  config = function()
    -- Better Around/Inside textobjects
    require("mini.ai").setup({ n_lines = 500 })

    -- Minimal and fast autopairs
    require("mini.pairs").setup({
      modes = { insert = true, command = false, terminal = false },
      mappings = {
        ["<"] = { action = "open", pair = "<>", neigh_pattern = "\r." },
      },
    })

    -- Disable ' auto-pairing in Rust (conflicts with lifetime annotations)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "rust",
      callback = function(event)
        vim.keymap.set("i", "'", "'", { buffer = event.buf, noremap = true })
      end,
    })

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    require("mini.surround").setup({
      mappings = {
        add = "<leader>msa",
        delete = "<leader>msd",
        find = "<leader>msf",
        find_left = "<leader>msF",
        highlight = "<leader>msh",
        replace = "<leader>msr",
        update_n_lines = "<leader>msn",
        suffix_last = "",
        suffix_next = "",
      },
    })
  end,
}
