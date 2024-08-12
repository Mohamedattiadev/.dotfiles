-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps heresd

--disabling some nonesense keymaps--------------------------------------------------
-- vim.keymap.set("n", "gx", ":!open <c-r><c-a><CR>")
vim.keymap.del("n", "gx")
--Disable window mappings
-- discipline

-- --clipboard copy -paste
-- -- yank to clipboard
-- vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
-- -- yank line to clipboard
-- vim.keymap.set("n", "<leader>Y", [["+Y]])
--
-- -- delete without yanking
-- vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
-- --clipboard copy -paste

local cowboy = require("config.autocmds")

cowboy.cowboy()
-- windows
vim.keymap.del("n", "<leader>w")
vim.keymap.del("n", "<leader>-")
vim.keymap.del("n", "<leader>|")
vim.keymap.del("n", "<leader>wd")
vim.keymap.del("n", "<leader>wm")
vim.keymap.del("n", "<leader>bb")
-- vim.keymap.del("n", "<leader>/")
----switch to other buffer

vim.keymap.set("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
vim.keymap.del("n", "<S-h>")
vim.keymap.del("n", "<S-l>")
vim.keymap.del("n", "<leader>/")
-------

-- save file
vim.keymap.del({ "i", "x", "n", "s" }, "<C-s>")

-----save_quit_write_......
vim.keymap.set("n", "<leader>w", "<cmd>:w <CR><esc>")
vim.keymap.set("n", "<leader>q", "<cmd>:q <CR>")
vim.keymap.set("n", "<leader>q", "<cmd>:q! <CR>")
vim.keymap.set("n", "<leader><leader>q", "<cmd>:wqa <CR>")
vim.keymap.set("n", "<leader><leader>n", "<cmd>:nohlsearch <CR>")

-- Move selected line / block of text in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

----

-- Tabs
vim.keymap.del("n", "<leader><tab>l")
vim.keymap.del("n", "<leader><tab>o")
vim.keymap.del("n", "<leader><tab>f")
vim.keymap.del("n", "<leader><tab><tab>")
vim.keymap.del("n", "<leader><tab>]")
vim.keymap.del("n", "<leader><tab>d")
vim.keymap.del("n", "<leader><tab>[")

--
--disabling some nonesense keymaps--------------------------------------------------
--

--- Normal mode mappings
vim.api.nvim_set_keymap("n", "<tab>h", "5h", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<tab>j", "5j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<tab>k", "5k", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<tab>l", "5l", { noremap = true, silent = true })

-- Visual mode mappings
vim.api.nvim_set_keymap("v", "<tab>h", "5h", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<tab>j", "5j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<tab>k", "5k", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<tab>l", "5l", { noremap = true, silent = true })
