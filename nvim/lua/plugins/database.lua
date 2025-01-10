return {
	{
		'kristijanhusak/vim-dadbod-ui',
		lazy = false,
		dependencies = {
			{ 'tpope/vim-dadbod',                     lazy = true },
			{ 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'plsql' }, lazy = true },
		},
		cmd = {
			'DBUI',
			'DBUIToggle',
			'DBUIAddConnection',
			'DBUIFindBuffer',
		},
		-- keys = {
		-- 	{ '<leader>du', ':DBUIToggle<CR>' },
		-- },
		config = function()
			vim.g.db_ui_save_location = vim.fn.stdpath "config" .. require("plenary.path").path.sep .. "db_ui"
			vim.g.db_ui_use_nerd_fonts = 1
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"sql",
				},
				command = [[setlocal omnifunc=vim_dadbod_completion#omni]],
			})
			vim.keymap.set('n', '<leader>du', '<cmd>DBUIToggle<CR>')
		end
	},
	{
		'saghen/blink.cmp',
		opts = {
			sources = {
				-- add vim-dadbod-completion to your completion providers
				default = { "lsp", "luasnip", "path", "buffer", "dadbod" },
				providers = {
					dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
				},
			},
		},
	}
}
