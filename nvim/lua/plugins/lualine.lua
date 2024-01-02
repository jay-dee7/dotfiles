return {
	'nvim-lualine/lualine.nvim',
	dependencies = {
		'nvim-tree/nvim-web-devicons'
	},
	config = function()
		local lualine = require('lualine')

		local conditions = {
			buffer_not_empty = function()
				return vim.fn.empty(vim.fn.expand '%:t') ~= 1
			end,
			hide_in_width = function()
				return vim.fn.winwidth(0) > 200
			end,
			check_git_workspace = function()
				local filepath = vim.fn.expand '%:p:h'
				local gitdir = vim.fn.finddir('.git', filepath .. ';')
				return gitdir and #gitdir > 0 and #gitdir < #filepath
			end,
		}

		-- Config
		local config = {
			globalstatus = true,
			options = {
				-- Disable sections and component separators
				component_separators = '',
				section_separators = '⚡️',
				theme = 'gruvbox',
				icons_enabled = true,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000
				}
			},
			sections = {
				-- these are to remove the defaults
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
				-- These will be filled later
				lualine_c = {},
				lualine_x = {},
			},
			inactive_sections = {
				-- these are to remove the defaults
				lualine_a = {},
				lualine_v = {},
				lualine_y = {},
				lualine_z = {},
				lualine_c = {},
				lualine_x = {},
			},
			-- extensions = { 'trouble', 'toggleterm', 'mason', 'lazy', 'fugitive' }
		}

		-- Inserts a component in lualine_c at left section
		local function ins_left(component)
			table.insert(config.sections.lualine_c, component)
		end

		-- Inserts a component in lualine_x ot right section
		local function ins_right(component)
			table.insert(config.sections.lualine_x, component)
		end

		ins_left {
			function()
				return '▊'
			end,
			padding = { left = 0, right = 1 }, -- We don't need space before this
		}

		ins_left {
			-- mode component
			function()
				-- auto change color according to neovims mode
				return '🦀'
			end,
			padding = { right = 1 },
		}

		ins_left {
			-- filesize component
			'filesize',
			cond = conditions.buffer_not_empty,
		}
		ins_left {
			'filename',
			cond = conditions.buffer_not_empty,
		}

		ins_left { 'location' }

		ins_left { 'progress' }

		ins_left {
			'diagnostics',
			sources = { 'nvim_diagnostic', 'nvim_lsp', 'nvim_workspace_diagnostic' },
			sections = { 'error', 'warn', 'info', 'hint' },
			symbols = { error = '❌', warn = ' ', info = '🍀', hint = '💡' },
			colored = true,
		}

		-- Insert mid section. You can make any number of sections in neovim :)
		-- for lualine it's any number greater then 2
		ins_left {
			function()
				return '%='
			end,
		}

		ins_left {
			-- Lsp server name .
			function()
				local msg = 'No Active Lsp'
				local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
				local clients = vim.lsp.get_active_clients()
				if next(clients) == nil then
					return msg
				end
				for _, client in ipairs(clients) do
					local filetypes = client.config.filetypes
					if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
						return client.name
					end
				end
				return msg
			end,
			icon = ' LSP:',
			color = { fg = '#ffffff', gui = 'bold' },
		}

		ins_left {
			'searchcount'
		}

		ins_right {
			'filetype',
			cond = conditions.buffer_not_empty,
		}
		-- Add components to right sections
		ins_right {
			'o:encoding', -- option component same as &encoding in viml
			fmt = string.upper, -- I'm not sure why it's upper case either ;)
			cond = conditions.hide_in_width,
		}

		ins_right {
			'fileformat',
			fmt = string.upper,
			icons_enabled = true, -- I think icons are cool but Eviline doesn't have them. sigh
		}

		ins_right {
			'branch',
			icon = '',
		}

		ins_right {
			'diff',
			symbols = { added = ' ', modified = '柳 ', removed = ' ' },
		}

		ins_right {
			function()
				return '▊'
			end,
			padding = { left = 1 },
		}

		lualine.setup(config)
	end
}
