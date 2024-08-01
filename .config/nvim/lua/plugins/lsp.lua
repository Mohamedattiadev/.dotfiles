return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tsserver = {
          keys = {
            --         { "<leader>co", "<cmd>TypescriptOrganizeImports<CR>", desc = "Organize Imports" },
            { "<leader>cR", "<cmd>TypescriptRenameFile<CR>", desc = "Rename File" },
            { "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>", desc = "Go to Definition" },
            { "<leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>", desc = "Find References" },
            { "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code Action" },
          },
        },
      },
    },
  },
}
