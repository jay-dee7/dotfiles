return {
	'ellisonleao/gruvbox.nvim',
	lazy = false,
	priority = 1000,
	config = function()
		require('gruvbox').setup({
			terminal_colors = true,
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
			contrast = 'hard', -- can be "hard", "soft" or empty string
			palette_overrides = {
				dark0_hard = '#0f1011',
			},
			overrides = {
				SignColumn = { bg = '#1d2021' },
				['@text.note'] = { bold = true, reverse = false, fg = '', bg = '#213352' },
				['@constant.builtin'] = { link = 'GruvboxPurple' },
			},
			dim_inactive = false,
			transparent_mode = false,
		})
		vim.cmd('colorscheme gruvbox')
	end,
}

-- return {
-- 	"catppuccin/nvim",
-- 	name = "catppuccin",
-- 	priority = 1000,
-- 	config = function()
-- 		require("catppuccin").setup({
-- 			flavour = "mocha", -- latte, frappe, macchiato, mocha
-- 			background = { -- :h background
-- 				dark = "mocha",
-- 			},
-- 			transparent_background = false, -- disables setting the background color.
-- 			show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
-- 			term_colors = false,   -- sets terminal colors (e.g. `g:terminal_color_0`)
-- 			dim_inactive = {
-- 				enabled = false,   -- dims the background color of inactive window
-- 				shade = "dark",
-- 				percentage = 0.15, -- percentage of the shade to apply to the inactive window
-- 			},
-- 			no_italic = false,     -- Force no italic
-- 			no_bold = false,       -- Force no bold
-- 			no_underline = false,  -- Force no underline
-- 			styles = {             -- Handles the styles of general hi groups (see `:h highlight-args`):
-- 				comments = { "italic" }, -- Change the style of comments
-- 				conditionals = { "italic" },
-- 				loops = {},
-- 				functions = {},
-- 				keywords = {},
-- 				strings = {},
-- 				variables = {},
-- 				numbers = {},
-- 				booleans = {},
-- 				properties = {},
-- 				types = {},
-- 				operators = {},
-- 			},
-- 			color_overrides = {
-- 				mocha = {
-- 					-- base = "#151515",
-- 					base = '#07010b',
-- 					-- base = "#000000"
-- 				}
-- 			},
-- 			custom_highlights = function(colors)
-- 				return {
-- 					CmpBorder = { fg = colors.red, bg = colors.teal },
-- 					CmpItemKindSnippet = { fg = colors.base, bg = colors.mauve },
-- 					CmpItemKindKeyword = { fg = colors.base, bg = colors.red },
-- 					CmpItemKindText = { fg = colors.base, bg = colors.teal },
-- 					CmpItemKindMethod = { fg = colors.base, bg = colors.blue },
-- 					CmpItemKindConstructor = { fg = colors.base, bg = colors.blue },
-- 					CmpItemKindFunction = { fg = colors.base, bg = colors.blue },
-- 					CmpItemKindFolder = { fg = colors.base, bg = colors.blue },
-- 					CmpItemKindModule = { fg = colors.base, bg = colors.blue },
-- 					CmpItemKindConstant = { fg = colors.base, bg = colors.peach },
-- 					-- CmpItemKindField = { fg = colors.base, bg = colors.green },
-- 					-- CmpItemKindProperty = { fg = colors.base, bg = colors.green },
-- 					-- CmpItemKindEnum = { fg = colors.base, bg = colors.green },
-- 					-- CmpItemKindUnit = { fg = colors.base, bg = colors.green },
-- 					CmpItemKindClass = { fg = colors.base, bg = colors.yellow },
-- 					-- CmpItemKindVariable = { fg = colors.base, bg = colors.flamingo },
-- 					CmpItemKindFile = { fg = colors.base, bg = colors.blue },
-- 					CmpItemKindInterface = { fg = colors.base, bg = colors.yellow },
-- 					CmpItemKindColor = { fg = colors.base, bg = colors.red },
-- 					CmpItemKindReference = { fg = colors.base, bg = colors.red },
-- 					CmpItemKindEnumMember = { fg = colors.base, bg = colors.red },
-- 					CmpItemKindStruct = { fg = colors.base, bg = colors.blue },
-- 					CmpItemKindValue = { fg = colors.base, bg = colors.peach },
-- 					CmpItemKindEvent = { fg = colors.base, bg = colors.blue },
-- 					CmpItemKindOperator = { fg = colors.base, bg = colors.blue },
-- 					CmpItemKindTypeParameter = { fg = colors.base, bg = colors.blue },
-- 					CmpItemKindCopilot = { fg = colors.base, bg = colors.teal },
-- 				}
-- 			end,
-- 			integrations = {
-- 				cmp = true,
-- 				gitsigns = true,
-- 				treesitter = true,
-- 				harpoon = true,
-- 				mason = true,
-- 				telescope = {
-- 					enabled = true,
-- 				},
-- 				lsp_trouble = true,
-- 			},
-- 		})
--
-- 		-- 		-- Set colorscheme after options
-- 		vim.cmd('colorscheme catppuccin-mocha')
-- 	end
-- }

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
