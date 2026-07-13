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

    require("mini.statusline").setup({
      use_icons = true,
      content = {
        active = function()
          local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
          local git = MiniStatusline.section_git({ trunc_width = 40 })
          local diff = MiniStatusline.section_diff({ trunc_width = 75 })
          local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
          local filename = MiniStatusline.section_filename({ trunc_width = 140 })
          local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
          local progress = "%2p%%" -- matches lualine "progress"

          return MiniStatusline.combine_groups({
            { hl = mode_hl, strings = { mode } },
            { hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics } },
            "%<", -- truncate point
            { hl = "MiniStatuslineFilename", strings = { filename } },
            "%=", -- right align
            { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
            { hl = mode_hl, strings = { progress } },
          })
        end,
        inactive = function()
          local filename = MiniStatusline.section_filename({ trunc_width = 140 })
          local location = MiniStatusline.section_location({ trunc_width = 75 })

          return MiniStatusline.combine_groups({
            { hl = "MiniStatuslineInactive", strings = { filename } },
            "%=",
            { hl = "MiniStatuslineInactive", strings = { location } },
          })
        end,
      },
    })

    require("mini.files").setup({
      mappings = {
        go_in_plus = "<CR>",
        go_out = "-",
      },
    })
    -- Make `:w` synchronize, matches the oil.nvim muscle memory
    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesBufferCreate",
      callback = function(args)
        local buf_id = args.data.buf_id
        vim.bo[buf_id].buftype = "acwrite"
        vim.api.nvim_create_autocmd("BufWriteCmd", {
          buffer = buf_id,
          callback = function()
            require("mini.files").synchronize()
          end,
        })
      end,
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
