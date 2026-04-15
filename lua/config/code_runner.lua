local M = {}

local runner_buf = nil
local runner_win = nil

function M.run(cmd)
  -- Save current window to return focus later
  local current_win = vim.api.nvim_get_current_win()

  -- If the window already exists and is valid, reuse it
  if runner_win and vim.api.nvim_win_is_valid(runner_win) then
    -- Clear the old buffer content by creating a new one
    local new_buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_win_set_buf(runner_win, new_buf)

    -- Delete old buffer
    if runner_buf and vim.api.nvim_buf_is_valid(runner_buf) then
      vim.api.nvim_buf_delete(runner_buf, { force = true })
    end

    runner_buf = new_buf
  else
    -- Create a new split at the bottom
    vim.cmd("botright new")
    runner_win = vim.api.nvim_get_current_win()
    runner_buf = vim.api.nvim_get_current_buf()

    -- Set split height
    vim.api.nvim_win_set_height(runner_win, 15)
  end

  -- Set buffer options
  vim.api.nvim_set_option_value("buftype", "nofile", { buf = runner_buf })
  vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = runner_buf })
  vim.api.nvim_set_option_value("swapfile", false, { buf = runner_buf })

  -- Focus the runner window briefly to run termopen
  vim.api.nvim_set_current_win(runner_win)

  -- Run the command
  vim.fn.termopen(cmd, {
    on_exit = function(_, exit_code, _)
      -- Rename the buffer to show status
      if vim.api.nvim_buf_is_valid(runner_buf) then
        local status = exit_code == 0 and "✓ SUCCESS" or "✗ FAILED (" .. exit_code .. ")"
        vim.api.nvim_buf_set_name(runner_buf, " " .. cmd .. " — " .. status)
      end
    end,
  })

  -- Switch back to normal mode in the terminal (so it doesn't capture input)
  vim.cmd("stopinsert")

  -- Return focus to the original window
  vim.api.nvim_set_current_win(current_win)

  -- Keymaps to close the runner window
  vim.keymap.set("n", "q", function()
    if runner_win and vim.api.nvim_win_is_valid(runner_win) then
      vim.api.nvim_win_close(runner_win, true)
      runner_win = nil
      runner_buf = nil
    end
  end, { buffer = runner_buf, silent = true })
end

function M.close()
  if runner_win and vim.api.nvim_win_is_valid(runner_win) then
    vim.api.nvim_win_close(runner_win, true)
    runner_win = nil
    runner_buf = nil
  end
end

function M.toggle()
  if runner_win and vim.api.nvim_win_is_valid(runner_win) then
    M.close()
  else
    -- Reopen last command or show empty
    M.run("echo 'No command run yet'")
  end
end

return M
