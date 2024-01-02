return {
	'numToStr/Comment.nvim',
	dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
	config = function()
		local ft = require('Comment.ft')
		local ts_commentstring = require('ts_context_commentstring')

		-- we need to disable autocmds
		-- https://github.com/JoosepAlviste/nvim-ts-context-commentstring/wiki/Integrations#plugins-with-a-pre-comment-hook
		ts_commentstring.setup({
			enable_autocmd = false,
		})

		ft.set('svelte', '/*%s*/')
		require('Comment').setup({
			pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
		})
	end
}
