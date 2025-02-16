return {
  -- Core LSP Config
  {
    "neovim/nvim-lspconfig",
  },
  -- Mason (Package Manager)
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  -- Mason LSP (Auto-install LSPs)
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "clangd", -- C/C++
          "rust_analyzer", -- Rust
          "tsserver", -- TypeScript -> This has to be manually added (https://github.com/Proziam/nvim/commit/e04c7cbe594568ea73a2e9ceda1aaa56ba73aabb)
          "lua_ls", -- Lua
          "bashls", -- Bash
          "taplo", -- TOML
          "tailwindcss", -- Tailwind CSS
          "pyright", -- Python
          "jsonls", -- JSON
          "html", -- HTML
          "eslint", -- ESLint
          "cssls", -- CSS
          "dockerls", -- Dockerfile
          "docker_compose_language_service", -- Docker Compose
        },
        automatic_installation = true,
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      -- Auto-setup all installed LSPs
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({})
        end,
      })
    end,
  },

  -- Mason DAP (Auto-install Debuggers)
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("mason-nvim-dap").setup({
        ensure_installed = {
          "codelldb", -- C, C++, Rust
          "python", -- Python Debugger
          "node2", -- Node.js Debugger
          "chrome", -- Chrome Debugger
          "bash", -- Bash Debugger
          "firefox-debug-adapter", -- Firefox Debugger
        },
        automatic_installation = true,
      })
    end,
  },

  -- Mason Null-LS (Auto-install Formatters & Linters)
  {
    "jay-babu/mason-null-ls.nvim",
    dependencies = { "jose-elias-alvarez/null-ls.nvim" },
    config = function()
      require("mason-null-ls").setup({
        ensure_installed = {
          -- Linters
          "eslint_d", -- JavaScript/TypeScript Linter
          "shellcheck", -- Shell Script Linter
          "flake8", -- Python Linter
          "golangci-lint", -- Go Linter

          -- Formatters
          "prettier", -- JavaScript/TypeScript Formatter
          "stylua", -- Lua Formatter
          "black", -- Python Formatter
          "shfmt", -- Shell Script Formatter
          "clang-format", -- C/C++ Formatter
        },
        automatic_installation = true,
      })

      -- Setup Null-LS
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          -- Formatting
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.shfmt,
          null_ls.builtins.formatting.clang_format,

          -- Linting
          null_ls.builtins.diagnostics.eslint_d,
          null_ls.builtins.diagnostics.shellcheck,
          null_ls.builtins.diagnostics.flake8,
          null_ls.builtins.diagnostics.golangci_lint,
        },
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
          "powershell",
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
