return {
  -- Use custom options for colorscheme (to make it transparent)
  {
    "tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
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
  -- Telescope -> https://github.com/nvim-telescope/telescope.nvim
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
      { "nvim-tree/nvim-web-devicons", opts = {} },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          prompt_prefix = "🔍 ", -- Custom prompt prefix
          initial_mode = "insert", -- Start in insert mode
          path_display = { "absolute" },
        },
        extensions = {
          fzf = {
            -- These are default values, they are just added for easier adjustments if needed
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- smart_case / ignore_case / respect_case
          },
        },
      })
      -- Load the fzf extension
      pcall(require("telescope").load_extension("fzf"))
    end,
  },
  -- Telescope File Browser -> https://github.com/nvim-telescope/telescope-file-browser.nvim
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("telescope").load_extension("file_browser")
    end,
  },

  -- ToggleTerm -> https://github.com/akinsho/toggleterm.nvim
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        direction = "tab",
        shell = "pwsh",
        shade_terminals = false,
        persist_mode = true,
      })
    end,
  },
  -- Lazydocker -> https://github.com/mgierada/lazydocker.nvim
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
  -- Comment -> https://github.com/numToStr/Comment.nvim
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
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
        adapters = {
          require("neotest-python")({
            dap = { justMyCode = false },
          }),
          require("neotest-plenary"),
          require("neotest-vim-test")({
            -- Ignore file_types which are already handled by manually installed test adapters
            ignore_file_types = { "python", "vim", "lua", "rust", "cpp", "c" },
          }),
          require("neotest-rust")({
            args = { "--no-capture" },
          }),
          require("neotest-jest")({
            jestCommand = "npm test --",
            env = { CI = true },
            cwd = function()
              return vim.fn.getcwd()
            end,
          }),
        },
      })
    end,
  },
  -- Markdown Previewer
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    commit = "2149fc2009d1117d58e86e56836f70c969f60a82",
  },

  -- Having a hard-code commit in here is a work-around since newer versions caused errors for me
  {
    "lewis6991/gitsigns.nvim",
    commit = "2149fc2009d1117d58e86e56836f70c969f60a82",
  },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = true,
          auto_refresh = true,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>",
          },
          layout = {
            position = "bottom", -- | top | left | right | horizontal | vertical
            ratio = 0.4,
          },
        },
        suggestion = {
          enabled = true,
          -- auto_trigger will directly show suggestions in insert mode even if you don't type anything
          auto_trigger = true,
          hide_during_completion = true,
          debounce = 75,
          trigger_on_accept = true,
          keymap = {
            accept = "<M-l>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        filetypes = {
          yaml = false,
          markdown = false,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false,
        },
        auth_provider_url = nil, -- URL to authentication provider, if not "https://github.com/"
        logger = {
          file = vim.fn.stdpath("log") .. "/copilot-lua.log",
          file_log_level = vim.log.levels.OFF,
          print_log_level = vim.log.levels.WARN,
          trace_lsp = "off", -- "off" | "messages" | "verbose"
          trace_lsp_progress = false,
          log_lsp_messages = false,
        },
        copilot_node_command = "node", -- Node.js version must be > 20
        workspace_folders = {},
        copilot_model = "gpt-4o", -- Current LSP default is gpt-35-turbo, supports gpt-4o-copilot
        root_dir = function()
          return vim.fs.dirname(vim.fs.find(".git", { upward = true })[1])
        end,
        should_attach = function(_, _)
          local logger = require("copilot.logger")

          if not vim.bo.buflisted then
            logger.debug("not attaching, buffer is not 'buflisted'")
            return false
          end

          if vim.bo.buftype ~= "" then
            logger.debug("not attaching, buffer 'buftype' is " .. vim.bo.buftype)
            return false
          end

          return true
        end,
        server = {
          type = "nodejs", -- "nodejs" | "binary"
          custom_server_filepath = nil,
        },
        server_opts_overrides = {},
      })
    end,
  },
  -- https://github.com/CopilotC-Nvim/CopilotChat.nvim
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {
      model = "gpt-4o", -- AI model to use
      temperature = 0.1, -- Lower = focused, higher = creative
      window = {
        layout = "float", -- 'vertical', 'horizontal', 'float'
        width = 0.5, -- 50% of screen width
      },
      auto_insert_mode = true, -- Enter insert mode when opening
    },
  },
}
