return {
  -- NeoTree
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
  -- Telescope
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
      { "nvim-tree/nvim-web-devicons", opts = {} },
    },
  },
  -- NeoTest
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "alfaix/neotest-gtest",
      "nvim-neotest/neotest-jest",
      "rouge8/neotest-rust",
    },
    config = function()
      require("neotest").setup({
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
