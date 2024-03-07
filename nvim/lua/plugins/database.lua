return {
	'kristijanhusak/vim-dadbod-ui',
	dependencies = {
		'tpope/vim-dadbod',
		{ 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'plsql' }, lazy = true },

	},
	cmd = {
		'DBUI',
		'DBUIToggle',
		'DBUIAddConnection',
		'DBUIFindBuffer',
	},
	config = function()
		vim.g.db_ui_save_location = vim.fn.stdpath "config" .. require("plenary.path").path.sep .. "db_ui"
		vim.g.db_ui_use_nerd_fonts = 1

		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"sql",
			},
			command = [[setlocal omnifunc=vim_dadbod_completion#omni]],
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"sql",
				"plsql",
			},
			callback = function()
				vim.schedule(function()
					require("cmp").setup.buffer { sources = { { name = "vim-dadbod-completion" } } }
				end)
			end
		})
	end
}
