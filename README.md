# nvim-config

Not finished, still ongoing

## Setup

- git clone this repository (this is based on https://github.com/LazyVim/starter) in `$env:LOCALAPPDATA\nvim` (on Windows; `~/.config/nvim` on Linux)
- Optionally remove .git folder to create a separate repository: `Remove-Item -Recurse -Force .git` or directly via nvim
- Install [LazyGit](https://github.com/jesseduffield/lazygit?tab=readme-ov-file#installation)
- Install [LLVM (clang) (not mingw)](https://github.com/nvim-treesitter/nvim-treesitter/wiki/Windows-support)
  - Don't forget to add bin folder to PATH
- Install [make](https://winget.ragerworks.com/package/GnuWin32.Make) (needed for fzf-native (see Telescope section below))
  - Don't forget to add bin folder to PATH (probably at like `C:\Program Files (x86)\GnuWin32\bin` for Windows)
- Have in mind, that you will also need a MSVC environment (from Visual Studio, for example) since at this point, you have the `clang` compiler and the `make` tool but no access to standard C headers like `string.h`. You can also use [`MinGW-w64`](https://www.mingw-w64.org/downloads/#mingw-w64-builds) where you want to use like `x86_64-14.2.0-release-posix-seh-ucrt-rt_v12-rev2.7z`, for example. Download this, extract it somewhere and add the `bin` folder to your PATH. This should be enough to get the C headers working. If you are doing this with the `MinGW-w64` way, you will also get access to the `gcc` compiler (this is the compiler, the Makefile expects for `telescope-fzf-native` below, even though you could update the Makefile and compile with `clang` as well).
- Install [Lazydocker](https://winget.ragerworks.com/package/JesseDuffield.Lazydocker)
- Install [ripgrep](https://github.com/BurntSushi/ripgrep?tab=readme-ov-file#installation)
- Install [fd (winget install --id sharkdp.fd)](https://github.com/sharkdp/fd?tab=readme-ov-file#installation)
- To get fzf-native (for [telescope-fzf-native](https://github.com/nvim-telescope/telescope-fzf-native.nvim)) working, you need to build it with either cmake or make. It's not shipped via binaries. However, this does not seem to properly work when trying to build it within the configs with LazyVim (using `build = "make"`) - https://www.reddit.com/r/neovim/comments/183pj1i/how_to_resolve_fzf_extension_doesnt_exist_or_isnt/?rdt=43798 -> Instead, build it manually yourself (this is where `make` is required). Go to `C:\Users\<user_name>\AppData\Local\nvim-data\lazy\telescope-fzf-native.nvim` or wherever it's stored and use `make`. It's automatically used as soon as it's working (use `:checkhealth telescope` to check if the `fzf` section is included).
- The `typescript-language-server` LSP [needs to be installed manually](https://github.com/Proziam/nvim/commit/e04c7cbe594568ea73a2e9ceda1aaa56ba73aabb) through Mason after start up. This is important to have in mind when deleting and reinstalling all mason packages. Right now at startup a warning should appear, that it doesn't understand "tsserver" ("is not a valid entry ...").
- If using Rust, install the rust-analyzer from rustup directly (`rustup component add rust-analyzer`) as well as through Mason. If there are still errors, it might be worth, to reinstall rustup, cargo etc. (rustup self uninstall), then reinstall via [the official Rust installer](https://www.rust-lang.org/tools/install), also delete nvim-data in this situation to have a full reset.
- The markdown-previewer plugin has [trouble with its install process](https://github.com/iamcco/markdown-preview.nvim/issues/188). After the initial Lazy install process, go the plugin's directory in like `../nvim-data\lazy\markdown-preview.nvim` and use `yarn install` (or with npm etc. even though this seems to cause errors when using `:Lazy sync` but it works anyways) to build the plugin.

### Additional Setup Information

- [Find more information on configuration, plugins etc.](https://www.lazyvim.org/plugins)
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
  - Add specific words to the spell file list: `zg`
- Using something like `event = { "BufReadPre", "BufNewFile" }` in a plugin config file will make sure that the plugin is only loaded when a buffer is opened or created. This is a good way to optimize the loading time of NeoVim, since not all plugins are needed at all times.
- This config repository also includes a `ftplugin` directory that is automatically detected by NeoVim. Inside that I have my `rust.vim` script with custom configs which I wasn't able to make work via the lsp configs - this file is also automatically detected and for the [Ft_rust plugin](https://neovim.io/doc/user/ft_rust.html#ft_rust.txt). There are other such already available NeoVim plugins which you can find via https://neovim.io/doc/user/

## Basic Usage

- `<leader>n` to open the notification history. This will include recent infos, warnings, and errors from the LSP, plugins, and NeoVim itself.
- Open a terminal at the bottom: `:belowright split | terminal`
- Copy the full path to the clipboard: `:let @+=expand('%:p')`
- Replace anything in selected area: `s/replace/replace_with`
- Add text via command line (for multi-select): `normal a` or `normal i`
- With cursor on an opening or closing bracket, jump to the respective opening or closing bracket: `SHIFT + 5`
- Search for next occurence of a character in the current line (backwards with uppercase): `f + search_for`
- Search for next occurence of a character in the current line but place the cursor to the preceding position (backwards with uppercase): `t + search_for`
- Repeat the preceding change: `.`
- Enter a register/macro (register_key can be a-z): `q{register_key} + commands + q` -> use it with `@register_key`
- Add/remove spaces at the start of a line (like `Tab` or `Shift + Tab`) (also works with multiple lines selected): Select lines and then `Shift>`/`Shift<`
- `<C-o>` would be CTRL + o
- `<s-down>` would be Shift + down_arrow
- `<M-s>` would be meta key (oftentimes Alt key)
- Use Mason (package manager for NeoVim) to install language servers, linters, formatters, and other developer tools
- You can use `:cd` within NeoVim to switch the cwd. This will also automatically update the NeoTree view.
- See the current cwd: `:pwd`
- To set the cwd to the directory of the currently open file: `:cd %:p:h`
- Use `<s-k>` on anything code-related holding information to get the info you probably know from VS Code when hovering over it
- Use `:LspRestart` to restart the LSP tool. Use `:LspInfo` for more information on it.
- Add specific words to the spell file list: `zg` (not with `:`, just press `zg`, while the cursor is on the word)
- Window Resizing with `<C-w><Left>`, `<C-w><Right>`, `<C-w><Up>`, and `<C-w><Down>`
- Use `<C-x><C-o>` in normal mode to trigger code completion suggestion (Omni Completion) - seems to not always work
- Open `+code` menu with `<leader>c`. Use `<leader>ca` for code actions (for auto-import, for example, like in VS Code).
- Open the `+goto` menu with `g` -> e.g. jump to the file where a React component is defined with `gd` while the cursor is on the component's name.
  - also used for any other "go to definition" situations
- When you press `y` for "yank" anywhere, you will get a menu of what actions you can perform based on the yank.
  - `yiw` is to yank the inner word the cursor is on.
  - `yis` is to yank the inner sentence the cursor is on.
  - `yib` is to yank stuff inside parentheses.
  - There are very similar commands when using `d` for the "delete" menu or `c` for the "change" menu or `v` for the "visual" menu.
    - like `ciw` for replacing the inner word the cursor is on etc.
- Use `<leader>x` to open the diagnostics/quickfix menu. With `<leader>xx` you can see all the files' errors in a separate window, for example (`<leader>cd` would also work for this, but without opening a new window).
- Find out which fileformat you are using: `:set fileformat?` and `:set fileformats?`
  - the fileformat "dos" means, it uses the standard line ending format for Windows which would be `CRLF`. For unix the standard line ending format would be `LF`.
- Use `<C-w>` to get to the `+window` menu, use `<C-w>25>` to increase the width by 25% or use `<C-w>5<` to decrease the width by 5% (or decrease height with `<C-w>-` or increase height with `<C-w>+`).
  Or:
  - Resize a window (8 lines as example): `:resize 8`
  - Resize a window vertically: `:vertical resize 30`
- Check version of some plugin installed via Mason: `:!stylua --version`
- If defined keymaps are missing, try re-applying them with `:lua ReapplyKeymaps()` (custom command from keymaps.lua config file).
- Open `+ai` keymaps menu with `<leader>a`
- Besides like `e` and `b` you can also user their uppercase versions `E` and `B` to go to the next/previous space character. This is helpful for like URLs or similar situations where you would have to use multiple `e` or `b` commands to get through while with their uppercase versions you can just skip the whole URL, for example.
- Use `:Gitsigns` to see all corresponding commands (`toggle_current_line_blame` is probably the most important in most situations).

### Buffers

- All buffer commands: `<leader>b`
- `<leader>bd` to delete current one
- `<leader>bo` to delete all the other buffers
- Use `Shift + L` to navigate to the forward/right buffer, and use `Shift + H` to move the backwards/left buffer from the current
  - Or use `bn` or `bp` to switch buffers on same window and close buffers with `bd`
- `<leader>,` to go through all active buffers
  - There you can search by file name or number and can use arrow keys to go through all buffers besides the current active one

### Tabs

- All tab commands: `<leader>Tab`
- When having multiple tabs, use `gt` to switch to the next tab, or `gT` to switch to the previous tab
  - Or use `:tabn` and `:tabp` for this

### Terminal

- Open ToggleTerm (I have `tab` as default mode): `:ToggleTerm`
- When in `terminal` mode use `CTRL + ALT + ß` and then `<C-n>` to leave the `terminal` mode and switch to `normal` mode
  - Actually press the `CTRL` key first, not all at the same time
  - Use `<C-7>` to close the terminal
- Open a normal terminal (not ToggleTerm) with `:split terminal` or use `<leader>ft or T`
- When there is no additional active buffer, you won't see the tab indexes on the top right

### More Plugin Usage

- If you enable plugins from the LazyVim Extras
  and also add those plugins in your config,
  their settings will be merged.
  This way you can basically just tweak the settings
  while still having all the base settings,
  the lazy vim extra implementation added.

#### Conform

- This is the main plugin used by LazyVim for formatting. Adjust the settings to set up different formatter and more.
To have eslint formatting work, you still have to use none-ls and set it up there.

#### File Management & File Searching (includes general commands)

- Backward search in a file: `<S-ß>`
- Forward search in a file: `<S-7>`
  - Jump up to the next backward match: `N`
  - Jump down to the next forward match: `n`
  - both commands are the same for the backward search
- `<leader>fn` to create new file, then `:edit file_name` to name it

#### Telescope

- Find all available pickers: `:Telescope`
- `<leader>ff` to open the Telescope find commands
- `<leader>ffb` to get to file browser and select files via `Tab` and delete with `d` while in normal mode
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

#### Diffview

- Use `:DiffviewOpen` to open the merge-conflict resolver tool, use `:h diffview-merge-tool` to get information on how to use it more effectively
- Use `:DiffviewClose` to leave the Diffview mode.
- You can use `g?` within Diffview to see all commands.
- Some of the most important commands within Diffview:
  - `g<C-x>` -> Cycle available layouts
  - `]x` -> Go to the next conflict
  - `[x` -> Go to the previous conflict
  - `i` -> Toggle between 'list' and 'tree' views
  - `s` -> Stage / unstage the selected entry
  - `-` (dash symbol) -> Stage / unstage the selected entry
  - `X` -> Restore entry to the state on the left side
  - `<leader>cA` -> Choose all the versions of a conflict for the whole file
  - `<leader>cB` -> Choose the BASE version of a conflict for the whole file
  - `<leader>cO` -> Choose the OURS version of a conflict for the whole file
  - `<leader>cT` -> Choose the THEIRS version of a conflict for the whole file

#### Comment

- Use `gc` to open comment command menu
- Use `gcc` for single line commenting in/out (can also be used with multi-select (`v`))
- Use `gb` for block commenting in/out

#### GitHub Copilot

- Use `:Copilot setup` to login
- Find more information: `:help Copilot`
- Accept suggestion: `<Tab>`
- Dismiss suggestion: `<C-]>` or `<Esc>`
- Show next suggestion: `<M-]>`
- Show previous suggestion: `<M-[>`

#### LazyGit

- LazyGit Commands: https://github.com/jesseduffield/lazygit?tab=readme-ov-file#features
  - `p` for pulling, `<s-p>` for Pushing, `q` to leave
  - Use `<S-↑|↓>` (arrow keys) to select multiple commits, for example

#### Lazydocker

- Open Lazydocker: `<leader>ld`
- To exit the exec shell in a docker container from Lazydocker: `<C-d>`
- Use `x` to see all shortcuts inside Lazydocker (like `[` or `]` to switch tabs inside the right panel)

#### markdown-previewer

- `:MarkdownPreview` (starts and opens the preview), `:MarkdownPreviewStop` (stops and closes the preview), and `:MarkdownPreviewToggle` (starts and opens or stops and closes the preview) are the three commands for this plugin.

# Troubleshooting

- When having eslint problems in projects which don't use the same eslint version you have installed via Mason, try rolling back your Mason version.
  - e.g. eslint_d v14 uses eslint v9 which comes with breaking changes for the config file format. Check your version with `:!eslint_d --version` and roll back by using `MasonInstall eslint_d@13.1.2`, for example, if updating the project's eslint is not an option. eslint-lsp and eslint_d are for real-time linting feedbacks, while using scripts with like `pnpm run lint` use the installed eslint modules to show the summarized linting results of the target directories in your terminal.
- If packages seem broken, try deleting the corresponding nvim-data folder section and restart nvim to trigger a full reinstall
  - `Remove-Item -Recurse -Force "$env:LOCALAPPDATA\nvim-data\lazy\nvim-treesitter"` for example (on Windows)
- When using Rust with the rust-analyzer LSP plugin and you have an `proc-macro not been built yet` error, try `cargo check` in the terminal and then saving/reloading the file
- When deleting the nvim-data (for a full reinstall), remember to manually build the telescope-fzf-native and also run `:Lazy clean` and/or lazy sync and update if having additional problems that something couldn't properly load in.
- When it seems like that the custom overwrites of some keys in the `<leader>` menu are back to their default, close and reopen the current nvim session.
- When having trouble with the Rust DAP, check if `cpptools` and `codelldb` were successfully installed via Mason and check the config to see if the debug_path is actually the correct one (if the work directory makes use of nested directories for their binaries, the debug_path has to be adjusted). Or just use `cargo build` to create the needed binary
- To have all formatters work correctly in .ts and similar files, make sure to have prettier as well prettier_d and eslint_d installed via Mason and also have prettier and eslint installed in your project. You can check the prettier version by running `:!prettier --version` (or `:!eslint_d --version` for eslint_d, for example). `conform.nvim` is for prettier (and other) `none-ls` is for eslint (and other).

## Ongoing ToDos

- Some plugin is breaking with gitsigns in a version around the 29th of April 2025, I put in a commit hash of a version a week prior to this, to fix this. Try to remove the hard-code commit hash to update to the newest version in the near future and check if it's still broken.
- Find package/configuration to automatically adjust imports if files are moved to different directories
  - potential source: https://www.reddit.com/r/neovim/comments/187wwfa/anything_in_neovim_land_that_can_update_js/
- NeoTest seems to be broken right now (at least for jest), find fix or alternative? test.core is a Lazy Extra an works with Neotree I think?
- Test more with Debug for Rust and Node and apply fixes if needed
- Add more notes for Diffview Merge Conflict Resolver, LazyGit, Lazydocker, and more
- Try out GitHub Copilot (inline edits) and note down most important commands
  - Same for GitHub Copilot Chat (separate plugin)
  - both plugins are enabled via LazyVim Extras (with not custom configs right now)
- Fix NeoTree move command (`m`)
- Potentially add a shortcut command for this step:
  - When in `terminal` mode use `CTRL + ALT + ß` and then `<C-n>` to leave the `terminal` mode and switch to `normal` mode
- ? Are there any additional configurations needed to remove unused imports or format them or is it sufficient to have the proper eslint/prettier configs for this?
- Bring nvim commands from general personal doc to this documentation
- Configure keymaps for https://github.com/monaqa/dial.nvim
- Configure keymaps for https://github.com/gbprod/yanky.nvim
- Configure settings/keymaps for https://github.com/echasnovski/mini.hipatterns
- Find more information on how to use https://github.com/folke/snacks.nvim/blob/main/docs/picker.md (if I want to use this)
- Create complete overview of all plugins used with basic usage examples (in addition to the inner plugin documentation below)

## Additional Information

### null-ls/none-ls

null-ls is a Neovim plugin that allows you to integrate external formatters, linters, and other tools into the Neovim LSP (Language Server Protocol) ecosystem. It acts as a bridge between Neovim’s built-in LSP client and various external tools that provide formatting, linting, and diagnostics capabilities. The original [null-ls plugin](https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main) is not maintained anymore, so the community forked it and called it [none-ls](https://github.com/nvimtools/none-ls.nvim).

### Telescope

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

### LazyVim

- LazyVim looks for `lua/config/options.lua`, `lua/config/keymaps.lua`, and `lua/config/autocmds.lua` automatically during startup.
- When LazyVim starts, it sources `lua/config/options.lua`, applying all settings inside it.
- This happens before plugins are loaded, ensuring that global options (like vim.opt.spelllang) take effect immediately.
- By default, NeoVim stores custom words in ~/.config/nvim/spell/en.utf-8.add (for English). You can manually edit this file if needed.

### Treesitter (through nvim-treesitter)

Treesitter is mainly used for syntax highlighting and code parsing. It provides:
✅ Better syntax highlighting (more accurate than regex-based Vim highlighting).
✅ Indentation improvements (better auto-indent).
✅ Folding, text objects, and query-based features.

👉 It does NOT provide autocompletion or error checking.

When looking into the running nvim-treesitter plugin with `:checkhealth nvim-treesitter`, you will find out which treesitter parser are active with their features, which include the following:

- `H` -> Highlighting (Syntax highlighting using Treesitter)
- `L` -> Locals (Capturing and analyzing local variable definitions and scopes)
- `F` -> Folding (Code folding support)
- `I` -> Indentation (Treesitter-based indentation)
- `J` -> Injections (Parsing embedded languages within other languages)

### LSP (Language Server Protocol) (through Mason)

LSP is a protocol that allows editors like Neovim to communicate with language servers, providing features like auto-completion, go to definition, hover documentation, and more for various programming languages.

Neovim has built-in support for LSP (starting from version 0.5), and using LSP makes the editor aware of your code structure, improving the development experience.

LSP provides:
✅ Autocompletion (e.g., lua-language-server suggests functions).
✅ Go-to definition, hover documentation, refactoring.
✅ Diagnostics (errors, warnings).

👉 LSP is like IntelliSense in VS Code—it makes coding smarter.

### DAP (Debug Adapter Protocol) (through Mason)

DAP stands for Debug Adapter Protocol, and it is a protocol that allows debugging functionality to be integrated into text editors or IDEs. It enables the connection between a debugging client (like Neovim) and a debugging server (which can be a debugger for a specific programming language). This integration allows you to debug your code directly inside your editor.

DAP allows debugging inside NeoVim. It provides:
✅ Breakpoints (F9)
✅ Step Over / Step Into / Step Out
✅ Variable inspection

👉 It’s like a built-in debugger, similar to VS Code's debugger.

### Colorschemes

Find other colorschemes via `https://github.com/topics/neovim-colorscheme` or `<leader>uC` and adjust them in the lazy.lua file
