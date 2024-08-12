return {
	{
		"williamboman/mason.nvim",
		lazy = false,

		config = function()
			require("mason").setup()
			-- Map F2 to toggle Tagbar
			-- big note: if u tried to open it with <F2> and did not work (:Tagbar Toggle not an editor--->error)
			-- to solve it first: install ctags
			-- second:move the ctags to the ~/.local/share/nvim/mason/bin/ ---> dirc
			-- third : have fun ^_*
			vim.api.nvim_set_keymap("n", "<F2>", ":TagbarToggle<CR>", { noremap = true, silent = true })
			-- If ctags is not in your PATH, specify its location
			vim.g.tagbar_ctags_bin = vim.fn.stdpath("data") .. "/mason/bin/ctags"
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")
			lspconfig.tailwindcss.setup({
				capabilities = capabilities,
			})
			lspconfig.tsserver.setup({
				capabilities = capabilities,
			})
			lspconfig.solargraph.setup({
				capabilities = capabilities,
			})
			lspconfig.html.setup({
				capabilities = capabilities,
			})
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.gopls.setup({
				capabilities = capabilities,
			})
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
			})
			lspconfig.jdtls.setup({
				capabilities = capabilities,
			})
			lspconfig.clangd.setup({
				capabilities = capabilities,
			})
			lspconfig.cssls.setup({
				capabilities = capabilities,
			})
			lspconfig.jsonls.setup({
				capabilities = capabilities,
			})
			lspconfig.pylsp.setup({
				capabilities = capabilities,
			})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			----------------------------go to link-------------------
			-- ---- Ensure netrw is enabled
			-- vim.g.loaded_netrw = 1
			-- vim.g.loaded_netrwPlugin = 1
			--
			-- -- Set the default browser to Edge
			-- vim.g.netrw_browsex_viewer = 'start ""'
			--
			-- -- Explicitly set the gx keymap
			-- vim.api.nvim_set_keymap('v', 'gx', ':!start <cfile><CR>', { noremap = true, silent = true })
			-- Use the default web browser to open URLs
			if vim.fn.has("mac") == 1 then
				vim.g.netrw_browsex_viewer = "open"
			elseif vim.fn.has("unix") == 1 then
				vim.g.netrw_browsex_viewer = "xdg-open"
			elseif vim.fn.has("win32") == 1 then
				vim.g.netrw_browsex_viewer = "start"
			end

			----------------------------End go to link-------------------
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>m", ":Mason<CR>", {})
		end,
	},
	{
		"preservim/tagbar",
		lazy = false,
		config = function()
			-- Additional configuration for Tagbar if needed
		end,
	},
}
