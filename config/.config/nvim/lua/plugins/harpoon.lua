return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  event = "InsertEnter",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    settings = {
      save_on_toggle = true,
    },
  },
  config = function()
    local harpoon = require("harpoon")
    -- REQUIRED

    harpoon:setup()

    vim.keymap.set("n", "<leader>a", function()
      harpoon:list():add()
    end)
    vim.keymap.set("n", "<leader>h", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, {
      noremap = true,
      silent = true,
      desc = "Toggle Harpoon menu", -- optional description
    })

    vim.keymap.set("n", "<leader>h1", function()
      harpoon:list():select(1)
    end)
    vim.keymap.set("n", "<leader>h2", function()
      harpoon:list():select(2)
    end)
    vim.keymap.set("n", "<leader>h3", function()
      harpoon:list():select(3)
    end)
    vim.keymap.set("n", "<leader>h4", function()
      harpoon:list():select(4)
    end)

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<S-h>", function()
      harpoon:list():prev()
    end)
    vim.keymap.set("n", "<S-l>", function()
      harpoon:list():next()
    end)
  end,
}
