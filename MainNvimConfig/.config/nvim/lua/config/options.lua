-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- Set indentation preferences
local opt = vim.opt
------------------------------
--
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
------------mouse
-- Set cursor movement and update speeds
vim.o.timeoutlen = 300 -- Time to wait for a mapped sequence to complete (default is 1000 ms)
vim.o.updatetime = 300 -- Time to wait before triggering the swap file write (default is 4000 ms)

-- Adjust scrolling settings
vim.o.scrolloff = 5 -- Number of lines to keep above and below the cursor
vim.o.sidescrolloff = 5 -- Number of columns to keep left and right of the cursor

-- Enable global search/replacement default
vim.o.gdefault = true -- Automatically make global replacements

-- Enable mouse support
vim.o.mouse = "a" -- Enable mouse in all modes

------------mouse

-- Disable swapfile
opt.swapfile = false
-- Clipboard
vim.o.clipboard = "unnamedplus"
----------------------------------------options---------
-- Line Numbers
opt.relativenumber = true
opt.number = true

-- Tabs & Indentation

-- Line Wrapping

opt.wrap = true

-- Search Settings
opt.ignorecase = true
opt.smartcase = true

-- Cursor Line
opt.cursorline = true

-- Appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.showmode = false
vim.diagnostic.config({
  float = { border = "rounded" }, -- add border to diagnostic popups
})

----------------------------------------otions---------
--
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

vim.keymap.set("n", "<leader><leader>v", "<cmd>:vsplit <CR>")
vim.keymap.set("n", "<leader><leader>h", "<cmd>:sp <CR>")

-------------------------End splits---------------------------------------
------------------------------------------------------------------------
