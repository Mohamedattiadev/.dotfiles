return {
  "numToStr/Comment.nvim",
  opts = {
    -- add any options here
  },
  config = function()
    local Comment = require("Comment")

    Comment.setup()
  end,
}
