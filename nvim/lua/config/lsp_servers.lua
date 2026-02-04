local lsp_helpers = require('config/lsp_helpers')
local typescript = require('typescript-tools')

vim.lsp.enable({
	"gopls",
	"golangci_lint_ls",
	"lua_ls",
	"zls",
	"svelte",
	"eslint",
	"jsonls",
	"yamlls",
	"buf_ls",
	"sqlls",
	"pyright",
	"taplo",
	"clangd",
	"zls",
	"terraformls",
	"cssls",
	"tailwindcss",
	"biome",
})

typescript.setup({
	on_attach = lsp_helpers.on_attach,
	filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact', 'jsx', 'tsx' },

	settings = {
		separate_diagnostic_server = true,
		publish_diagnostic_on = 'insert_leave', -- other options -> 'insert_leave' | 'change'
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
			enable = false,
			filetypes = { 'svelte' },
		},
	},
})

local on_attach = function(event)
	local function buf_set_keymap(binding, cmd)
		local opts = { buffer = event.buf, noremap = true, silent = true }
		vim.keymap.set("n", binding, cmd, opts)
		-- vim.api.nvim_buf_set_keymap(event.buf, 'n', binding, cmd, opts)
	end

	buf_set_keymap('gd', vim.lsp.buf.definition)
	buf_set_keymap('K', vim.lsp.buf.hover)
	buf_set_keymap('gi', vim.lsp.buf.implementation)
	buf_set_keymap('<c-k>', vim.lsp.buf.signature_help)
	buf_set_keymap('1gd', vim.lsp.buf.type_definition)
	buf_set_keymap('gr', vim.lsp.buf.references)
	buf_set_keymap('ca', vim.lsp.buf.code_action)
	buf_set_keymap('g0', vim.lsp.buf.document_symbol)
	buf_set_keymap('gW', vim.lsp.buf.workspace_symbol)
	buf_set_keymap('gD', vim.lsp.buf.declaration)
	buf_set_keymap('rn', vim.lsp.buf.rename)
	buf_set_keymap('FF', vim.lsp.buf.format)
	-- buf_set_keymap('gld', '<cmd>lua lsp_ext.workspace.diagnostic").set_qf_list()<CR>')
	--- " Show diagnostic popup on cursor hold
	--- " Goto previous/next diagnostic warning/error
	--- " have a fixed column for the diagnostics to appear in
	--- " this removes the jitter when warnings/errors flow in
	buf_set_keymap('g[', function() vim.diagnostic.jump({ count = -1, float = true }) end)
	buf_set_keymap('g]', function() vim.diagnostic.jump({ count = 1, float = true }) end)

	local filetype = vim.api.nvim_buf_get_option(0, 'filetype')

	if filetype == 'rust' then
		-- vim.diagnostic.config({ virtual_text = true, virtual_lines = true, })
		if not vim.lsp.inlay_hint.is_enabled() then
			vim.lsp.inlay_hint.enable(true)
		end
		-- vim.lsp.inlay_hint.enable(true);
		buf_set_keymap('gle', vim.lsp.codelens.refresh)
		buf_set_keymap('glr', vim.lsp.codelens.run)
		buf_set_keymap('<leader>rr', ':RustRun<CR>')
		-- buf_set_keymap("ca", "<cmd>lua vim.cmd.RustLsp('codeAction')<CR>")
		buf_set_keymap('K', function() vim.cmd.RustLsp({ 'hover', 'actions' }) end)
		-- buf_set_keymap('n', "K", rust_tools.hover_actions.hover_actions, opts)
		-- buf_set_keymap('n', "ca", rust_tools.code_action_group.code_action_group, opts)
	end
	if filetype == 'go' then
		-- vim.cmd [[autocmd BufWritePre <buffer> :lua require('config.helpers').goimports(2000)]]
		vim.cmd(
			[[autocmd BufEnter,BufNewFile,BufRead <buffer> map <buffer> <leader>fs <cmd>lua require('telescope.builtin').lsp_workspace_symbols { query = vim.fn.input("Query: ") }<cr>]]
		)
	end

	local ts_js_ecosystem_ft = filetype == 'typescriptreact'
		or filetype == 'typescript'
		or filetype == 'jsx'
		or filetype == 'tsx'
		or filetype == 'js'
		or filetype == 'ts'
		or filetype == 'javascriptreact'
		or filetype == 'javascript'
		or filetype == 'javascrip.jsx'
		or filetype == 'typescript.tsx'
		or filetype == 'vue'
		or filetype == 'astro'

	if ts_js_ecosystem_ft then
		-- client.server_capabilities.document_formatting = true
		buf_set_keymap('gO', ':TSToolsAddMissingImports<CR>')
		buf_set_keymap('fa', ':TSToolsFixAll<CR>')
		buf_set_keymap('ru', ':TSToolsRemoveUnusedImports<CR>')
		buf_set_keymap('rf', ':TSToolsRenameFile<CR>')
		buf_set_keymap('gD', ':TSToolsGoToSourceDefinition<CR>')
	end

	-- 300ms of no cursor movement to trigger CursorHold
	vim.cmd([[set updatetime=100]])
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = on_attach,
})
