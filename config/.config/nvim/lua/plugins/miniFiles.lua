return {
  "echasnovski/mini.files",
  version = "*",
  opts = {
    options = {
      use_as_default_explorer = false,
    },
    windows = {
      preview = true,
      width_focus = 50,
      width_preview = 50,
    },
  },
  keys = {
    {
      "<leader>f",
      function()
        local mini_files = require("mini.files")

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

        if is_mini_files_open() then
          mini_files.close()
        else
          mini_files.open(vim.api.nvim_buf_get_name(0), false)
        end
      end,
      desc = "Toggle mini.files (current file dir)",
    },
  },
  config = function(_, opts)
    local mini_files = require("mini.files")
    mini_files.setup(opts)

    local preview_win_id = nil

    local function open_preview(filepath)
      if preview_win_id and vim.api.nvim_win_is_valid(preview_win_id) then
        vim.api.nvim_win_close(preview_win_id, true)
      end

      local stat = vim.loop.fs_stat(filepath)
      if not stat or stat.type ~= "file" or stat.size > 100000 then
        return
      end

      local buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")

      vim.api.nvim_buf_call(buf, function()
        vim.cmd("silent! r " .. vim.fn.fnameescape(filepath))
      end)

      local width = math.floor(vim.o.columns * 0.5)
      local height = math.floor(vim.o.lines * 0.6)
      local row = math.floor((vim.o.lines - height) / 2 - 1)
      local col = math.floor((vim.o.columns - width) / 2)

      preview_win_id = vim.api.nvim_open_win(buf, false, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded",
      })
    end

    local function close_preview()
      if preview_win_id and vim.api.nvim_win_is_valid(preview_win_id) then
        vim.api.nvim_win_close(preview_win_id, true)
        preview_win_id = nil
      end
    end

    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesCursorMoved",
      callback = function(args)
        local entry = args.data.entry
        if entry.fs_type == "file" then
          open_preview(entry.path)
        else
          close_preview()
        end
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesClose",
      callback = function()
        close_preview()
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesActionOpen",
      callback = function(args)
        local fs_entry = args.data.entry
        if fs_entry.fs_type == "file" then
          vim.defer_fn(function()
            mini_files.close()
            close_preview()
          end, 50)
        end
      end,
    })
  end,
}
