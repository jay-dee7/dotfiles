return {
	'stevearc/quicker.nvim',
	ft = "qf",
	config = function()
		local quicker = require("quicker")

		quicker.setup({})
	end
}
