-- keymaps.lua
-- Automatically loaded on the VeryLazy event
-- Allows manual reloading with :lua ReapplyKeymaps()

local M = {}

function M.setup()
  -- Telescope
  local builtin = require("telescope.builtin")
  vim.keymap.set("n", "<leader>fff", builtin.find_files, { desc = "Telescope find files" })
  vim.keymap.set("n", "<leader>ffg", builtin.live_grep, { desc = "Telescope live grep" })
  vim.keymap.set("n", "<leader>ffh", builtin.help_tags, { desc = "Telescope help tags" })
  vim.keymap.set("n", "<space>ffb", function()
    require("telescope").extensions.file_browser.file_browser()
  end, { desc = "Telescope File Browser" })

  -- Neotest
  require("which-key").add({
    { "<leader>t", desc = "tests" },
  })

  vim.keymap.set("n", "<leader>tt", function()
    require("neotest").run.run()
  end, { desc = "Run nearest test" })
  vim.keymap.set("n", "<leader>tf", function()
    require("neotest").run.run(vim.fn.expand("%"))
  end, { desc = "Run current test file" })
  vim.keymap.set("n", "<leader>tl", function()
    require("neotest").run.run_last()
  end, { desc = "Run last test" })
  vim.keymap.set("n", "<leader>ts", function()
    require("neotest").summary.toggle()
  end, { desc = "Toggle test summary" })
  vim.keymap.set("n", "<leader>to", function()
    require("neotest").output.open({ enter = true })
  end, { desc = "Open test output" })
  vim.keymap.set("n", "<leader>tS", function()
    require("neotest").run.stop()
  end, { desc = "Stop running test" })

  -- DAP
  local dap = require("dap")
  vim.keymap.set("n", "<F5>", function()
    dap.continue()
  end)
  vim.keymap.set("n", "<F9>", function()
    dap.toggle_breakpoint()
  end)
  vim.keymap.set("n", "<F10>", function()
    dap.step_over()
  end)
  vim.keymap.set("n", "<F11>", function()
    dap.step_into()
  end)
  vim.keymap.set("n", "<S-F11>", function()
    dap.step_out()
  end)
end

-- 1. Apply immediately on start
M.setup()

-- 2. Re-apply again when VeryLazy fires, just in case LazyVim plugins overwrite them
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    M.setup()
  end,
})

-- Global function to reapply keymaps manually
-- :lua ReapplyKeymaps()
_G.ReapplyKeymaps = M.setup

return M
