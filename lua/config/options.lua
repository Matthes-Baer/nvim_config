-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Bring vim.opt into scope
local options = vim.opt

-- Add German to spell check languages besides English as default
options.spelllang = { "en", "de" }
options.spell = true

-- Tell where it can find the spell file for German which I put there manually
-- The standard path "config" corresponds to ~\AppData\Local\nvim\ (on Windows)
options.spellfile = vim.fn.stdpath("config") .. "/spell/de.utf-8.add"

-- This removes spell checks in terminals that were opened within NeoVim (like with :ToggleTerm)
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.wo.spell = false
  end,
})

-- Set the standard line ending format to the default unix format (LF)
vim.o.fileformat = "unix"
vim.o.fileformats = "unix"
