return {
  { "CRAG666/code_runner.nvim", event = "InsertEnter", config = true },
  vim.keymap.set("n", "<leader>r", ":RunCode<CR>", { noremap = true, silent = false }),
}
