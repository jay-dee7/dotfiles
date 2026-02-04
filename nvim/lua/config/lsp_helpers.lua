local lsp_helpers = {}

lsp_helpers.on_attach = function(client, bufnr)
	local function buf_set_keymap(binding, cmd)
		local opts = { buffer = bufnr, noremap = true, silent = true }
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
	buf_set_keymap('g[', function()
		vim.diagnostic.jump({
			count = -1,
			on_jump = function()
				vim.diagnostic.open_float({
					cursorpos = true, -- Show float at the cursor position
					scope = "cursor", -- Only show the float for the diagnostic under the cursor
					-- Add other float options as needed
				})
			end
		})
	end)
	buf_set_keymap('g]', function()
		vim.diagnostic.jump({
			count = 1,
			on_jump = function()
				vim.diagnostic.open_float({
					cursorpos = true, -- Show float at the cursor position
					scope = "cursor", -- Only show the float for the diagnostic under the cursor
					-- Add other float options as needed
				})
			end
		})
	end)

	local filetype = vim.api.nvim_buf_get_option(0, 'filetype')

	if filetype == 'rust' then
		-- vim.diagnostic.config({ virtual_text = true, virtual_lines = true, })
		-- if not vim.lsp.inlay_hint.is_enabled() then
		-- 	vim.lsp.inlay_hint.enable(true)
		-- end
		-- vim.lsp.inlay_hint.enable(true);
		buf_set_keymap('gd', vim.lsp.buf.definition)
		buf_set_keymap('gle', vim.lsp.codelens.refresh)
		buf_set_keymap('glr', vim.lsp.codelens.run)
		buf_set_keymap('<leader>rr', ':RustRun<CR>')
		-- buf_set_keymap("ca", "<cmd>lua vim.cmd.RustLsp('codeAction')<CR>")
		buf_set_keymap('K', function() vim.cmd.RustLsp({ 'hover', 'actions' }) end)
		-- buf_set_keymap('n', "K", rust_tools.hover_actions.hover_actions, opts)
		-- buf_set_keymap('n', "ca", rust_tools.code_action_group.code_action_group, opts)
		-- ['textDocument/inlayHint'] = function() end
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

return lsp_helpers
