return {
	'williamboman/mason.nvim',
	build = ':MasonUpdate',
	dependencies = {
		'williamboman/mason-lspconfig.nvim',
		'neovim/nvim-lspconfig',
		-- 'jose-elias-alvarez/typescript.nvim',
		{
			'pmizio/typescript-tools.nvim',
			dependencies = { 'nvim-lua/plenary.nvim' },
			opts = {},
		},
	},
	config = function()
		local mason = require('mason')
		local mason_config = require('mason-lspconfig')
		mason.setup({
			ui = {
				icons = {
					package_installed = '✓',
					package_pending = '➜',
					package_uninstalled = '✗',
				},
				border = 'none',
			},
			max_concurrent_installers = 8,
		})

		mason_config.setup({
			ensure_installed = {
				-- LSP Servers
				'lua_ls',
				'gopls',
				'jsonls',
				'terraformls',
				'cssls',
				'tailwindcss',
				'svelte',
				'eslint',
				'yamlls',
				'buf_ls',
				'taplo',
				'clangd',
				'pyright',

				-- Formatters
				-- 'yamlfix',
				-- 'markdownlint',
				-- 'stylua',
				-- 'prettierd',
				-- 'prettier',
				-- 'jq',
				-- 'gomodifytags',
			},
		})

		vim.cmd([[set shortmess+=c]])
		vim.o.completeopt = 'menu,menuone,noselect'
		vim.diagnostic.config({
			virtual_text = {
				source = 'always',
			},
			on_jump = {
				source = 'always',
			},
		})
	end,
}
