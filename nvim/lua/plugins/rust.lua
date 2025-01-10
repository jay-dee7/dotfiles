return {
	'mrcjkb/rustaceanvim',
	lazy = false,
	config = function()
		local lsp_helpers = require('config/lsp_helpers')
		local rusteacean_config = require('rustaceanvim.config');
		local mason = require('mason-registry');
		local codelldb = mason.get_package('codelldb');
		local extension = codelldb:get_install_path() .. "/extension/";
		local codelldb_path = extension .. "adapter/codelldb"
		local liblldb_path = extension .. "lldb/lib/liblldb.dylib"

		---@diagnostic disable-next-line: duplicate-set-field
		vim.g.rustaceanvim = function()
			return {
				tools = {
					executor = 'toggleterm',
					replace_builtin_hover = true,
				},
				server = {
					on_attach = lsp_helpers.on_attach,
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
				},
				dap = {
					adapter = rusteacean_config.get_codelldb_adapter(codelldb_path, liblldb_path),
				}
			}
		end
	end
}
