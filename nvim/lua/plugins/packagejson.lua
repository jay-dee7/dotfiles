return {
	"vuki656/package-info.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim"
	},
	config = function()
		local pkg_info = require('package-info')

		pkg_info.setup({
			colors = {
				up_to_date = "#3C4048",
				outdated = "#d19a66",
			},
			icons = {
				enable = true,
				style = {
					up_to_date = "|  ",
					outdated = "|  ",
				},
			},
			autostart = false,
			hide_up_to_date = false,
			hide_unstable_versions = false,
			package_manager = "pnpm"
		})

		local pkg_info_show = function()
			return pkg_info.show({ force = true })
		end

		vim.keymap.set("n", "<leader>ns", pkg_info_show, { silent = true, noremap = true })
		vim.keymap.set("n", "<leader>nd", pkg_info.delete, { silent = true, noremap = true })
		vim.keymap.set("n", "<leader>np", pkg_info.change_version, { silent = true, noremap = true })
		vim.keymap.set("n", "<leader>ni", pkg_info.install, { silent = true, noremap = true })
		vim.keymap.set("n", "<leader>nt", pkg_info.toggle, { silent = true, noremap = true })
		vim.keymap.set("n", "<leader>nu", pkg_info.update, { silent = true, noremap = true })
	end
}
