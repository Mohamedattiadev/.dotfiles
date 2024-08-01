-- Set indentation preferences
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

-- Enable relative line numbers
vim.opt.relativenumber = true

-- Change mapleader to space
vim.g.mapleader = " "

-- Disable swapfile
vim.opt.swapfile = false

vim.keymap.set("n", "<leader>w", ":wa <CR>")
vim.keymap.set("n", "<leader>q", ":q! <CR>")
vim.keymap.set("n", "<leader><leader>q", ":wqa <CR>")
vim.keymap.set("n", "<leader><leader>n", ":nohlsearch <CR>")

----------------------------------------------          ---------------------------------------------------
-----------------------------------------------Terminal----------------------------------------------------

-- Keymaps to toggle terminal and project navigation mode
vim.keymap.set("n", "<C-j>", "<cmd>lua toggle_terminal_navigation()<CR>") -- Move down
vim.keymap.set("n", "<C-k>", "<cmd>lua toggle_terminal_navigation()<CR>") -- Move up
vim.keymap.set("n", "<C-h>", "<cmd>lua toggle_terminal_navigation()<CR>") -- Move left
vim.keymap.set("n", "<C-l>", "<cmd>lua toggle_terminal_navigation()<CR>") -- Move right

---------------------------------
-- -- Function to toggle terminal and project navigation mode
-- local function toggle_terminal_navigation()
-- 	local bufnr = vim.api.nvim_get_current_buf()
--
-- 	-- Check if the current buffer is a terminal buffer
-- 	if vim.bo[bufnr].buftype == "terminal" then
-- 		-- In terminal: switch between insert and normal mode
-- 		vim.cmd("startinsert")
-- 	else
-- 		-- In normal buffer: open terminal split with Zsh
-- 		vim.cmd("botright split term://zsh") -- Open a new split at the bottom right with Zsh shell
-- 	end
-- end
--
--
-- Function to toggle terminal and project navigation mode
local function toggle_terminal_navigation()
	local bufnr = vim.api.nvim_get_current_buf()

	-- Check if the current buffer is a terminal buffer
	if vim.bo[bufnr].buftype == "terminal" then
		-- In terminal: switch between insert and normal mode
		vim.cmd("startinsert")
	else
		-- In normal buffer: open terminal split with Zsh and current working directory
		local current_file_dir = vim.fn.getcwd() -- Get the current working directory
		local command = string.format("botright split term://zsh -c 'cd %s; zsh'", current_file_dir)
		vim.cmd(command)
	end
end

--------------------------------------
-- Variable to store previous terminal split height
local previous_terminal_height = 10 -- Set your preferred default height here

-- Keymap to open a horizontal split terminal at the bottom
vim.keymap.set("n", "<leader>tt", function()
	vim.cmd("botright split term://zsh") -- Open a new split at the bottom right with Zsh shell
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
