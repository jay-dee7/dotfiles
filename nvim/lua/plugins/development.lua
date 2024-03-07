return {
	'folke/neodev.nvim',
	'jbyuki/venn.nvim',
	'nvim-lua/lsp-status.nvim',
	'jvirtanen/vim-hcl',
	'windwp/nvim-ts-autotag',
	'prisma/vim-prisma',
	'cespare/vim-toml',
	'ThePrimeagen/vim-be-good',
	'dmmulroy/ts-error-translator.nvim',
	{ 'jremmen/vim-ripgrep',         lazy = true, cmd = { 'Rg' } },
	{ 'norcalli/nvim-colorizer.lua', lazy = true, cmd = { 'ColorizerToggle' } },
	config = function()
		local neodev = require('neodev')
		local ts_error_translator = require("ts-error-translator")

		neodev.setup({
			library = {
				enabled = true,
				runtime = true,
				types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
				plugins = true, -- installed opt or start plugins in packpath
				-- you can also specify the list of plugins to make available as a workspace library
				-- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
			},
			setup_jsonls = true, -- configures jsonls to provide completion for project specific .luarc.json files
			-- for your Neovim config directory, the config.library settings will be used as is
			-- for plugin directories (root_dirs having a /lua directory), config.library.plugins will be disabled
			-- for any other directory, config.library.enabled will be set to false
			-- override = function(root_dir, options) end,
			-- With lspconfig, Neodev will automatically setup your lua-language-server
			-- If you disable this, then you have to set {before_init=require("neodev.lsp").before_init}
			-- in your lsp start options
			lspconfig = true,
			-- much faster, but needs a recent built of lua-language-server
			-- needs lua-language-server >= 3.6.0
			pathStrict = true,
		})

		ts_error_translator.setup()
	end
}
