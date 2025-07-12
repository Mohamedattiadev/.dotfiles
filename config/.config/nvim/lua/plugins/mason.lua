-- lua/plugins/mason.lua
return {
  "williamboman/mason.nvim",
  event = "VeryLazy",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    -- Enable Mason with custom icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    -- Define LSPs to be installed by mason-lspconfig
    mason_lspconfig.setup({
      ensure_installed = {
        -- Web Development
        "ts_ls",
        "volar", -- Vue
        "html",
        "cssls",
        "tailwindcss",
        "emmet_ls",
        "eslint",

        -- General
        "lua_ls",
        "jsonls",
        "yamlls",
        "marksman", -- Markdown
        "bashls",
        "dockerls",
        "prismals",
        "graphql",

        -- Other Languages
        "pyright", -- Python
        "jdtls", -- Java
        "intelephense", -- PHP
        "sqlls", -- SQL
      },
    })

    -- Define Linters and Formatters to be installed by mason-tool-installer
    mason_tool_installer.setup({
      ensure_installed = {
        -- Formatters
        "prettier", -- Universal formatter
        "stylua", -- Lua formatter
        "black", -- Python formatter
        "isort", -- Python import sorter
        "shfmt", -- Shell formatter

        -- Linters
        -- "eslint_d", -- Faster ESLint
        "pylint", -- Python linter
      },
    })
  end,
}
