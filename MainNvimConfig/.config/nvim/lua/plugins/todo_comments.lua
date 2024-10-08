return {
  "folke/todo-comments.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<leader>tn",
      function()
        require("todo-comments").jump_next()
      end,
      desc = "Next Todo Comment",
    },
    {
      "<leader>tb",
      function()
        require("todo-comments").jump_prev()
      end,
      desc = "Previous Todo Comment",
    },
    -- { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
    -- {
    --   "<leader>xT",
    --   "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>",
    --   desc = "Todo/Fix/Fixme (Trouble)",
    --}
    { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Todo" },
    { "<leader>fT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
  },
}
