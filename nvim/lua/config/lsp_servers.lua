require('config/auto-format')
local eslint = require('efmls-configs.linters.eslint')
local lsp_helpers = require('config/lsp_helpers')
local lsp_utils = require('lspconfig.util')
local nvim_lsp = require('lspconfig')
local prettier = require('efmls-configs.formatters.prettier')
local stylua = require('efmls-configs.formatters.stylua')
-- local typescript = require('typescript')
local typescript = require("typescript-tools")

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

-- nvim_lsp.rust_analyzer.setup({
--     on_attach = lsp_helpers.on_attach,
--     capabilities = capabilities,
--     cmd = {
--         "rust-analyzer"
--     },
--     settings = {
--         ["rust-analyzer"] = {
--
--         }
--     }
-- })

nvim_lsp.zls.setup({
	on_attach = lsp_helpers.on_attach,
	capabilities = capabilities,
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

nvim_lsp.terraformls.setup({
	on_attach = lsp_helpers.on_attach,
	capabilities = capabilities,
})

nvim_lsp.cssls.setup({
	on_attach = lsp_helpers.on_attach,
	capabilities = capabilities,
})

typescript.setup({
	on_attach = lsp_helpers.on_attach,
	settings = {
		separate_diagnostic_server = true,
		publish_diagnostic_on = "insert_leave",
		expose_as_code_action = {
			"fix_all", "add_missing_imports", "remove_unused", "remove_unused_imports", "organize_imports"
		},
		tsserver_path = nil,
		-- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
		-- (see 💅 `styled-components` support section)
		tsserver_plugins = {},
		tsserver_max_memory = "auto",
		tsserver_format_options = {
			allowIncompleteCompletions = false,
			allowRenameOfImportPath = false,

			-- insertSpaceAfterCommaDelimiter = true,
			-- insertSpaceAfterSemicolonInForStatements = true,
			-- insertSpaceBeforeAndAfterBinaryOperators = true,
			-- insertSpaceAfterConstructor = true,
			-- insertSpaceAfterKeywordsInControlFlowStatements = true,
			-- insertSpaceAfterFunctionKeywordForAnonymousFunctions = true,
			-- insertSpaceAfterOpeningAndBeforeClosingEmptyBraces = true,
			-- insertSpaceAfterOpeningAndBeforeClosingNonemptyParenthesis = true,
			-- insertSpaceAfterOpeningAndBeforeClosingNonemptyBrackets = true,
			-- insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces = true,
			-- insertSpaceAfterOpeningAndBeforeClosingTemplateStringBraces = true,
			-- insertSpaceAfterOpeningAndBeforeClosingJsxExpressionBraces = true,
			-- insertSpaceAfterTypeAssertion = true,
			-- insertSpaceBeforeFunctionParenthesis = true,
			-- placeOpenBraceOnNewLineForFunctions = true,
			-- placeOpenBraceOnNewLineForControlBlocks = true,
			-- insertSpaceBeforeTypeAnnotation = true,
			semicolons = "insert",
		},
		tsserver_file_preferences = {
			includeInlayParameterNameHints = "all", -- "none" | "literals" | "all";
			includeInlayParameterNameHintsWhenArgumentMatchesName = true,
			includeInlayFunctionParameterTypeHints = true,
			includeInlayVariableTypeHints = true,
			includeInlayVariableTypeHintsWhenTypeMatchesName = true,
			includeInlayPropertyDeclarationTypeHints = true,
			includeInlayFunctionLikeReturnTypeHints = true,
			includeInlayEnumMemberValueHints = true,
			includeCompletionsForModuleExports = true,
			quotePreference = "auto",
		},
		-- https://github.com/microsoft/TypeScript/blob/3c221fc086be52b19801f6e8d82596d04607ede6/src/compiler/utilitiesPublic.ts#L620
		tsserver_locale = "en",
		complete_function_calls = false,
		include_completions_with_insert_text = true,
		-- CodeLens
		-- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
		-- possible values: ("off"|"all"|"implementations_only"|"references_only")
		code_lens = "off",
		-- by default code lenses are displayed on all referencable values and for some of you it can
		-- be too much this option reduce count of them by removing member references from lenses
		disable_member_code_lens = true,
		-- JSXCloseTag
		-- WARNING: it is disabled by default (maybe you configuration or distro already uses nvim-auto-tag,
		-- that maybe have a conflict if enable this feature. )
		jsx_close_tag = {
			enable = true,
			filetypes = { "javascriptreact", "typescriptreact", "svelte" },
		}
	},
})

nvim_lsp.tailwindcss.setup({
	on_attach = lsp_helpers.on_attach,
	capabilities = capabilities,
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


-- nvim_lsp.biome.setup({
--
-- })

local formatting_langs = {
	typescript = { eslint, prettier },
	javascript = { eslint, prettier },
	svelte = { eslint, prettier },
	lua = { stylua },
}

local efmls_config = {
	filetypes = vim.tbl_keys(formatting_langs),
	settings = {
		rootMarkers = { '.git/' },
		languages = formatting_langs,
	},
	init_options = {
		documentFormatting = true,
		documentRangeFormatting = true,
	},
}

nvim_lsp.efm.setup(vim.tbl_extend('force', efmls_config, {
	on_attach = lsp_helpers.on_attach,
	capabilities = capabilities,
}))
