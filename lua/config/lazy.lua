-- Check if lazy.nvim is already existing in the nvim-data directory
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Clone the lazy.nvim repository if it did not exist yet in the nvim-data directory
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim",                                import = "lazyvim.plugins" },

    -- Enable the extra for `none-ls` for formatting and linting
    { import = "lazyvim.plugins.extras.lsp.none-ls" },

    -- This would add eslint via Mason, I think (but I actually want to use eslint_d)
    -- { import = "lazyvim.plugins.extras.linting.eslint" },

    -- This would add prettier via Mason, I think (but I actually want to use prettierd)
    -- { import = "lazyvim.plugins.extras.formatting.prettier" },

    -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
    { import = "lazyvim.plugins.extras.lang.typescript" },


    -- import/override with your plugins
    -- This imports all files from the plugins directory
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
  },                -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        -- "tutor",
        "zipPlugin",
      },
    },
  },
})
