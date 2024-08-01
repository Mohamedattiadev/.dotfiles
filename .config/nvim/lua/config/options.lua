-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- Set indentation preferences

vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
--
vim.cmd("set shiftwidth=2")

-- Change mapleader to space

-- Disable swapfile
vim.opt.swapfile = false

----------------------------------------------          ---------------------------------------------------
-----------------------------------------------Terminal----------------------------------------------------
local previous_terminal_height = 10 -- Set your preferred default height here

-- Keymap to open a horizontal split terminal at the bottom
vim.keymap.set("n", "<leader>tt", function()
  vim.cmd("botright split term://" .. vim.o.shell) -- Open a new split at the bottom right with the default shell
  vim.cmd("resize " .. previous_terminal_height) -- Restore previous height

  -- Keymap inside terminal buffer to toggle insert mode
  vim.keymap.set("t", "i", "i", { silent = true })

  vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { silent = true })
end)

----------------------------------------------- End Terminal----------------------------------------------------
-----------------------------------------------             ----------------------------------------------------

----------------------------splits-------------------------------------------
---------------------------------------------------------------------------

vim.keymap.set("n", "<leader><leader>v", ":vsplit <CR>")
vim.keymap.set("n", "<leader><leader>h", ":sp <CR>")

-------------------------End splits---------------------------------------
------------------------------------------------------------------------
