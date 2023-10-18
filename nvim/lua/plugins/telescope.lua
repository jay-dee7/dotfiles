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
		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
		{ 'imNel/monorepo.nvim' },
	},
	config = function()
		local builtin = require('telescope.builtin')
		local lga_actions = require('telescope-live-grep-args.actions')
		local extensions = require('telescope').extensions
		local fb_actions = extensions.file_browser.actions
		local sorters = require('telescope.sorters')
		local previewers = require('telescope.previewers')
		local trouble = require('trouble.providers.telescope')
		local actions = require('telescope.actions')
		local monorepo = require('monorepo')

		require('telescope').setup({
			defaults = {
				mappings = {
					i = {
						['<esc>'] = actions.close,
						['<c-t>'] = trouble.open_with_trouble,
					},
					n = {
						['<c-t>'] = trouble.open_with_trouble,
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
						mirror = false,
						width = 0.90,
						height = 0.90,
						preview_height = 0.7,
						preview_width = 0.6,
						-- prompt_position = "bottom",
						-- preview_cutoff = 120,
					},
					horizontal = {
						mirror = false,
						width = 0.90,
						height = 0.60,
						preview_height = 0.7,
						preview_width = 0.6,
						prompt_position = 'bottom',
						preview_cutoff = 120,
					},
				},
				file_ignore_patterns = { '.idea/*', 'cpu.pprof', '*.prof', '.kvstore', 'vendor', 'node_modules' },
				winblend = 0,
				border = {},
				borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
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
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
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

		require('telescope').load_extension('fzf')
		require('telescope').load_extension('ui-select')
		require('telescope').load_extension('file_browser')
		require('telescope').load_extension('live_grep_args')
		require('telescope').load_extension('gh')
		require('telescope').load_extension('monorepo')
		-- require("telescope").load_extension("git_worktree")

		local opts = { noremap = true, silent = true }

		-- Telescope + LSP
		vim.keymap.set('n', '<leader>fg', function()
			builtin.lsp_definitions()
		end, opts)
		vim.keymap.set('n', '<leader>jm', function()
			builtin.diagnostics()
		end, opts)
		vim.keymap.set('n', '<leader>ji', function()
			builtin.lsp_implementations()
		end, opts)

		-- Regular Telescope magic
		vim.keymap.set('n', '<leader>tr', function()
			extensions.live_grep_args.live_grep_args()
		end, opts)
		vim.keymap.set('n', '<leader>fb', function()
			builtin.buffers()
		end, opts)
		vim.keymap.set('n', '<leader>fh', function()
			builtin.help_tags()
		end, opts)
		vim.keymap.set('n', '<C-p>', function()
			builtin.git_files()
		end, opts)
		vim.keymap.set('n', '<C-f>', function()
			builtin.find_files()
		end, opts)
		vim.keymap.set('n', '<leader>sd', function()
			builtin.diagnostics()
		end, opts)
		vim.keymap.set('n', '<leader>ps', function()
			builtin.grep_string({ search = vim.fn.input('Grep> ') })
		end)
		vim.keymap.set('n', '<leader>sh', function()
			builtin.search_history()
		end, { noremap = true, silent = true })

		-- Telescope Extensions
		vim.keymap.set('n', '<leader>jis', extensions.gh.issues, { noremap = true, silent = true })
		vim.keymap.set('n', '<leader>jpl', extensions.gh.pull_request, { noremap = true, silent = true })
		vim.keymap.set('n', '<leader>jgi', extensions.gh.gist, { noremap = true, silent = true })
		vim.keymap.set('n', '<leader>gar', extensions.gh.run, { noremap = true, silent = true })

		-- Telescope Git Stuff
		vim.keymap.set('n', '<leader>jc', function()
			builtin.git_commits()
		end, { noremap = true, silent = true })
		vim.keymap.set('n', '<leader>jb', function()
			builtin.git_branches()
		end, { noremap = true, silent = true })
		vim.keymap.set('n', '<leader>js', function()
			builtin.git_status()
		end, { noremap = true, silent = true })
		vim.keymap.set('n', '<leader>mt', function()
			monorepo.toggle_project()
		end, { noremap = true, silent = true })
		-- vim.api.nvim_create_autocmd("VimEnter", {
		--   callback = function()
		--     if vim.fn.argv(0) == "" then
		--       builtin.find_files()
		--     end
		--   end
		-- })
	end,
}
