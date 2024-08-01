return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.del("n", "<leader>/", { desc = "Buffers" })
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
      vim.keymap.set("n", "<leader>oo", builtin.oldfiles, { desc = "Old Files" })

      vim.keymap.set("n", "<leader>bb", builtin.buffers, { desc = "Buffers" })
    end,

    --disable some nonesense
  },
}
