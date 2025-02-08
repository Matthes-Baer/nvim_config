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
- `<C-o>` would be CTRL + o
- `<s-down>` would be Shift + down_arrow
- Open `nvim`, then Leader Key + `e`, to open Neo-tree
- Use `bn` or `bp` to switch buffers on same window and close buffers with `bd` OR use Leader key + "," to go through all active buffers
  - With the buffer from window you can search by file name or number and can use arrow keys to go through all buffers besides the current active one
- Open a terminal with `split` and then `terminal` OR use `Leader Key + f + t or T`
- Use Mason (package manager for Neovim) to install language servers, linters, formatters, and other developer tools
- `Leader Key + f + n` to create new file, then `:edit file_name` to name it
- `Leader Kef + f + b` to get to file browser and select files via `Tab` and delete with `d` while in normal mode
- LazyGit Commands: https://github.com/jesseduffield/lazygit?tab=readme-ov-file#features
  - p for pulling, P for Pushing, q to leave
- When in terminal (`Leader Key + f + t`), use double `ESC` to leave the `terminal` mode


# Troubleshooting

- If packages seem broken, try deleting the corresponding nvim-data folder section and restart nvim to trigger a full installation
  - `Remove-Item -Recurse -Force "$env:LOCALAPPDATA\nvim-data\lazy\nvim-treesitter"` for example (on Windows)

# TODO:
- Add anything for autocmds, keymaps, or options?
- Merge Conflict resolver tool -> hatte ich dafür schon was installiert?
- Notizen machen zu LazyGit, was man dafür installieren muss und wie man es nutzen kann
- Gibt es ein package für ein besser integriertes terminal?
- Config aufräumen
- ggf. weitere Informationen/Erklärungen in readme hinzufügen
- Am Ende Repo public machen, damit ich es klonen könnte
- How to delete file? Telescope? then delete test.lua and testA.lua
  - also how to rename?
- Deutsche Rechtschreibprüfung fehlt
- Notizen machen zu, wie man telescope & co. nutzt und was man vorher installieren muss:
  - https://github.com/nvim-telescope/telescope.nvim
    - muss man hier noch configs für anpassen, dass bspw. fzf-native genutzt wird?
  - https://github.com/nvim-lua/plenary.nvim
  - https://github.com/BurntSushi/ripgrep
  - https://github.com/nvim-telescope/telescope-fzf-native.nvim
  - https://github.com/sharkdp/fd
  - https://github.com/nvim-telescope/telescope-file-browser.nvim
- 


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


Test for merge conflict
