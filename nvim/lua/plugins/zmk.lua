return {
	'codethread/qmk.nvim',
	lazy = true,
	ft = { 'keymap', },
	config = function()
		local qmk = require('qmk')
		qmk.setup({
			name = 'LAYOUT_adv_360',
			layout = {
				'x x x x x x x x x x x x x x x x x x',
				'x x x x x x _ _ _ _ _ _ x x x x x x',
				'x x x x x x _ _ _ _ _ _ x x x x x x',
				'x x x x x x _ _ _ _ _ _ x x x x x x',
				'x x x x x x _ _ _ _ _ _ x x x x x x',
				'_ x x x x _ _ _ _ _ _ _ _ x x x x _',
				'_ _ _ _ _ x x _ _ _ _ x x _ _ _ _ _',
				'_ _ _ _ _ _ x _ _ _ _ x _ _ _ _ _ _',
				'_ _ _ _ x x x _ _ _ _ x x x _ _ _ _',
			},
			variant = 'zmk'
		})
	end
}
