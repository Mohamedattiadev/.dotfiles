return {

  {
    "ibhagwan/fzf-lua",
    event = "InsertEnter",
    event = "BufReadPre",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- config = function()
    --   local set = vim.keymap.set
    --
    --   -- Function to wrap LazyVim pick commands
    --   local function lazyvim_pick(command, opts)
    --     return function()
    --       require("lazyvim.util.pick").open(command, opts)
    --     end
    --   end
    --
    --   -- vim.keymap.del("n", "<leader>bb")
    --   -- Key mappings
    --   -- vim.keymap.del("n", "<leader>fb")
    --   set("n", "<leader><space>", lazyvim_pick("files"), { desc = "Find Files (Root Dir)", silent = true })
    --   set("n", "<leader>oO", lazyvim_pick("oldfiles"), { desc = "oldfiles", silent = true })
    --
    --   -- set("n", "<leader>ff", lazyvim_pick("files"), { desc = "Find Files (Root Dir)" })
    --   set("n", "<leader>bB", lazyvim_pick("buffers"), { desc = "buffers", silent = true })
    --   -- set('n', '<leader>fF', lazyvim_pick("files", { root = false }), { desc = "Find Files (cwd)" })
    --   -- set('n', '<leader>fg', "<cmd>FzfLua git_files<cr>", { desc = "Find Files (git-files)" })
    --
    --   set("n", "<leader>fg", lazyvim_pick("live_grep"), { desc = "Grep (Root Dir)", silent = true })
    --
    --   -- set('n', '<leader>fG', lazyvim_pick("live_grep", { root = false }), { desc = "Grep (cwd)" })
    --   set("n", "<leader>fw", lazyvim_pick("grep_cword"), { desc = "Word (Root Dir)", silent = true })
    --   -- set('n', '<leader>fW', lazyvim_pick("grep_cword", { root = false }), { desc = "Word (cwd)" })
    -- end,
    config = function()
      local set = vim.keymap.set

      -- Function to wrap LazyVim pick commands
      local function lazyvim_pick(command, opts)
        return function()
          require("lazyvim.util.pick").open(command, opts)
        end
      end

      -- Key mappings for LazyVim commands
      set(
        "n",
        "<leader><leader>",
        lazyvim_pick("files"),
        { desc = "Find Files (Root Dir)", noremap = true, silent = true }
      )
      set("n", "<leader>oO", lazyvim_pick("oldfiles"), { desc = "Old Files", noremap = true, silent = true })
      set("n", "<leader>bB", lazyvim_pick("buffers"), { desc = "Buffers", noremap = true, silent = true })
      set("n", "<leader>fG", lazyvim_pick("live_grep"), { desc = "Grep (Root Dir)", noremap = true, silent = true })
      set("n", "<leader>fw", lazyvim_pick("grep_cword"), { desc = "Word (Root Dir)", noremap = true, silent = true })

      -- Key mappings for fzf commands
      set("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "Find Files (FZF)", noremap = true, silent = true })
      set("n", "<leader>fg", "<cmd>FzfLua live_grep<cr>", { desc = "Grep (FZF)", noremap = true, silent = true })
      set("n", "<leader>fw", "<cmd>FzfLua grep_cword<cr>", { desc = "Word (FZF)", noremap = true, silent = true })
    end,
  },
}
