return {
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
}
