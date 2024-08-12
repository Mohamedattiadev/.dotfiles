-- return {
--   "epwalsh/obsidian.nvim",
--   version = "*",
--   lazy = true,
--   ft = "markdown",
--   dependencies = {
--     "nvim-lua/plenary.nvim",
--   },
--   config = function()
--     require("obsidian").setup({
--       workspaces = {
--         {
--           name = "AttiaNotes",
--           path = "~/AttiaNotes/",
--         },
--       },
--       notes_subdir = "inbox",
--       new_notes_location = "notes_subdir",
--
--       disable_frontmatter = true,
--       templates = { subdir = "templates", date_format = "%Y-%m-%d", time_format = "%H:%M:%S" },
--
--       -- key mappings, below are the defaults
--       mappings = {
--         -- overrides the 'gf' mapping to work on markdown/wiki links within your vault
--         ["gf"] = {
--           action = function()
--             return require("obsidian").util.gf_passthrough()
--           end,
--           opts = { noremap = false, expr = true, buffer = true },
--         },
--       },
--       completion = {
--         nvim_cmp = true,
--         min_chars = 2,
--       },
--       ui = {
--         -- Disable some things below here because I set these manually for all Markdown files using treesitter
--         checkboxes = {},
--         bullets = {},
--       },
--     })
--
--     -- Key mappings
--     vim.keymap.set("n", "<leader>ob", ":cd ~/AttiaNotes/<cr>")
--     vim.keymap.set("n", "<leader>on", ":ObsidianTemplate note<cr> :lua vim.cmd([[1,/^\\S/s/^\\n\\{1,}//]])<cr>")
--     vim.keymap.set("n", "<leader>of", ":s/\\(# \\)[^_]*_/\\1/ | s/-/ /g<cr>")
--     vim.keymap.set("n", "<leader>os", ':Telescope find_files search_dirs={"~/AttiaNotes/"}<cr>')
--     vim.keymap.set("n", "<leader>oz", ':Telescope live_grep search_dirs={"~/AttiaNotes/"}<cr>')
--     vim.keymap.set("n", "<leader>ok", ":!mv '%:p' ~/AttiaNotes/<cr>:bd<cr>")
--     vim.keymap.set("n", "<leader>odd", ":!rm '%:p'<cr>:bd<cr>")
--   end,
-- }
return {
  "epwalsh/obsidian.nvim",
  version = "*",
  event = "VeryLazy",
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    -- Ensure the templates directory exists
    local templates_dir = vim.fn.expand("/mnt/c/Users/moham/OneDrive/Desktop/Attia/2enBrain/templates/")
    if vim.fn.isdirectory(templates_dir) == 0 then
      print("'" .. templates_dir .. "' does not exist, creating it now.")
      vim.fn.mkdir(templates_dir, "p")
    end

    require("obsidian").setup({
      workspaces = {
        {
          name = "AttiaNotes",
          path = "/mnt/c/Users/moham/OneDrive/Desktop/Attia/2enBrain/",
        },
      },
      notes_subdir = "inbox",
      new_notes_location = "notes_subdir",

      disable_frontmatter = true,
      templates = { subdir = "templates", date_format = "%Y-%m-%d", time_format = "%H:%M:%S" },

      -- key mappings, below are the defaults
      mappings = {
        -- overrides the 'gf' mapping to work on markdown/wiki links within your vault
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
      },
      completion = {
        nvim_cmp = true,
        min_chars = 2,
      },
      ui = {
        enable = true, -- set to false to disable all additional syntax features
        update_debounce = 200, -- update delay after a text change (in milliseconds)
        max_file_length = 5000, -- disable UI features for files with more than this many lines
        -- Define how various check-boxes are displayed
        checkboxes = {
          -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
          [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
          ["x"] = { char = "", hl_group = "ObsidianDone" },
          [">"] = { char = "", hl_group = "ObsidianRightArrow" },
          ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
          ["!"] = { char = "", hl_group = "ObsidianImportant" },
          -- Replace the above with this if you don't have a patched font:
          -- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
          -- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

          -- You can also add more custom ones...
        },
        -- Use bullet marks for non-checkbox lists.
        bullets = { char = "•", hl_group = "ObsidianBullet" },
        external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
        -- Replace the above with this if you don't have a patched font:
        -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
        reference_text = { hl_group = "ObsidianRefText" },
        highlight_text = { hl_group = "ObsidianHighlightText" },
        tags = { hl_group = "ObsidianTag" },
        block_ids = { hl_group = "ObsidianBlockID" },
        hl_groups = {
          -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
          ObsidianTodo = { bold = true, fg = "#f78c6c" },
          ObsidianDone = { bold = true, fg = "#89ddff" },
          ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
          ObsidianTilde = { bold = true, fg = "#ff5370" },
          ObsidianImportant = { bold = true, fg = "#d73128" },
          ObsidianBullet = { bold = true, fg = "#89ddff" },
          ObsidianRefText = { underline = true, fg = "#c792ea" },
          ObsidianExtLinkIcon = { fg = "#c792ea" },
          ObsidianTag = { italic = true, fg = "#89ddff" },
          ObsidianBlockID = { italic = true, fg = "#89ddff" },
          ObsidianHighlightText = { bg = "#75662e" },
        },
      },
    })

    -- Key mappings
    --
    --
    vim.keymap.set("n", "<leader>ob", "<cmd>cd  /mnt/c/Users/moham/OneDrive/Desktop/Attia/2enBrain/<cr>")

    vim.keymap.set("n", "<leader>on", "<cmd>ObsidianTemplate note<cr> :lua vim.cmd([[1,/^\\S/s/^\\n\\{1,}//]])<cr>")

    vim.keymap.set("n", "<leader>of", "<cmd>s/\\(# \\)[^_]*_/\\1/ | s/-/ /g<cr>")

    vim.keymap.set(
      "n",
      "<leader>os",
      '<cmd>Telescope find_files search_dirs={"/mnt/c/Users/moham/OneDrive/Desktop/Attia/2enBrain/"}<cr>'
    )
    vim.keymap.set(
      "n",
      "<leader>oz",
      '<cmd>Telescope live_grep search_dirs={"/mnt/c/Users/moham/OneDrive/Desktop/Attia/2enBrain/"}<cr>'
    )
    vim.keymap.set(
      "n",
      "<leader>ok",
      "<cmd>!mv '%:p' /mnt/c/Users/moham/OneDrive/Desktop/Attia/2enBrain/NeedToRev<cr>:bd<cr>"
    )
    vim.keymap.set("n", "<leader>odd", "<cmd>!rm '%:p'<cr>:bd<cr>")
  end,
}
