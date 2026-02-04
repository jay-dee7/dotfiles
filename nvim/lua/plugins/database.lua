return {
	'kristijanhusak/vim-dadbod-ui',
	lazy = true,
	dependencies = {
		{ 'tpope/vim-dadbod',                     lazy = true },
		{ 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'plsql' }, lazy = true },
		{ 'hrsh7th/nvim-cmp',                     ft = { 'sql', 'plsql' }, lazy = true },
	},
	cmd = {
		'DBUI',
		'DBUIToggle',
		'DBUIAddConnection',
		'DBUIFindBuffer',
	},
	config = function()
		-- Set up nvim-cmp.
		local cmp = require('cmp')
		vim.g.db_ui_save_location = vim.fn.stdpath('config') .. require('plenary.path').path.sep .. 'db_ui'
		vim.g.db_ui_use_nerd_fonts = 1

		cmp.setup({
			enabled = function()
				return vim.bo.filetype == 'sql' or vim.bo.filetype == 'plsql'
			end,
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				['<C-p>'] = cmp.mapping.select_prev_item(),
				['<C-n>'] = cmp.mapping.select_next_item(),
				['<C-d>'] = cmp.mapping.scroll_docs(-4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),
				['<C-Space>'] = cmp.mapping.complete(),
				['<C-y>'] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Select,
					select = false,
				}),
				['<C-e>'] = cmp.mapping.close(),
				['<CR>'] = cmp.mapping.confirm({ select = true }),
			}),
			sources = cmp.config.sources({
				{ name = 'vim-dadbod-completion' },
			}),
		})
	end,
}
