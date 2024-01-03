require('config/auto-format')
local lsp_helpers = require('config/lsp_helpers')
local lsp_utils = require('lspconfig.util')
local nvim_lsp = require('lspconfig')
local typescript = require('typescript-tools')

require('lspconfig.configs').postgres_lsp = {
	default_config = {
		name = 'postgres_lsp',
		cmd = { 'postgres_lsp' },
		filetypes = { 'sql' },
		single_file_support = true,
		root_dir = lsp_utils.root_pattern('root-file.txt'),
	},
}

nvim_lsp.postgres_lsp.setup({ { force_setup = true } })

local cap = vim.lsp.protocol.make_client_capabilities()
cap.textDocument.completion.completionItem.snippetSupport = true
cap.textDocument.completion.completionItem.resolveSupport = {
	properties = {
		'documentation',
		'detail',
		'additionalTextEdits',
	},
}
cap.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}
local capabilities = require('cmp_nvim_lsp').default_capabilities(cap)

nvim_lsp.gopls.setup({
	on_attach = lsp_helpers.on_attach,
	capabilities = capabilities,
	cmd = { 'gopls', 'serve' },
	hint = true,
	settings = {
		hint = true,
		gopls = {
			gofumpt = true,
			codelenses = {
				gc_details = true,
				tidy = true,
				generate = true,
				upgrade_dependency = true,
				vendor = false,
			},
			linkTarget = 'pkg.go.dev',
			usePlaceholders = true,
			hoverKind = 'FullDocumentation',
			diagnosticsDelay = '200ms',
			analyses = {
				unusedparams = true,
				fieldalignment = true,
				nilness = true,
				shadow = true,
				unusedwrite = true,
			},
			staticcheck = true,
			annotations = {
				bounds = true,
				escape = true,
				inline = true,
			},
		},
	},
})

require('rust-tools').setup({
	tools = {
		snippet_func = function(edits, bufnr, offset_encoding, old_func)
			old_func(edits, bufnr, offset_encoding)
		end,
		executor = require('rust-tools/executors').termopen, -- can be quickfix or termopen
		reload_workspace_from_cargo_toml = true,
		runnables = {
			use_telescope = true,
		},
		inlay_hints = {
			auto = true,
			only_current_line = false,
			show_parameter_hints = true,
			parameter_hints_prefix = '<-',
			other_hints_prefix = '=>',
			max_len_align = false,
			max_len_align_padding = 1,
			right_align = false,
			right_align_padding = 7,
			highlight = 'Comment',
		},
		hover_actions = {
			border = 'rounded',
		},
	},
	server = {
		standalone = true,
		on_attach = function(client, bufnr)
			lsp_helpers.on_attach(client, bufnr)
			local rt = require('rust-tools')
			vim.keymap.set('n', 'K', rt.hover_actions.hover_actions, { buffer = bufnr })
		end,
		capabilities = capabilities,
		settings = {
			['rust-analyzer'] = {
				lens = {
					enable = true,
				},
				checkOnSave = {
					command = 'clippy',
				},
				check = {
					enable = true,
					command = 'clippy',
				},
			},
		},
	},
})

nvim_lsp.jsonls.setup({
	on_attach = lsp_helpers.on_attach,
	commands = {
		Format = {
			function()
				vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line('$'), 0 })
			end,
		},
	},
})

typescript.setup({
	on_attach = lsp_helpers.on_attach,
	settings = {
		separate_diagnostic_server = true,
		publish_diagnostic_on = 'insert_leave',
		expose_as_code_action = {
			'fix_all',
			'add_missing_imports',
			'remove_unused',
			'remove_unused_imports',
			'organize_imports',
		},
		tsserver_path = nil,
		tsserver_plugins = {},
		tsserver_max_memory = 'auto',
		tsserver_format_options = {
			allowIncompleteCompletions = false,
			allowRenameOfImportPath = false,
			semicolons = 'insert',
		},
		tsserver_file_preferences = {
			includeInlayParameterNameHints = 'all', -- "none" | "literals" | "all";
			includeInlayParameterNameHintsWhenArgumentMatchesName = true,
			includeInlayFunctionParameterTypeHints = true,
			includeInlayVariableTypeHints = true,
			includeInlayVariableTypeHintsWhenTypeMatchesName = true,
			includeInlayPropertyDeclarationTypeHints = true,
			includeInlayFunctionLikeReturnTypeHints = true,
			includeInlayEnumMemberValueHints = true,
			includeCompletionsForModuleExports = true,
			quotePreference = 'auto',
		},
		-- https://github.com/microsoft/TypeScript/blob/3c221fc086be52b19801f6e8d82596d04607ede6/src/compiler/utilitiesPublic.ts#L620
		tsserver_locale = 'en',
		complete_function_calls = false,
		include_completions_with_insert_text = true,
		code_lens = 'off',
		disable_member_code_lens = true,
		jsx_close_tag = {
			enable = true,
			filetypes = { 'javascriptreact', 'typescriptreact', 'svelte' },
		},
	},
})

nvim_lsp.svelte.setup({
	on_attach = lsp_helpers.on_attach,
	capabilities = capabilities,
	settings = {
		svelte = {
			plugin = {
				html = {
					completions = { enable = true, emmet = false },
					tag_complete = { enable = true },
				},
				svelte = {
					completions = { enable = true, emmet = false },
					default_script_language = 'typescript',
				},
				css = {
					completions = { enable = true, emmet = false },
				},
			},
		},
	},
})

nvim_lsp.vuels.setup({
	on_attach = lsp_helpers.on_attach,
	capabilities = capabilities,
})

nvim_lsp.graphql.setup({
	on_attach = lsp_helpers.on_attach,
	capabilities = capabilities,
})

nvim_lsp.eslint.setup({
	on_attach = lsp_helpers.on_attach,
	capabilities = capabilities,
})

nvim_lsp.lua_ls.setup({
	on_attach = lsp_helpers.on_attach,
	capabilities = capabilities,
	settings = lsp_helpers.settings.lua_ls,
})

nvim_lsp.yamlls.setup({
	on_attach = lsp_helpers.on_attach,
	capabilities = capabilities,
	settings = lsp_helpers.settings.yaml_ls,
})
nvim_lsp.bufls.setup({
	on_attach = lsp_helpers.on_attach,
	capabilities = capabilities,
})

nvim_lsp.prismals.setup({
	on_attach = lsp_helpers.on_attach,
	capabilities = capabilities,
})

nvim_lsp.sqlls.setup({
	on_attach = lsp_helpers.on_attach,
	capabilities = capabilities,
})

nvim_lsp.pyright.setup({
	on_attach = lsp_helpers.on_attach,
	capabilities = capabilities,
})

nvim_lsp.taplo.setup({
	on_attach = lsp_helpers.on_attach,
	capabilities = capabilities,
})

nvim_lsp.clangd.setup({
	on_attach = lsp_helpers.on_attach,
	capabilities = capabilities,
})

nvim_lsp.zls.setup({
	on_attach = lsp_helpers.on_attach,
	capabilities = capabilities,
})

nvim_lsp.terraformls.setup({
	on_attach = lsp_helpers.on_attach,
	capabilities = capabilities,
})

nvim_lsp.cssls.setup({
	on_attach = lsp_helpers.on_attach,
	capabilities = capabilities,
})

nvim_lsp.tailwindcss.setup({
	on_attach = lsp_helpers.on_attach,
	capabilities = capabilities,
})
