return {
	"theprimeagen/harpoon",
	branch = 'harpoon2',
	dependencies = {
		{ 'letieu/harpoon-lualine' },
		{ 'nvim-lua/plenary.nvim' },
		{ 'nvim-telescope/telescope.nvim' }
	},
	config = function()
		local harpoon = require("harpoon")
		--
		local telescope_pickers = require("telescope.pickers")
		local telescope_finders = require("telescope.finders")
		local telescope_config = require("telescope.config").values

		local function toggle_telescope(harpoon_files)
			local file_paths = {}
			for _, item in ipairs(harpoon_files.items) do
				table.insert(file_paths, item.value)
			end

			telescope_pickers.new({}, {
				prompt_title = "𓌡",
				finder = telescope_finders.new_table({
					results = file_paths,
				}),
				previewer = telescope_config.file_previewer({}),
				sorter = telescope_config.generic_sorter({}),
			}):find()
		end

		harpoon:setup()

		vim.keymap.set("n", "<leader>ma", function() harpoon:list():add() end)
		vim.keymap.set("n", "<leader>mr", function() harpoon:list():add() end)
		vim.keymap.set("n", "<leader>mra", function() harpoon:list():add() end)

		-- vim.keymap.set("n", "<leader>ms", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
		vim.keymap.set("n", "<leader>ms", function() toggle_telescope(harpoon:list()) end)
		vim.keymap.set("n", "<leader>m1", function() harpoon:list():select(1) end)
		vim.keymap.set("n", "<leader>m2", function() harpoon:list():select(2) end)
		vim.keymap.set("n", "<leader>m3", function() harpoon:list():select(3) end)
		vim.keymap.set("n", "<leader>m4", function() harpoon:list():select(4) end)
		vim.keymap.set("n", "<leader>m5", function() harpoon:list():select(4) end)
	end,
}
