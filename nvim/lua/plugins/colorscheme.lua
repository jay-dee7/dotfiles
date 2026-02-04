-- return {
-- 	'sainnhe/gruvbox-material',
-- 	lazy = false,
-- 	enabled = true,
-- 	priority = 1000,
-- 	config = function()
-- 		vim.g.gruvbox_material_enable_italic = true
-- 		vim.g.gruvbox_material_background = "hard"
--
-- 		vim.cmd('colorscheme gruvbox-material')
-- 	end,
-- }

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
-- 			bold_vert_split = true,
-- 			dim_nc_background = true,
-- 			disable_background = false,
-- 			disable_float_background = false,
-- 			disable_italics = false,
-- 		})
-- 		-- Set colorscheme after options
-- 		vim.cmd('colorscheme rose-pine')
-- 	end,
-- }

-- return {
-- 	'rebelot/kanagawa.nvim',
-- 	config = function()
-- 		local kanagawa = require('kanagawa');
-- 		kanagawa.setup({
-- 			compile = true, -- enable compiling the colorscheme
-- 			undercurl = true, -- enable undercurls
-- 			commentStyle = { italic = true },
-- 			functionStyle = {},
-- 			keywordStyle = { italic = true },
-- 			statementStyle = { bold = true },
-- 			typeStyle = {},
-- 			transparent = false, -- do not set background color
-- 			dimInactive = true, -- dim inactive window `:h hl-NormalNC`
-- 			terminalColors = true, -- define vim.g.terminal_color_{0,17}
-- 			colors = {    -- add/modify theme and palette colors
-- 				palette = {},
-- 				theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
-- 			},
-- 			overrides = function(colors) -- add/modify highlights
-- 				return {}
-- 			end,
-- 			theme = "wave", -- Load "wave" theme
-- 			background = { -- map the value of 'background' option to a theme
-- 				dark = "wave", -- try "dragon" !
-- 				light = "lotus"
-- 			},
-- 		})
-- 		-- Set colorscheme after options
-- 		vim.cmd('colorscheme kanagawa')
-- 	end,
-- }
