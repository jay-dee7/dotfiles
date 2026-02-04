return {
	'mrcjkb/rustaceanvim',
	lazy = false,
	dependencies = {
		'saecki/crates.nvim',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'chrisgrieser/nvim-lsp-endhints',
		},
	},
	config = function()
		local crates = require('crates')
		local lsp_helpers = require('config/lsp_helpers')
		local rusteacean_config = require('rustaceanvim.config')
		local extension = vim.env.HOME .. '/.local/share/nvim/mason/packages/codelldb/extension/'
		local codelldb_path = extension .. 'adapter/codelldb'
		local liblldb_path = extension .. 'lldb/lib/liblldb.dylib'
		local endhints = require("lsp-endhints");

		endhints.setup({
			icons = {
				type = "󰜁 ",
				parameter = "󰏪 ",
				offspec = " ", -- hint kind not defined in official LSP spec
				unknown = "? ", -- hint kind is nil
			},
			label = {
				truncateAtChars = 40,
				padding = 1,
				marginLeft = 0,
				sameKindSeparator = ", ",
			},
			extmark = {
				priority = 50,
			},
			autoEnableHints = false,
		});

		vim.g.rustaceanvim = function()
			local rustacean_opts = {
				tools = {
					executor = 'toggleterm',
					replace_builtin_hover = true,
				},
				server = {
					on_attach = lsp_helpers.on_attach,
					capabilities = require('blink.cmp').get_lsp_capabilities(),
					default_settings = {
						['rust-analyzer'] = {
							cargo = {
								allFeatures = true,
								loadOutDirsFromCheck = true,
								runBuildScripts = true,
							},
							check = {
								command = 'clippy',
							},
							diagnostics = {
								experimental = {
									enable = true,
								}
							},
							procMacro = {
								enable = true,
							},
							inlayHints = {
								enable = true,
								bindingModeHints = { enable = false },
								chainingHints = { enable = false },
								lifetimeElisionHints = {
									enable = true,
									useParameterNames = true,
								},
							},
						},
					},
				},
				dap = {
					adapter = rusteacean_config.get_codelldb_adapter(codelldb_path, liblldb_path),
				},
			}
			return rustacean_opts
		end

		crates.setup()
	end,
}
