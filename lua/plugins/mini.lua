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

    require("mini.files").setup({
      mappings = {
        go_in_plus = "<CR>",
        go_out = "-",
      },
    })
    vim.keymap.set("n", "-", function()
      local MiniFiles = require("mini.files")
      -- Only open a new instance if one isn't already active.
      -- Prevents the global `-` from re-opening/resetting the explorer,
      -- so the buffer-local `go_out` mapping (`-`) works cleanly.
      if not MiniFiles.close() then
        MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
      end
    end, { desc = "Open MiniFiles" })

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
