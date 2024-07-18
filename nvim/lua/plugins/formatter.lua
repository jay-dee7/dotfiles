return {
	'stevearc/conform.nvim',
	event = { 'BufReadPre', 'BufNewFile', 'BufWritePre' },
	config = function()
		local conform = require('conform')

		conform.setup({
			notify_on_error = true,
			formatters_by_ft = {
				lua = { "stylua" },
				-- svelte = { { "prettierd", "prettier" } },
				javascript = { { "prettierd", "prettier" } },
				typescript = { { "prettierd", "prettier" } },
				css = { { "prettierd", "prettier" } },
				scss = { { "prettierd", "prettier" } },
				-- json = { { "prettierd", "prettier" } },
				-- markdown = { { "prettierd", "prettier" } },
				proto = { "buf" },
				rust = { "rustfmt" },
				toml = { "taplo" },
				yaml = { "yamlfix" },
				go = { "goimports-reviser", "gofumpt", "gomodifytags" },
				zig = { "zigfmt" }
			}
		})

		-- Command for manually format
		vim.keymap.set({ "n", "v" }, "<leader>F",
			function() conform.format({ lsp_fallback = true, async = true, timeout_ms = 5000, }) end,
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
					timeout_ms = 500,
				})
			end
		})
	end
}
