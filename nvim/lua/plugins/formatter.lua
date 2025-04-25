return {
	'stevearc/conform.nvim',
	event = { 'BufReadPre', 'BufNewFile', 'BufWritePre' },
	config = function()
		local conform = require('conform')

		conform.setup({
			notify_on_error = true,
			formatters_by_ft = {
				lua = { "stylua" },
				svelte = { "prettierd", "prettier", stop_after_first = true },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				css = { "prettierd", "prettier", stop_after_first = true },
				scss = { "prettierd", "prettier", stop_after_first = true },
				json = { "prettierd", "prettier", stop_after_first = true },
				markdown = { "prettierd", "prettier", stop_after_first = true },
				proto = { "buf" },
				rust = { "rustfmt" },
				toml = { "taplo" },
				yaml = { "yamlfmt" },
				go = { "goimports-reviser", "gofumpt", "gomodifytags", "goimports", stop_after_first = false, timeout_ms = 15000 },
				zig = { "zigfmt", timeout_ms = 15000, lsp_format = "last" }
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
		})

		-- Command for manually format
		vim.keymap.set({ "n", "v" }, "<leader>F",
			function() conform.format({ lsp_fallback = true, async = true, timeout_ms = 1000, }) end,
			{ desc = "format current file" })

		vim.keymap.set({ "n", "v" }, "<leader>FL", function() print(vim.inspect(conform.list_formatters(0))) end,
			{ desc = "format current file" })
		-- Autogroup for auto-formatting
		local formatter_au = vim.api.nvim_create_augroup('auto_formatter_au', { clear = true })
		vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
			group    = formatter_au,
			callback = function()
				conform.format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 750,
				})
			end
		})
	end
}
