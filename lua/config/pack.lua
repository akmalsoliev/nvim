--        _                                _
-- __   __(_) _ __ ___    _ __    __ _   ___ | | __
-- \ \ / /| || '_ ` _ \  | '_ \  / _` | / __|| |/ /
--  \ V / | || | | | | |_| |_) || (_| || (__ |   <
--   \_/  |_||_| |_| |_(_) .__/  \__,_| \___||_|\_\
--                        |_|
-- Neovim 0.12+ built-in plugin manager

-- Disable built-in plugins for performance
local disabled_builtins = {
  "gzip", "matchit", "matchparen", "netrwPlugin",
  "shada", "tar", "tarPlugin", "tohtml",
  "tutor", "zip", "zipPlugin",
}
for _, name in ipairs(disabled_builtins) do
  vim.g["loaded_" .. name] = 1
end

-- Helpers ----------------------------------------------------------------

local function gh(repo)
  if repo:match("^https?://") then return repo end
  return "https://github.com/" .. repo
end

local function as_list(val)
  if val == nil then return {} end
  if type(val) == "string" then return { val } end
  return val
end

local function mod_name(spec)
  local name = spec.name or (spec[1] or ""):match("[^/]+$") or ""
  return name:gsub("%.nvim$", ""):gsub("%.lua$", ""):gsub("^nvim%-", "")
end

local function apply_config(spec)
  if spec.config then
    spec.config()
  elseif spec.opts then
    local name = mod_name(spec)
    local ok, m = pcall(require, name)
    if ok and type(m) == "table" and m.setup then
      m.setup(spec.opts)
    end
  end
end

local function apply_keys(spec)
  for _, k in ipairs(as_list(spec.keys)) do
    local lhs, rhs = k[1], k[2]
    if lhs and rhs then
      vim.keymap.set(as_list(k.mode or "n"), lhs, rhs, {
        desc = k.desc,
        silent = k.silent,
        nowait = k.nowait,
        expr = k.expr,
      })
    end
  end
end

local function is_lazy(spec)
  return spec.event ~= nil or spec.cmd ~= nil or spec.ft ~= nil
end

local function to_pack(spec)
  return { src = gh(spec[1]), name = spec.name, version = spec.version }
end

-- Fire VeryLazy after UI is ready (mirrors lazy.nvim behavior) -----------

vim.api.nvim_create_autocmd("UIEnter", {
  once = true,
  callback = function()
    vim.schedule(function()
      vim.api.nvim_exec_autocmds("User", { pattern = "VeryLazy" })
    end)
  end,
})

-- Collect specs from lua/plugins/*.lua -----------------------------------

local all_specs = {}
local config_dir = vim.fn.stdpath("config")
for _, file in ipairs(vim.split(vim.fn.glob(config_dir .. "/lua/plugins/*.lua"), "\n")) do
  local mod = file:match("([^/]+)%.lua$")
  if mod then
    local ok, spec = pcall(require, "plugins." .. mod)
    if ok and spec then
      -- Flatten nested specs like { { "owner/repo", ... } }
      if type(spec[1]) == "table" and type(spec[1][1]) == "string" then
        for _, s in ipairs(spec) do
          table.insert(all_specs, s)
        end
      else
        table.insert(all_specs, spec)
      end
    end
  end
end

all_specs = vim.tbl_filter(function(s) return s.enabled ~= false end, all_specs)
table.sort(all_specs, function(a, b) return (a.priority or 50) > (b.priority or 50) end)

-- Collect dependency URLs ------------------------------------------------

local main_repos = {}
for _, s in ipairs(all_specs) do
  main_repos[s[1]] = true
end

local dep_specs = {}
local seen = {}
for _, spec in ipairs(all_specs) do
  for _, dep in ipairs(as_list(spec.dependencies)) do
    local src = type(dep) == "string" and dep or (type(dep) == "table" and (dep[1] or dep.src))
    if src and not seen[src] and not main_repos[src] then
      seen[src] = true
      table.insert(dep_specs, { src = gh(src) })
    end
  end
end

-- Build hooks (must register before add()) -------------------------------

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.kind ~= "install" and ev.data.kind ~= "update" then return end
    local pname = ev.data.spec.name

    for _, spec in ipairs(all_specs) do
      local sname = spec.name or (spec[1] or ""):match("[^/]+$")
      if sname == pname and spec.build then
        if not ev.data.active then
          pcall(vim.cmd.packadd, pname)
        end
        if type(spec.build) == "function" then
          spec.build()
        elseif type(spec.build) == "string" then
          if spec.build:sub(1, 1) == ":" then
            vim.cmd(spec.build:sub(2))
          else
            vim.system(vim.split(spec.build, "%s+"), { cwd = ev.data.path }):wait()
          end
        end
        break
      end
    end
  end,
})

-- Separate eager / lazy --------------------------------------------------

local eager, lazy = {}, {}
for _, spec in ipairs(all_specs) do
  table.insert(is_lazy(spec) and lazy or eager, spec)
end

-- Install & load dependencies and eager plugins --------------------------

if #dep_specs > 0 then vim.pack.add(dep_specs, { confirm = false }) end
if #eager > 0 then vim.pack.add(vim.tbl_map(to_pack, eager), { confirm = false }) end

-- Run init() for all specs (before config, like lazy.nvim) ---------------

for _, spec in ipairs(all_specs) do
  if spec.init then spec.init() end
end

-- Configure eager plugins and register keymaps ---------------------------

for _, spec in ipairs(eager) do
  local ok, err = pcall(apply_config, spec)
  if not ok then
    vim.notify("pack: config error for " .. (spec[1] or "?") .. ": " .. err, vim.log.levels.WARN)
  end
  apply_keys(spec)
end

-- Install lazy plugins without loading (no-op load function) -------------

if #lazy > 0 then
  vim.pack.add(vim.tbl_map(to_pack, lazy), { confirm = false, load = function() end })
end

-- Set up lazy-loading triggers -------------------------------------------

for _, spec in ipairs(lazy) do
  local pname = spec.name or (spec[1] or ""):match("[^/]+$")
  local loaded = false

  local function ensure()
    if loaded then return end
    loaded = true
    vim.cmd.packadd(pname)
    apply_config(spec)
    apply_keys(spec)
  end

  -- Event triggers
  for _, ev in ipairs(as_list(spec.event)) do
    if ev == "VeryLazy" then
      vim.api.nvim_create_autocmd("User", { pattern = "VeryLazy", once = true, callback = ensure })
    else
      vim.api.nvim_create_autocmd(ev, { once = true, callback = ensure })
    end
  end

  -- Command triggers
  for _, cmd in ipairs(as_list(spec.cmd)) do
    vim.api.nvim_create_user_command(cmd, function(info)
      vim.api.nvim_del_user_command(cmd)
      ensure()
      vim.cmd(string.format("%s%s %s", cmd, info.bang and "!" or "", info.args or ""))
    end, { nargs = "*", bang = true, complete = "file" })
  end

  -- Filetype triggers
  local fts = as_list(spec.ft)
  if #fts > 0 then
    vim.api.nvim_create_autocmd("FileType", { pattern = fts, once = true, callback = ensure })
  end

  -- Key triggers (proxy keymaps that load the plugin on first press)
  for _, k in ipairs(as_list(spec.keys)) do
    local lhs, rhs = k[1], k[2]
    if lhs and rhs then
      vim.keymap.set(as_list(k.mode or "n"), lhs, function()
        ensure()
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(lhs, true, true, true), "m", false)
      end, { desc = k.desc })
    end
  end
end
