-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local o = vim.opt
o.spelllang = { "en", "de" }
o.spell = true

-- the standard path "config" corresponds to ~\AppData\Local\nvim\ (on Windows)
vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/de.utf-8.add"
