vim.pack.add({'https://github.com/dmtrKovalenko/fff.nvim'})

vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(event)
        if event.data.updated then
            require('fff.download').download_or_build_binary()
        end
    end
})

-- the plugin will automatically lazy load
vim.g.fff = {
    lazy_sync = true, -- start syncing only when the picker is open
    debug = {
        enabled = true,
        show_scores = true
    }
}

require("fff").setup({
    opts = {
        keymaps = {
            close = "<C-c>"
        }
    }
})

vim.keymap.set("n", "fc", function()
    require("fff").find_files_in_dir(vim.fn.stdpath("config"))
end, {
    desc = "FFFind config files"
})
