return {
	cmd = {
		"lua-language-server",
	},
	filetypes = {
		"lua",
	},
	root_markers = {
		".git",
		".luacheckrc",
		".luarc.json",
		".luarc.jsonc",
		".stylua.toml",
		"selene.toml",
		"selene.yml",
		"stylua.toml",
	},
	single_file_support = true,
	settings = {
		Lua = {
			diagnostics = {
				globals = {
					-- vim
					'vim',
					'hs',

					-- Busted
					'describe',
					'it',
					'before_each',
					'after_each',
					'teardown',
					'pending',
					'clear',

					-- Colorbuddy
					'Color',
					'c',
					'Group',
					'g',
					's',

					-- Custom
					'RELOAD',
				},
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = {
					vim.api.nvim_get_runtime_file('', true),
					string.format('%s/.hammerspoon/Spoons/EmmyLua.spoon/annotations', os.getenv('HOME')),
				},
			},
		},
	}
}
