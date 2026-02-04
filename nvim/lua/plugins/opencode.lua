return {
	"sudo-tee/opencode.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				anti_conceal = { enabled = false },
				file_types = { 'markdown', 'opencode_output' },
			},
			ft = { 'markdown', 'copilot-chat', 'opencode_output' },
		},
		'saghen/blink.cmp',
		'nvim-telescope/telescope.nvim',
	},
	config = function()
		require("opencode").setup({
			preferred_picker = "telescope",
			preferred_completion = "blink",
			default_mode = "plan",
			keymap_prefix = '<leader>o',
			keymap = {
				input_window = {
					['<C-m>'] = { 'switch_mode' }
				}
			},
			ui = {
				position = 'right',
				input_position = 'bottom',
				window_width = 0.45,
				zoom_width = 0.8,
				input_height = 0.20,
				input = {
					text = {
						wrap = true,
					},
				},
			}
		})

		vim.keymap.set('n', '<leader>om', ':Opencode agent select<CR>', { noremap = true, silent = true })
	end,
}
-- return {
-- 	"NickvanDyke/opencode.nvim",
-- 	dependencies = {
-- 		-- Recommended for `ask()` and `select()`.
-- 		-- Required for `snacks` provider.
-- 		---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
-- 		{ "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
-- 	},
-- 	config = function()
-- 		---@type opencode.Opts
-- 		vim.g.opencode_opts = {
-- 			provider = {
-- 				enabled = "tmux",
-- 				tmux = {
-- 					-- ...
-- 				}
-- 			}
-- 		}
--
-- 		-- Required for `opts.events.reload`.
-- 		vim.o.autoread = true
--
-- 		-- Recommended/example keymaps.
-- 		vim.keymap.set({ "n", "x" }, "<C-a>", function() require("opencode").ask("@this: ", { submit = true }) end,
-- 			{ desc = "Ask opencode…" })
-- 		vim.keymap.set({ "n", "x" }, "<C-x>", function() require("opencode").select() end,
-- 			{ desc = "Execute opencode action…" })
-- 		vim.keymap.set({ "n", "t" }, "<C-.>", function() require("opencode").toggle() end, { desc = "Toggle opencode" })
--
-- 		vim.keymap.set({ "n", "x" }, "go", function() return require("opencode").operator("@this ") end,
-- 			{ desc = "Add range to opencode", expr = true })
-- 		vim.keymap.set("n", "goo", function() return require("opencode").operator("@this ") .. "_" end,
-- 			{ desc = "Add line to opencode", expr = true })
--
-- 		vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end,
-- 			{ desc = "Scroll opencode up" })
-- 		vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end,
-- 			{ desc = "Scroll opencode down" })
--
-- 		-- You may want these if you stick with the opinionated "<C-a>" and "<C-x>" above — otherwise consider "<leader>o…".
-- 		vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
-- 		vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
-- 	end,
--
-- }
