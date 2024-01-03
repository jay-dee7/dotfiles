return {
	'stevearc/conform.nvim',
	event = { 'BufReadPre', 'BufNewFile' },
	config = function()
		local conform = require('conform')

		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				svelte = { "prettierd", "prettier" },
				javascript = { "prettierd", "prettier" },
				typescript = { "prettierd", "prettier" },
				css = { "prettierd", "prettier" },
				scss = { "prettierd", "prettier" },
				json = { "prettierd", "prettier" },
				markdown = { "prettierd", "prettier" },
				proto = { "buf" },
				rust = { "rustfmt" },
				toml = { "taplo" },
				yaml = { "yamlfix" },
				go = { "goimports-reviser", "gofumpt", "gomodifytags" }
			}
		})

		-- Command for manually format
		vim.keymap.set({ "n", "v" }, "<leader>F", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			})
		end, { desc = "format current file" })

		-- Autogroup for auto-formatting
		local formatter_au = vim.api.nvim_create_augroup('auto_formatter', { clear = true })
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
