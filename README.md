# Setup

- git clone this repository (this is based on https://github.com/LazyVim/starter) in `$env:LOCALAPPDATA\nvim` (on Windows; `~/.config/nvim` on Linux)
- Optionally remove .git folder to create a separate repository: `Remove-Item -Recurse -Force .git` or directly via nvim
- Install LazyGit: https://github.com/jesseduffield/lazygit?tab=readme-ov-file#installation
- Install LLVM (clang) (not mingw) -> https://github.com/nvim-treesitter/nvim-treesitter/wiki/Windows-support
  - Don't forget to add bin folder to PATH
- Install Lazydocker: https://winget.ragerworks.com/package/JesseDuffield.Lazydocker
- Install ripgrep: https://github.com/BurntSushi/ripgrep?tab=readme-ov-file#installation
- Install fd (winget install --id sharkdp.fd): https://github.com/sharkdp/fd?tab=readme-ov-file#installation
- Install make (needed for fzf-native (see Telescope section below)): https://winget.ragerworks.com/package/GnuWin32.Make
  - Don't forget to add bin folder to PATH (probably at like `C:\Program Files (x86)\GnuWin32\bin`)
- To get fzf-native (for telescope-fzf-native (https://github.com/nvim-telescope/telescope-fzf-native.nvim)) working, you need to build it with either cmake or make. It's not shipped via binaries. However, this does not seem to properly work when trying to build it within the configs with LazyVim - https://www.reddit.com/r/neovim/comments/183pj1i/how_to_resolve_fzf_extension_doesnt_exist_or_isnt/?rdt=43798 -> Instead, build it manually yourself (this is where `make` is required). Go to `C:\Users\<user_name>\AppData\Local\nvim-data\lazy\telescope-fzf-native.nvim` or wherever it's stored and use `make`. It's automatically used as soon as it's working (use `:checkhealth telescope` to check if the `fzf` section is included).
- The `typescript-language-server` LSP needs to be installed manually (https://github.com/Proziam/nvim/commit/e04c7cbe594568ea73a2e9ceda1aaa56ba73aabb) through Mason after start up. This is important to have in mind when deleting and reinstalling all mason packages. Right now at startup a warning should appear, that it doesn't understand "tsserver" ("is not a valid entry ...").

## Additional Setup Information

- _The following explanation is for understanding what was done, to make the German spell check work, all this is already added in this repository. There is no additional action required, the following is just extra information:_
  - To have spellchecking by NeoVim for other languages than English, you have to add spell files.
  - The `options.lua` file is set up, to have a custom spell file directory in `\nvim` (based on your custom configs path), since otherwise you would have to start NeoVim in a terminal with administrator privileges and download the needed files on startup (this won't work, if you don't have the admin permissions).
  - The files you need are `de.utf-8.spl`, `de.utf-8.sug`, and `de.utf-8.add` for German.
  - If you are not using the admin permission way, you would have to manually download two of the files which can be done through:
    - `Invoke-WebRequest -Uri "https://ftp.nluug.nl/vim/runtime/spell/de.utf-8.spl" -OutFile "$env:LOCALAPPDATA\nvim\spell\de.utf-8.spl"` (in PowerShell)
    - `Invoke-WebRequest -Uri "https://ftp.nluug.nl/vim/runtime/spell/de.utf-8.sug" -OutFile "$env:LOCALAPPDATA\nvim\spell\de.utf-8.sug"` (in PowerShell)
    - If you want to add special words to the spell list (like "PowerShell"), you have to manually add a `de.utf-8.add` file in the same directory where your other spell files are stored. NeoVim will then automatically also create a `de.utf-8.add.spl` file in the same directory.
    - This manual setup won't interfere with any spell files placed in the system-wide installation directory of NeoVim since it checks this directory and any custom directories if setup properly, therefore the default English spellchecks can still remain in their original place and don't need to be moved
    - I don't know how to set all this up for multiple additional languages

# Basic Usage

- `<C-o>` would be CTRL + o
- `<s-down>` would be Shift + down_arrow
- Use Mason (package manager for NeoVim) to install language servers, linters, formatters, and other developer tools
- You can use `:cd` within NeoVim to switch the cwd
- See the current cwd: `:pwd`
- To set the cwd to the directory of the currently open file: `:cd %:p:h`
- Use `<s-k>` on anything code-related holding information to get the info you probably know from VS Code when hovering over it
- Use `:LspRestart` to restart the LSP tool. Use `:LspInfo` for more information on it.
- Add specific words to the spell file list: `zg` (not with `:`, just press `zg`, while the cursor is on the word)
- Window Resizing with `<C-w><Left>`, `<C-w><Right>`, `<C-w><Up>`, and `<C-w><Down>`
- Use `<C-x><C-o>` in normal mode to trigger code completion suggestion (Omni Completion)

## Buffers

- All buffer commands: `<leader>b`
- `<leader>bd` to delete current one
- `<leader>bo` to delete all the other buffers
- Use `Shift + L` to navigate to the forward/right buffer, and use `Shift + H` to move the backwards/left buffer from the current
  - Or use `bn` or `bp` to switch buffers on same window and close buffers with `bd`
- `<leader>,` to go through all active buffers
  - There you can search by file name or number and can use arrow keys to go through all buffers besides the current active one

## Tabs

- All tab commands: `<leader>Tab`
- When having multiple tabs, use `gt` to switch to the next tab, or `gT` to switch to the previous tab
  - Or use `:tabn` and `:tabp` for this

## Terminal

- Open ToggleTerm as tab: `:ToggleTerm direction=tab`
- When in `terminal` mode use `CTRL + ALT + ß` and then `<C-n>` to leave the `terminal` mode and switch to `normal` mode
  - Actually press the `CTRL` key first, not all at the same time
  - Use `<C-7>` to close the terminal
- Open a normal terminal (not ToggleTerm) with `:split terminal` or use `<leader>ft or T`
- When there is no additional active buffer, you won't see the tab indexes on the top right

## More Plugin Usage

### File Management & File Searching (includes general commands)

- General search in file: `<S-?>`
- `<leader>fn` to create new file, then `:edit file_name` to name it

#### Telescope

- Find all available pickers: `:Telescope`
- `<leader>fg` for live_grep to look through the content of all files in the cwd
- `<leader>fb` to get to file browser and select files via `Tab` and delete with `d` while in normal mode
  - Commands: `https://github.com/nvim-telescope/telescope-file-browser.nvim#Mappings`
  - Within the file browser use `c` in normal mode to create new folders and files
  - Within the file browser, use `r` to rename a file, `<S-r>` for replace

#### NeoTree

- Use `<leader>e` to open NeoTree
- Use `<s-?>` to see all commands in NeoTree
- Use `<S-h>` to toggle showing hidden items while on the NeoTree screen
- Use `<S-r>` to reload (when new files were created, for example)
- `d` for deleting
- `c` for copying to another place (e.g. `my_file` to `/another_directory/my_file`)
- `m` for moving to another place (this seems to be broken currently)
- `a` for creating new directory or file
- `r` for renaming (can also be used to move files when adding the new path for the file (use `../` to move file to parent directory))
- `b` for new base name (switching base names won't affect the file ending)
- `o` to order files
- `i` to get file information

### Diffview

- Use `:DiffviewOpen` to open the merge-conflict resolver tool, use `:h diffview-merge-tool` to get information on how to use it more effectively

### Comment
- Use `gcc` and `gc` to comment in/out lines/blocks

### GitHub Copilot
- Use `:Copilot setup` to login
- Find more information: `:help Copilot`
- Accept suggestion:	`<Tab>`
- Dismiss suggestion:	`<C-]>` or `<Esc>`
- Show next suggestion:	`<M-]>`
- Show previous suggestion:	`<M-[>`

### LazyGit

- LazyGit Commands: https://github.com/jesseduffield/lazygit?tab=readme-ov-file#features
  - `p` for pulling, `<s-p>` for Pushing, `q` to leave
  - Use <s-↑|↓> (arrow keys) to select multiple commits, for example

### Lazydocker

- Open Lazydocker: `<leader>ld`
- To exit the exec shell in a docker container from Lazydocker: `<C-d>`
- Use `x` to see all shortcuts inside Lazydocker (like `[` or `]` to switch tabs inside the right panel)


# Troubleshooting

- If packages seem broken, try deleting the corresponding nvim-data folder section and restart nvim to trigger a full reinstall
  - `Remove-Item -Recurse -Force "$env:LOCALAPPDATA\nvim-data\lazy\nvim-treesitter"` for example (on Windows)
- When using Rust with the rust-analyzer LSP plugin and you have an `proc-macro not been built yet` error, try `cargo check` in the terminal and then saving/reloading the file
- When deleting the nvim-data (for a full reinstall), remember to manually build the telescope-fzf-native and also run `:Lazy clean` and/or lazy sync and update if having additional problems that something couldn't properly load in.


# Ongoing ToDos
- NeoTest seems to be broken right now (at least for jest), find fix or alternative?
- Add more notes for Diffview Merge Conflict Resolver, LazyGit, Lazydocker, and more
- Try out GitHub Copilot and note down most important commands
- Update autocmds, keymaps, or options (in `lua/config`)
- Fix NeoTree move command (`m`)
- Potentially add a shortcut command for this step:
  - When in `terminal` mode use `CTRL + ALT + ß` and then `<C-n>` to leave the `terminal` mode and switch to `normal` mode


# Additional Information

## Telescope

A fuzzy finder for Neovim, with the following plugins and tools:

_The following is included in the current setup:_

- telescope-file-browser.nvim → A file browser extension for Telescope that allows interactive file navigation.
- telescope.nvim → The core fuzzy finder framework for Neovim.
- plenary.nvim → A utility library required by Telescope for Lua functions and async operations.
- telescope-fzf-native.nvim → A native FZF sorter for faster fuzzy searching within Telescope.
  - Fuzzy search is a type of search algorithm that finds results even if the input is partially incorrect, incomplete, or out of order. Instead of requiring an exact match, it ranks potential matches based on relevance and similarity.
- nvim-web-devicons → Provides file icons for an enhanced UI.
- ripgrep (rg) → A fast command-line search tool used for live grep and other functionality in Telescope.
- fd → A faster alternative to find, used by Telescope to locate files efficiently.

## LazyVim

- LazyVim looks for `lua/config/options.lua`, `lua/config/keymaps.lua`, and `lua/config/autocmds.lua` automatically during startup.
- When LazyVim starts, it sources `lua/config/options.lua`, applying all settings inside it.
- This happens before plugins are loaded, ensuring that global options (like vim.opt.spelllang) take effect immediately.
- By default, NeoVim stores custom words in ~/.config/nvim/spell/en.utf-8.add (for English). You can manually edit this file if needed.

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

DAP allows debugging inside NeoVim. It provides:
✅ Breakpoints (F9)
✅ Step Over / Step Into / Step Out
✅ Variable inspection

👉 It’s like a built-in debugger, similar to VS Code's debugger.

## Colorschemes

Find other colorschemes via `https://github.com/topics/neovim-colorscheme` or `<leader>uC` and adjust them in the lazy.lua file
