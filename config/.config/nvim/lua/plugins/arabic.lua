return {
  -- {
  --   "LazyVim/LazyVim",
  --   config = function()
  --     -- Ensure UTF-8 encoding
  --     vim.opt.encoding = "utf-8"
  --     vim.opt.fileencoding = "utf-8"
  --   end,
  -- },
  -- {
  --   -- Use a dummy plugin to inject config
  --   "nvim-lua/plenary.nvim",
  --   config = function()
  --     -- Auto-set RTL + Arabic mode for specific filetypes
  --     vim.api.nvim_create_autocmd("FileType", {
  --       pattern = { "markdown", "text", "plaintex" },
  --       callback = function()
  --         -- vim.opt.rightleft = true
  --         -- vim.opt.arabic = true
  --       end,
  --     })
  --
  -- Toggle keybinding: <leader>ar
  vim.keymap.set("n", "<leader>ar", function()
    vim.opt.rightleft = not vim.opt.rightleft:get()
    vim.opt.arabic = not vim.opt.arabic:get()
  end, { desc = "Toggle Arabic Mode" }),
  --   end,
  -- },
}
