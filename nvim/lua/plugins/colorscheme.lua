return {
	"ellisonleao/gruvbox.nvim",
	lazy = false,
	config = function()
		require("gruvbox").setup({
			undercurl = true,
			underline = true,
			bold = true,
			italic = {
				strings = true,
				operators = true,
				comments = true,
			},
			strikethrough = true,
			invert_selection = false,
			invert_signs = false,
			invert_tabline = false,
			invert_intend_guides = false,
			inverse = true, -- invert background for search, diffs, statuslines and errors
			contrast = "hard", -- can be "hard", "soft" or empty string
			palette_overrides = {
				dark0_hard = "#0f1011"
			},
			overrides = {
				SignColumn = { bg = "#1d2021" },
				["@text.note"] = { bold = true, reverse = false, fg = "", bg = "#213352" },
				["@constant.builtin"] = { link = "GruvboxPurple" },
			},
			dim_inactive = false,
			transparent_mode = false,
		})
		vim.cmd('colorscheme gruvbox')
	end
}

-- return {
-- 	'rose-pine/neovim',
-- 	name = 'rose-pine',
-- 	config = function()
-- 		local rose_pine = require('rose-pine')
-- 		rose_pine.setup({
-- 			--- @usage 'auto'|'main'|'moon'|'dawn'
-- 			variant = 'main',
-- 			--- @usage 'main'|'moon'|'dawn'
-- 			dark_variant = 'main',
-- 			bold_vert_split = false,
-- 			dim_nc_background = true,
-- 			disable_background = false,
-- 			disable_float_background = false,
-- 			disable_italics = false,
--
-- 			--- @usage string hex value or named color from rosepinetheme.com/palette
-- 			groups = {
-- 				background = 'base',
-- 				background_nc = '_experimental_nc',
-- 				panel = 'surface',
-- 				panel_nc = 'base',
-- 				border = 'highlight_med',
-- 				comment = 'muted',
-- 				link = 'iris',
-- 				punctuation = 'subtle',
--
-- 				error = 'love',
-- 				hint = 'iris',
-- 				info = 'foam',
-- 				warn = 'gold',
--
-- 				headings = {
-- 					h1 = 'iris',
-- 					h2 = 'foam',
-- 					h3 = 'rose',
-- 					h4 = 'gold',
-- 					h5 = 'pine',
-- 					h6 = 'foam',
-- 				},
-- 				-- or set all headings at once
-- 				-- headings = 'subtle'
-- 			},
--
-- 			-- Change specific vim highlight groups
-- 			-- https://github.com/rose-pine/neovim/wiki/Recipes
-- 			highlight_groups = {
-- 				ColorColumn = { bg = 'rose' },
--
-- 				-- Blend colours against the "base" background
-- 				CursorLine = { bg = 'foam', blend = 10 },
-- 				StatusLine = { fg = 'love', bg = 'love', blend = 10 },
--
-- 				-- By default each group adds to the existing config.
-- 				-- If you only want to set what is written in this config exactly,
-- 				-- you can set the inherit option:
-- 				Search = { bg = 'gold', inherit = false },
--
-- 				TelescopeBorder = { fg = 'overlay', bg = 'overlay' },
-- 				TelescopeNormal = { fg = 'subtle', bg = 'overlay' },
-- 				TelescopeSelection = { fg = 'text', bg = 'highlight_med' },
-- 				TelescopeSelectionCaret = { fg = 'love', bg = 'highlight_med' },
-- 				TelescopeMultiSelection = { fg = 'text', bg = 'highlight_high' },
--
-- 				TelescopeTitle = { fg = 'base', bg = 'love' },
-- 				TelescopePromptTitle = { fg = 'base', bg = 'pine' },
-- 				TelescopePreviewTitle = { fg = 'base', bg = 'iris' },
--
-- 				TelescopePromptNormal = { fg = 'text', bg = 'surface' },
-- 				TelescopePromptBorder = { fg = 'surface', bg = 'surface' },
-- 			},
-- 		})
--
-- 		-- Set colorscheme after options
-- 		vim.cmd('colorscheme rose-pine')
-- 	end,
-- }
