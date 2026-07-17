# Neovim Configuration Readme

This repository contains my personal Neovim configuration, tailored to my
preferences and workflow. Below is a brief overview of key features and how to
set it up.

This config is heavily influenced by
[kickstart](https://github.com/nvim-lua/kickstart.nvim.git)

## Features

### Plugins

Utilizes popular plugins to enhance Neovim's functionality, including:

- aerial: a code outline window for skimming and quick navigation
- blink-cmp: a modern completion engine with fuzzy matching and better UI
- conform: a formatting solution with format-on-save toggle and consistent code
  styles
- dab: Debug Adapter Protocol client with support for Python, Lua, and Go
- diffview: git diff viewer for comparing branches and changes
- fff: a fast file picker built in Rust for quick file navigation
- flash: lets you navigate your code with search labels, enhanced character
  motions, and Treesitter integration
- gitsigns: git integration for Neovim to show git change signs and perform git
  actions
- mini: a minimal and fast collection of Lua modules providing text objects,
  autopairs, surroundings, a minimal statusline, and a file explorer
  (mini.files)
- noice: enhanced UI for command line, search, and LSP documentation
- rainbow-delimiters: rainbow highlighting for nested brackets and delimiters
- rustowl: ownership and lifetime visualization for Rust code
- snacks: a collection of utilities including dashboard, picker, indent guides,
  scroll, notifications, and zen mode
- todo-comments: highlight and manage TODO comments within your code
- tree-sitter-manager: manages Tree-sitter parsers for syntax highlighting and
  indentation
- which-key: a keybinding helper for discovering key mappings in Neovim

### Custom utilities

- code runner: a lightweight custom runner (`lua/config/code_runner.lua`) that
  executes commands (e.g. cargo) in a reusable split buffer
- native undotree: undo history navigation using Neovim's built-in
  functionality

### Appearance

Consistent and visually pleasing setup using the ayu (dark) color scheme and a
minimal mini.statusline.
![Screenshot](./screenshot.png)

## Setup

The configuration uses [lazy.nvim](https://github.com/folke/lazy.nvim) for
plugin management. LSP servers are auto-discovered from the `lsp/` directory
(basedpyright, ruff, rust-analyzer, lua_ls, gopls, terraformls,
typescript-language-server, dbt_ls, tombi, and more) and are expected to be
installed externally (e.g. via Homebrew) — Mason is not used.

## Performance

The configuration optimizes Neovim's startup time by:

- Lazy-loading plugins when possible
- Disabling unnecessary built-in plugins

## Feedback

If you have any suggestions, feedback, or encounter any issues with the
configuration, feel free to open an issue or submit a pull request. Your
contributions are welcome!

Happy coding! 🚀
