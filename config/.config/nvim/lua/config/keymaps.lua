-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps heresd

--disabling some nonesense keymaps--------------------------------------------------
-- vim.keymap.set("n", "gx", ":!open <c-r><c-a><CR>")
-- vim.keymap.del("n", "gx")
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

-- Safe delete function to avoid errors with multiple modes
local function safe_del(modes, key)
  -- If modes is a list, iterate through each mode and delete the keymap
  if type(modes) == "table" then
    for _, mode in ipairs(modes) do
      if vim.fn.maparg(key, mode) ~= "" then
        vim.keymap.del(mode, key)
      end
    end
  else
    -- Otherwise, just delete for the single mode
    if vim.fn.maparg(key, modes) ~= "" then
      vim.keymap.del(modes, key)
    end
  end
end
-- Delete keymaps only if they exist
--

safe_del("n", "gx")
safe_del("n", "<leader>w")
safe_del("n", "<leader>-")
safe_del("n", "<leader>|")
safe_del("n", "<leader>wd")
safe_del("n", "<leader>wm")
safe_del("n", "<leader>bb")
safe_del("n", "<S-h>")
safe_del("n", "<S-l>")
safe_del("n", "<leader>/")

-- Example keymaps (just adding safe_del here for others)
vim.keymap.set("n", "<leader>`", "<cmd>e #<cr>")

-- Save file keymaps
safe_del({ "i", "x", "n", "s" }, "<C-s>")
vim.keymap.set("n", "<leader>w", "<cmd>:w <CR><esc>")
vim.keymap.set("n", "<leader>q", "<cmd>:q <CR>")
vim.keymap.set("n", "<leader><leader>q", "<cmd>:wqa <CR>")

-- Code runner keymap
vim.keymap.set("n", "<leader>r", ":RunCode<CR>", { noremap = true, silent = false })
-- local cowboy = require("config.autocmds")
--
-- cowboy.cowboy()
-- -- windows
-- vim.keymap.del("n", "<leader>w")
-- vim.keymap.del("n", "<leader>-")
-- vim.keymap.del("n", "<leader>|")
-- vim.keymap.del("n", "<leader>wd")
-- vim.keymap.del("n", "<leader>wm")
-- vim.keymap.del("n", "<leader>bb")
-- -- vim.keymap.del("n", "<leader>/")
-- ----switch to other buffer
--
-- vim.keymap.set("n", "<leader>`", "<cmd>e #<cr>")
-- vim.keymap.del("n", "<S-h>")
-- vim.keymap.del("n", "<S-l>")
-- vim.keymap.del("n", "<leader>/")
-- -------
--
-- -- save file
-- vim.keymap.del({ "i", "x", "n", "s" }, "<C-s>")
--
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

-- -- Tabs
-- vim.keymap.del("n", "<leader><tab>l")
-- vim.keymap.del("n", "<leader><tab>o")
-- vim.keymap.del("n", "<leader><tab>f")
-- vim.keymap.del("n", "<leader><tab><tab>")
-- vim.keymap.del("n", "<leader><tab>]")
-- vim.keymap.del("n", "<leader><tab>d")
-- vim.keymap.del("n", "<leader><tab>[")
--
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
---------------------------------
---scroll
vim.keymap.set("n", "<C-e>", "10<C-e>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-y>", "10<C-y>", { noremap = true, silent = true }) -- also faster scroll up
--- code runner
vim.keymap.set("n", "<leader>r", ":RunCode<CR>", { noremap = true, silent = false })

-- File: lua/core/keymaps.lua (or any other config file)

-- Disable the default Visual Block mode binding
vim.keymap.set("n", "<C-v>", "<Nop>")

-- Paste from system clipboard in different modes
-- Normal Mode: Paste after the cursor
vim.keymap.set("n", "<C-v>", '"+P', { desc = "Paste after cursor" })
-- Normal Mode (uppercase V): Paste before the cursor
vim.keymap.set("n", "<C-S-v>", '"+p', { desc = "Paste before cursor" })

-- Insert Mode: Paste at the cursor position
vim.keymap.set("i", "<C-v>", "<C-R>+", { desc = "Paste from clipboard" })

-- Visual Mode: Replace selection with clipboard content
vim.keymap.set("v", "<C-v>", '"+P', { desc = "Paste and replace selection" })
