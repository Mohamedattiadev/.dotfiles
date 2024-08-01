return {
  { "CRAG666/code_runner.nvim", config = true },
  vim.keymap.set("n", "<leader>r", ":RunCode<CR>", { noremap = true, silent = false }),
}
