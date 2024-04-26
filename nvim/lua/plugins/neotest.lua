return {
	"nvim-neotest/neotest",
	dependencies = {
		"lawrence-laz/neotest-zig", -- for Zig support
		"nvim-neotest/neotest-go", -- for Go support
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter"
	},
	config = function()
		local neotest = require("neotest")

		-- local neotest_ns = vim.api.nvim_create_namespace("neotest")
		-- vim.diagnostic.config({
		-- 	virtual_text = {
		-- 		format = function(diagnostic)
		-- 			local message =
		-- 				diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
		-- 			return message
		-- 		end,
		-- 	},
		-- }, neotest_ns)

		neotest.setup({
			adapters = {
				require('neotest-zig'),
				require("neotest-go"),
			},
		});

		vim.keymap.set('n', '<leader>TR', neotest.run.run);
	end
}
