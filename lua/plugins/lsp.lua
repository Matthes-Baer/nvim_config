return {
  -- LSP Setup
  {
    "neovim/nvim-lspconfig",
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup() -- Initialize Mason
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "typescript-language-server", "clangd", "rust_analyzer", "json-lsp" }, -- Add specific LSP servers here
      })
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          -- ESLint D (eslint_d) setup for diagnostics (linting)
          null_ls.builtins.diagnostics.eslint_d.with({
            -- Optional: you can configure debounce time or other options here
            diagnostics_format = "#{m} (#{c})", -- Format for diagnostic message
          }),
        },
        -- You can also add other formatters or linters here if needed
      })
    end,
  },
  -- Treesitter for Syntax Highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate", -- Automatically update parsers
    config = function()
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        sync_install = false,
        ignore_install = {},
        modules = {},
        ensure_installed = {
          "lua",
          "typescript",
          "javascript",
          "rust",
          "cpp",
          "json",
          "bash",
          "html",
          "markdown",
          "markdown_inline",
          "python",
          "query",
          "regex",
          "tsx",
          "vim",
          "yaml",
        },
        highlight = { enable = true },
        indent = { enable = true },
        -- Add any other configurations you want here
      })

      -- Set clang as the compiler
      require("nvim-treesitter.install").compilers = { "clang" }
    end,
  },
}
