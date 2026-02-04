return {
	'folke/neodev.nvim',
	'nvim-lua/lsp-status.nvim',
	'windwp/nvim-ts-autotag',
	'dmmulroy/ts-error-translator.nvim',
	'yorickpeterse/nvim-pqf',
	'tpope/vim-eunuch',
	{ 'jremmen/vim-ripgrep',         lazy = true, cmd = { 'Rg' } },
	{ 'norcalli/nvim-colorizer.lua', lazy = true, cmd = { 'ColorizerToggle' } },
	config = function()
		local neodev = require('neodev')
		local ts_error_translator = require("ts-error-translator")
		local pqf = require("pqf");

		pqf.setup({
			signs = {
				error = { text = 'E', hl = 'DiagnosticSignError' },
				warning = { text = 'W', hl = 'DiagnosticSignWarn' },
				info = { text = 'I', hl = 'DiagnosticSignInfo' },
				hint = { text = 'H', hl = 'DiagnosticSignHint' },
			},
			show_multiple_lines = false,
			max_filename_length = 0,
			filename_truncate_prefix = '[...]',
		})

		neodev.setup({
			library = {
				enabled = true,
				runtime = true,
				types = true,
				plugins = true,
			},
			plugins = {
				"nvim-dap-ui"
			},
			setup_jsonls = true,
			lspconfig = true,
			pathStrict = true,
		})

		ts_error_translator.setup()
	end
}
