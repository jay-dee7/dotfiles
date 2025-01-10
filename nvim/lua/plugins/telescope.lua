return {
	'nvim-telescope/telescope.nvim',
	dependencies = {
		{ 'nvim-lua/plenary.nvim' },
		{ 'nvim-lua/popup.nvim' },
		{ 'nvim-telescope/telescope-github.nvim' },
		{ 'nvim-telescope/telescope-project.nvim' },
		{ 'nvim-telescope/telescope-ui-select.nvim' },
		{ 'nvim-telescope/telescope-rg.nvim' },
		{ 'nvim-telescope/telescope-file-browser.nvim' },
		{ 'nvim-telescope/telescope-dap.nvim' },
		{ 'nvim-telescope/telescope-live-grep-args.nvim' },
		-- { 'nvim-telescope/telescope-fzf-native.nvim',    build = 'make' },
		{ 'imNel/monorepo.nvim' },
		{ 'ThePrimeagen/git-worktree.nvim' },
		{ 'natecraddock/telescope-zf-native.nvim' }
	},
	config = function()
		local builtin = require('telescope.builtin')
		local lga_actions = require('telescope-live-grep-args.actions')
		local sorters = require('telescope.sorters')
		local previewers = require('telescope.previewers')
		local trouble = require('trouble.sources.telescope')
		local actions = require('telescope.actions')
		local extensions = require('telescope').extensions
		local telescope = require('telescope')
		local fb_actions = extensions.file_browser.actions
		local monorepo = require('monorepo')

		telescope.setup({
			defaults = {
				mappings = {
					i = {
						['<esc>'] = actions.close,
						['<c-t>'] = trouble.open,
					},
					n = {
						['<c-t>'] = trouble.open,
					},
				},
				vimgrep_arguments = {
					'rg',
					'--color=never',
					'--no-heading',
					'--with-filename',
					'--line-number',
					'--column',
					'--smart-case',
					'--no-binary',
					'--no-hidden',
				},
				prompt_prefix = '➜ ',
				selection_carett = ' ',
				entry_prefix = ' ',
				initial_mode = 'insert',
				selection_strategy = 'row',
				sorting_strategy = 'ascending',
				layout_strategy = 'vertical',
				layout_config = {
					vertical = {
						width = 0.85,
						height = 0.75,
						prompt_position = "bottom",
						mirror = false,
						preview_width = 1,
						preview_height = 0.7,
						preview_cutoff = 50,
					},

					horizontal = {
						mirror = false,
						width = 0.90,
						height = 0.75,
						preview_height = 0.7,
						preview_width = 0.6,
						prompt_position = 'top',
						preview_cutoff = 120,
					},
				},
				file_ignore_patterns = { '.idea/*', 'cpu.pprof', '*.prof', '.kvstore', 'vendor', 'node_modules', },
				winblend = 0,
				-- border = {},
				-- borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
				color_devicons = true,
				use_less = false,
				set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
				file_sorter = sorters.get_fzy_sorter,
				generic_sorter = sorters.get_generic_fuzzy_sorter,
				file_previewer = previewers.vim_buffer_cat.new,
				grep_previewer = previewers.vim_buffer_vimgrep.new,
				qflist_previewer = previewers.vim_buffer_qflist.new,
				buffer_previewer_maker = previewers.buffer_previewer_maker,
			},
			extensions = {
				-- fzf = {
				-- 	fuzzy = true,    -- false will only do exact matching
				-- 	override_generic_sorter = true, -- override the generic sorter
				-- 	override_file_sorter = true, -- override the file sorter
				-- 	case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
				-- },
				["zf-native"] = {
					-- options for sorting file-like items
					file = {
						-- override default telescope file sorter
						enable = true,

						-- highlight matching text in results
						highlight_results = true,

						-- enable zf filename match priority
						match_filename = true,

						-- optional function to define a sort order when the query is empty
						initial_sort = nil,

						-- set to false to enable case sensitive matching
						smart_case = true,
					},

					-- options for sorting all other items
					generic = {
						-- override default telescope generic item sorter
						enable = true,

						-- highlight matching text in results
						highlight_results = true,

						-- disable zf filename match priority
						match_filename = false,

						-- optional function to define a sort order when the query is empty
						initial_sort = nil,

						-- set to false to enable case sensitive matching
						smart_case = true,
					},
				},
				file_browser = {
					mappings = {
						['i'] = {
							['<C-R>'] = fb_actions.create,
						},
						['n'] = {
							['<C-R>'] = fb_actions.create,
						},
					},
				},
				['ui-select'] = {},
				live_grep_args = {
					auto_quoting = true,
					i = {
						['<C-k>'] = lga_actions.quote_prompt(),
						['<C-l>g'] = lga_actions.quote_prompt({ postfix = ' --iglob ' }),
						['<C-l>t'] = lga_actions.quote_prompt({ postfix = ' -t' }),
					},
				},
			},
		})

		monorepo.setup({
			autoload_telescope = false,
		})

		-- telescope.load_extension('fzf')
		telescope.load_extension("zf-native")
		telescope.load_extension('ui-select')
		telescope.load_extension('file_browser')
		telescope.load_extension('live_grep_args')
		telescope.load_extension('gh')
		telescope.load_extension('monorepo')
		telescope.load_extension("git_worktree")
		telescope.load_extension('harpoon')

		local opts = { noremap = true, silent = true }

		-- Telescope + LSP
		vim.keymap.set('n', '<leader>fg', builtin.lsp_definitions, opts)
		vim.keymap.set('n', '<leader>jm', builtin.diagnostics, opts)
		vim.keymap.set('n', '<leader>ji', builtin.lsp_implementations, opts)

		-- Regular Telescope magic
		vim.keymap.set('n', '<leader>tr', extensions.live_grep_args.live_grep_args, opts)
		vim.keymap.set('n', '<leader>fb', builtin.buffers, opts)
		vim.keymap.set('n', '<leader>fh', builtin.help_tags, opts)
		vim.keymap.set('n', '<C-p>', builtin.git_files, opts)
		vim.keymap.set('n', '<C-f>', builtin.find_files, opts)
		vim.keymap.set('n', '<leader>sd', builtin.diagnostics, opts)
		vim.keymap.set('n', '<leader>sh', builtin.search_history, { noremap = true, silent = true })
		vim.keymap.set('n', '<leader>ps', function() builtin.grep_string({ search = vim.fn.input('Grep> ') }) end)

		-- Telescope Extensions
		vim.keymap.set('n', '<leader>jis', extensions.gh.issues, { noremap = true, silent = true })
		vim.keymap.set('n', '<leader>jpl', extensions.gh.pull_request, { noremap = true, silent = true })
		vim.keymap.set('n', '<leader>jgi', extensions.gh.gist, { noremap = true, silent = true })
		vim.keymap.set('n', '<leader>gar', extensions.gh.run, { noremap = true, silent = true })
		-- vim.keymap.set('n', '<leader>ms', extensions.harpoon.marks, { noremap = true, silent = true })

		-- Telescope Git Stuff
		vim.keymap.set('n', '<leader>jc', builtin.git_commits, { noremap = true, silent = true })
		vim.keymap.set('n', '<leader>jb', builtin.git_branches, { noremap = true, silent = true })
		vim.keymap.set('n', '<leader>js', builtin.git_status, { noremap = true, silent = true })
		vim.keymap.set('n', '<leader>mt', monorepo.toggle_project, { noremap = true, silent = true })
	end,
}
