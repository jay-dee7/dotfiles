local lsp_helpers = {}
lsp_helpers.on_attach = function(client, bufnr)
	local function buf_set_keymap(binding, cmd)
		local opts = { noremap = true, silent = true }
		vim.api.nvim_buf_set_keymap(bufnr, "n", binding, cmd, opts)
	end

	buf_set_keymap("gd", '<cmd>lua vim.lsp.buf.definition()<CR>')
	buf_set_keymap("K", '<cmd>lua vim.lsp.buf.hover()<CR>')
	buf_set_keymap("gi", '<cmd>lua vim.lsp.buf.implementation()<CR>')
	buf_set_keymap("<c-k>", '<cmd>lua vim.lsp.buf.signature_help()<CR>')
	buf_set_keymap("1gd", '<cmd>lua vim.lsp.buf.type_definition()<CR>')
	buf_set_keymap("gr", '<cmd>lua vim.lsp.buf.references()<CR>')
	buf_set_keymap("ca", '<cmd>lua vim.lsp.buf.code_action()<CR>')
	buf_set_keymap("g0", '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
	buf_set_keymap("gW", '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
	buf_set_keymap("gD", '<cmd>lua vim.lsp.buf.declaration()<CR>')
	buf_set_keymap("rn", '<cmd>lua vim.lsp.buf.rename()<CR>')
	buf_set_keymap("FF", '<cmd>lua vim.lsp.buf.format()<CR>')
	buf_set_keymap("gld", '<cmd>lua lsp_ext.workspace.diagnostic").set_qf_list()<CR>')
	--- " Show diagnostic popup on cursor hold
	--- " Goto previous/next diagnostic warning/error
	--- " have a fixed column for the diagnostics to appear in
	--- " this removes the jitter when warnings/errors flow in
	buf_set_keymap("g[", '<cmd>lua vim.diagnostic.goto_prev()<CR>')
	buf_set_keymap("g]", '<cmd>lua vim.diagnostic.goto_next()<CR>')

	local filetype = vim.api.nvim_buf_get_option(0, 'filetype')

	if filetype == 'rust' then
		buf_set_keymap("gle", "<cmd>lua vim.lsp.codelens.refresh()<CR>")
		buf_set_keymap("glr", "<cmd>lua vim.lsp.codelens.run()<CR>")
		buf_set_keymap("<leader>rr", ":RustRun<CR>")
		-- buf_set_keymap('n', "K", rust_tools.hover_actions.hover_actions, opts)
		-- buf_set_keymap('n', "ca", rust_tools.code_action_group.code_action_group, opts)
	end
	if filetype == 'go' then
		-- vim.cmd [[autocmd BufWritePre <buffer> :lua require('config.helpers').goimports(2000)]]
		vim.cmd [[autocmd BufEnter,BufNewFile,BufRead <buffer> map <buffer> <leader>fs <cmd>lua require('telescope.builtin').lsp_workspace_symbols { query = vim.fn.input("Query: ") }<cr>]]
	end

	if filetype == 'typescriptreact'
		or filetype == 'typescript'
		or filetype == 'jsx'
		or filetype == 'tsx'
		or filetype == 'js'
		or filetype == 'ts'
		or filetype == 'javascriptreact'
		or filetype == "javascript"
		or filetype == "javascrip.jsx"
		or filetype == "typescript.tsx"
		or filetype == "vue"
		or filetype == "astro" then
		client.server_capabilities.document_formatting = true
		buf_set_keymap("gO", '<cmd>lua require("typescript").actions.addMissingImports()<CR>')
		buf_set_keymap("gm", '<cmd>TSLspImportAll<CR>')
		buf_set_keymap("fa", '<cmd>require("typescript").actions.fixAll()<CR>')
		buf_set_keymap("ru", '<cmd>lua require("typescript").actions.removeUnused()<CR>')
		buf_set_keymap("rf", ':TypescriptRenameFile<CR>')
		buf_set_keymap("gd", ':TypescriptGoToSourceDefinition<CR>')
		buf_set_keymap("FF", ':PrettierAsync<CR>')

		vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
			vim.lsp.diagnostic.on_publish_diagnostics,
			{
				underline = true,
				virtual_text = {
					spacing = 5,
					severity_limit = 'Warning',
				},
				update_in_insert = true,
			})
	end

	-- vim.cmd [[autocmd CursorHold <buffer> lua vim.diagnostic.open_float()]]
	-- 300ms of no cursor movement to trigger CursorHold
	vim.cmd [[set updatetime=100]]
	-- vim.cmd [[set signcolumn=yes]]
end

lsp_helpers.settings = {
	lua_ls = {
		Lua = {
			diagnostics = {
				globals = {
					-- vim
					"vim",
					"hs",

					-- Busted
					"describe",
					"it",
					"before_each",
					"after_each",
					"teardown",
					"pending",
					"clear",

					-- Colorbuddy
					"Color",
					"c",
					"Group",
					"g",
					"s",

					-- Custom
					"RELOAD",
				},
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = {
					vim.api.nvim_get_runtime_file("", true),
					string.format('%s/.hammerspoon/Spoons/EmmyLua.spoon/annotations', os.getenv 'HOME'),
				}
			},
		},
	},
	yaml_ls = {
		yaml = {
			keyOrdering = false
		}
	}
}

return lsp_helpers
