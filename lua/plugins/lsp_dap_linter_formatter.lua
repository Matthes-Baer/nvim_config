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
  -- Mason DAP (Auto-install Debuggers)
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("mason-nvim-dap").setup({
        ensure_installed = {
          "python", -- Python Debugger
          "node2", -- Node.js Debugger
          "chrome", -- Chrome Debugger
          "bash", -- Bash Debugger
          "firefox-debug-adapter", -- Firefox Debugger
          "cpptools", -- C, C++, Rust
          "codelldb", -- C, C++, Rust
        },
        automatic_installation = true,
      })
    end,
  },

  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")

      -- Rust (codelldb)
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = vim.fn.stdpath("data") .. "\\mason\\bin\\codelldb.cmd",
          args = { "--port", "${port}" },
        },
      }

      dap.configurations.rust = {
        {
          name = "Launch Rust Debugging",
          type = "codelldb",
          request = "launch",
          program = function()
            local debug_path = vim.fn.getcwd() .. "/target/debug/"
            local cmd = 'ls "' .. debug_path .. '" 2> /dev/null' -- Linux/macOS
            if vim.fn.has("win32") == 1 then
              cmd = 'dir /B "' .. debug_path .. '"'
            end

            local handle = io.popen(cmd)
            if not handle then
              vim.notify("Error: Failed to run command")
              return nil
            end

            local files = {}
            for line in handle:lines() do
              if line:match("%.exe$") then
                table.insert(files, debug_path .. line)
              end
            end
            handle:close()

            if #files == 0 then
              vim.notify(
                "Error: No .exe file found in target/debug/. Did you forget to run `cargo build` or have nested applications you are trying to debug? Use cargo build or update debug path in lsp_dap_linter_formatter.lua config file."
              )
              return nil
            end

            return files[1] -- Return the first .exe file found
          end,

          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          console = "integratedTerminal",
        },
      }

      -- Node.js (node2)
      dap.adapters.node2 = {
        type = "executable",
        command = "node",
        args = { vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js" },
      }

      dap.configurations.javascript = {
        {
          type = "node2",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "inspector",
        },
      }
    end,
  },
  { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
  { "nvim-telescope/telescope-dap.nvim" }, -- Telescope UI for debugging

  -- None-LS
  -- This is needed to have eslint's fix work on save
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          -- still useful for diagnostics and code actions
          require("none-ls.diagnostics.eslint_d"),
          require("none-ls.code_actions.eslint_d"),

          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.shfmt,
          null_ls.builtins.formatting.clang_format,
        },
      })
    end,
  },

  -- Mason
  -- prettier is needed to still have access to :ConformInfo - prettierd is used for the actual formatting for .ts etc. files
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "stylua", "black", "shfmt", "clang-format", "prettier", "prettierd", "eslint_d" } },
  },

  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      log_level = vim.log.levels.DEBUG,
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "eslint_d", "prettierd" },
        typescript = { "eslint_d", "prettierd" },
        typescriptreact = { "eslint_d", "prettierd" },
        javascriptreact = { "eslint_d", "prettierd" },

        -- Use the "_" filetype to run formatters on filetypes that don't
        -- have other formatters configured.
        ["_"] = { "trim_whitespace" },
      },
    },
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
      })

      -- Set clang as the compiler
      require("nvim-treesitter.install").compilers = { "clang" }
    end,
  },
  -- Treesitter Context - https://github.com/nvim-treesitter/nvim-treesitter-context
  { "nvim-treesitter/nvim-treesitter-context" },
}
