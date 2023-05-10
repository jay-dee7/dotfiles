return {
    'williamboman/mason.nvim',
    build = ":MasonUpdate",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        'jose-elias-alvarez/typescript.nvim',
        'simrat39/rust-tools.nvim',
    },
    config = function()
        local mason = require("mason");
        local mason_config = require("mason-lspconfig")
        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            },
            max_concurrent_installers = 8,
        })
        mason_config.setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "gopls",
                "jsonls",
                "terraformls",
                "cssls",
                "tailwindcss",
                "svelte",
                "vuels",
                "graphql",
                "eslint",
                "lua_ls",
                "yamlls",
                "bufls",
                "prismals",
                "sqlls",
                "taplo",
            },
        })
        vim.cmd [[set shortmess+=c]]
        vim.o.completeopt = "menu,menuone,noselect"
        vim.diagnostic.config({
            virtual_text = {
                source = 'always',
            },
            float = {
                source = 'always',
            },
        })
    end
}
