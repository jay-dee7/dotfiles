return {
	'saghen/blink.cmp',
	version = 'v0.12.4',
	enalbed = true,
	event = { 'LspAttach' },
	build = 'cargo build --release',
	dependencies = {
		{ 'L3MON4D3/LuaSnip',    version = "v2.*" },
		{ 'saghen/blink.compat', opts = { impersonate_nvim_cmp = true } },
		{
			'windwp/nvim-autopairs',
			event = 'InsertCharPre',
			config = function()
				require('nvim-autopairs').setup()
				-- Integration w/ nvim-cmp
			end,
		},
		{
			"edte/blink-go-import.nvim",
			ft = "go",
			config = function()
				require("blink-go-import").setup()
			end
		}
	},
	opts_extend = { "sources.default", },
	config = function()
		local blink = require('blink.cmp');
		require("luasnip.loaders.from_vscode").lazy_load()

		blink.setup({
			keymap = {
				['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
				['<C-e>'] = { 'hide' },
				['<C-n>'] = { 'select_next', 'fallback' },
				['<C-p>'] = { 'select_prev', 'fallback' },
				['<C-y>'] = { 'select_and_accept' },
				['<CR>'] = { 'accept', 'fallback' },
				['<K>'] = { 'show_documentation', 'hide_documentation' },
				['<C-d>'] = { 'scroll_documentation_up', 'fallback' },
				['<C-f'] = { 'scroll_documentation_down', 'fallback' },
				['<Tab>'] = {
					function(cmp)
						if cmp.snippet_active() then
							return cmp.accept()
						else
							return cmp.select_and_accept()
						end
					end,
					'snippet_forward',
					'fallback'
				},
				['<S-Tab>'] = { 'snippet_backward', 'fallback' },
			},
			snippets = {
				preset = 'luasnip'
			},

			completion = {
				keyword = {
					range = 'prefix',
				},

				list = {
					max_items = 200,
					-- Controls if completion items will be selected automatically,
					-- and whether selection automatically inserts
					-- selection = 'preselect',
					selection = {
						preselect = function(ctx)
							-- return ctx.mode == 'cmdline' and 'auto_insert' or 'preselect'
							return ctx.mode ~= 'cmdline'
						end,
						auto_insert = function(ctx) return ctx.mode == 'cmdline' end,
					},
					-- Controls how the completion items are selected
					-- 'preselect' will automatically select the first item in the completion list
					-- 'manual' will not select any item by default
					-- 'auto_insert' will not select any item by default, and insert the completion items automatically
					-- when selecting them
					--
					-- You may want to bind a key to the `cancel` command, which will undo the selection
					-- when using 'auto_insert'
					cycle = {
						-- When `true`, calling `select_next` at the *bottom* of the completion list
						-- will select the *first* completion item.
						from_bottom = true,
						-- When `true`, calling `select_prev` at the *top* of the completion list
						-- will select the *last* completion item.
						from_top = true,
					},
				},

				accept = {
					-- Create an undo point when accepting a completion item
					create_undo_point = true,
					-- Experimental auto-brackets support
					auto_brackets = {
						-- Whether to auto-insert brackets for functions
						enabled = true,
						-- Default brackets to use for unknown languages
						default_brackets = { '(', ')' },
						-- Overrides the default blocked filetypes
						override_brackets_for_filetypes = {},
						-- Synchronously use the kind of the item to determine if brackets should be added
						kind_resolution = {
							enabled = true,
							-- blocked_filetypes = { 'typescriptreact', 'javascriptreact', 'svelte' },
						},
						-- Asynchronously use semantic token to determine if brackets should be added
						semantic_token_resolution = {
							enabled = true,
							blocked_filetypes = {},
							-- How long to wait for semantic tokens to return before assuming no brackets should be added
							timeout_ms = 400,
						},
					},
				},

				documentation = {
					auto_show = true,
					auto_show_delay_ms = 300,
					treesitter_highlighting = true,
				},

				menu = {
					enabled = true,
					-- Screen coordinates of the command line
					auto_show = function(ctx)
						return ctx.mode ~= "cmdline" or not vim.tbl_contains({ '/', '?' }, vim.fn.getcmdtype())
					end,
					cmdline_position = function()
						if vim.g.ui_cmdline_pos ~= nil then
							local pos = vim.g.ui_cmdline_pos -- (1, 0)-indexed
							return { pos[1] - 1, pos[2] }
						end
						local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
						return { vim.o.lines - height, 0 }
					end,
				}
			},

			signature = {
				enabled = true,
				trigger = {
					blocked_trigger_characters = {},
					blocked_retrigger_characters = {},
					-- When true, will show the signature help window when the cursor comes after a trigger character when entering insert mode
					show_on_insert_on_trigger_character = true,
				},
				window = {
					min_width = 1,
					max_width = 100,
					max_height = 10,
					border = 'padded',
					winblend = 0,
					winhighlight = 'Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder',
					scrollbar = false, -- Note that the gutter will be disabled when border ~= 'none'
					-- Which directions to show the window,
					-- falling back to the next direction when there's not enough space,
					-- or another window is in the way
					direction_priority = { 'n', 's' },
					-- Disable if you run into performance issues
					treesitter_highlighting = true,
				},
			},

			cmdline = {
				enabled = true,
				keymap = nil, -- Inherits from top level `keymap` config when not set
				sources = function()
					return vim.fn.getcmdtype() == ':' and { 'cmdline' } or {}
				end,
				completion = {
					trigger = {
						show_on_blocked_trigger_characters = {},
						show_on_x_blocked_trigger_characters = nil, -- Inherits from top level `completion.trigger.show_on_blocked_trigger_characters` config when not set
					},
					menu = {
						auto_show = nil, -- Inherits from top level `completion.menu.auto_show` config when not set
						draw = {
							columns = { { 'label', 'label_description', gap = 1 } },
						},
					}
				}
			},

			sources = {
				default = { "lsp", "snippets", "go_pkgs", "path", "buffer", "cmdline", },
				-- cmdline = function()
				-- 	return vim.fn.getcmdtype() == ':' and { 'cmdline' } or {}
				-- end,
				transform_items = function(_, items)
					for _, item in ipairs(items) do
						if item.kind == require('blink.cmp.types').CompletionItemKind.Snippet then
							item.score_offset = item.score_offset - 3
						end
					end
					return items
				end,
				providers = {
					-- dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
					-- cmdline = {
					-- 	name = 'cmdline',
					--
					-- 	module = 'blink.cmp.cmdline.sources',
					-- 	max_items = 48,
					-- 	async = false,
					-- 	should_show_items = true,
					-- },
					go_pkgs = {
						module = "blink-go-import",
						name = "Import",
					}
				},
				min_keyword_length = function(ctx)
					-- only applies when typing a command, doesn't apply to arguments
					if ctx.mode == 'cmdline' and string.find(ctx.line, ' ') == nil then return 3 end
					return 0
				end
			},

			appearance = {
				highlight_ns = vim.api.nvim_create_namespace('blink_cmp'),
				use_nvim_cmp_as_default = false,
				nerd_font_variant = 'mono',
				kind_icons = {
					Text = " Text",
					Method = "󰊕 Method",
					Function = "󰊕 Function",
					Constructor = " Constructor",
					Field = "󰇽 Field",
					Variable = "󰂡 Variable",
					Class = "󰜁 Class",
					Interface = " Interface",
					Module = " Module",
					Property = "󰜢 Property",
					Unit = " Unit",
					Value = "󰎠 Value",
					Enum = " Enum",
					Keyword = "󰌋 Keyword",
					Snippet = "󰒕 Snippet",
					Color = "󰏘 Color",
					Reference = " Reference",
					File = " File",
					Folder = "󰉋 Folder",
					EnumMember = " EnumMember",
					Constant = "󰏿 Constant",
					Struct = " Struct",
					Event = " Event",
					Operator = "󰆕 Operator",
					TypeParameter = "󰅲 TypeParameter",
				},
			}
		})
	end
}
