-- lua/plugins/lspconfig.lua
return {
  "neovim/nvim-lspconfig",
  event = "VeryLazy",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local keymap = vim.keymap

    -- Set up custom diagnostic symbols
    local signs = { Error = "", Warn = "", Hint = "󰠠", Info = "" }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- Keymaps to be set on LSP attach
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }
        local buf_keymap = function(mode, lhs, rhs, desc)
          opts.desc = desc
          keymap.set(mode, lhs, rhs, opts)
        end

        -- LSP Navigation & Information
        buf_keymap("n", "K", vim.lsp.buf.hover, "Show documentation")
        buf_keymap("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
        buf_keymap("n", "gR", "<cmd>Telescope lsp_references<CR>", "Show references")
        buf_keymap("n", "<leader>gd", "<cmd>Telescope lsp_definitions<CR>", "Show definitions")
        buf_keymap("n", "<leader>gi", "<cmd>Telescope lsp_implementations<CR>", "Show implementations")
        buf_keymap("n", "<leader>gt", "<cmd>Telescope lsp_type_definitions<CR>", "Show type definitions")

        -- LSP Actions
        buf_keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "See code actions")
        buf_keymap("n", "<leader>rn", vim.lsp.buf.rename, "Smart rename")
        buf_keymap("n", "<leader>rs", ":LspRestart<CR>", "Restart LSP")

        -- Diagnostics
        buf_keymap("n", "<leader>d", vim.diagnostic.open_float, "Show line diagnostics")
        buf_keymap("n", "<leader>dn", vim.diagnostic.goto_next, "Go to next diagnostic")
        buf_keymap("n", "<leader>db", vim.diagnostic.goto_prev, "Go to previous diagnostic")
        buf_keymap("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "Show buffer diagnostics")
      end,
    })

    -- Set up default capabilities for autocompletion
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Setup handlers for mason-lspconfig
    mason_lspconfig.setup_handlers({
      -- Default handler for servers that don't need special configuration
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end,

      -- Special setup for Volar (Vue)
      ["volar"] = function()
        lspconfig.volar.setup({
          capabilities = capabilities,
          filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
        })
      end,

      -- Special setup for lua_ls
      ["lua_ls"] = function()
        lspconfig.lua_ls.setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        })
      end,
    })
  end,
}
