return {
  "echasnovski/mini.files",
  version = "*",
  config = function()
    local mini_files = require("mini.files")

    mini_files.setup({
      options = {
        use_as_default_explorer = false, -- Do not auto-open with nvim .
      },
    })

    -- Helper function to check if mini.files is open
    local function is_mini_files_open()
      for _, win_id in ipairs(vim.api.nvim_list_wins()) do
        local buf_id = vim.api.nvim_win_get_buf(win_id)
        local buf_name = vim.api.nvim_buf_get_name(buf_id)
        if buf_name:match("MiniFiles") then
          return true
        end
      end
      return false
    end

    -- Toggle mini.files with <leader>f
    vim.keymap.set("n", "<leader>f", function()
      if is_mini_files_open() then
        mini_files.close()
      else
        mini_files.open(vim.api.nvim_buf_get_name(0), false)
      end
    end, { desc = "Toggle mini.files (current file dir)" })

    -- Close mini.files after opening a file
    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesActionOpen",
      callback = function(args)
        local fs_entry = args.data.entry
        if fs_entry.fs_type == "file" then
          vim.defer_fn(function()
            mini_files.close()
          end, 50)
        end
      end,
    })
  end,
}
