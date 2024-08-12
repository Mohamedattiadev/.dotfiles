return {

  -- nvim v0.8.0
  "kdheepak/lazygit.nvim",

  event = "InsertEnter",
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  -- optional for floating window border decoration
  dependencies = {

    "nvim-lua/plenary.nvim",
  },

  -- setting the keybinding for LazyGit with 'keys' is recommended in
  -- order to load the plugin when the command is run for the first time
  keys = {

    { "<leader>gG", enabled = false, desc = false },
    { "<leader>gb", enabled = false, desc = false },
    { "<leader>gB", enabled = false, desc = false },
    { "<leader>gb", enabled = false, desc = false },
    { "<leader>gc", enabled = false, desc = false },
    { "<leader>gL", enabled = false, desc = false },
    { "<leader>gs", enabled = false, desc = false },
    { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
  },
}
