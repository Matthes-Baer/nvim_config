# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

# Setup
- git clone this repository (this is based on https://github.com/LazyVim/starter) in $env:LOCALAPPDATA\nvim (on Windows; `~/.config/nvim` on Linux)
- Optionally remove .git folder to create a separate repository: Remove-Item -Recurse -Force .git
- Install lazygit: https://github.com/jesseduffield/lazygit?tab=readme-ov-file#installation
- Install LLVM (clang) (not mingw) -> https://github.com/nvim-treesitter/nvim-treesitter/wiki/Windows-support
  - Don't forget to add bin folder to PATH

# Basic Usage
- Open `nvim`, then Leader Key + `e`, to open Neo-tree
- Use `bn` or `bp` to switch buffers on same window and close buffers with `bd` OR use Leader key + "," to go through all active buffers
  - With the buffer from window you can search by file name or number and can use arrow keys to go through all buffers besides the current active one
- Open a terminal with `split` and then `terminal`
- Use Mason (package manager for Neovim) to install language servers, linters, formatters, and other developer tools
- LazyGit Commands: https://github.com/jesseduffield/lazygit?tab=readme-ov-file#features
  - p for pulling, P for Pushing, q to leave


# Troubleshooting

- If packages seem broken, try deleting the corresponding nvim-data folder section and restart nvim to trigger a full installation
  - Remove-Item -Recurse -Force "$env:LOCALAPPDATA\nvim-data\lazy\nvim-treesitter" for example

# TODO:
- Add anything for autocmds, keymaps, or options?
- Merge Conflict resolver tool -> hatte ich dafür schon was installiert?
- Notizen machen zu GitLazy oder wie es hieß
- Gibt es ein package für ein besser integriertes terminal?
- Config aufräumen
- ggf. weitere Informationen/Erklärungen in readme hinzufügen
- Am Ende Repo public machen, damit ich es klonen könnte
- How to delete file? Telescope? then delete test.lua and testA.lua
- Deutsche Rechtschreibprüfung fehlt



# Information

## Treesitter (through nvim-treesitter)

Treesitter is mainly used for syntax highlighting and code parsing. It provides:
✅ Better syntax highlighting (more accurate than regex-based Vim highlighting).
✅ Indentation improvements (better auto-indent).
✅ Folding, text objects, and query-based features.

👉 It does NOT provide autocompletion or error checking.

## LSP (Language Server Protocol) (through Mason)
LSP is a protocol that allows editors like Neovim to communicate with language servers, providing features like auto-completion, go to definition, hover documentation, and more for various programming languages.

Neovim has built-in support for LSP (starting from version 0.5), and using LSP makes the editor aware of your code structure, improving the development experience.

LSP provides:
✅ Autocompletion (e.g., lua-language-server suggests functions).
✅ Go-to definition, hover documentation, refactoring.
✅ Diagnostics (errors, warnings).

👉 LSP is like IntelliSense in VS Code—it makes coding smarter.

## DAP (Debug Adapter Protocol) (through Mason)
DAP stands for Debug Adapter Protocol, and it is a protocol that allows debugging functionality to be integrated into text editors or IDEs. It enables the connection between a debugging client (like Neovim) and a debugging server (which can be a debugger for a specific programming language). This integration allows you to debug your code directly inside your editor.

DAP allows debugging inside Neovim. It provides:
✅ Breakpoints (F9)
✅ Step Over / Step Into / Step Out
✅ Variable inspection

👉 It’s like a built-in debugger, similar to VS Code's debugger.
