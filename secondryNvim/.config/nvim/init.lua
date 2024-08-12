local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("vim-options")
require("lazy").setup("plugins")
-------------------------------------
-- Function to run current file based on filetype in a vertical tmux pane
function RunCurrentFile()
    local filetype = vim.bo.filetype
    local file = vim.fn.expand('%')

    local cmd = ""

    if filetype == 'python' then
        cmd = 'tmux split-window -v "zsh -c \'/usr/bin/python3 ' .. file .. '; echo Press any key to close...; read -n 1\'"'
    elseif filetype == 'javascript' then
        cmd = 'tmux split-window -v "zsh -c \'/usr/bin/node ' .. file .. '; echo Press any key to close...; read -n 1\'"'
    elseif filetype == 'sh' then
        cmd = 'tmux split-window -v "zsh -c \'chmod +x ' .. file .. ' && ./' .. file .. '; echo Press any key to close...; read -n 1\'"'
    elseif filetype == 'c' then
        cmd = 'tmux split-window -v "zsh -c \'gcc ' .. file .. ' -o ' .. file:gsub('%.c$', '') .. ' && ./' .. file:gsub('%.c$', '') .. '; echo Press any key to close...; read -n 1\'"'
    elseif filetype == 'cpp' then
        cmd = 'tmux split-window -v "zsh -c \'g++ ' .. file .. ' -o ' .. file:gsub('%.cpp$', '') .. ' && ./' .. file:gsub('%.cpp$', '') .. '; echo Press any key to close...; read -n 1\'"'
    else
        print('Filetype not supported!')
        return
    end

    -- Execute the command in the shell context
    os.execute(cmd)
end

--------------------------------------------------
function RunReactProject()
    local project_root = '/path/to/your/react/project'  -- Replace with your actual project path
    local cmd = 'tmux split-window -v -t 0 "zsh -c \'cd ' .. project_root .. ' && npm start; echo Press any key to close...; read -n 1\'"'
    os.execute(cmd)
end


vim.api.nvim_set_keymap('n', '<leader>rp', ':lua RunReactProject()<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>r', ':lua RunCurrentFile()<CR>', { noremap = true, silent = true })


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Other configurations

-- Key mapping for opening URLs
vim.api.nvim_set_keymap('n', '<leader>gx', '<Plug>(openbrowser-smart-search)', {})
vim.api.nvim_set_keymap('v', '<leader>gx', '<Plug>(openbrowser-smart-search)', {})

