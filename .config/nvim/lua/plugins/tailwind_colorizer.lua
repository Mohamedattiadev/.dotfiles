return {

  -- TailwindCSS Colorizer for nvim-cmp
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    config = function()
      require("tailwindcss-colorizer-cmp").setup({
        color_square_width = 2,
      })

      -- Configure nvim-cmp to use the formatter
      local cmp = require("cmp")
      cmp.setup({
        formatting = {
          format = require("tailwindcss-colorizer-cmp").formatter,
        },
      })
    end,
  },
}
