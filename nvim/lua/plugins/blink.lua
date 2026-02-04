return {
	'saghen/blink.cmp',
	event = { 'LspAttach' },
	enabled = true,
	build = 'cargo build --release',
	dependencies = {
		-- 'saghen/blink.indent',
		{ 'L3MON4D3/LuaSnip', version = 'v2.*' },
		{
			'windwp/nvim-autopairs',
			event = 'InsertEnter',
			config = function()
				require('nvim-autopairs').setup()
			end,
		},
		-- {
		-- 	'edte/blink-go-import.nvim',
		-- 	ft = 'go',
		-- 	config = function()
		-- 		require('blink-go-import').setup()
		-- 	end,
		-- },
	},
	opts_extend = { 'sources.default' },
	config = function()
		require('luasnip.loaders.from_vscode').lazy_load()

		local opts = {
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
					'fallback',
				},
				['<S-Tab>'] = { 'snippet_backward', 'fallback' },
			},
			appearance = {
				nerd_font_variant = 'mono'
			},
			signature = { enabled = true },
			snippets = {
				preset = 'luasnip',
			},
			-- completion = {
			-- 	documentation = {
			-- 		auto_show = true,
			-- 		auto_show_delay_ms = 100,
			-- 		treesitter_highlighting = true,
			-- 	},
			-- },
			sources = {
				-- default = { 'lsp', 'snippets', 'go_pkgs', 'buffer', 'path', 'cmdline', },
				default = { 'lsp', 'snippets', 'buffer', 'path', 'cmdline', },
				-- providers = {
				-- 	go_pkgs = {
				-- 		module = 'blink-go-import',
				-- 		name = 'Import',
				-- 	},
				-- },
			},
			fuzzy = { implementation = 'prefer_rust_with_warning' },
		}

		require("blink.cmp").setup(opts)
	end,
}
