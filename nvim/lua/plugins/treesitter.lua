return {
	'nvim-treesitter/nvim-treesitter',
	build = function()
		pcall(require('nvim-treesitter.install').update({ with_sync = true }))
	end,
	dependencies = {
		'nvim-treesitter/nvim-treesitter-textobjects',
		'nvim-treesitter/playground',
		'nvim-treesitter/nvim-treesitter-context',
		'nvim-treesitter/nvim-treesitter-refactor',
		'IndianBoy42/tree-sitter-just',
		"nushell/tree-sitter-nu",
	},
	config = function()
		local ts_ctx        = require('treesitter-context')
		local ts_configs    = require('nvim-treesitter.configs');
		local ts_parsers    = require('nvim-treesitter.parsers')
		local parser_config = ts_parsers.get_parser_configs()

		ts_configs.setup({
			ensure_installed = {
				'go',
				'gomod',
				'gosum',
				'llvm',
				'json',
				'lua',
				'markdown',
				'markdown_inline',
				'proto',
				'rust',
				'svelte',
				'toml',
				'tsx',
				'typescript',
				'yaml',
				'dockerfile',
				'graphql',
				'comment',
				'css',
				'scss',
				'sql',
				'http',
				'c',
				'cpp',
				'capnp',
				'cmake',
				'diff',
				'hurl',
				'dot',
				'bash',
				'git_config',
				'gitattributes',
				'gitcommit',
				'gitignore',
				'zig',
				'vim',
				'vimdoc',
				'devicetree',
				'tmux',
				'nix',
				'nu',
			},
			auto_pairs = {
				enable = true,
			},
			autotag = {
				enable = true,
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = '<C-space>',
					node_incremental = '<C-space>',
					scope_incremental = '<C-s>',
					node_decremental = '<C-backspace>',
				},
			},
			refactor = {
				highlight_definitions = false,
				highlight_current_scope = { enable = false },
				smart_rename = {
					enable = true,
					-- Assign keymaps to false to disable them, e.g. `smart_rename = false`.
					keymaps = {
						smart_rename = 'trr',
					},
				},
			},
			textobjects = {
				move = {
					enable = true,
				},
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						-- You can optionally set descriptions to the mappings (used in the desc parameter of
						-- nvim_buf_set_keymap) which plugins like which-key display
						["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
						-- You can also use captures from other query groups like `locals.scm`
						["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
					},
					-- You can choose the select mode (default is charwise 'v')
					--
					-- Can also be a function which gets passed a table with the keys
					-- * query_string: eg '@function.inner'
					-- * method: eg 'v' or 'o'
					-- and should return the mode ('v', 'V', or '<c-v>') or a table
					-- mapping query_strings to modes.
					selection_modes = {
						['@parameter.outer'] = 'v', -- charwise
						['@function.outer'] = 'V', -- linewise
						['@class.outer'] = '<c-v>', -- blockwise
					},
					-- If you set this to `true` (default is `false`) then any textobject is
					-- extended to include preceding or succeeding whitespace. Succeeding
					-- whitespace has priority in order to act similarly to eg the built-in
					-- `ap`.
					--
					-- Can also be a function which gets passed a table with the keys
					-- * query_string: eg '@function.inner'
					-- * selection_mode: eg 'v'
					-- and should return true or false
					include_surrounding_whitespace = true,
				},
			},
		})

		ts_ctx.setup({
			enable = true,
			max_lines = 0,
			min_window_height = 0,
			line_numbers = true,
			multiline_threshold = 20,
			trim_scope = 'outer', -- or 'inner'
			mode = 'cursor', -- or 'topline'
			separator = nil,
			zindex = 20,
			on_attach = nil,
		})

		parser_config.tsx.filetype_to_parsername = { 'javascript', 'typescript.tsx', 'ts' }
		parser_config.hcl.filetype_to_parsername = { 'hcl', 'tf' }
		parser_config.just = {
			install_info = {
				url = 'https://github.com/IndianBoy42/tree-sitter-just', -- local path or git repo
				files = { 'src/parser.c', 'src/scanner.c' },
				branch = 'main',
				-- use_makefile = true -- this may be necessary on MacOS (try if you see compiler errors)
			},
			maintainers = { '@IndianBoy42' },
		}
	end,
}
