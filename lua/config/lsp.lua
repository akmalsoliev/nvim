--  _       _____ _____    _  __
-- | |     / ____|  __ \  | |/ /
-- | |    | (___ | |__) | | ' / ___ _   _ _ __ ___   __ _ _ __  ___
-- | |     \___ \|  ___/  |  < / _ \ | | | '_ ` _ \ / _` | '_ \/ __|
-- | |____ ____) | |      | . \  __/ |_| | | | | | | (_| | |_) \__ \
-- |______|_____/|_|      |_|\_\___|\__, |_| |_| |_|\__,_| .__/|___/
--                                   __/ |               | |
--                                  |___/                |_|
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("CustomLspConfig", { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    map("gt", "<cmd>vsplit | lua vim.lsp.buf.definition()<CR>", "Go to Definition in a split")

    map("<leader>e", function()
      vim.diagnostic.open_float({ source = true })
    end, "Show diagnostic [E]rror messages, default is <C-W>d")

    map("<leader>q", vim.diagnostic.setloclist, "Open diagnostic [Q]uickfix list")

    -- Rename the variable under your cursor
    --  Most Language Servers support renaming across files, etc.
    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

    -- Execute a code action, usually your cursor needs to be on top of an error
    -- or a suggestion from your LSP for this to activate.
    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

    -- WARN: This is not Goto Definition, this is Goto Declaration.
    --  For example, in C this would take you to the header
    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

    map("gi", vim.lsp.buf.implementation, "[G]oto [i]mplementation")
  end,
})

--  _       _____ _____
-- | |     / ____|  __ \
-- | |    | (___ | |__) |
-- | |     \___ \|  ___/
-- | |____ ____) | |
-- |______|_____/|_|

local configDir = vim.fn.stdpath("config")
local lspFiles = vim.fn.glob(configDir .. "/lsp/*.lua")
local lspSplitFiles = vim.split(lspFiles, "\n")

for _, files in pairs(lspSplitFiles) do
  local fileName = files:match("([^/\\]+)%.lua$")
  vim.lsp.enable(fileName)
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("my.lsp", {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    local bufnr = args.buf

    -- Add any other on-attach logic here (keymaps, etc.)
  end,
})
