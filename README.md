# Setup
- git clone this repository (this is based on https://github.com/LazyVim/starter) in `$env:LOCALAPPDATA\nvim` (on Windows; `~/.config/nvim` on Linux)
- Optionally remove .git folder to create a separate repository: Remove-Item -Recurse -Force .git
- Install lazygit: https://github.com/jesseduffield/lazygit?tab=readme-ov-file#installation
- Install LLVM (clang) (not mingw) -> https://github.com/nvim-treesitter/nvim-treesitter/wiki/Windows-support
  - Don't forget to add bin folder to PATH
- Install lazydocker: https://winget.ragerworks.com/package/JesseDuffield.Lazydocker

# Basic Usage
- `<C-o>` would be CTRL + o
- `<s-down>` would be Shift + down_arrow
- Use `bn` or `bp` to switch buffers on same window and close buffers with `bd` OR use Leader key + "," to go through all active buffers
  - With the buffer from window you can search by file name or number and can use arrow keys to go through all buffers besides the current active one
  - Use `Shift + L` to navigate to the forward/right buffer, and use `Shift + H` to move the backwards/left buffer from the current
- Use Mason (package manager for Neovim) to install language servers, linters, formatters, and other developer tools
- When having multiple tabs (not just regular buffers), use `gt` to switch to the next tab, or `gT` to switch to the previous tab (`tabn` and `tabp` would also work)
- Search in file: `<S-?>`
- You can use `:cd` within NeoVim to switch the cwd
- See the current cwd: `:pwd`
- To set the cwd to the directory of the currently open file: `:cd %:p:h`
- Use `<s-k>` on anything code-related holding information to get the info you probably know from VS Code when hovering over it 
- Use `:LspRestart` to restart the LSP tool. Use `:LspInfo` for more information on it.

## Plugins

### Diffview
- Use `:DiffviewOpen` to open the merge-conflict resolver tool, use `:h diffview-merge-tool` to get information on how to use it more effectively 

### LazyGit
- LazyGit Commands: https://github.com/jesseduffield/lazygit?tab=readme-ov-file#features
  - `p` for pulling, `<s-p>` for Pushing, `q` to leave

### NeoTree
- Use `<leader>e` to open Neo-tree
- Use `<S-h>` to toggle showing hidden items while on the NeoTree screen
- Use `<S-r>` to reload (when new files were created, for example)

### lazydocker
- Open lazydocker: `<leader>ld`
- To exit the exec shell in a docker from lazydocker: `<C-d>`
- Use `x` to see all shortcuts inside lazydocker (like `[` or `]` to switch tabs inside the right panel)

## Terminal
- Open ToggleTerm as tab: `:ToggleTerm direction=tab`
- When in `terminal` mode use `CTRL + ALT + ß` (or `CTRL + \`) and then `<C-n>` to leave the `terminal` mode and switch to `normal` mode
  - Actually press the `CTRL` key first, not all at the same time
  - Use `<C-7>` to close the terminal
- Open a normal terminal (not ToggleTerm) with `:split terminal` or use `<leader>ft or T`

## File Management
- `<leader>fn` to create new file, then `:edit file_name` to name it
- `<leader>fb` to get to file browser and select files via `Tab` and delete with `d` while in normal mode
  - Commands: `https://github.com/nvim-telescope/telescope-file-browser.nvim#Mappings`
  - Within the file browser use `c` in normal mode to create new folders and files
  - Within the file browser, use `r` to rename a file, `<S-r>` for replace


# Troubleshooting

- If packages seem broken, try deleting the corresponding nvim-data folder section and restart nvim to trigger a full installation
  - `Remove-Item -Recurse -Force "$env:LOCALAPPDATA\nvim-data\lazy\nvim-treesitter"` for example (on Windows)
- When using Rust with the rust-analyzer LSP plugin and you have an `proc-macro not been built yet` error, try `cargo check` in the terminal and then saving/reloading the file 


# Ongoing ToDos
- Make notes for Diffview Merge Conflict Resolver and LazyGit and more


# TODO:
- How to close and open new Tabs
- How to close buffers more effectively (instead of going to each buffer and use :bd)
- Add anything for autocmds, keymaps, or options?
- Config aufräumen
- ggf. weitere Informationen/Erklärungen in readme hinzufügen
- Am Ende Repo public machen, damit ich es klonen könnte
- Github Copilot plugin hinzufügen
- How to move files (with replace from file browser?)
  - Einige Telescope Notizen machen und auch zu den folgenden Punkten und ähnlichem:
    - `<leader>f` .. 
    - Allgemeine Notizen machen zu grep und ripgrep
    - How to search for files and how to search for specific content in files in current work directory or similar?
- Deutsche Rechtschreibprüfung fehlt
- Notizen machen zu, wie man telescope & co. nutzt und was man vorher installieren muss:
  - https://github.com/nvim-telescope/telescope.nvim
    - muss man hier noch configs für anpassen, dass bspw. fzf-native genutzt wird?
  - https://github.com/nvim-lua/plenary.nvim
  - https://github.com/BurntSushi/ripgrep
  - https://github.com/nvim-telescope/telescope-fzf-native.nvim
  - https://github.com/sharkdp/fd
  - https://github.com/nvim-telescope/telescope-file-browser.nvim
- Mit Next.js-Projekt oder so rumprobieren, um zu testen, welche Common commands mir fehlen würden (bspw. STRG + . oder zur File zu springen etc.?)
- NeoTest für Jest und Rust ausprobieren (in general.lua plugin file)


# Additional Information

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


## Colorschemes

Find other colorschemes via `https://github.com/topics/neovim-colorscheme` and adjust them in the lazy.lua file
