return {
	'mrcjkb/rustaceanvim',
	ft = { 'rust' },
	config = function()
		local lsp_helpers = require('config/lsp_helpers')
		vim.g.rustaceanvim = function()
			return {
				tools = {
					executor = 'toggleterm',
				},
				server = {
					on_attach = function(client, bufnr)
						lsp_helpers.on_attach(client, bufnr)
					end,
					capabilities = lsp_helpers.capabilities,
					default_settings = {
						['rust-analyzer'] = {
							cargo = {
								allFeatures = true,
								loadOutDirsFromCheck = true,
								runBuildScripts = true,
							},
							checkOnSave = {
								allFeatures = true,
								command = "clippy",
								extraArgs = { "--no-deps" },
							},
							procMacro = {
								enable = true,
								ignored = {
									["async-trait"] = { "async_trait" },
									["napi-derive"] = { "napi" },
									["async-recursion"] = { "async_recursion" },
								},
							},
						}
					}
				}
			}
		end
	end
}

