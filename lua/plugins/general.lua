return {
  -- NeoTree -> https://github.com/nvim-neo-tree/neo-tree.nvim
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Dependency for file operations
      "nvim-tree/nvim-web-devicons", -- Icon support (optional, but recommended)
    },
    config = function()
      require("neo-tree").setup({
        filesystem = {
          filtered_items = {
            visible = true, -- Ensure hidden items are visible
            hide_dotfiles = false, -- Show dotfiles like .gitignore, .eslintrc.json, etc.
            hide_gitignored = false, -- Optionally, show git-ignored files
          },
        },
      })
    end,
  },
  -- Telescope File Browser -> https://github.com/nvim-telescope/telescope-file-browser.nvim
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
      { "nvim-tree/nvim-web-devicons", opts = {} },
    },
  },
  -- ToggleTerm -> https://github.com/akinsho/toggleterm.nvim
  { "akinsho/toggleterm.nvim", version = "*", config = true },
  -- LazyDocker -> https://github.com/mgierada/lazydocker.nvim
  {
    "mgierada/lazydocker.nvim",
    dependencies = { "akinsho/toggleterm.nvim" },
    config = function()
      require("lazydocker").setup({
        border = "curved", -- valid options are "single" | "double" | "shadow" | "curved"
      })
    end,
    event = "BufRead",
    keys = {
      {
        "<leader>ld",
        function()
          require("lazydocker").open()
        end,
        desc = "Open Lazydocker floating window",
      },
    },
  },
  -- NeoTest -> https://github.com/nvim-neotest/neotest
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-neotest/neotest-plenary",
      "nvim-neotest/neotest-vim-test",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "alfaix/neotest-gtest",
      "nvim-neotest/neotest-jest",
      "rouge8/neotest-rust",
      "nvim-neotest/neotest-python",
    },
    config = function()
      require("neotest").setup({
        log_level = vim.log.levels.WARN, -- or "info", "debug"
        consumers = {}, -- Add any consumer functions here
        icons = {}, -- Customize icons if needed
        highlights = {}, -- Customize highlight groups

        floating = {
          border = "rounded",
          max_height = 0.8,
          max_width = 0.8,
          options = {},
        },

        strategies = {
          integrated = {
            width = 120,
            height = 40,
          },
        },

        run = {
          enabled = true,
        },

        summary = {
          enabled = true,
          animated = true,
          follow = true,
          expand_errors = true,
          mappings = {},
          open = false,
          count = 0,
        },

        output = {
          enabled = true,
          open_on_run = "short",
        },

        adapters = {
          require("neotest-python")({
            dap = { justMyCode = false },
          }),
          require("neotest-plenary"),
          require("neotest-vim-test")({
            -- Ignore file_types which are already handled by manually installed test adapters
            ignore_file_types = { "python", "vim", "lua", "javascript", "typescript", "rust", "cpp", "c" },
          }),
          require("neotest-rust")({
            args = { "--no-capture" },
          }),
          require("neotest-gtest").setup({}),
          require("neotest-jest"),
        },
      })
    end,
  },
}
