return {
	'williamboman/mason.nvim',
	build = ":MasonUpdate",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		-- 'jose-elias-alvarez/typescript.nvim',
		{
			"pmizio/typescript-tools.nvim",
			dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
			opts = {},
		},
		'simrat39/rust-tools.nvim',
		{
			'saecki/crates.nvim',
			dependencies = {
				'nvim-lua/plenary.nvim'
			}
		},
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
				},
				border = "none"
			},
			max_concurrent_installers = 8,
		})

		mason_config.setup({
			ensure_installed = {
				-- LSP Servers
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
				"sqlls",
				"taplo",
				"clangd",
				'zls',

				-- Formatters
				-- 'yamlfix',
				-- 'markdownlint',
				-- 'stylua',
				-- 'prettierd',
				-- 'prettier',
				-- 'jq',
				-- 'gomodifytags',
				-- 'buf',
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
		require('crates').setup({})
	end
}
