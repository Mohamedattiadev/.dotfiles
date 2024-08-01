-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps heresd

--disabling some nonesense keymaps--------------------------------------------------

-- Disable window mappings
-- windows
vim.keymap.del("n", "<leader>w", { desc = "Windows" })
vim.keymap.del("n", "<leader>-", { desc = "Split Window Below" })
vim.keymap.del("n", "<leader>|", { desc = "Split Window Right" })
vim.keymap.del("n", "<leader>wd", { desc = "Delete Window" })
vim.keymap.del("n", "<leader>wm", { desc = "Maximize Window" })
vim.keymap.del("n", "<leader>bb", { desc = "switch to other buffer" })
----switch to other buffer

vim.keymap.set("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
vim.keymap.set("n", "<S-h>`", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<S-l>`", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
-------

-- save file
vim.keymap.del({ "i", "x", "n", "s" }, "<C-s>", { desc = "Save File" })

-----save_quit_write_......
vim.keymap.set("n", "<leader>w", "<cmd>:w <CR><esc>")
vim.keymap.set("n", "<leader>q", "<cmd>:q! <CR>")
vim.keymap.set("n", "<leader><leader>q", "<cmd>:wqa <CR>")
vim.keymap.set("n", "<leader><leader>n", "<cmd>:nohlsearch <CR>")

-- Move selected line / block of text in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

----

-- Tabs
vim.keymap.del("n", "<leader><tab>l", { desc = "Last Tab" })
vim.keymap.del("n", "<leader><tab>o", { desc = "Close Other Tabs" })
vim.keymap.del("n", "<leader><tab>f", { desc = "First Tab" })
vim.keymap.del("n", "<leader><tab><tab>", { desc = "New Tab" })
vim.keymap.del("n", "<leader><tab>]", { desc = "Next Tab" })
vim.keymap.del("n", "<leader><tab>d", { desc = "Close Tab" })
vim.keymap.del("n", "<leader><tab>[", { desc = "Previous Tab" })

--disabling some nonesense keymaps--------------------------------------------------
