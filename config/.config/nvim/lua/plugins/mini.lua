return {
  { "echasnovski/mini.nvim", version = false },
  event = "InsertEnter",
  {
    "echasnovski/mini.ai",
    event = "InsertEnter",
    version = false,
    config = function()
      require("mini.ai").setup()
    end,
  },
}
