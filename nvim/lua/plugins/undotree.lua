return {
	'mbbill/undotree',
	dependencies = {
		'tzachar/highlight-undo.nvim',
	},
	config = function()
		local highlight_undo = require('highlight-undo')

		highlight_undo.setup({
			duration = 100,
			undo = {
				hlgroup = 'HighlightUndo',
				mode = 'n',
				lhs = 'u',
				map = 'undo',
				opts = {}
			},
			redo = {
				hlgroup = 'HighlightUndo',
				mode = 'n',
				lhs = '<C-r>',
				map = 'redo',
				opts = {}
			},
			highlight_for_count = true,
		})
	end
}
